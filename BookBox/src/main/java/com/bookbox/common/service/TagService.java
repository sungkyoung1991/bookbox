package com.bookbox.common.service;

import java.util.List;

import com.bookbox.common.domain.Tag;
/**
 * @file com.bookbox.common.service.TagService.java
 * @brief Tag Service
 * @detail Tag Service
 * @author JW
 * @date 2017.10.16
 */

public interface TagService {

	/**
	 * @brief REST Controller에서 tag 자동완성목록 반환 
	 * @param tag
	 * @return tagList : 자동완성목록
	 */
	public List<Tag> getTagList(Tag tag);
	
	/**
	 * @brief content에 추가할 tagGroup을 저장
	 * @param category
	 * @param target
	 * @param tagList
	 * @return 저장된 tagGroup 수
	 */
	public int addTagGroup(int category, Object target, List<Tag> tagList);
	
	/**
	 * @brief 해당 content의 tagList를 반환
	 * @param category
	 * @param target
	 * @return tagList
	 */
	public List<Tag> getTagGroupList(int category, Object target);
	
	/**
	 * @breif content에 있는 tagGroup을 새로운 tagGroup으로 저장 
	 * @param category
	 * @param target
	 * @param tagList
	 * @return 수정된 tagGroup 수
	 */
	public int updateTagGroup(int category, Object target, List<Tag> tagList);
	
}
