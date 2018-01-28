package com.bookbox.service.domain;

import java.util.List;

import com.bookbox.common.domain.Tag;
import com.bookbox.common.domain.UploadFile;

/**
 * @file com.bookbox.service.domain.Posting.java
 * @brief Posting domain
 * @detail
 * @author JW
 * @date 2017.10.12
 */

public class Posting {

	//Field
	private int postingNo;
	private User user;
	private String postingTitle;
	private String postingContent;
	private List<UploadFile> postingFileList;
	private String postingRegDate;
	private String postingUpdateDate;
	private List<Tag> postingTagList;
	private int viewCount;
	
	public Posting() {
		// TODO Auto-generated constructor stub
	}

	public int getPostingNo() {
		return postingNo;
	}

	public void setPostingNo(int postingNo) {
		this.postingNo = postingNo;
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	public String getPostingTitle() {
		return postingTitle;
	}

	public void setPostingTitle(String postingTitle) {
		this.postingTitle = postingTitle;
	}

	public String getPostingContent() {
		return postingContent;
	}

	public void setPostingContent(String postingContent) {
		this.postingContent = postingContent;
	}

	public List<UploadFile> getPostingFileList() {
		return postingFileList;
	}

	public void setPostingFileList(List<UploadFile> postingFileList) {
		this.postingFileList = postingFileList;
	}

	public String getPostingRegDate() {
		return postingRegDate;
	}

	public void setPostingRegDate(String postingRegDate) {
		this.postingRegDate = postingRegDate.substring(0,postingRegDate.lastIndexOf("."));
	}

	public String getPostingUpdateDate() {
		return postingUpdateDate;
	}

	public void setPostingUpdateDate(String postingUpdateDate) {
		this.postingUpdateDate = postingUpdateDate.substring(0,postingUpdateDate.lastIndexOf("."));
	}

	public List<Tag> getPostingTagList() {
		return postingTagList;
	}

	public void setPostingTagList(List<Tag> postingTagList) {
		this.postingTagList = postingTagList;
	}

	public int getViewCount() {
		return viewCount;
	}

	public void setViewCount(int viewCount) {
		this.viewCount = viewCount;
	}

	@Override
	public String toString() {
		return "Posting [postingNo=" + postingNo + ", user=" + user + ", postingTitle=" + postingTitle
				+ ", postingContent=" + postingContent + ", postingFileList=" + postingFileList + ", postingRegDate="
				+ postingRegDate + ", postingUpdateDate=" + postingUpdateDate
				+ ", postingTagList=" + postingTagList + ", viewCount=" + viewCount + "]";
	}

}
