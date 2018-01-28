<%@ page language="java" contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="com.bookbox.service.domain.User"%>
<%@page import="com.bookbox.service.domain.Creation"%>
<%@page import="java.sql.Date"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.bookbox.service.domain.PayInfo"%>
<%@page import="java.util.List"%>
<%@page import="com.bookbox.service.domain.Funding"%>

<% 
	Funding funding = new Funding();
	Creation creation = new Creation();
	User user = new User();
	List<PayInfo> payInfoList = new ArrayList<PayInfo>();
	List<Funding> fundingList = new ArrayList<Funding>();
	PayInfo payInfo = new PayInfo();
	User joinUser = new User();
	joinUser.setEmail("wndhks@naver.com");
	payInfo.setPayInfoNo(1);
	payInfo.setUser(joinUser);
	payInfo.setFundingTitle("TestFunding");
	payInfo.setUserName("주와니");
	payInfo.setAddr("주소를주소");
	payInfo.setPhone("111-2311-1231");
	payInfo.setRegDate(new Date(2017,11,1));
	
	/*1st funding*/
	funding.setFundingNo(1);
	funding.setFundingTitle("TestFunding");
	funding.setFundingIntro("테스트 중이니까 테스트중임");
	funding.setFundingRegDate(new Date(2017,11,1));
	funding.setFundingEndDate(new Date(2017,11,30));
	funding.setFundingTarget(5000);
	funding.setPerFunding(100);
	/* funding.setFundingFileName("test.jpg"); */
	
	user.setEmail("krinsa@naver.com");
	creation.setCreationNo(30);
	creation.setCreationTitle("창작공간 픽션글 1호");
	creation.setCreationAuthor(user);
	funding.setCreation(creation);
	
	for(int i=0; i<20; i++){
		payInfoList.add(new PayInfo());
	}
	payInfoList.add(payInfo);
	funding.setPayInfoList(payInfoList);

	fundingList.add(funding);
	

	/*2nd Funding*/
	Funding funding2 = new Funding();
	funding2.setFundingNo(1);
	funding2.setFundingTitle("TestFunding2");
	funding2.setFundingIntro("테스트 중이니까 테스트중임");
	funding2.setFundingRegDate(new Date(2017,11,1));
	funding2.setFundingEndDate(new Date(2017,11,25));
	funding2.setFundingTarget(50000);
	funding2.setPerFunding(2000);
	/* funding2.setFundingImage("test.jpg"); */
	
	Creation creation2 = new Creation();
	creation2.setCreationNo(32);
	creation2.setCreationTitle("창작공간 픽션글 2호");
	creation2.setCreationAuthor(user);
	funding2.setCreation(creation2);
	
	List<PayInfo> payInfoList2 = new ArrayList<PayInfo>();
	for(int i=0; i<22; i++){
		payInfoList2.add(new PayInfo());
	}
	funding2.setPayInfoList(payInfoList2);
	
	fundingList.add(funding2);

	
	request.setAttribute("payInfo", payInfo);
	request.setAttribute("fundingList", fundingList);
	request.setAttribute("funding", funding);
%>
