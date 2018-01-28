package com.bookbox.common.aspect;

import org.aspectj.lang.ProceedingJoinPoint;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;

import com.bookbox.common.domain.Const;
import com.bookbox.common.domain.Log;
import com.bookbox.common.service.LogService;
import com.bookbox.common.util.CommonUtil;
import com.bookbox.service.domain.Board;
import com.bookbox.service.domain.Book;
import com.bookbox.service.domain.Booklog;
import com.bookbox.service.domain.Creation;
import com.bookbox.service.domain.Funding;
import com.bookbox.service.domain.PayInfo;
import com.bookbox.service.domain.Posting;
import com.bookbox.service.domain.User;
import com.bookbox.service.domain.Writing;

/**
 * @file com.bookbox.common.aspect.LogToDAO.java
 * @author JW
 * @date 2017.10.10
 * @brief 
 */
public class LogToDAO {
	
	@Autowired
	@Qualifier("logServiceImpl")
	private LogService logService;
	
	@Value("#{commonProperties['fundingPossibleLike']}")
	int fundingPossibleLike;
	
	public LogToDAO() {
		System.out.println("Constructor :: "+getClass().getName());
	}
	
	/**
	 * @brief 로그를 기록할 method를 판별
	 * @param joinPoint : 서비스에서 실행한 method 정보
	 * @return 서비스에서 실행한 return값
	 * @throws Throwable
	 * @detail
	 * 		서비스에서 실행한 method 이름을 parsing하여
	 * 		category, behavior, addBehavior를 분류하고
	 * 		각각의 조건을 비교 후 로그를 기록 또는 생략한다.
	 * 		로그를 남기기 위해서는 다음 두 가지의 조건을 필수로 만족해야 한다.
	 *		1. 첫 번째 parameter는 email 정보가 있는 User 객체이어야 한다.
	 *		2. 두 번째 parameter는 각 개체에 알맞는 PK가 존재하는 도메인 객체이어야 한다.
	 *
	 *		예외 : 	1. behavior가 get인 경우, user가 없으면 anonymous 계정으로 카운트(비회원 조회 로그 기록용 계정)
	 *				2. bahavior가 cancel 또는 delete인 경우, category가 funding이면 도메인 안의 payInfoList로 로그를 기록
	 */
	public Object logWrite(ProceedingJoinPoint joinPoint) throws Throwable{

		String methodName = joinPoint.getSignature().getName();
		int categoryNo = parseCategoryToInt(methodName);
		int behavior = parseBehaviorToInt(methodName);
		int addBehavior = parseAddBehaviorToInt(methodName);

		Object obj = this.invoke(joinPoint);
		
		if(categoryNo == Const.NONE ||
				behavior == Const.NONE ||
				behavior == Const.Behavior.LIST ||
				addBehavior == Const.AddBehavior.REPLY) {
			
			System.out.println("Log :: "+ methodName + " 로그를 남기지 않는 method");
			
		}else if( categoryNo == Const.Category.FUNDING && 
						(behavior == Const.Behavior.CANCEL || behavior == Const.Behavior.DELETE) ) {
			
			if(joinPoint.getArgs()[0] instanceof Funding) {
				
				System.out.println("Log :: 로그를 남기는 method");
				Funding funding = (Funding)joinPoint.getArgs()[0];
				Object targetNo = funding.getFundingNo();
				
				this.addLogModule(funding.getCreation().getCreationAuthor(), categoryNo, behavior, targetNo);
				
				for(PayInfo payInfo : funding.getPayInfoList()) {
					
					this.addLogModule(payInfo.getUser(), categoryNo, behavior, targetNo);
				}
				
			}else {
				
				System.out.println("Log :: 잘못된 접근입니다!");
				
			}
			
		}else if( !this.checkUserLogin(joinPoint) && behavior != Const.Behavior.GET){
			
			System.out.println("Log :: 비회원 로그는 남기지 않음");
			
		}else {

			User user = null;
			if(behavior == Const.Behavior.GET) {
				if(!this.checkUserLogin(joinPoint)) {
					if(joinPoint.getArgs()[0] instanceof User || joinPoint.getArgs()[0] == null) {
						user = new User();
						user.setEmail("anonymous");
						System.out.println("Log :: 비회원 게시물 조회");
					}else {
						System.out.println("Log :: 비회원 로그는 남기지 않음");
						return obj;
					}
				}else if(this.checkAuthorUser(categoryNo, obj, joinPoint)) {
					
					System.out.println("Log :: 자신이 작성한 게시물 조회는 로그를 남기지 않음");
					return obj;
					
				}
			}
			
			System.out.println("Log :: 로그를 남기는 method");
			Object targetNo = getTargetNo(joinPoint.getArgs()[1], obj);
			
			if(user == null) {
				user = (User)joinPoint.getArgs()[0];
			}
			
			this.addLogModule(user, categoryNo, behavior, addBehavior, targetNo);
			
			if(categoryNo == Const.Category.CREATION && behavior == Const.Behavior.ADD && addBehavior == Const.AddBehavior.LIKE) {
				Creation creation = (Creation)joinPoint.getArgs()[1];
				if(creation.getLike().getTotalLike() == fundingPossibleLike -1) {

					this.addLogModule(creation.getCreationAuthor(), categoryNo, Const.Behavior.ABLE, targetNo);
					
				}
			}

		}
		
		return obj;
	}
	
	/**
	 * @brief 서비스 실행 시 method 정보와 리턴값을 출력한다.
	 * @param joinPoint
	 * @return method 실행 return 값
	 * @throws Throwable
	 */
	public Object invoke(ProceedingJoinPoint joinPoint) throws Throwable{
		
		System.out.println("[Around before] " + 
						joinPoint.getTarget().getClass().getName() + "." + 
						joinPoint.getSignature().getName() + "()" );
		
		Object obj = joinPoint.proceed();
		
		System.out.println("[Around after] return value : " + obj);
		
		return obj;
	}

	/**
	 * @brief method 이름에서 category를 추출
	 * @param methodName : 서비스에서 실행된 method의 이름
	 * @return categoryNo
	 * @detail const.properties에 있는 정보를 토대로 parsing을 진행한다.
	 */
	public int parseCategoryToInt(String methodName) {
		
		String lowerCaseMethodName = methodName.toLowerCase();
		
		for(int i=1; i<=10; i++) {
			if(lowerCaseMethodName.contains(CommonUtil.getConstProp().getProperty("S_C"+i))) {
				if(i == Const.Category.BOOK) {
					if(lowerCaseMethodName.contains(CommonUtil.getConstProp().getProperty("S_AB"+Const.AddBehavior.BOOKMARK))) {
						continue;
					}
				}
				return i;
			}
		}
		
		return Const.NONE;
	}
	
	/**
	 * @brief method 이름에서 behavior를 추출
	 * @param methodName : 서비스에서 실행된 method의 이름
	 * @return behavior
	 * @detail const.properties에 있는 정보를 토대로 parsing을 진행한다.
	 */
	public int parseBehaviorToInt(String methodName) {
		
		String lowerCaseMethodName = methodName.toLowerCase();
		
		for(int i=0; i<=10; i++) {
			if(lowerCaseMethodName.contains(CommonUtil.getConstProp().getProperty("S_B"+i))) {
				return i;
			}
		}
		
		return Const.NONE;
	}
	
	/**
	 * @brief method 이름에서 addBehavior를 추출
	 * @param methodName : 서비스에서 실행된 method의 이름
	 * @return addBehavior
	 * @detail const.properties에 있는 정보를 토대로 parsing을 진행한다.
	 */
	public int parseAddBehaviorToInt(String methodName) {
		
		String lowerCaseMethodName = methodName.toLowerCase();
		
		for(int i=1; i<=5; i++) {
			if(lowerCaseMethodName.contains(CommonUtil.getConstProp().getProperty("S_AB"+i))) {
				return i;
			}
		}
		
		return Const.NONE;
	}
	
	/**
	 * @brief 전달받은 도메인 객체에서 알맞은 PK값을 추출한다.
	 * @param target : 서비스 실행시 전달받은 도메인 객체
	 * @param returnObject : 서비스 실행 후 return 받아온 도메인 객체
	 * @return 전달받은 도메인 객체의 PK값
	 */
	public Object getTargetNo(Object target, Object returnObject) {
		
		Object targetNo = null;
		
		if(target instanceof Creation) {
			targetNo = ((Creation)target).getCreationNo();
		}else if(target instanceof Writing) {
			targetNo = ((Writing)target).getWritingNo();
		}else if(target instanceof Funding) {
			targetNo = ((Funding)target).getFundingNo();
		}else if(target instanceof Booklog) {
			targetNo = ((Booklog)target).getBooklogNo();
			if(targetNo.equals(0)) {
				targetNo = ((Booklog)returnObject).getBooklogNo();
			}
		}else if(target instanceof Posting) {
			targetNo = ((Posting)target).getPostingNo();
		}else if(target instanceof Board) {
			targetNo = ((Board)target).getBoardNo();
		}else if(target instanceof Book) {
			targetNo = ((Book)target).getIsbn();
		}
		System.out.println("Log :: 로그를 남길 targetNo = "+targetNo);
		return targetNo;
	}
	
	/**
	 * @brief User의 instance가 로그를 남기기 유효한지 판별 
	 * @param joinPoint
	 * @return 로그를 남기는 유저인 경우 true, 아닐 경우 false
	 * @throws Throwable
	 */
	public boolean checkUserLogin(ProceedingJoinPoint joinPoint) throws Throwable{
		if(joinPoint.getArgs() == null) {
			return false;
		}else if(joinPoint.getArgs()[0] instanceof User) {
			if( ( (User)joinPoint.getArgs()[0] ).getEmail() != null){
				return true;
			}else {
				return false;
			}
		}else {
			return false;
		}
	}
	
	/**
	 * @brief 조회시 유저가 작성자 본인인지 판별
	 * @param categoryNo
	 * @param joinPoint
	 * @return 작성자일 경우 true, 아닐경우 false
	 */
	public boolean checkAuthorUser(int categoryNo, Object returnObject, ProceedingJoinPoint joinPoint) {
		User author = new User();
		switch(categoryNo){
			case Const.Category.BOARD:
				author = ((Board)returnObject).getWriter();
				break;
			case Const.Category.BOOKLOG:
				author = ((Booklog)returnObject).getUser();
				break;
			case Const.Category.CREATION:
				author = ((Creation)returnObject).getCreationAuthor();
				break;
			case Const.Category.POSTING:
				author = ((Posting)returnObject).getUser();
				break;
//			case Const.Category.WRITING:
//				author = ((Writing)joinPoint.getArgs()[1]).getWritingAuthor();
//				break;
			default:
				author.setEmail("");
		}
		return author.getEmail().equals( ((User)joinPoint.getArgs()[0]).getEmail() );
	}
	
	/**
	 * @brief log 기록 모듈화
	 * @param user
	 * @param categoryNo
	 * @param behavior
	 * @param addBehavior
	 * @param targetNo
	 */
	public void addLogModule(User user, int categoryNo, int behavior, int addBehavior, Object targetNo) {
		Log log = new Log();
		log.setUser(user);
		log.setCategoryNo(categoryNo);
		log.setBehavior(behavior);
		log.setAddBehavior(addBehavior);
		log.setTargetNo(targetNo);
		
		logService.addLog(log);
	}


	public void addLogModule(User user, int categoryNo, int behavior, Object targetNo) {
		Log log = new Log();
		log.setUser(user);
		log.setCategoryNo(categoryNo);
		log.setBehavior(behavior);
		log.setTargetNo(targetNo);
		
		logService.addLog(log);
	}

}
