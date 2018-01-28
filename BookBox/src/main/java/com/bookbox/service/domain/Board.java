package com.bookbox.service.domain;

import java.sql.Date;
import java.util.Calendar;
import java.util.List;

import com.bookbox.common.domain.Tag;

/**
 * @file com.bookbox.service.domain.Board.java
 * @brief Board domain
 * @detail
 * @author HS
 * @date 2017.10.12
 */

public class Board {
	
	///Field
	private int boardNo;
	private String boardTitle;
	private String boardContent;
	private String boardRegDate;
	private User writer;
	private int recommend;
	private int report;
	private List<Tag> tagList;
	private List<Comment> comment;
	private boolean blind;
	private String thumbnailUrl;
	private int commentCount;
	public Board() {
		// TODO Auto-generated constructor stub
	}

	public int getBoardNo() {
		return boardNo;
	}

	public List<Tag> getTagList() {
		return tagList;
	}

	public void setTagList(List<Tag> tagList) {
		this.tagList = tagList;
	}

	public void setBoardNo(int boardNo) {
		this.boardNo = boardNo;
	}

	public String getBoardTitle() {
		return boardTitle;
	}

	public void setBoardTitle(String boardTitle) {
		this.boardTitle = boardTitle;
	}

	public String getBoardContent() {
		return boardContent;
	}

	public void setBoardContent(String boardContent) {
		this.boardContent = boardContent;
	}

	public String getBoardRegDate() {
		
		return this.boardRegDate.split("\\.")[0];
		//return boardRegDate;
	}

	public void setBoardRegDate(String boardRegDate) {
		this.boardRegDate = boardRegDate;
	}

	public User getWriter() {
		return writer;
	}

	public void setWriter(User writer) {
		this.writer = writer;
	}

	public int getRecommend() {
		return recommend;
	}

	public void setRecommend(int recommend) {
		this.recommend = recommend;
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

	public int getReport() {
		return report;
	}

	public void setReport(int report) {
		this.report = report;
	}
	
	public String getThumbnailUrl() {
		return thumbnailUrl;
	}

	public void setThumbnailUrl(String thumbnailUrl) {
		this.thumbnailUrl = thumbnailUrl;
	}
	
	
	public int getCommentCount() {
		return commentCount;
	}

	public void setCommentCount(int commentCount) {
		this.commentCount = commentCount;
	}

	public String getContentText() {
		return this.boardContent.replaceAll("<(/)?([a-zA-Z]*)(\\s[a-zA-Z]*=[^>]*)?(\\s)*(/)?>", "");
	}

	@Override
	public String toString() {
		return "Board [boardNo=" + boardNo + ", boardTitle=" + boardTitle + ", boardContent=" + boardContent
				+ ", boardRegDate=" + boardRegDate + ", writer=" + writer + ", recommend=" + recommend + ", comment="
			+"reprot="+report+ comment + ", blind=" + blind +"tagList="+tagList+",thumbnailUrl="+thumbnailUrl +"]";
	}
}
