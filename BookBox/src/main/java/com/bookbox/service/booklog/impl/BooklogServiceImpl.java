package com.bookbox.service.booklog.impl;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.bookbox.common.domain.Const;
import com.bookbox.common.service.CommonDAO;
import com.bookbox.common.util.CommonUtil;
import com.bookbox.service.booklog.BooklogDAO;
import com.bookbox.service.booklog.BooklogService;
import com.bookbox.service.domain.Book;
import com.bookbox.service.domain.Booklog;
import com.bookbox.service.domain.Posting;
import com.bookbox.service.domain.User;
import com.bookbox.service.unifiedsearch.BookSearchDAO;

@Service("booklogServiceImpl")
public class BooklogServiceImpl implements BooklogService {

	@Autowired
	@Qualifier("booklogDAOImpl")
	private BooklogDAO booklogDAO;
	
	@Autowired
	@Qualifier("bookSearchKakaoAladinDAOImpl")
	private BookSearchDAO bookSearchDAO;
	
	@Autowired
	@Qualifier("commonDAOImpl")
	private CommonDAO commonDAO;
	
	public BooklogServiceImpl() {
		System.out.println("Constructor :: "+getClass().getName());
	}
	
	@Override
	public List<Booklog> getBooklogList(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return booklogDAO.getBooklogList(map);
	}

	@Override
	public Booklog getBooklog(User user, Booklog booklog) {
		// TODO Auto-generated method stub
		booklog = booklogDAO.getBooklog(booklog);
		for(Posting posting : booklog.getPostingList()) {
			StringBuffer content = new StringBuffer();
			for(String seq : posting.getPostingContent().split("<")) {
				if(seq.indexOf(">") != -1) {
					content.append(seq.substring(seq.indexOf(">")+1));
				}else {
					content.append(seq);
				}
			}
			posting.setPostingContent(content.toString());
		}
		return booklog;
	}

	@Override
	public void updateBooklog(User user, Booklog booklog) {
		// TODO Auto-generated method stub
		booklogDAO.updateBooklog(booklog);
	}

	@Override
	public boolean addBooklogBookmark(User user, Booklog booklog) {
		// TODO Auto-generated method stub
		if(booklogDAO.addBookmark(user, booklog) > 0) {
			return true;
		}else {
			return false;
		}
	}

	@Override
	public boolean deleteBooklogBookmark(User user, Booklog booklog) {
		// TODO Auto-generated method stub
		if(booklogDAO.deleteBookmark(user, booklog) > 0) {
			return true;
		}else {
			return false;
		}
	}

	@Override
	public boolean getBookmark(User user, Booklog booklog) {
		// TODO Auto-generated method stub
		return booklogDAO.getBookmark(user, booklog);
	}

	@Override
	public Map<String, String> getCounts(String email) {
		// TODO Auto-generated method stub
		return booklogDAO.getCounts(email);
	}

	@Override
	public List<Book> getBookLikeList(Map<String, Object> map) {
		// TODO Auto-generated method stub
		List<String> isbnList = booklogDAO.getBookLikeList(map);
		List<Book> bookList = new ArrayList<Book>();
		for(String isbn : isbnList) {
			try {
				Book book = bookSearchDAO.getBook(isbn);
				User user = (User)map.get("user");
				System.out.println(user);
				Map<String, Object> mappingCategoryTarget = CommonUtil.mappingCategoryTarget(Const.Category.BOOK, book.getIsbn(), user);
				book.setLike(commonDAO.getLike(mappingCategoryTarget));
				book.setGrade(commonDAO.getGrade(mappingCategoryTarget));
				bookList.add(book);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		return bookList;
	}


}
