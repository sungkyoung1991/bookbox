package com.bookbox.service.user.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.bookbox.common.domain.Page;
import com.bookbox.common.domain.Search;
import com.bookbox.service.domain.User;
import com.bookbox.service.user.UserDAO;
import com.bookbox.service.user.UserRestDAO;
import com.bookbox.service.user.UserService;


/**
 * @file com.bookbox.service.user.impl.UserServieceImpl.java
 * @brief 회원 Service impl
 * @detail
 * @author HJ
 * @date 2017.10.14
 */

@Service("userServiceImpl")
public class UserServiceImpl implements UserService {
	
	/**
	 * @brief Field
	 */
	@Autowired
	@Qualifier("userDAOImpl")
	private UserDAO userDAO;
	public void setUserDAO(UserDAO userDAO) {
		this.userDAO =userDAO;
	}
	
	@Autowired
	@Qualifier("userDAOKakaoImpl")
	private UserRestDAO userRestKakaoDAO;
	
	@Autowired
	@Qualifier("userDAOGoogleImpl")
	private UserRestDAO userRestGoogleDAO;

	@Autowired
	@Qualifier("userDAONaverImpl")
	private UserRestDAO userRestNaverDAO;

	
	/**
	 * @brief Constructor
	 */			
	public UserServiceImpl() {
		System.out.println("Constructor :: "+this.getClass().getName());
	}

	/**
	 * @brief 회원가입/INSERT
	 * @param User user
	 * @throws Exception
	 * @return void
	 */
	public void addUser(User user) throws Exception{
		userDAO.addUser(user);
	}

	/**
	 * @brief 회원정보수정/UPDATE
	 * @param User user
	 * @throws Exception
	 * @return User
	 */
	public void updateUser(User user) throws Exception{
		userDAO.updateUser(user);
	}

	/**
	 * @brief 내정보확인/로그인/SELECT ONE
	 * @param User user
	 * @throws Exception
	 * @return User
	 */
	public User getUser(User user) throws Exception{
		
		int outerAccount =user.getOuterAccount();
		User dbuser;
		
		if (user.getActive()==0) {
			
			switch(outerAccount) {
				case 1 :
					user=userRestNaverDAO.getUser(user);
					break;
				case 2 :
					user=userRestKakaoDAO.getUser(user);
					break;
				default :
			}
			
		}		
		
		dbuser=userDAO.getUser(user);
		System.out.println("UserServiceImpl :: "+dbuser);
		
		return dbuser;
	
	}

	/**
	 * @brief 회원목록조회
	 * @param User
	 * @throws Exception
	 * @return List<User>
	 */
	@Override
	public List<User> getUserList(Map<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
	
		Page page=(Page)map.get("page");
		page.setTotalCount(userDAO.getTotalCount((Search)map.get("search")));
		System.out.println("getUserList :: getTotalCount ::"+page.getTotalCount());
		
		List<User> userList = userDAO.getUserList(map);
		
		return userList;
	}

	/**
	 * @brief 로그아웃
	 * @param User user
	 * @throws Exception
	 * @return void
	 */
	public void logout(User user) throws Exception{
		
		switch(user.getOuterAccount()) {
			case 1 :
				userRestNaverDAO.logout(user);
				break;
			case 2 :
				userRestKakaoDAO.logout(user);
				break;
			case 3 :
				userRestGoogleDAO.logout(user);
				break;	
			default :
	}
		
	}
	
	/**
	 * @brief 메일인증 후 회원활성화코드 변경/ 회원탈퇴
	 * @param User user
	 * @throws Exception
	 * @return 
	 */
	public void updateActive(Map<String, Object> map) throws Exception{
		userDAO.updateActive(map);
	}
	
	/**
	 * @brief 이메일 중복체크 
	 * @param User user
	 * @throws Exception
	 * @return boolean
	 */
	public boolean checkEmailValidation(User user) throws Exception{
		
		boolean result = true;
		
		System.out.println("checkEmailValidation input Email 확인:: "+user);
		System.out.println("checkEmailValidation getUser 확인 :: "+userDAO.getUser(user));
				
		user.setActive(1);
		
		if(userDAO.getUser(user) != null ) {
			if(userDAO.getUser(user).getEmail() != null) {
				result=false;
			}
			result =false;
		}
		return result;
	}
	
	/**
	 * @brief 닉네임중복체크
	 * @param User user
	 * @throws Exception
	 * @return boolean
	 */
	public boolean checkNicknameValidation(User user) throws Exception{
		
		boolean result = true;
		
		System.out.println("checkEmailValidation input Nickname 확인:: "+user);
		System.out.println("checkNicknameValidation getUser 확인 :: "+userDAO.getUser(user));
		user.setActive(1);
		
		if(userDAO.getUser(user) != null ) {
			if(userDAO.getUser(user).getNickname() != null) {
				result=false;
			}
			result =false;
		}
		return result;
	}
	


}
