package com.bookbox.common.domain;

/**
 * @file com.bookbox.common.domain.Search.java
 * @brief Search domain
 * @detail
 * @author JJ
 * @date 2017.10.12
 */

public class Search {

	//Field
	private String keyword;
	private String condition;
	private String order;
	private int category;
	
	public Search() {
		// TODO Auto-generated constructor stub
	}

	public String getKeyword() {
		return keyword;
	}

	public void setKeyword(String keyword) {
		this.keyword = keyword;
	}

	public String getCondition() {
		return condition;
	}

	public void setCondition(String condition) {
		this.condition = condition;
	}

	public int getCategory() {
		return category;
	}

	public void setCategory(int category) {
		this.category = category;
	}
	
	public String getOrder() {
		return order;
	}

	public void setOrder(String order) {
		this.order = order;
	}

	@Override
	public String toString() {
		return "Search [keyword=" + keyword + ", condition=" + condition + ", category=" + category + "]";
	}
}
