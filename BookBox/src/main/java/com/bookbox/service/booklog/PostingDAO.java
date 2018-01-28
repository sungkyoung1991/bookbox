package com.bookbox.service.booklog;

import java.util.List;
import java.util.Map;

import com.bookbox.common.domain.Search;
import com.bookbox.service.domain.Posting;

/**
 * @file com.bookbox.service.booklog.PostingDAO.java
 * @author JW
 * @date 2017.10.10
 * @breif PostingDAO
 */
public interface PostingDAO {

	/**
	 * @brief 새로운 포스팅을 DB에 등록
	 * @param posting : 새로 등록될 포스팅 정보
	 * @return 저장여부
	 */
	public boolean addPosting(Posting posting);
	
	/**
	 * @brief DB에 저장된 포스팅 정보를 가져옴
	 * @param posting : postingNo가 포함된 가져올 포스팅 정보 
	 * @return postingNo에 해당하는 포스팅 전체 정보
	 */
	public Posting getPosting(Posting posting);
	
	/**
	 * @brief DB에 저장된 포스팅 목록을 조건에 따라 가져옴
	 * @param map : search, page를 포함
	 * 		search.condition == booklog : keyword는 북로그의 주인, 등록순으로 정렬된 리스트
	 * 		search.condition == main : keyword는 없음, 조회순으로 정렬된 리스트
	 * @return 조건에 맞는 포스팅 목록
	 */
	public List<Posting> getPostingList(Map<String, Object> map);
	
	/**
	 * @brief 기존 포스팅의 정보를 새로운 정보로 갱신
	 * @param posting : 갱신할 포스팅의 정보
	 * @return 갱신여부
	 */
	public boolean updatePosting(Posting posting);
	
	/**
	 * @brief 포스팅 수를 가져옴
	 * @param search : 포스팅 수를 셀 조건
	 * 		search.condition == booklog : keyword는 북로그의 주인, 등록순으로 정렬된 리스트
	 * 		search.condition == main : keyword는 없음, 조회순으로 정렬된 리스트
	 * @return 검색할 목록에 해당하는 포스팅 전체 수
	 */
	public int getPostingCount(Search search);
}
