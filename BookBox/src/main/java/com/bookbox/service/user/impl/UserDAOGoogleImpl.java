package com.bookbox.service.user.impl;

import org.springframework.stereotype.Repository;

import com.bookbox.service.domain.User;
import com.bookbox.service.user.UserRestDAO;

/**
 * @file com.bookbox.service.user.impl.UserDAOGoogleImpl.java
 * @brief 구글로그인 DAO impl
 * @detail
 * @author HJ
 * @date 2017.10.11
 */
@Repository("userDAOGoogleImpl")
public class UserDAOGoogleImpl implements UserRestDAO {

	/**
	 * @brief Google LOGIN
	 * @param User user
	 * @throws Exception
	 * @return User
	 */
	public User getUser(User user) throws Exception{
		
		return user;
	}
	
	/**
	 * @brief Google LOGOUT
	 * @param User user
	 * @throws Exception
	 * @return void
	 */
	public void logout(User user) throws Exception{

	}
	
	
}
