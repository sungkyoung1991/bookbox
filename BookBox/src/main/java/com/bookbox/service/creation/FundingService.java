package com.bookbox.service.creation;

import java.util.List;
import java.util.Map;

import com.bookbox.service.domain.Funding;
import com.bookbox.service.domain.PayInfo;
import com.bookbox.service.domain.User;

/**
 * @file com.bookbox.service.creation.fundingService.java
 * @brief 펀딩 Service
 * @detail 인터페이스
 * @author HJ
 * @date 2017.10.11
 */

public interface FundingService {

	/**
	 * @brief 펀딩등록 
	 * @param User , Funding 
	 * @throws Exception
	 * @return void
	 */		
	public void addFunding(User user, Funding funding) throws Exception;
	
	/**
	 * @brief 펀딩 수정 
	 * @param User , Funding 
	 * @throws Exception
	 * @return void
	 */		
	public void updateFunding(User user, Funding funding) throws Exception;

	/**
	 * @brief 펀딩 조회 
	 * @param User, Funding
	 * @throws Exception
	 * @return Funding
	 */		
	public Funding getFunding(User user, Funding funding) throws Exception;
	
	public Funding getFunding(Funding funding) throws Exception;
	
	
	/**
	 * @brief 펀딩리스트, 펀딩리스트 총 개수
	 * @param Map<String, Object>
	 * @throws Exception
	 * @return List<Funding>
	 */	
	public List<Funding> getFundingList(Map<String, Object> map) throws Exception;
	
	/**
	 * @brief 펀딩참여자리스트, 펀딩참여자 총 인원수
	 * @param Map<String, Object>
	 * @throws Exception
	 * @return List<PayInfo>
	 */	
	public List<PayInfo> getFundingUserList(Map<String, Object> map) throws Exception;
	
	/**
	 * @brief 펀딩결제
	 * @param User , Funding 
	 * @throws Exception
	 * @return void
	 */		
	public void addPayInfo(User user, PayInfo payInfo) throws Exception;
	
	/**
	 * @brief 펀딩결제 정보수정 
	 * @param User , Funding 
	 * @throws Exception
	 * @return void
	 */		
	public void updatePayInfo(User user, PayInfo payInfo) throws Exception;

	/**
	 * @brief 펀딩결제 정보조회 
	 * @param User, Funding
	 * @throws Exception
	 * @return PayInfo
	 */		
	public PayInfo getPayInfo(User user, PayInfo payInfo) throws Exception;
	
	
	/**
	 * @brief 펀딩실패로 인한 취소 
	 * @param Funding
	 * @throws Exception
	 * @return void
	 */		
	public void cancelFunding(Funding funding) throws Exception;
	
	/**
	 * @brief 펀딩 active 비활성화/update와 동일
	 * @param Funding
	 * @throws Exception
	 * @return void
	 */		
	public void deleteFunding(Funding funding) throws Exception;
	

	public List<Funding> getCancelFundingList() throws Exception;
	
	public  void deletePayInfo(PayInfo payInfo) throws Exception;
}
