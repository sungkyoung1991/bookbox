package com.bookbox.service.user;

import com.bookbox.service.domain.User;

/**
 * @file com.bookbox.service.user.UserRestDAO.java
 * @brief 회원 RestDAO
 * @detail 인터페이스
 * @author HJ
 * @date 2017.10.11
 */
public interface UserRestDAO {

	/**
	 * @brief LOGIN
	 * @param User user
	 * @throws Exception
	 * @return User
	 */
	public User getUser(User user) throws Exception;
	
	
	/**
	 * @brief LOGOUT
	 * @param User user
	 * @throws Exception
	 * @return void
	 */
	public void logout(User user) throws Exception;
}
