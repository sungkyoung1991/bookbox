package com.bookbox.common.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.bookbox.common.domain.Tag;
import com.bookbox.common.service.TagDAO;
import com.bookbox.common.service.TagService;

/**
 * @file com.bookbox.common.service.impl.TagServiceImpl.java
 * @brief Tag Service Implement
 * @detail Tag Service Implement
 * @author JW
 * @date 2017.10.16
 */

@Service("tagServiceImpl")
public class TagServiceImpl implements TagService {
	
	@Autowired
	@Qualifier("tagDAOImpl")
	private TagDAO tagDAO; 
	
	public TagServiceImpl() {
		System.out.println("Constructor :: "+getClass().getName());
	}

	@Override
	public List<Tag> getTagList(Tag tag) {
		// TODO Auto-generated method stub
		return tagDAO.getTagList(tag);
	}

	@Override
	public int addTagGroup(int category, Object target, List<Tag> tagList) {
		// TODO Auto-generated method stub
		addTagList(tagList);
		return tagDAO.addTagGroup(category, target, tagList);
	}

	@Override
	public List<Tag> getTagGroupList(int category, Object target) {
		// TODO Auto-generated method stub
		return tagDAO.getTagGroupList(category, target);
	}

	@Override
	public int updateTagGroup(int category, Object target, List<Tag> tagList) {
		// TODO Auto-generated method stub
		tagDAO.deleteTagGroup(category, target);
		addTagList(tagList);
		return tagDAO.addTagGroup(category, target, tagList);
	}

	/**
	 * @brief addTag 모듈화
	 * @param tagList
	 */
	public void addTagList(List<Tag> tagList) {
		for(Tag tag : tagList) {
			tagDAO.addTag(tag);
		}
	}
}
