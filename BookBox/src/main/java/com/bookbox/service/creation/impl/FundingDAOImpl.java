package com.bookbox.service.creation.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.json.simple.JSONObject;
import org.json.simple.JSONValue;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Repository;

import com.bookbox.common.util.HttpUtil;
import com.bookbox.service.creation.FundingDAO;
import com.bookbox.service.domain.Funding;
import com.bookbox.service.domain.PayInfo;

/**
 * @file com.bookbox.service.creation.impl.fundingDAOImpl.java
 * @brief 펀딩 DAO impl
 * @detail
 * @author HJ
 * @date 2017.10.11
 */
@Repository("fundingDAOImpl")
public class FundingDAOImpl implements FundingDAO {

	/**
	 * Field
	 */
	@Autowired
	@Qualifier("sqlSessionTemplate")
	private SqlSession sqlSession;
	
	@Value("#{restapiProperties['importAPIKey']}")
	String importAPIKey;
	@Value("#{restapiProperties['importAPIsecret']}")
	String importAPIsecret;
	@Value("#{restapiProperties['importIDcode']}")
	String importIDcode;
	@Value("#{restapiProperties['importRequestURL_cancel']}")
	String importRequestURL_cancel;
	@Value("#{restapiProperties['importRequestURL_getToken']}")
	String importRequestURL_getToken;	
	
	
	/**
	 * Constructor
	 */
	public FundingDAOImpl() {
		System.out.println("Constructor :: "+getClass().getName());
	}

	@Override
	public void addFunding(Funding funding) throws Exception {
		// TODO Auto-generated method stub
		sqlSession.insert("FundingMapper.addFunding", funding);
	}

	@Override
	public void updateFunding(Funding funding) throws Exception {
		// TODO Auto-generated method stub
		sqlSession.update("FundingMapper.updateFunding", funding);
	}

	@Override
	public Funding getFunding(Funding funding) throws Exception {
		// TODO Auto-generated method stub
		
		Map<String, Object> map = new HashMap<>();
		map.put("fundingNo", funding.getFundingNo());
		
		funding = sqlSession.selectOne("FundingMapper.getFunding", funding);
		funding.setPayInfoList(this.getFundingUserList(map));
		
		return funding;
	}

	@Override
	public List<Funding> getFundingList(Map<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectList("FundingMapper.getFundingList", map);
	}

	@Override
	public int getTotalFundingCount(Map<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("FundingMapper.getTotalFundingCount", map);
	}

	@Override
	public List<PayInfo> getFundingUserList(Map<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectList("FundingMapper.getFundingUserList", map);
	}

	@Override
	public int getTotalFundingUserCount(Map<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("FundingMapper.getTotalFundingUserCount", map);
	}

	@Override
	public void addPayInfo(PayInfo payInfo) throws Exception {
		// TODO Auto-generated method stub
		sqlSession.insert("FundingMapper.addPayInfo", payInfo);
	}

	@Override
	public void updatePayInfo(PayInfo payInfo) throws Exception {
		// TODO Auto-generated method stub
		sqlSession.update("FundingMapper.updatePayInfo", payInfo);
	}

	@Override
	public PayInfo getPayInfo(PayInfo payInfo) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("FundingMapper.getPayInfo", payInfo);
	}
	
	@Override
	public void deletePayInfo(PayInfo payInfo) throws Exception {
		// TODO Auto-generated method stub
		sqlSession.delete("FundingMapper.deletePayInfo", payInfo);
		
	}

	@Override
	public int getDoFunding(Map<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("FundingMapper.getDoFunding",map);
	}

	@Override
	public List<Funding> getCancelFundingList() throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectList("FundingMapper.getCancelFundingList");
	}

	@Override
	public void cancelFunding(Funding funding) throws Exception {
		// TODO Auto-generated method stub
		String data="";
		String response="";
	
		//getToken header
		Map<String, String> headers = new HashMap<>();
		headers.put("Content-Type", "application/json");
		
		//getToken data
		data="{\"imp_key\":\""+importAPIKey+"\", \"imp_secret\":\""+importAPIsecret+"\"}";
		
		response=HttpUtil.requestMethodPost(importRequestURL_getToken, headers, data);
		
		JSONObject jsonobj = (JSONObject)JSONValue.parse(response.toString());
		jsonobj =(JSONObject)JSONValue.parse(jsonobj.get("response").toString());
		
		System.out.println("FundingDAOImpl :: cancelFunding :: accessToken :: "+jsonobj.get("access_token"+"\n"));
		
		
		//cancel header
		headers.put("Authorization", jsonobj.get("access_token").toString());
		
		//cancel data
		List<PayInfo> payInfoList = funding.getPayInfoList();

		for(PayInfo payInfo : payInfoList) {
			data="{\"imp_uid\":\""+payInfo.getUid()+"\"}";
			response = HttpUtil.requestMethodPost(importRequestURL_cancel, headers, data);

			System.out.println("FundingDAOImpl :: cancelFunding :: cancel response정보 확인 :: "+response.toString());
			
			//펀딩 active 업데이트 필요
		}
       
	}

	
	
	
}
