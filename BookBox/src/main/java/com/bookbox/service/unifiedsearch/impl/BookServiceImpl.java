package com.bookbox.service.unifiedsearch.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.bookbox.common.domain.Const;
import com.bookbox.common.domain.Grade;
import com.bookbox.common.domain.Like;
import com.bookbox.common.domain.Reply;
import com.bookbox.common.domain.Search;
import com.bookbox.common.domain.Tag;
import com.bookbox.common.service.CommonDAO;
import com.bookbox.common.service.TagService;
import com.bookbox.common.util.CommonUtil;
import com.bookbox.service.domain.Book;
import com.bookbox.service.domain.User;
import com.bookbox.service.unifiedsearch.BookSearchDAO;
import com.bookbox.service.unifiedsearch.BookService;

/**
 * @file com.bookbox.service.unifiedsearch.impl.BookServiceImpl.java
 * @brief BookServiceImpl
 * @detail
 * @author JJ
 * @date 2017.10.20
 */

@Service("bookServiceImpl")
public class BookServiceImpl implements BookService {

	@Autowired
	@Qualifier("bookSearchKakaoAladinDAOImpl")
	private BookSearchDAO bookSearchDAO;

	@Autowired
	@Qualifier("commonDAOImpl")
	private CommonDAO commonDAO;

	@Autowired
	@Qualifier("tagServiceImpl")
	private TagService tagService;

	private Map<String, Object> map;

	public BookServiceImpl() {
		System.out.println("Constructor :: " + this.getClass().getName());
	}

	@Override
	public List<Book> getBookList(Search search) throws Exception {
		search.setKeyword(search.getKeyword());
		return bookSearchDAO.getBookList(search);
	}

	@Override
	public Book getBook(User user, Book book) throws Exception {
		Book returnBook = bookSearchDAO.getBook(book.getIsbn());
		List<Tag> tagList = new ArrayList<Tag>();
		
		if(returnBook == null)
			return null;		

		if (!returnBook.getTag().getTagName().trim().equals("")) {
			tagList.add(returnBook.getTag());
			tagService.updateTagGroup(Const.Category.BOOK, returnBook.getIsbn(), tagList);
		}
		return returnBook;
	}

	@Override
	public List<Book> getRecommendBookList(String type) throws Exception {
		return bookSearchDAO.getRecommendBookList(type);
	}

	@Override
	public void addBookLike(User user, Book book) {
		map = CommonUtil.mappingCategoryTarget(Const.Category.BOOK, book.getIsbn(), user);
		commonDAO.addLike(map);
	}

	@Override
	public void deleteBookLike(User user, Book book) {
		map = CommonUtil.mappingCategoryTarget(Const.Category.BOOK, book.getIsbn(), user);
		commonDAO.deleteLike(map);
	}

	@Override
	public List<Reply> getBookReplyList(User user, Book book) {
		map = CommonUtil.mappingCategoryTarget(Const.Category.BOOK, book.getIsbn(), user);
		return commonDAO.getReplyList(map);
	}

	@Override
	public void addBookReply(User user, Book book, Reply reply) {
		map = CommonUtil.mappingCategoryTarget(Const.Category.BOOK, book.getIsbn(), user);
		map.put("reply", reply);
		commonDAO.addReply(map);
	}

	@Override
	public void deleteBookReply(User user, Book book, Reply reply) {
		map = CommonUtil.mappingCategoryTarget(Const.Category.BOOK, book.getIsbn(), user);
		map.put("reply", reply);
		commonDAO.deleteReply(map);
	}

	@Override
	public void addBookGrade(User user, Book book, Grade grade) {
		map = CommonUtil.mappingCategoryTarget(Const.Category.BOOK, book.getIsbn(), user);
		map.put("grade", grade);
		commonDAO.addGrade(map);
	}

	@Override
	public Grade getBookGrade(Book book, User user) {
		map = CommonUtil.mappingCategoryTarget(Const.Category.BOOK, book.getIsbn(), user);
		return commonDAO.getGrade(map);
	}

	@Override
	public Like getBookLike(Book book, User user) {
		map = CommonUtil.mappingCategoryTarget(Const.Category.BOOK, book.getIsbn(), user);
		return commonDAO.getLike(map);
	}

	@Override
	public Map<String, Map<String, Integer>> getBookStatistics(Book book) {
		Map<String, Map<String, Integer>> resultMap = new HashMap<String, Map<String, Integer>>();
		map = new HashMap<String, Object>();
		map.put("targetNo", book.getIsbn());
		map.put("gender", "남");

		resultMap.put("men", commonDAO.getBookStatics(map).get(0));

		map.put("gender", "여");

		resultMap.put("women", commonDAO.getBookStatics(map).get(0));

		return resultMap;
	}

	@Override
	public List<Book> getUserLikeBook(String email) throws Exception {
		Search search = new Search();

		if (commonDAO.getUserLikeBook(email)!=null) {
			search.setKeyword(commonDAO.getUserLikeBook(email));
			search.setCondition(categoryNum(search.getKeyword()));
			search.setOrder("4");
		}
		else
			return null;

		return bookSearchDAO.getBookList(search);
	}

	public String categoryNum(String str) {
		int num = 0;

		switch (str) {
		case "소설":
			num = 1;
			break;
		case "시/에세이":
			num = 3;
			break;
		case "인문":
			num = 5;
			break;
		case "가정/생활":
			num = 7;
			break;
		case "요리":
			num = 8;
			break;
		case "건강":
			num = 9;
			break;
		case "취미/스포츠":
			num = 11;
			break;
		case "경제/경영":
			num = 13;
			break;
		case "자기계발":
			num = 15;
			break;
		case "정치/사회":
			num = 17;
			break;
		case "정부간행물":
			num = 18;
			break;
		case "역사/문화":
			num = 19;
			break;
		case "종교":
			num = 21;
			break;
		case "예술/대중문화":
			num = 23;
			break;
		case "중/고등학습":
			num = 25;
			break;
		case "기술/공학":
			num = 26;
			break;
		case "외국어":
			num = 27;
			break;
		case "과학":
			num = 29;
			break;
		case "취업/수험서":
			num = 31;
			break;
		case "여행/기행":
			num = 32;
			break;
		case "컴퓨터/IT":
			num = 33;
			break;
		case "잡지":
			num = 35;
			break;
		case "사전":
			num = 37;
			break;
		case "청소년":
			num = 38;
			break;
		case "초등참고서":
			num = 39;
			break;
		case "유아":
			num = 41;
			break;
		case "아동":
			num = 42;
			break;
		case "어린이영어":
			num = 45;
			break;
		case "만화":
			num = 47;
			break;
		case "대학교재":
			num = 50;
			break;
		case "어린이전집":
			num = 51;
			break;
		case "한국소개도서":
			num = 53;
			break;
		}
		return num + "";
	}
}
