package com.bookbox.service.creation;

import java.util.List;
import java.util.Map;

import com.bookbox.common.domain.Search;
import com.bookbox.service.domain.Creation;
import com.bookbox.service.domain.User;
import com.bookbox.service.domain.Writing;

/**
 * @file com.bookbox.service.creation.writingDAO.java
 * @brief 창작글 DAO
 * @detail 인터페이스
 * @author HJ
 * @date 2017.10.11
 */

public interface WritingDAO {

	/**
	 * @brief 창작글등록 
	 * @param Writing 
	 * @throws Exception
	 * @return void
	 */	
	public void addWriting(Writing writing) throws Exception;
	
	/**
	 * @brief 창작글 업로드 이미지 등록 
	 * @param User , Writing 
	 * @throws Exception
	 * @return void
	 */	
	public void addUploadImage(Writing writing) throws Exception;
	
	/**
	 * @brief 창작글 수정 
	 * @param Writing Writing
	 * @throws Exception
	 * @return void
	 */		
	public void updateWriting(Writing writing ) throws Exception;

	/**
	 * @brief 창작글 조회 
	 * @param Writing 
	 * @throws Exception
	 * @return Writing
	 */		
	public Writing getWriting(Writing writing) throws Exception;
	
	/**
	 * @brief 창작글리스트, 창작글 총 개수
	 * @param Map<String, Object> 
	 * @throws Exception
	 * @return void
	 */	
	public List<Writing> getWritingList(Map<String, Object> map) throws Exception;
	
	/**
	 * @brief 창작글리스트 총 개수
	 * @param Search search
	 * @throws Exception
	 * @return void
	 */
	public int getTotalWritingCount(Creation creation) throws Exception;

	
	/**
	 * @brief 창작글 삭제 
	 * @param Writing
	 * @throws Exception
	 * @return void
	 */		
	public void deleteWriting(Writing writing) throws Exception;
	
}
