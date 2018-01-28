package com.bookbox.service.user;

import java.util.List;
import java.util.Map;

import com.bookbox.service.domain.User;

/**
 * @file com.bookbox.service.user.userService.java
 * @brief 회원 Service
 * @detail 인터페이스
 * @author HJ
 * @date 2017.10.14
 */
public interface UserService {

	/**
	 * @brief 회원가입
	 * @param User user
	 * @throws Exception
	 * @return void
	 */
	public void addUser(User user) throws Exception;
	
	/**
	 * @brief 회원정보수정
	 * @param User user
	 * @throws Exception
	 * @return User
	 */
	public void updateUser(User user) throws Exception;	

	/**
	 * @brief 내정보확인/로그인
	 * @param User user
	 * @throws Exception
	 * @return User
	 */
	public User getUser(User user) throws Exception;
	
	/**
	 * @brief 회원목록조회
	 * @param User user
	 * @throws Exception
	 * @return List<User>
	 */
	public List<User> getUserList(Map<String, Object> map) throws Exception;

	/**
	 * @brief 로그아웃
	 * @param User user
	 * @throws Exception
	 * @return void
	 */
	public void logout(User user) throws Exception;
	
	/**
	 * @brief 이메일 중복체크 
	 * @param User user
	 * @throws Exception
	 * @return boolean
	 */
	public boolean checkEmailValidation(User user) throws Exception;
	
	/**
	 * @brief 닉네임중복체크
	 * @param User user
	 * @throws Exception
	 * @return boolean
	 */
	public boolean checkNicknameValidation(User user) throws Exception;
	
	/**
	 * @brief 메일인증 후 회원활성화코드 변경/ 회원탈퇴
	 * @param User user
	 * @throws Exception
	 * @return 
	 */
	public void updateActive(Map<String, Object> map) throws Exception;
	
}
