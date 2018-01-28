package com.bookbox.service.booklog;

import java.util.Map;

import com.bookbox.service.domain.Posting;
import com.bookbox.service.domain.User;

/**
 * @file com.bookbox.service.booklog.PostingService.java
 * @author JW
 * @date 2017.10.10
 * @brief PostingService
 */
public interface PostingService {

	/**
	 * @brief 새로운 포스팅 등록
	 * @param user
	 * @param posting
	 * @return 성공여부
	 * @throws Exception
	 */
	public boolean addPosting(User user, Posting posting) throws Exception;
	
	/**
	 * @brief 단일 포스팅 조회
	 * @param user
	 * @param posting
	 * @return 포스팅 상세정보
	 */
	public Posting getPosting(User user, Posting posting);
	
	/**
	 * @brief 포스팅 목록 조회
	 * @param map search, page 소유
	 * 			search.condition == booklog : 해당 북로그의 포스팅 목록 조회
	 * 			search.condition : main : 인기 포스팅 목록 조회
	 * @return 조건에 해당하는 포스팅 목록
	 */
	public Map<String, Object> getPostingList(Map<String, Object> map);
	
	/**
	 * @brief 포스팅 정보 수정
	 * @param user
	 * @param posting
	 * @return 수정여부
	 * @throws Exception
	 */
	public boolean updatePosting(User user, Posting posting) throws Exception;
	
}
