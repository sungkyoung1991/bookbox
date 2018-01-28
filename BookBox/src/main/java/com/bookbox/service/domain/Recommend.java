package com.bookbox.service.domain;

public class Recommend {
	
	private String email;
	private int targetNo;
	private String Category;
	private int categoryNo;
	private String pref;
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public int getTargetNo() {
		return targetNo;
	}
	public void setTargetNo(int targetNo) {
		this.targetNo = targetNo;
	}
	public String getCategory() {
		return Category;
	}
	public void setCategory(String category) {
		Category = category;
	}
	public String getPref() {
		return pref;
	}
	public void setPref(String pref) {
		this.pref = pref;
	}
	
	public int getCategoryNo() {
		return categoryNo;
	}
	public void setCategoryNo(int categoryNo) {
		this.categoryNo = categoryNo;
	}
	@Override
	public String toString() {
		return "email="+email+", targetNo="+targetNo+",category="+Category+",pref="+pref;
	}
}
