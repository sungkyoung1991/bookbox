package com.bookbox.service.creation;

import java.util.List;
import java.util.Map;

import com.bookbox.common.domain.Search;
import com.bookbox.service.domain.Creation;
import com.bookbox.service.domain.User;

/**
 * @file com.bookbox.service.creation.creationDAO.java
 * @brief 창작작품 DAO
 * @detail 인터페이스
 * @author HJ
 * @date 2017.10.11
 */

public interface CreationDAO {

	/**
	 * @brief INSERT/창작작품등록 
	 * @param Creation 
	 * @throws Exception
	 * @return void
	 */	
	public void addCreation(Creation creation) throws Exception;
	
	/**
	 * @brief GET/ 창작작품정보 가져오기 
	 * @param Creation
	 * @throws Exception
	 * @return Creation
	 */		
	public Creation getCreation(Map<String, Object> map) throws Exception;
	
	
	/**
	 * @brief UPDATE/ 창작작품수정 
	 * @param Creation
	 * @throws Exception
	 * @return void
	 */		
	public void updateCreation(Creation creation) throws Exception;
	
	/**
	 * @brief 창작작품리스트
	 * @param Map
	 * @throws Exception
	 * @return List<Creation>
	 */	
	public List<Creation> getCreationList(Map<String, Object> map) throws Exception;
	
	/**
	 * @brief 작품리스트 총 개수
	 * @param Search
	 * @throws Exception
	 * @return void
	 */
	public int getTotalCreationCount(Search search) throws Exception;
	

	/**
	 * @brief 작품구독신청
	 * @param Creation
	 * @throws Exception
	 * @return 
	 */	
	public void addCreationSubscribe(Map<String, Object> map) throws Exception;
	
	/**
	 * @brief 작품구독취소 
	 * @param Map 
	 * @throws Exception
	 * @return 
	 */	
	public void deleteCreationSubscribe(Map<String, Object> map) throws Exception;

	/**
	 * @brief 작품 구독정보 가져오기 
	 * @param Map
	 * @throws Exception
	 * @return int
	 */	
	public int getCreationSubscribe(Map<String, Object> map) throws Exception;

}
