package com.bookbox.service.creation;

import java.util.List;
import java.util.Map;

import com.bookbox.service.domain.Funding;
import com.bookbox.service.domain.PayInfo;

/**
 * @file com.bookbox.service.creation.FundingDAO.java
 * @brief 펀딩 DAO
 * @detail 인터페이스
 * @author HJ
 * @date 2017.10.11
 */

public interface FundingDAO {
	
	/**
	 * @brief 펀딩등록 
	 * @param User , Funding 
	 * @throws Exception
	 * @return void
	 */		
	public void addFunding(Funding funding) throws Exception;
	
	/**
	 * @brief 펀딩 수정 
	 * @param User , Funding 
	 * @throws Exception
	 * @return void
	 */		
	public void updateFunding(Funding funding) throws Exception;

	/**
	 * @brief 펀딩 조회 
	 * @param User, Funding
	 * @throws Exception
	 * @return Funding
	 */		
	public Funding getFunding(Funding funding) throws Exception;
	
	/**
	 * @brief 펀딩리스트
	 * @param Map<String, Object>
	 * @throws Exception
	 * @return List<Funding>
	 */	
	public List<Funding> getFundingList(Map<String, Object> map) throws Exception;
	
	/**
	 * @brief 펀딩리스트 총 개수
	 * @param Search
	 * @throws Exception
	 * @return int
	 */
	public int getTotalFundingCount(Map<String, Object> map) throws Exception;
	
	/**
	 * @brief 펀딩참여자리스트
	 * @param Map<String, Object>
	 * @throws Exception
	 * @return List<PayInfo>
	 */	
	public List<PayInfo> getFundingUserList(Map<String, Object> map) throws Exception;
	
	/**
	 * @brief 펀딩참여자리스트 총 인원
	 * @param Search
	 * @throws Exception
	 * @return int
	 */
	public int getTotalFundingUserCount(Map<String, Object> map) throws Exception;
	
	/**
	 * @brief 펀딩결제
	 * @param User , Funding 
	 * @throws Exception
	 * @return void
	 */		
	public void addPayInfo(PayInfo payInfo) throws Exception;
	
	/**
	 * @brief 펀딩결제 정보수정 
	 * @param PayInfo
	 * @throws Exception
	 * @return void
	 */		
	public void updatePayInfo(PayInfo payInfo) throws Exception;

	/**
	 * @brief 펀딩결제 정보조회 
	 * @param PayInfo
	 * @throws Exception
	 * @return void
	 */		
	public PayInfo getPayInfo(PayInfo payInfo) throws Exception;
	
	/**
	 * @brief 펀딩실패시 결제취소 
	 * @param PayInfo
	 * @throws Exception
	 * @return void
	 */		
	public void deletePayInfo(PayInfo payInfo) throws Exception;
	
	/**
	 * @brief 펀딩참여정보 조회 
	 * @param Map<String,Object>
	 * @throws Exception
	 * @return int
	 */		
	public int getDoFunding(Map<String, Object> map) throws Exception;

	/**
	 * @brief 펀딩취소 
	 * @param Funding
	 * @throws Exception
	 * @return void
	 */		
	public void cancelFunding(Funding funding) throws Exception;
	
	/**
	 * @brief 마감될 펀딩리스트 get
	 * @param 
	 * @throws Exception
	 * @return List<Funding>
	 */		
	public List<Funding> getCancelFundingList() throws Exception;
}
