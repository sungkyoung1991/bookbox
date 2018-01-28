package common;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.bookbox.common.domain.Grade;
import com.bookbox.common.domain.Like;
import com.bookbox.common.domain.Reply;
import com.bookbox.service.domain.Book;
import com.bookbox.service.domain.User;
import com.bookbox.service.unifiedsearch.BookService;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = { "classpath:config/context-mybatis.xml", "classpath:config/context-common.xml",
		"classpath:config/context-transaction.xml", "classpath:config/context-aspect.xml", "classpath:config/context-mail.xml"})

public class commonTest {

	@Autowired
	@Qualifier("bookServiceImpl")
	private BookService bookService;

	private User user = new User();
	private Book book = new Book();
	private Reply reply = new Reply();
	private Like like = new Like();
	private Grade grade = new Grade();
	private List<Reply> listReply = new ArrayList<Reply>();

	/*@Test*/ 
	public void addReplyTest() {

		user.setEmail("test@test.com");
		book.setIsbn("9788954874971");
		reply.setContent("testtest");

		bookService.addBookReply(user, book, reply);
	}

	/*@Test*/ 
	public void deleteReplyTest() {

		user.setEmail("test@test.com");
		book.setIsbn("9788954874971");
		reply.setContent("에베베베");;

		System.out.println(reply.toString());
		
		bookService.deleteBookReply(user, book, reply);
	}

	@Test 
	public void getReplyListTest() {

		user.setEmail("test@test.com");
		book.setIsbn("9788954874971");

		listReply = (List<Reply>) bookService.getBookReplyList(user, book);
		
		System.out.println(listReply.size() + listReply.toString());
	}

	 /*@Test */
	public void addGradeTest() {

		user.setEmail("test@test.com");
		book.setIsbn("9788954874971");
		grade.setUserCount(1);

		bookService.addBookGrade(user, book, grade);
	}

	/* @Test */
	public void getGradeTest() {
		user.setEmail("test@test.com");
		book.setIsbn("9788954874971");

		System.out.println(bookService.getBookGrade(book, user));
	}

	/*@Test*/
	public void LikeTest() {

		user.setEmail("test@test.com");
		book.setIsbn("9788954874970");
		like.setDoLike(false);

		if (like.getDoLike()) 
			bookService.deleteBookLike(user, book); 
		
		else
			bookService.addBookLike(user, book);
	}

	/*@Test*/
	public void getLikeTest() {

		user.setEmail("join@google.com");
		book.setIsbn("9788954874971");

		System.out.println(bookService.getBookLike(book, user));
	}
	
	@Test
	public void getBookStaticsTest() {
		
		book.setIsbn("9788930705431");
		
		Map<String, Map<String, Integer>> map = bookService.getBookStatistics(book);
		
		System.out.println(map.toString());
	}
}
