package com.bookbox.service.creation;

import java.util.List;
import java.util.Map;

import com.bookbox.service.domain.User;
import com.bookbox.service.domain.Writing;

/**
 * @file com.bookbox.service.creation.WritingService.java
 * @brief 창작글 Service
 * @detail 인터페이스
 * @author HJ
 * @date 2017.10.11
 */
public interface WritingService {

	/**
	 * @brief 창작글등록 
	 * @param User , Writing 
	 * @throws Exception
	 * @return void
	 */	
	public void addWriting(User user, Writing writing) throws Exception;
	
	/**
	 * @brief 창작글 수정 
	 * @param User , Writing 
	 * @throws Exception
	 * @return void
	 */		
	public void updateWriting(User user, Writing writing) throws Exception;

	/**
	 * @brief 창작글 조회 
	 * @param User, Writing
	 * @throws Exception
	 * @return Writing
	 */		
	public Writing getWriting(User user, Writing writing) throws Exception;
	
	/**
	 * @brief 창작글리스트, 창작글 총 개수
	 * @param Search 
	 * @throws Exception
	 * @return void
	 */	
	public List<Writing> getWritingList(Map<String, Object> map) throws Exception;

	/**
	 * @brief 창작글 삭제 
	 * @param Writing
	 * @throws Exception
	 * @return void
	 */		
	public void deleteWriting(Writing writing) throws Exception;
	
	/**
	 * @brief  평점등록 
	 * @param Map<String,Object>
	 * @throws Exception
	 * @return void
	 */		
	public void addGrade(Map<String, Object> map) throws Exception;
	
	/**
	 * @brief  댓글등록 
	 * @param Map<String,Object>
	 * @throws Exception
	 * @return void
	 */		
	public void addReply(Map<String, Object> map) throws Exception;
}
