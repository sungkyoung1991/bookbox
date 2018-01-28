package com.bookbox.web.user;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.mail.javamail.JavaMailSenderImpl;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.bookbox.common.domain.Page;
import com.bookbox.common.domain.Search;
import com.bookbox.service.domain.User;
import com.bookbox.service.user.MailService;
import com.bookbox.service.user.UserService;
import com.bookbox.service.user.impl.MailRunnableImpl;


/**
 * @file com.bookbox.web.user.UserCrontroller.java
 * @brief 회원 Controller
 * @detail
 * @author HJ
 * @date 2017.10.13
 */

@Controller
@RequestMapping("/user/*")
public class UserController {

	
	/**
	 * @brief  field
	 */
	@Autowired
	@Qualifier("userServiceImpl")
	private UserService userService;
	
	@Autowired
	@Qualifier("mailServiceImpl")
	private MailService mailService;
		
	@Autowired
	@Qualifier("javaMailSenderImplGoogle")
	private JavaMailSenderImpl javaMailSenderImpl;
	
	@Value("#{commonProperties['pageUnit']}")
	int pageUnit;
	@Value("#{commonProperties['pageSize']}")
	int pageSize;
		
		/**
		 * @brief  Constructor
		 */		
	public UserController() {
		System.out.println("Constructor :: "+this.getClass().getName());
	}
	
	/**
	 * @brief addUser/회원가입화면으로 이동
	 * @details GET
	 * @param 
	 * @throws Exception
	 * @return "redirect:addUserView.jsp" 
	 */
	@RequestMapping( value="addUser", method=RequestMethod.GET )
	public String addUser() throws Exception{
		// TODO
	
		System.out.println("UserController :: /user/addUser : GET");
		
		return "redirect:../user/addUserView.jsp";
	}
	
	/**
	 * @brief addUser/회원가입
	 * @details POST/ addUser 후 로그인 화면으로 이동
	 * @param User user
	 * @throws Exception
	 * @return "forward:loginView.jsp"
	 */
	
	@RequestMapping( value="addUser", method=RequestMethod.POST )
	public String addUser( @ModelAttribute("user") User user ) throws Exception {
		// TODO addUser
		
		System.out.println("UserController :: /user/addUser : POST");
		System.out.println("Controller :: addUser :: "+user);
		
		String  resultPage = "redirect:loginTest.jsp";
		//Business Logic
		if (user.getOuterAccount() != 0) {
			userService.addUser(user);
			resultPage="forward:../user/login";
		}else {
			new Thread(new MailRunnableImpl(mailService, user)).start();
//			mailService.sendMail(user);
			resultPage ="redirect:../index.jsp";
		}
		
		return resultPage;
	}
	
	/**
	 * @brief getUser/로그인, 회원정보 조회
	 * @details GET
	 * @param User user(email)
	 * @throws Exception
	 * @return "forward:getUser.jsp"
	 */
	@RequestMapping( value="getUser", method=RequestMethod.GET )
	public String getUser( @ModelAttribute("user") User user , Model model ) throws Exception {
		// TODO getUser
		System.out.println("UserController :: /user/getUser : GET");
		//Business Logic
		System.out.println(user.getOuterAccount());
		System.out.println(user.getActive());
		User dbuser = userService.getUser(user);
		// Model 과 View 연결
		model.addAttribute("user", dbuser);
		
		return "forward:../user/getUser.jsp";
	}
	
	/**
	 * @brief getUserList/회원리스트 조회
	 * @details GET
	 * @param User
	 * @throws Exception
	 * @return "forward:listUser.jsp"
	 */
	@RequestMapping( value="getUserList", method=RequestMethod.GET )
	public String getUserList( @ModelAttribute("user") User user , 
														@ModelAttribute("Search") Search search,
														@ModelAttribute("Page") Page page,
														Model model ) throws Exception {
		// TODO getUser
		System.out.println("UserController :: /user/getUserList : GET");
		//Business Logic
		System.out.println(user.getOuterAccount());
		System.out.println(user.getActive());
		
		System.out.println("getCreationList :: getSearch :: "+search);
		System.out.println("getCreationList :: getPage :: "+page);
		//Business Logic
		if(search.getKeyword() == null) {
			search.setKeyword("");
		}
		if(search.getCondition() ==null) {
			search.setCondition("0");
		}
		if(page.getPageSize() ==0) {
			page.setPageSize(pageSize);
		}
		if(page.getPageUnit()==0) {
			page.setPageUnit(pageUnit);
		}
		
		Map<String, Object> map = new HashMap<>();
		map.put("search", search);
		map.put("page", page);
		
		List<User> userList = userService.getUserList(map);
		
		// Model 과 View 연결
		model.addAttribute("userList", userList);
		
		return "forward:../user/listUser.jsp";
	}
	
	
	/**
	 * @brief updateUser/회원정보수정화면으로 이동
	 * @details GET 
	 * @param User user(email)
	 * @throws Exception
	 * @return "forward:updateUserView.jsp"
	 */
	@RequestMapping( value="updateUser", method=RequestMethod.GET )
	public String updateUser(HttpSession session , Model model ) throws Exception{
		// TODO
		System.out.println("UserController :: /user/updateUser : GET");
		//Business Logic
		
		User user = (User)session.getAttribute("user");
		User dbuser = userService.getUser(user);
		// Model 과 View 연결
		model.addAttribute("user", dbuser);
		
		return "forward:../user/updateUserView.jsp";
	}
	
	/**
	 * @brief updateUser/회원정보수정
	 * @details POST
	 * @param User user
	 * @throws Exception
	 * @return "redirect:getUser?email=user.getEmail()"
	 */
	@RequestMapping( value="updateUser", method=RequestMethod.POST )
	public String updateUser( @ModelAttribute("user") User user , Model model , HttpSession session) throws Exception{
		// TODO updateUser
		System.out.println("UserController :: /user/updateUser : POST");
		//Business Logic
		userService.updateUser(user);
		
		String sessionEmail=((User)session.getAttribute("user")).getEmail();
		if(sessionEmail.equals(user.getEmail())){
			session.setAttribute("user", user);
		}
			
		return "redirect:../user/getUser?email="+user.getEmail();
	}
	
	
	/**
	 * @brief checkCertNo/메일인증번호 확인                           
	 * @details GET
	 * @param User user
	 * @throws Exception
	 * @return "forward:updateUser"
	 */
	@RequestMapping( value="checkCertNo", method=RequestMethod.GET)
	public String checkCertNo(@RequestParam("certificationNo") int certificationNo,
														@ModelAttribute("user") User user, HttpSession session) throws Exception{
		// TODO checkCertNo
		System.out.println("UserController :: /user/checkCertNo : GET");		

		if (certificationNo == userService.getUser(user).getCertificationNo()) {
			Map<String, Object> map = new HashMap<>();
			map.put("email", user.getEmail());
			map.put("active", user.getActive());
			
			userService.updateActive(map);
		}else {
			return "redirect:../user/addUserView.jsp";
		}

				
		return "redirect:../user/confirmCertNo.jsp";
	}

	/**
	 * @brief login/로그인화면으로 이동                           
	 * @details GET
	 * @param 
	 * @throws Exception
	 * @return "redirect:/user/loginTest.jsp"
	 */
	@RequestMapping( value="login", method=RequestMethod.GET )
	public String login(HttpSession session) throws Exception{
		// TODO
		System.out.println("UserController :: /user/login : GET");
		
		String resultPage = "redirect:../user/login.jsp";
		
		System.out.println(session.getAttribute("user"));
		
		if (session.getAttribute("user") != null) {
			resultPage = "redirect:../index.jsp";
		}
		
		return resultPage;
	}
	
	/**
	 * @brief login/로그인                           
	 * @details POST
	 * @param User user, HttpSession session
	 * @throws Exception
	 * @return "forward:../index.jsp"
	 */
	@RequestMapping( value="login", method=RequestMethod.POST )
	public String login(@ModelAttribute("user") User user , HttpSession session, Model model) throws Exception{
		// TODO
		System.out.println("UserController :: /user/login : POST");
		
		String returnValue="redirect:../index.jsp";
		
//		System.out.println("외부계정 user 정보 :: "+user);
		//Business Logic
		User dbUser=userService.getUser(user);
				
		if(dbUser != null) {
			if (dbUser.getOuterAccount()==0) {
				if (user.getPassword().equals(dbUser.getPassword())) {
					session.setAttribute("user", dbUser);
							
				}else {
					model.addAttribute("user", user);
					model.addAttribute("msg", "이메일 또는 비밀번호가 잘못되었습니다.");
					returnValue = "forward:../user/login.jsp";
				}
			}else {
				session.setAttribute("user", dbUser);		
			}
			
		}else {
			if (user.getOuterAccount()==0) {
				model.addAttribute("user", user);
				model.addAttribute("msg", "잘못된 회원 정보입니다.");

				returnValue = "forward:../user/login.jsp";
			}else {
				model.addAttribute("user", user);
				System.out.println("Model.getAttribute('user')  :: "+user);
				returnValue ="forward:addUserExtraView.jsp";
			}
		}
		return returnValue;		
	}
	
	/**
	 * @brief logout/로그아웃                           
	 * @details GET
	 * @param HttpSession session
	 * @throws Exception
	 * @return "forward:../index.jsp"
	 */	
	@RequestMapping( value="logout", method=RequestMethod.GET )
	public String logout(HttpSession session ) throws Exception{
		// TODO
		System.out.println("UserController :: /user/logout : POST");
		
//		User user = (User)session.getAttribute("user"); 
		
//		if (user.getOuterAccount() != 0) {
//			userService.logout(user);
//		}
		
		session.invalidate();
		
		return "redirect:../index.jsp";
	}
	
	/**
	 * @brief findPassword/비밀번호찾기 화면으로 이동
	 * @details GET
	 * @param 
	 * @throws Exception
	 * @return "redirect:findPassword.jsp"
	 */
	@RequestMapping( value="findPassword", method=RequestMethod.GET )
	public String findPassword() throws Exception {
		// TODO 
		System.out.println("UserController :: /user/findPassword : GET");
		
		return "redirect:../user/findPasswordView.jsp";
	}
	
	/**
	 * @brief deleteUser/회원탈퇴
	 * @details GET
	 * @param 
	 * @throws Exception
	 * @return "redirect:../index.jsp"
	 */
	@RequestMapping( value="deleteUser", method=RequestMethod.GET )
	public String deleteUser(HttpSession session) throws Exception {
		// TODO deleteUser
		System.out.println("UserController :: /user/deleteUser : GET");
		
		Map<String, Object> map = new HashMap<>();
		map.put("email",  ((User)session.getAttribute("user")).getEmail());
		map.put("active", 2);
		
		userService.updateActive(map);
		
		session.invalidate();
		
		return "redirect:../index.jsp";
	}
	
	/**
	 * @brief activeUser/ 인증후 회원활성화
	 * @details GET
	 * @param 
	 * @throws Exception
	 * @return "redirect:../index.jsp"
	 */
	@RequestMapping( value="activeUser", method=RequestMethod.GET )
	public String activeUser(@ModelAttribute("user") User user, HttpSession session) throws Exception {
		// TODO
		System.out.println("UserController :: /user/activeUser : GET");
		
		User dbuser = userService.getUser(user);
		
		Map<String, Object> map = new HashMap<>();
		map.put("email",  dbuser.getEmail());
		map.put("active", 1);
		
		userService.updateActive(map);
		
		System.out.println("Controller : activeUser :: "+dbuser);
		
		return "redirect:../user/login?email="+dbuser.getEmail();
	}
	


	

	/////////////////////////////////////////////////////////////////////////////////////
////	/**
////	 * @brief updateUserCheck/회원정보수정인증 화면으로 이동
////	 * @details GET
////	 * @param 
////	 * @throws Exception
////	 * @return "forward:/user/updateUserCheckView.jsp"
////	 */
//	@RequestMapping( value="updateUserCheck", method=RequestMethod.GET )
//	public String updateUserCheck() throws Exception{
//
//		System.out.println("/user/updateUserCheck : GET");
//		
//		return "redirect:/user/updateUserCheckView.jsp";
//	}
//	
////	/**
////	 * @brief updateUserCheck/회원정보수정인증 
////	 * @details POST
////	 * @param User user
////	 * @throws Exception
////	 * @return "forward:/user/updateUserView.jsp"
////	 */
//	@RequestMapping( value="updateUserCheck", method=RequestMethod.POST )
//	public String updateUserCheck(@ModelAttribute("user") User user, 
//																	HttpSession session, Model model) throws Exception{
//
//		System.out.println("/user/updateUser : POST");
//		
//		User dbuser = (User)session.getAttribute("user");
//		
//		if(user.getPassword()==dbuser.getPassword()) {
//			return "forword:/user/updateUserView.jsp";
//		}
//			return "";	
//	}
////////////////////////////////////////////////////////////////////////////////////////

	
	
	

	
	

	
		
	
	
}
