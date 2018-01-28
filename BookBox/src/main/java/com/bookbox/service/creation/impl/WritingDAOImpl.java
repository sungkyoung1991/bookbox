package com.bookbox.service.creation.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import com.bookbox.common.domain.Search;
import com.bookbox.service.creation.WritingDAO;
import com.bookbox.service.domain.Creation;
import com.bookbox.service.domain.User;
import com.bookbox.service.domain.Writing;

/**
 * @file com.bookbox.service.creation.impl.writingDAOImpl.java
 * @brief 창작글 DAO impl
 * @detail
 * @author HJ
 * @date 2017.10.11
 */
@Repository("writingDAOImpl")
public class WritingDAOImpl implements WritingDAO {
	
	/**
	 * @brief Field
	 */
	@Autowired
	@Qualifier("sqlSessionTemplate")
	private SqlSession sqlSession;
	
	/**
	 * @brief Field
	 */
	public WritingDAOImpl() {
		System.out.println("Constructor :: "+getClass().getName());
	}


	/**
	 * @brief 창작글등록 
	 * @param Writing writing
	 * @throws Exception
	 * @return void
	 */	
	public void addWriting(Writing writing) throws Exception{
		sqlSession.insert("WritingMapper.addWriting", writing);
	}
	
	/**
	 * @brief 창작글 업로드 이미지 등록 
	 * @param User , Writing 
	 * @throws Exception
	 * @return void
	 */	
	public void addUploadImage(Writing writing) throws Exception{
		sqlSession.insert("CommonMapper.addUploadImage",writing);
	}
	

	/**
	 * @brief 창작글 수정 
	 * @param Writing Writing
	 * @throws Exception
	 * @return void
	 */		
	public void updateWriting(Writing writing) throws Exception{
		sqlSession.update("WritingMapper.updateWriting", writing);
	}

	/**
	 * @brief 창작글 조회 
	 * @param Writing Writing
	 * @throws Exception
	 * @return void
	 */		
	public Writing getWriting(Writing writing) throws Exception{
		return sqlSession.selectOne("WritingMapper.getWriting", writing);
	}
	
	/**
	 * @brief 창작글리스트, 창작글 총 개수
	 * @param Search search
	 * @throws Exception
	 * @return void
	 */	
	public List<Writing> getWritingList(Map<String, Object> map) throws Exception{
		
		return sqlSession.selectList("WritingMapper.getWritingList", map);
	}
	
	/**
	 * @brief 창작글리스트 총 개수
	 * @param Search search
	 * @throws Exception
	 * @return void
	 */	
	public int getTotalWritingCount(Creation creation) throws Exception{
		return sqlSession.selectOne("WritingMapper.getTotalWritingCount", creation);
	}
	
	/**
	 * @brief 창작글 삭제 
	 * @param Writing
	 * @throws Exception
	 * @return void
	 */		
	public void deleteWriting(Writing writing) throws Exception{
		sqlSession.update("WritingMapper.updateWriting", writing);
		
	}
	
}
