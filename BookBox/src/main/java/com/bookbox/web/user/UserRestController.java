package com.bookbox.web.user;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.bookbox.service.domain.User;
import com.bookbox.service.user.MailService;
import com.bookbox.service.user.UserService;

/**
 * @file com.bookbox.web.user.UserRestController.java
 * @brief 회원 RestController
 * @detail
 * @author HJ
 * @date 2017.10.16
 */
@RestController
@RequestMapping("/user/rest/*")
public class UserRestController {
	
	
	/**
	 * @brief Field
	 */
	@Autowired
	@Qualifier("userServiceImpl")
	private UserService userService;
	
	@Autowired
	@Qualifier("mailServiceImpl")
	private MailService mailService;
	
	/**
	 * @brief Constructor
	 */		
	public UserRestController(){
		System.out.println("Constructor :: "+this.getClass().getName());
	}
	
	/**
	 * @brief login/로그인                           
	 * @details POST
	 * @param User user, HttpSession session
	 * @throws Exception
	 * @return User/ dbUser
	 */	
	@RequestMapping( value="login", method=RequestMethod.POST )
	public User login(	@RequestBody User user,
									HttpSession session ) throws Exception{
	
		System.out.println("/user/rest/login : POST");
		//Business Logic
		User dbUser=userService.getUser(user);
		
		if( dbUser != null
				&&user.getPassword().equals(dbUser.getPassword())
				&& user.getOuterAccount()==dbUser.getOuterAccount()){
			session.setAttribute("user", dbUser);
		}
		
		return dbUser;
	}
	
	/**
	 * @brief checkEmailValidation/ 이메일중복체크                           
	 * @details POST
	 * @param User user
	 * @throws Exception
	 * @return boolean result
	 */	
	@RequestMapping(value="checkEmailValidation", method=RequestMethod.POST)
	public boolean checkEmailValidation(@RequestBody User user) throws Exception{
		System.out.println("/user/rest/checkEmailValidation : POST");
		
		//Business Logic
		boolean result = userService.checkEmailValidation(user); 
		 
		System.out.println("user/rest/checkEmailValidation :: "+result);
		 
		return result;
	}

	/**
	 * @brief checkNicknameValidation/ 닉네임중복체크                           
	 * @details POST
	 * @param User user
	 * @throws Exception
	 * @return boolean result
	 */
	@RequestMapping(value="checkNicknameValidation", method=RequestMethod.POST)
	public boolean checkNicknameValidation(@RequestBody User user) throws Exception{
		System.out.println("/user/rest/checkNicknameValidation : POST");
		
		//Business Logic
		boolean result = userService.checkNicknameValidation(user); 
		 
		System.out.println("user/rest/checkEmailValidation :: "+result);
		 
		return result;
	}
	
	/**
	 * @brief findPassword/비밀번호찾기
	 * @details POST
	 * @param User user
	 * @throws Exception
	 * @return boolean result
	 */
	@RequestMapping( value="findPassword", method=RequestMethod.POST )
	public boolean findPassword(@RequestBody User user) throws Exception {
		// TODO findPassword
		
		System.out.println("UserRestController :: /user/rest/findPassword : POST");
		
		boolean result = false;
//		System.out.println("findPassword :: "+user);
//		System.out.println("findPassword Email :: "+user.getEmail());
//		System.out.println("findPassword ServiceEmail :: "+userService.getUser(user).getEmail());
//		System.out.println("findPassword Brith :: "+user.getBirth().toString());
//		System.out.println("findPassword ServiceBirth :: "+userService.getUser(user).getBirth().toString());
		
		if (userService.getUser(user)!=null ) {
				if(user.getEmail().equals(userService.getUser(user).getEmail())){
					if( user.getBirth().toString().equals(userService.getUser(user).getBirth().toString())){
						mailService.sendMail(user);
						result = true;
					}
				}
		}
		
		System.out.println("findPassword 결과 :: "+result);
		return result;
		
	}

}