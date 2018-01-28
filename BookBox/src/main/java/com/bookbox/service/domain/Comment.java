package com.bookbox.service.domain;

import java.sql.Date;
import java.util.List;

/**
 * @file com.bookbox.service.domain.Comment.java
 * @brief Comment domain
 * @detail
 * @author HS
 * @date 2017.10.12
 */

public class Comment {
	
	//Field
	private int commentNo;
	private int boardNo;
	private int seniorCommentNo;
	private User writer;
	private String content;
	private String regDate;
	private int level;
	private List<Comment> comment;
	private int active;
	private int recommendCount;
	private int reportCount;
	private boolean blind;
	
	public Comment() {
		// TODO Auto-generated constructor stub
	}

	public int getCommentNo() {
		return commentNo;
	}

	public void setCommentNo(int commentNo) {
		this.commentNo = commentNo;
	}

	public User getWriter() {
		return writer;
	}

	public void setWriter(User writer) {
		this.writer = writer;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getRegDate() {
		//return regDate;
		return this.regDate.split("\\.")[0];
	}

	public void setRegDate(String regDate) {
		this.regDate = regDate;
	}

	public int getLevel() {
		return level;
	}

	public void setLevel(int level) {
		this.level = level;
	}

	public List<Comment> getComment() {
		return comment;
	}

	public void setComment(List<Comment> comment) {
		this.comment = comment;
	}

	public boolean isBlind() {
		return blind;
	}

	public void setBlind(boolean blind) {
		this.blind = blind;
	}

	public int getBoardNo() {
		return boardNo;
	}

	public void setBoardNo(int boardNo) {
		this.boardNo = boardNo;
	}

	public int getSeniorCommentNo() {
		return seniorCommentNo;
	}

	public void setSeniorCommentNo(int seniorCommentNo) {
		this.seniorCommentNo = seniorCommentNo;
	}

	public int getActive() {
		return active;
	}

	public void setActive(int active) {
		this.active = active;
	}

	public int getReportCount() {
		return reportCount;
	}

	public void setReportCount(int reportCount) {
		this.reportCount = reportCount;
	}
	
	public int getRecommendCount() {
		return recommendCount;
	}

	public void setRecommendCount(int recomment) {
		this.recommendCount = recomment;
	}

	@Override
	public String toString() {
		return "Comment [commentNo=" + commentNo +", boardNo="+boardNo+", writer=" + writer + ", content=" + content + ", regDate="
				+ regDate + ", level=" + level + ", ReportCount"+reportCount +", blind=" + blind+ ", comment=" + comment + "]";
	}
}
