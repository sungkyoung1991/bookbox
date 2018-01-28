package com.bookbox.service.domain;

import java.util.List;

/**
 * @file com.bookbox.service.domain.Unifiedsearch.java
 * @brief Unifiedsearch domain
 * @detail
 * @author JJ
 * @date 2017.11.02
 */

public class Unifiedsearch {

	private String nick_name;
	private String title;
	private String content;
	private String reg_date;
	private String id;
	private String category;
	private String image;
	private List<String> tag;
	private List<Writing> writing;
	
	public Unifiedsearch() {
		// TODO Auto-generated constructor stub
	}
	
	public List<Writing> getWriting() {
		return writing;
	}

	public void setWriting(List<Writing> writing) {
		this.writing = writing;
	}

	public String getImage() {
		return image;
	}

	public void setImage(String image) {
		this.image = image;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getCategory() {
		return category;
	}

	public void setCategory(String category) {
		this.category = category;
	}

	
	public String getNick_name() {
		return nick_name;
	}

	public void setNick_name(String nick_name) {
		this.nick_name = nick_name;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getReg_date() {
		return reg_date;
	}

	public void setReg_date(String reg_date) {
		this.reg_date = reg_date;
	}

	public List<String> getTag() {
		return tag;
	}

	public void setTag(List<String> tag) {
		this.tag = tag;
	}
}
