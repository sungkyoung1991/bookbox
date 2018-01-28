package com.bookbox.service.booklog;

import java.util.List;
import java.util.Map;

import com.bookbox.service.domain.Book;
import com.bookbox.service.domain.Booklog;
import com.bookbox.service.domain.User;

/**
 * @file com.bookbox.service.booklog.BooklogService.java
 * @author JW
 * @date 2017.10.10
 * @brief BooklogService
 */
public interface BooklogService {

	/**
	 * @brief 북로그 목록 조회
	 * @param map : search, page
	 * 				search.condition == main : 인기 북로그 목록
	 * 				search.condition == bookmark : keyword에 해당하는 유저의 책갈피 목록
	 * 				search.condition == nickname : keyword를 포함하는 닉네임 유저의 북로그 목록(미구현)
	 * @return 해당 조건에 맞는 북로그 목록
	 */
	public List<Booklog> getBooklogList(Map<String, Object> map);
	
	/**
	 * @brief 북로그 상세조회
	 * @param user : 조회를 요청한 유저 정보
	 * @param booklog : booklogNo를 가진 도메인
	 * @return 해당 북로그 상세정보
	 */
	public Booklog getBooklog(User user, Booklog booklog);
	
	/**
	 * @brief 북로그 정보수정
	 * @param user : 수정을 요청한 유저 정보
	 * @param booklog : 수정할 북로그 정보
	 */
	public void updateBooklog(User user, Booklog booklog);
	
	/**
	 * @brief 책갈피 추가
	 * @param user : 서비스를 요청한 유저 정보
	 * @param booklog : 책갈피에 추가할 북로그 정보
	 * @return 성공여부
	 */
	public boolean addBooklogBookmark(User user, Booklog booklog);

	/**
	 * @brief 책갈피 삭제
	 * @param user : 서비스를 요청한 유저 정보
	 * @param booklog : 책갈피 삭제할 북로그 정보
	 * @return 성공여부
	 */
	public boolean deleteBooklogBookmark(User user, Booklog booklog);
	
	/**
	 * @brief 책갈피 여부 확인
	 * @param user : 서비스를 요청한 유저 정보
	 * @param booklog : 책갈피 여부를 확인할 북로그 정보
	 * @return 책갈피 등록 여부
	 */
	public boolean getBookmark(User user, Booklog booklog);
	
	/**
	 * @brief 창작작품, 포스팅, 책갈피 숫자 확인
	 * @param email : 숫자를 확인할 유저
	 * @return creation, posting, bookmark 수
	 */
	public Map<String, String> getCounts(String email);

	/**
	 * @brief 좋아요 책 목록 조회
	 * @param map : email
	 * 				email : 조회할 유저 email
	 * @return 좋아요 책 목록
	 */
	public List<Book> getBookLikeList(Map<String, Object> map);
	
}
