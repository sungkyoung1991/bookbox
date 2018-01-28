package com.bookbox.common.service.impl;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.bookbox.common.domain.Grade;
import com.bookbox.common.domain.Like;
import com.bookbox.common.domain.Reply;
import com.bookbox.common.domain.UploadFile;
import com.bookbox.common.service.CommonDAO;

/**
 * @file com.bookbox.common.service.impl.CommonDaoImpl.java
 * @brief CommonDaoImpl
 * @detail
 * @author JJ
 * @date 2017.10.20
 */

@Service("commonDAOImpl")
public class CommonDAOImpl implements CommonDAO {

	@Autowired
	@Qualifier("sqlSessionTemplate")
	private SqlSession sqlSession;
	
	public void setSqlSession(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}

	public CommonDAOImpl() {
		System.out.println("Constructor :: " + this.getClass().getName());
	}

	@Override
	public void addLike(Map<String, Object> map) {		
		sqlSession.insert("CommonMapper.addLike", map);
	}

	@Override
	public void deleteLike(Map<String, Object> map) {	
		sqlSession.delete("CommonMapper.deleteLike", map);
	}

	@Override
	public Like getLike(Map<String, Object> map) {		
		return sqlSession.selectOne("CommonMapper.getLike", map);
	}

	@Override
	public void addReply(Map<String, Object> map) {
		sqlSession.insert("CommonMapper.addReply", map);
	}

	@Override
	public void deleteReply(Map<String, Object> map) {
		sqlSession.delete("CommonMapper.deleteReply", map);
	}

	@Override
	public List<Reply> getReplyList(Map<String, Object> map) {
		return sqlSession.selectList("CommonMapper.getReplyList", map);
	}

	@Override
	public void addGrade(Map<String, Object> map) {
		sqlSession.insert("CommonMapper.addGrade", map);
	}

	@Override
	public Grade getGrade(Map<String, Object> map) {
		return sqlSession.selectOne("CommonMapper.getGrade", map);
	}
	
	@Override
	public Grade getAvgGrade(Map<String, Object> map) {
		return sqlSession.selectOne("CommonMapper.getAvgGrade", map);
	}
	
	@Override
	public int getDoGrade(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("CommonMapper.getDoGrade",map);
	}

	@Override
	public void addUploadFile(List<UploadFile> list) {
		sqlSession.insert("CommonMapper.addUploadFile", list);
	
	}

	@Override
	public List<UploadFile> getUploadFileList(Map<String, Object> map) {
		return sqlSession.selectList("CommonMapper.getUploadFileList", map);
	}

	@Override
	public void updateUploadFile(List<UploadFile> list) {
		sqlSession.delete("CommonMapper.deleteUploadFile", list.get(0));
		sqlSession.insert("CommonMapper.addUploadFile", list);
	}

	@Override
	public void deleteUploadFile(Map<String, Object> map) {
		// TODO Auto-generated method stub
		sqlSession.delete("CommonMapper.deleteUploadFile",map);
	}	

	@Override
	public List<Map<String, Integer>> getBookStatics(Map<String, Object> map) {
		return sqlSession.selectList("CommonMapper.getBookStatics", map);
	}

	@Override
	public String getUserLikeBook(String email) {
		if(sqlSession.selectList("CommonMapper.getUserBook", email).isEmpty()) {
			return null;
		}
		
		else
			return (String)(sqlSession.selectList("CommonMapper.getUserBook", email) != null?sqlSession.selectList("CommonMapper.getUserBook", email).get(0):"");
	}
}
