package com.bookbox.service.unifiedsearch;

import java.util.List;

import com.bookbox.common.domain.Search;
import com.bookbox.common.domain.Tag;
import com.bookbox.service.domain.Book;

public interface BookSearchDAO {

	/**
	 * @file com.bookbox.service.unifiedsearch.getBookList.java
	 * @brief getBookList
	 * @detail KakaoAPI를 이용하여 검색어에 해당하는 도서 리스트 출력 
	 * @author JJ
	 * @return 
	 * @date 2017.10.17
	 */
	public List<Book> getBookList(Search search) throws Exception;

	/**
	 * @file com.bookbox.service.unifiedsearch.getBook.java
	 * @brief getBook
	 * @detail ISBN을 kakaoAPI에 검색하여 도서 상세 정보 출력
	 * @author JJ
	 * @throws Exception 
	 * @date 2017.10.17
	 */
	public Book getBook(String isbn) throws Exception;

	/**
	 * @file com.bookbox.service.unifiedsearch.getRecommendBookList.java
	 * @brief getRecommendBookList
	 * @detail AladinAPI를 이용하여 추천도서, 베스트셀러 리스트 출력
	 * @author JJ
	 * @throws Exception 
	 * @date 2017.11.03
	 */
	public List<Book> getRecommendBookList(String type) throws Exception;
}
