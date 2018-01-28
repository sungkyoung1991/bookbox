package com.bookbox.web.unifiedsearch;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.bookbox.common.domain.Const;
import com.bookbox.common.domain.Search;
import com.bookbox.service.domain.Book;
import com.bookbox.service.domain.User;
import com.bookbox.service.unifiedsearch.BookService;
import com.bookbox.service.unifiedsearch.UnifiedsearchService;

/**
 * @file com.bookbox.web.unifiedsearch.UnifiredSearchCrontroller.java
 * @brief UnifiredSearchController
 * @detail
 * @author JJ
 * @date 2017.11.01
 */

@Controller
@RequestMapping("/unifiedsearch/*")
public class UnifiedsearchController {

	// Filed
	@Autowired
	@Qualifier("unifiedsearchServiceImpl")
	private UnifiedsearchService unifiedsearchService;

	@Autowired
	@Qualifier("bookServiceImpl")
	private BookService bookService;

	private Search search;

	// Constructor
	public UnifiedsearchController() {
		System.out.println("Constructor :: " + getClass().getName());
	}
	
	@RequestMapping(value = "getUnifiedsearchList", method = RequestMethod.GET)
	public String getUnifiedsearchList(Model model, @RequestParam("keyword") String keyword, @RequestParam("category") int category) throws Exception {
		System.out.println("/unifiedsearch/getUnifiedsearchList : GET");
		//List<String> tagList = new ArrayList<String>();
		//model.addAttribute("tagList", new ArrayList<String>(new HashSet<String>(tagList)));
		search = new Search();
		search.setCategory(category);
		search.setKeyword(keyword);
		Map<String, Object> map = unifiedsearchService.elasticSearch(search);
		
		model.addAttribute("total", map.get("total"));
		model.addAttribute("search", search);		
		model.addAttribute("result", map.get("result"));
		model.addAttribute("tagList", unifiedsearchService.elasticRelationTagSearch(search));
		
		switch (category) {
		case 1:
			 return "forward:../unifiedsearch/listCreation.jsp";
		case 5:
			return  "forward:../unifiedsearch/listPosting.jsp";
		case 6:
			return  "forward:../unifiedsearch/listCommunity.jsp";
		default:
			model.addAttribute("creationList", map.get("creationList"));
			model.addAttribute("boardList", map.get("boardList"));
			model.addAttribute("postingList", map.get("postingList"));
			model.addAttribute("bookList", bookService.getBookList(search));
			return "forward:../unifiedsearch/listUnifiedsearch.jsp";
		}
	}
	
	
	@RequestMapping(value = "getBookList", method = RequestMethod.GET)
	public String getBookList(HttpServletRequest request, Model model, @RequestParam("keyword") String keyword)
			throws Exception {
		System.out.println("/unifiedsearch/getBookList : GET");

		HttpSession session = request.getSession();
		User user = (User) session.getAttribute("user");
		search = new Search();
		search.setKeyword(keyword);
		search.setCategory(Const.Category.BOOK);
		List<Book> bookList = bookService.getBookList(search);

		if (user == null)
			user = new User();

		for (Book book : bookList) {
			book.setLike(bookService.getBookLike(book, user));
			book.setGrade(bookService.getBookGrade(book, user));
		}

		model.addAttribute("bookList", bookList);
		model.addAttribute("total", bookList.size());
		model.addAttribute("keyword", keyword);

		return "forward:../unifiedsearch/listBook.jsp";
	}

	@RequestMapping(value = "getBook", method = RequestMethod.GET)
	public String getBook(HttpServletRequest request, Model model, @RequestParam("isbn") String isbn) throws Exception {
		System.out.println("/unifiedsearch/getBook : GET");

		HttpSession session = request.getSession();
		User user = (User) session.getAttribute("user");
		Book book = new Book();
		Book resultBook = new Book();
		book.setIsbn(isbn);

		if (user == null)
			user = new User();
		
		if(bookService.getBook(user, book) == null) {
			model.addAttribute("bookEmpty", true);
			return "forward:../unifiedsearch/getBook.jsp";
		}
		
		Map<String, Map<String, Integer>> map = bookService.getBookStatistics(book);
			
		resultBook = bookService.getBook(user, book);
		resultBook.setLike(bookService.getBookLike(book, user));
		resultBook.setGrade(bookService.getBookGrade(book, user));
		resultBook.setReplyList(bookService.getBookReplyList(user, book));

		model.addAttribute("bookEmpty", false);
		model.addAttribute("book", resultBook);
		model.addAttribute("user", user);
		model.addAttribute("men", map.get("men"));
		model.addAttribute("women", map.get("women"));

		return "forward:../unifiedsearch/getBook.jsp";
	}
}
