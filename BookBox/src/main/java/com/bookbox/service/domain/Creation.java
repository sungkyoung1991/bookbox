package com.bookbox.service.domain;

import java.sql.Date;
import java.util.List;

import com.bookbox.common.domain.Grade;
import com.bookbox.common.domain.Like;
import com.bookbox.common.domain.Tag;

/**
 * @file com.bookbox.service.domain.Creation.java
 * @brief Creation domain
 * @detail
 * @author HJ
 * @date 2017.10.11
 */

public class Creation {
	
	//Field
	private int creationNo;
	private String creationTitle;
	private String creationIntro;
	private User creationAuthor;
	private String creationHead;
	private String creationFileName;
	private String creationOriginName;
	private Date regDate;
	private List<Writing> writingList;
	private List<Tag> tagList;
	private boolean doFunding;
	private boolean doSubscription;
	private Grade grade;
	private Like like;
	private int active;
	
	public Creation() {
		// TODO Auto-generated constructor stub
	}

	public int getCreationNo() {
		return creationNo;
	}

	public void setCreationNo(int creationNo) {
		this.creationNo = creationNo;
	}

	public String getCreationTitle() {
		return creationTitle;
	}

	public void setCreationTitle(String creationTitle) {
		this.creationTitle = creationTitle;
	}

	public User getCreationAuthor() {
		return creationAuthor;
	}

	public void setCreationAuthor(User creationAuthor) {
		this.creationAuthor = creationAuthor;
	}

	public String getCreationHead() {
		return creationHead;
	}

	public void setCreationHead(String creationHead) {
		this.creationHead = creationHead;
	}

	public String getCreationFileName() {
		return creationFileName;
	}

	public void setCreationFileName(String creationFileName) {
		this.creationFileName = creationFileName;
	}
	
	public String getCreationOriginName() {
		return creationOriginName;
	}

	public void setCreationOriginName(String creationOriginName) {
		this.creationOriginName = creationOriginName;
	}

	public String getCreationIntro() {
		return creationIntro;
	}

	public void setCreationIntro(String creationIntro) {
		this.creationIntro = creationIntro;
	}

	public Date getRegDate() {
		return regDate;
	}

	public void setRegDate(Date regDate) {
		this.regDate = regDate;
	}

	public List<Writing> getWritingList() {
		return writingList;
	}

	public void setWritingList(List<Writing> writingList) {
		this.writingList = writingList;
	}

	public List<Tag> getTagList() {
		return tagList;
	}

	public void setTagList(List<Tag> tagList) {
		this.tagList = tagList;
	}

	public boolean isDoFunding() {
		return doFunding;
	}

	public void setDoFunding(boolean doFunding) {
		this.doFunding = doFunding;
	}

	public boolean isDoSubscription() {
		return doSubscription;
	}
	
	public void setDoSubscription(boolean doSubscription) {
		this.doSubscription = doSubscription;
	}
	
	public Grade getGrade() {
		return grade;
	}

	public void setGrade(Grade grade) {
		this.grade = grade;
	}

	public Like getLike() {
		return like;
	}

	public void setLike(Like like) {
		this.like = like;
	}


	public int getActive() {
		return active;
	}

	public void setActive(int active) {
		this.active = active;
	}

	@Override
	public String toString() {
		return "Creation [creationNo=" + creationNo + ", creationTitle=" + creationTitle + ", creationIntro="
				+ creationIntro + ", creationAuthor=" + creationAuthor + ", creationHead=" + creationHead
				+ ", creationFileName=" + creationFileName + ", creationOriginName=" + creationOriginName + ", regDate="
				+ regDate + ", writingList=" + writingList + ", tagList=" + tagList + ", doFunding=" + doFunding
				+ ", doSubscription=" + doSubscription + ", grade=" + grade + ", like=" + like + ", active=" + active
				+ "]\n";
	}


}
