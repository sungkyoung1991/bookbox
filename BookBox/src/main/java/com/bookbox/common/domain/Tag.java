package com.bookbox.common.domain;

/**
 * @file com.bookbox.common.domain.Tag.java
 * @brief Tag domain
 * @detail
 * @author JW
 * @date 2017.10.12
 */

public class Tag {

	//Field
	private String tagName;
	private int tagNo;
	
	public Tag() {
		// TODO Auto-generated constructor stub
	}
	
	public Tag(String tagName) {
		this.tagName = tagName;
	}

	public String getTagName() {
		return tagName;
	}

	public void setTagName(String tagName) {
		this.tagName = tagName;
	}

	public int getTagNo() {
		return tagNo;
	}

	public void setTagNo(int tagNo) {
		this.tagNo = tagNo;
	}

	@Override
	public String toString() {
		return "Tag [tagName=" + tagName + ", tagNo=" + tagNo + "]";
	}
}
