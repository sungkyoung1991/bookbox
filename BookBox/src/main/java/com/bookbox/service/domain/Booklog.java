package com.bookbox.service.domain;

import java.util.List;
import java.util.Map;

/**
 * @file com.bookbox.service.domain.Booklog.java
 * @brief Booklog domain
 * @detail
 * @author JW
 * @date 2017.10.12
 */

public class Booklog {
	
	//Field
	private int booklogNo;
	private User user;
	private String booklogName;
	private String booklogImage;
	private String booklogIntro;
	private List<Posting> postingList;
	private List<User> bookmarkList;
	private int viewCount;
	private Map<String, List<Map<String,Object>>> visitorsStatistics;
	
	public Booklog() {
		// TODO Auto-generated constructor stub
	}

	public int getBooklogNo() {
		return booklogNo;
	}

	public void setBooklogNo(int booklogNo) {
		this.booklogNo = booklogNo;
	}

	public User getUser() {
		return user;
	}
	
	public void setUser(User user) {
		this.user = user;
	}
	
	public String getBooklogName() {
		return booklogName;
	}
	
	public void setBooklogName(String booklogName) {
		this.booklogName = booklogName;
	}
	
	public List<Posting> getPostingList() {
		return postingList;
	}
	
	public void setPostingList(List<Posting> postingList) {
		this.postingList = postingList;
	}
	
	public String getBooklogImage() {
		return booklogImage;
	}
	
	public void setBooklogImage(String booklogImage) {
		this.booklogImage = booklogImage;
	}
	
	public List<User> getBookmarkList() {
		return bookmarkList;
	}
	
	public void setBookmarkList(List<User> bookmarkList) {
		this.bookmarkList = bookmarkList;
	}
	
	public String getBooklogIntro() {
		return booklogIntro;
	}
	
	public void setBooklogIntro(String booklogIntro) {
		this.booklogIntro = booklogIntro;
	}

	public int getViewCount() {
		return viewCount;
	}

	public void setViewCount(int viewCount) {
		this.viewCount = viewCount;
	}

	public Map<String, List<Map<String, Object>>> getVisitorsStatistics() {
		return visitorsStatistics;
	}

	public void setVisitorsStatistics(Map<String, List<Map<String, Object>>> visitorsStatistics) {
		this.visitorsStatistics = visitorsStatistics;
	}

	@Override
	public String toString() {
		return "Booklog [booklogNo=" + booklogNo + ", user=" + user + ", booklogName=" + booklogName + ", booklogImage="
				+ booklogImage + ", booklogIntro=" + booklogIntro + ", postingList=" + postingList + ", bookmarkList="
				+ bookmarkList + ", viewCount=" + viewCount + ", visitorsStatistics=" + visitorsStatistics + "]";
	}


}
