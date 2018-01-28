package com.bookbox.service.user.impl;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import com.bookbox.common.domain.Search;
import com.bookbox.service.domain.User;
import com.bookbox.service.user.UserDAO;

/**
 * @file com.bookbox.service.user.impl.userDAOImpl.java
 * @brief 회원 DAO impl
 * @detail
 * @author HJ
 * @date 2017.10.14
 */

@Repository("userDAOImpl")
public class UserDAOImpl implements UserDAO {

	
	/**
	 * @brief  Field
	 */
	@Autowired
	@Qualifier("sqlSessionTemplate")
	private SqlSession sqlSession;
	
	public void setSqlSession(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}

	
	/**
	 * @brief  Constructor
	 */
	public UserDAOImpl() {
		System.out.println("Constructor :: "+this.getClass().getName());
	}
	
	
	/**
	 * @brief INSERT
	 * @param User user
	 * @throws Exception
	 * @return void
	 */
	public void addUser(User user) throws Exception{
		sqlSession.insert("UserMapper.addUser", user);
		System.out.println("UserDAOImpl : sqlSession.insert('UserMapper.addUser',user)");
	}
	
	/**
	 * @brief UPDATE
	 * @param User user
	 * @throws Exception
	 * @return User
	 */
	public void updateUser(User user) throws Exception{
		sqlSession.update("UserMapper.updateUser", user);
	}

	/**
	 * @brief SELECT ONE
	 * @param User user
	 * @throws Exception
	 * @return User
	 */
	public User getUser(User user) throws Exception{
		return sqlSession.selectOne("UserMapper.getUser", user);
	}
	

	@Override
	public List<User> getUserList(Map<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectList("UserMapper.getUserList", map);
	}


	/**
	 * @brief SELECT LIST
	 * @param Search search
	 * @throws Exception
	 * @return List<User>
	 */
	public List<User> getUserList(Search search) throws Exception{
		return sqlSession.selectList("UserMapper.getUserList", search);
	}
	
	/**
	 * @brief 메일인증 후 회원활성화코드 변경/ 회원탈퇴
	 * @param User user
	 * @throws Exception
	 * @return 
	 */
	public void updateActive(Map<String, Object> map) throws Exception{
		sqlSession.update("UserMapper.updateActive", map);
	}

	
	/**
	 * @brief 게시판 Page 처리를 위한 전체Row(totalCount)
	 * @param Search search
	 * @throws Exception
	 * @return int
	 */
	public int getTotalCount(Search search) throws Exception {
		return sqlSession.selectOne("UserMapper.getTotalCount", search);
	}
				
}
	
	

