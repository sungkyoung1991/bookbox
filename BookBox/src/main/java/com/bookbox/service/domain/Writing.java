package com.bookbox.service.domain;

import java.sql.Date;
import java.util.List;

import com.bookbox.common.domain.Grade;
import com.bookbox.common.domain.Reply;
import com.bookbox.common.domain.UploadFile;

/**
 * @file com.bookbox.service.domain.Writing.java
 * @brief Writing domain
 * @detail
 * @author HJ
 * @date 2017.10.11
 */

public class Writing {

	//Field
	private int writingNo;
	private int creationNo;
	private String writingAuthor;
	private String writingTitle;
	private String writingContent;
	private List<UploadFile> writingFileList;
	private Date regDate;
	private Date updateDate;
	private List<Reply> replyList;
	private Grade grade;
	private int viewCount;
	private int active;
	
	public Writing() {
		// TODO Auto-generated constructor stub
	}

	public int getWritingNo() {
		return writingNo;
	}

	public void setWritingNo(int writingNo) {
		this.writingNo = writingNo;
	}
	
	public int getCreationNo() {
		return creationNo;
	}

	public void setCreationNo(int creationNo) {
		this.creationNo = creationNo;
	}

	public String getWritingAuthor() {
		return writingAuthor;
	}

	public void setWritingAuthor(String writingAuthor) {
		this.writingAuthor = writingAuthor;
	}


	public void setWritingTitle(String writingTitle) {
		this.writingTitle = writingTitle;
	}

	public String getWritingContent() {
		return writingContent;
	}

	public void setWritingContent(String writingContent) {
		this.writingContent = writingContent;
	}

	public Date getRegDate() {
		return regDate;
	}

	public void setRegDate(Date regDate) {
		this.regDate = regDate;
	}

	public Date getUpdateDate() {
		return updateDate;
	}

	public void setUpdateDate(Date updateDate) {
		this.updateDate = updateDate;
	}

	public List<Reply> getReplyList() {
		return replyList;
	}

	public void setReplyList(List<Reply> replyList) {
		this.replyList = replyList;
	}

	public Grade getGrade() {
		return grade;
	}

	public void setGrade(Grade grade) {
		this.grade = grade;
	}

	public List<UploadFile> getWritingFileList() {
		return writingFileList;
	}
	
	public void setWritingFileList(List<UploadFile> writingFileList) {
		this.writingFileList = writingFileList;
	}

	public String getWritingTitle() {
		return writingTitle;
	}

	public int getViewCount() {
		return viewCount;
	}

	public void setViewCount(int viewCount) {
		this.viewCount = viewCount;
	}

	public int getActive() {
		return active;
	}

	public void setActive(int active) {
		this.active = active;
	}

	@Override
	public String toString() {
		return "Writing [writingNo=" + writingNo + ", creationNo = "+creationNo+", writingTitle=" + writingTitle + ", writingContent="
				+ writingContent + ", regDate=" + regDate + ", updateDate=" + updateDate + ", replyList=" + replyList
				+ ", grade=" + grade + ", writingFileList=" + writingFileList + ", viewCount=" + viewCount + ", active="
				+ active + "]";
	}

}
