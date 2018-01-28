package unifiedsearch;

import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.bookbox.common.domain.Const.Category;
import com.bookbox.common.domain.Search;
import com.bookbox.service.domain.Book;
import com.bookbox.service.domain.User;
import com.bookbox.service.unifiedsearch.BookService;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = { "classpath:config/context-mybatis.xml", "classpath:config/context-common.xml",
		"classpath:config/context-transaction.xml", "classpath:config/context-aspect.xml", "classpath:config/context-mail.xml"})

public class bookTest {

	@Autowired
	@Qualifier("bookServiceImpl")
	private BookService bookService;

	private User user = new User();
	private Book book = new Book();
	private Search search = new Search();

	/* @Test */
	public void bookListSearchTest() throws Exception {

		search.setKeyword("죄와벌");
		search.setCondition("도서");
		search.setCategory(Category.BOOK);

		bookService.getBookList(search);
	}

	/*@Test*/ 
	public void bookSearchTest() throws Exception {

		user.setEmail("test@test.com");
		book.setIsbn("9788954874977");

		bookService.getBook(user, book);
	}

	/*@Test*/
	public void getRecommendBookList() throws Exception {
		List<Book> list = bookService.getRecommendBookList("ItemNewAll");
	} 
	
	@Test
	public void getUserBookListTest() throws Exception {
		user.setEmail("1015wlswn@naver.com");	
		System.out.println(bookService.getUserLikeBook(user.getEmail()));
	}
}
