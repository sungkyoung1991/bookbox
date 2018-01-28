package community;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.bookbox.common.domain.Const.Category;
import com.bookbox.common.domain.Page;
import com.bookbox.common.domain.Search;
import com.bookbox.service.community.CommunityDAO;
import com.bookbox.service.domain.Board;
import com.bookbox.service.domain.Comment;
import com.bookbox.service.domain.Report;
import com.bookbox.service.domain.User;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations={"classpath:config/context-mybatis.xml",
									"classpath:config/context-common.xml",
									"classpath:config/context-transaction.xml",
									"classpath:config/context-mail.xml"})

public class CommunityTest {

	@Autowired 
	@Qualifier("communityDAOImpl")
	CommunityDAO communityDAOImpl;
	
	//@Test
	public void addBoard() {
		User user=new User();
		user.setEmail("test@test.com");
		Board board=new Board();
		board.setWriter(user);
		board.setBoardTitle("TestTitle");
		board.setBoardContent("TestContent");
		
		communityDAOImpl.addBorad(board);
		
	}
	
	//@Test
	public void getBoard() {
		Board board=communityDAOImpl.getBoard(10);
		System.out.println(board.toString());
		System.out.println(board.getBoardRegDate());
	}
	
	//@Test
	public void updateBoard() {
		Board board=communityDAOImpl.getBoard(3);
		board.setBoardTitle("updateTitle");
		communityDAOImpl.updateBoard(board);
	}
	
	//@Test
	public void getBoardList() {
		Map map=new HashMap<String,Object>();
		Search search=new Search();
		search.setCondition("0");
		search.setKeyword("");
		
		Page page=new Page();
		page.setPageSize(5);
		page.setCurrentPage(1);
		
		map.put("search", search);
		map.put("page", page);
		
		List<Board> boardList;
		boardList=communityDAOImpl.getBoardList(map);
		System.out.println(boardList.size());
		for(Board b: boardList) {
			System.out.println(b);
		}
	
	}
	
//	@Test
	public void addComment() {
		User user=new User();
		user.setEmail("test@test.com");
		Comment comment=new Comment();
		comment.setBoardNo(4);
		comment.setLevel(0);
		comment.setContent("test");
		comment.setWriter(user);
		System.out.println(comment);
		communityDAOImpl.addComment(comment);
		
	}
	
	//@Test
	public void getCommentList() {
		List<Comment> commentList=communityDAOImpl.getCommentList(4);
		System.out.println(commentList);
		
		for(Comment c : commentList) {
			System.out.println(c);
		}
	}
	
	//@Test
	public void getCommentMaxLevel() {
		int level=communityDAOImpl.getCommentMaxLevel(10);
		System.out.println(level);
	}
	
	//@Test
	public void commonTest() {
		Calendar calendar=Calendar.getInstance();
		System.out.println(calendar.toString());
		
	}
	@Test
	public void addReport() {
		Report report=new Report();
		report.setEmail("gustn@naver.com");
		report.setCategoryNo(6);
		report.setTargetNo(11);
		int count=communityDAOImpl.getReport(report);
		System.out.println(count);
	}
}
