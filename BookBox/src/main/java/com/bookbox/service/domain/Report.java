package com.bookbox.service.domain;

public class Report {

	private String email;
	private String category;
	private int categoryNo;
	private int targetNo;
	
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getCategory() {
		return category;
	}
	public void setCategory(String category) {
		this.category = category;
	}
	public int getCategoryNo() {
		return categoryNo;
	}
	public void setCategoryNo(int categoryNo) {
		this.categoryNo = categoryNo;
	}
	public int getTargetNo() {
		return targetNo;
	}
	public void setTargetNo(int targetNo) {
		this.targetNo = targetNo;
	}
	
	@Override
	public String toString() {
		
		return ("[Report] : email= "+email+", targetNo ="+targetNo+", category="+ category);
	}
	
	
}
