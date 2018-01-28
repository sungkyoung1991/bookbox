package com.bookbox.service.domain;

import java.sql.Date;

/**
 * @file com.bookbox.service.domain.PayInfo.java
 * @brief PayInfo domain
 * @detail
 * @author HJ
 * @date 2017.10.11
 */

public class PayInfo {
	
	//Field
	private int payInfoNo;
	private int fundingNo;
	private String fundingTitle;
	private User user;
	private String tid;
	private String uid;
	private String userName;
	private String postCode;
	private String addr;
	private String addrDetail;
	private String phone;
	private Date regDate;

	public PayInfo() {
		// TODO Auto-generated constructor stub
	}

	public int getPayInfoNo() {
		return payInfoNo;
	}

	public void setPayInfoNo(int payInfoNo) {
		this.payInfoNo = payInfoNo;
	}

	public int getFundingNo() {
		return fundingNo;
	}

	public void setFundingNo(int fundingNo) {
		this.fundingNo = fundingNo;
	}

	public String getFundingTitle() {
		return fundingTitle;
	}

	public void setFundingTitle(String fundingTitle) {
		this.fundingTitle = fundingTitle;
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	public String getTid() {
		return tid;
	}

	public void setTid(String tid) {
		this.tid = tid;
	}

	public String getUid() {
		return uid;
	}

	public void setUid(String uid) {
		this.uid = uid;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}
	
	public String getPostCode() {
		return postCode;
	}

	public void setPostCode(String postCode) {
		this.postCode = postCode;
	}

	public String getAddr() {
		return addr;
	}

	public void setAddr(String addr) {
		this.addr = addr;
	}
	
	public String getAddrDetail() {
		return addrDetail;
	}

	public void setAddrDetail(String addrDetail) {
		this.addrDetail = addrDetail;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public Date getRegDate() {
		return regDate;
	}

	public void setRegDate(Date regDate) {
		this.regDate = regDate;
	}

	@Override
	public String toString() {
		return "PayInfo [payInfoNo=" + payInfoNo + ", fundingNo=" + fundingNo + ", fundingTitle=" + fundingTitle
				+ ", user=" + user + ", tid=" + tid + ", uid=" + uid + ", userName=" + userName + ", postCode="
				+ postCode + ", addr=" + addr + ", addrDetail=" + addrDetail + ", phone=" + phone + ", regDate="
				+ regDate + "]";
	}

	


}
