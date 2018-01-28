package com.bookbox.common.service;

import java.util.List;

import com.bookbox.common.domain.Tag;
/**
 * @file com.bookbox.common.service.TagDAO.java
 * @brief Tag DAO
 * @detail Tag DAO
 * @author JW
 * @date 2017.10.16
 */

public interface TagDAO {

	/**
	 * @brief tag TABLE에 tag 저장 후 tagNo를 가져옴
	 * @detail DuplicationKeyException 발생시 해당 tag 전체 정보를 가져옴
	 * @param tag
	 * @return 성공여부
	 */
	public int addTag(Tag tag);
	
	/**
	 * @brief REST Controller에서 tag 자동완성목록 반환
	 * @param tag
	 * @return tagList : 자동완성목록
	 */
	public List<Tag> getTagList(Tag tag);
	
	/**
	 * @brief 해당 content의 tagGroup을 DB에 저장
	 * @param category
	 * @param target
	 * @param tagList
	 * @return 저장된 tagGroup 수
	 */
	public int addTagGroup(int category, Object target, List<Tag> tagList);
	
	/**
	 * @brief 해당 content의 tagGroupList를 반환
	 * @param category
	 * @param target
	 * @return tagGroupList
	 */
	public List<Tag> getTagGroupList(int category, Object target);
	
	/**
	 * @brief 해당 content의 tagGroup을 DB에서 삭제
	 * @param category
	 * @param target
	 * @return 삭제된 tagGroup 수
	 */
	public int deleteTagGroup(int category, Object target);
	
}
