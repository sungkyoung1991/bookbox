package com.bookbox.service.user.impl;

import java.util.HashMap;
import java.util.Map;

import org.json.simple.JSONObject;
import org.json.simple.JSONValue;
import org.springframework.stereotype.Repository;

import com.bookbox.common.util.HttpUtil;
import com.bookbox.service.domain.User;
import com.bookbox.service.user.UserRestDAO;

/**
 * @file com.bookbox.service.user.impl.UserDAOKakaoImpl.java
 * @brief 카카오로그인 DAO impl
 * @detail
 * @author HJ
 * @date 2017.10.11
 */
@Repository("userDAOKakaoImpl")
public class UserDAOKakaoImpl implements UserRestDAO {

	/**
	 * @brief Kakao LOGIN
	 * @param User user
	 * @throws Exception
	 * @return User
	 */
	public User getUser(User user) throws Exception{
		
		String daumOpenAPIURL = "https://kapi.kakao.com/v1/user/me";
		
		Map<String, String> map = new HashMap<>();
		map.put("Authorization", "Bearer "+user.getOuterToken());
		
		String response = HttpUtil.requestMethodGet(daumOpenAPIURL, map);
		
        // Console 확인
        System.out.println("response정보 확인 :: "+response.toString());
        
        JSONObject jsonobj = (JSONObject)JSONValue.parse(response.toString());
        
         user.setEmail((String)jsonobj.get("kaccount_email"));
       
         System.out.println("email 정보 확인 :: "+(String)jsonobj.get("kaccount_email"));
     
         return user;
	}
	
	/**
	 * @brief Kakao LOGOUT
	 * @param User user
	 * @throws Exception
	 * @return void
	 */
	public void logout(User user) throws Exception{
		
		String daumOpenAPIURL = "https://kapi.kakao.com/v1/user/logout";
		
		Map<String, String> map = new HashMap<>();
		map.put("Authorization", "Bearer "+user.getOuterToken());
		
		String response = HttpUtil.requestMethodGet(daumOpenAPIURL, map);
		
		// Console 확인
        System.out.println("response정보 확인 :: "+response.toString());
        
        JSONObject jsonobj = (JSONObject)JSONValue.parse(response.toString());
        
         user.setEmail((String)jsonobj.get("kaccount_email"));
       
         System.out.println("로그아웃 된 email 정보 확인 :: "+(String)jsonobj.get("kaccount_email"));
	}
}
