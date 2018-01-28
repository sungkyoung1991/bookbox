package com.bookbox.service.user;

import java.util.List;
import java.util.Map;

import com.bookbox.common.domain.Search;
import com.bookbox.service.domain.User;


/**
 * @file com.bookbox.service.user.userDAO.java
 * @brief 회원 DAO
 * @detail 인터페이스
 * @author HJ
 * @date 2017.10.14
 */
public interface UserDAO {
	
	/**
	 * @brief INSERT
	 * @param User user
	 * @throws Exception
	 * @return void
	 */
	public void addUser(User user) throws Exception;
	
	/**
	 * @brief UPDATE
	 * @param User user
	 * @throws Exception
	 * @return User
	 */
	public void updateUser(User user) throws Exception ;

	/**
	 * @brief SELECT ONE
	 * @param User user
	 * @throws Exception
	 * @return User
	 */
	public User getUser(User user) throws Exception ;

	/**
	 * @brief SELECT LIST
	 * @param Search search
	 * @throws Exception
	 * @return List<User>
	 */
	public List<User> getUserList(Map<String , Object> map) throws Exception ;

	
	/**
	 * @brief 게시판 Page 처리를 위한 전체Row(totalCount)
	 * @param Search search
	 * @throws Exception
	 * @return int
	 */
	public int getTotalCount(Search search) throws Exception ;
	
	/**
	 * @brief 메일인증 후 회원활성화코드 변경/ 회원탈퇴
	 * @param User user
	 * @throws Exception
	 * @return 
	 */
	public void updateActive(Map<String, Object> map) throws Exception;
	
}
