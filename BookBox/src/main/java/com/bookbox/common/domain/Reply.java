package com.bookbox.common.domain;

import java.sql.Date;

import com.bookbox.service.domain.User;

/**
 * @file com.bookbox.common.domain.Reply.java
 * @brief Reply domain
 * @detail 창작글(writing), 책
 * @author HJ
 * @date 2017.10.11
 */

public class Reply {

	//Field
	private User user;
	private String regDate;
	private String content;
	
	public Reply() {
		// TODO Auto-generated constructor stub
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	public String getRegDate() {
		return regDate;
	}

	public void setRegDate(String regDate) {
		this.regDate = regDate.substring(0,regDate.lastIndexOf("."));
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	@Override
	public String toString() {
		return "Reply [user=" + user + ", regDate=" + regDate + ", content=" + content + "]";
	}
}
