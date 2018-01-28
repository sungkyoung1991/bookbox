package com.bookbox.web.community;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartRequest;

import com.bookbox.common.domain.Page;
import com.bookbox.common.domain.Search;
import com.bookbox.common.domain.Tag;
import com.bookbox.common.service.TagService;
import com.bookbox.service.community.CommunityService;
import com.bookbox.service.domain.ChatRoom;
import com.bookbox.service.domain.Comment;
import com.bookbox.service.domain.Recommend;
import com.bookbox.service.domain.Report;
import com.bookbox.service.domain.User;
import com.bookbox.service.user.UserService;

/**
 * @file com.bookbox.web.community.CommunityRestCrontroller.java
 * @brief CommunityRestController
 * @detail 소모임 RestController
 * @author HS
 * @date 2017.10.17
 */

@RestController
@RequestMapping("/community/rest/*")
public class CommunityRestController {

	@Autowired
	@Qualifier("communityServiceImpl")
	CommunityService communityServiceImpl;
	
	@Autowired
	@Qualifier("tagServiceImpl")
	TagService tagServiceImpl;
	
	@Autowired
	@Qualifier("userServiceImpl")
	UserService userServiceImpl;
	
	int pageUnit;
	int pageSize;
	
	
	public CommunityRestController() {
		System.out.println("Constructor :: "+getClass().getName());
	}
	
	
	
	//게시판
	/**
	 * @brief getBoardList
	 * @detail 게시글 목록 조회  검색조건
	 * @param Search search
	 * @return Map "boardList","page"리턴 
	 */
	@RequestMapping(value="/getBoardList")
	public Map getBoardList(@ModelAttribute("Search")Search search,
								@ModelAttribute("Page")Page page) throws Exception{
		
		if(search.getKeyword()==null) {
			search.setKeyword("");
		}
		if(search.getCondition()==null) {
			search.setCondition("0");
		}
		if(search.getOrder()==null) {
			search.setOrder("0");
		}
		
		if(page.getCurrentPage()==0) {
			page.setCurrentPage(1);
		}
		if(page.getPageSize()==0) {
			page.setPageSize(5);
		}
		if(page.getPageUnit()==0) {
			page.setPageUnit(5);
		}
	//	System.out.println(page);
		
		Map map=new HashMap<String,Object>();
		map.put("search", search);
		map.put("page", page);
		
		
		List boardList;
		//boardList=communityServiceImpl.getBoardList(map);
		boardList=communityServiceImpl.getBoardList(map);
		//System.out.println(boardList.size());
		System.out.println(page);
		
		
		Map returnMap=new HashMap<String, Object>();
		returnMap.put("boardList", boardList);
		returnMap.put("page", page);
		
		return returnMap;
	}
	
	
	/**
	 * @brief addRecommend
	 * @detail 게시글, 댓글 추천 및 비추천 
	 * @param Recommend recommend 추천,비추천도 메인
	 * @return int 추천수 리턴 
	 */
	@RequestMapping(value="/addRecommend")
	public int addRecommend(HttpServletRequest request,
							@ModelAttribute("Recommend")Recommend recommend,
							HttpSession session ) throws Exception{
		
		//파라미터 확인용
	//	System.out.print("targetNo : "+request.getParameter("targetNo")+" ");
	//	System.out.print("category : "+request.getParameter("category")+" ");
	//	System.out.print("pref : "+request.getParameter("pref")+" ");
		System.out.println(recommend);
		
		User user=(User)session.getAttribute("user");
		
		//테스트용 유저정보////////////////////////////
		if(user==null) {
			user=new User();
			user.setEmail("gustn@naver.com");
			user=userServiceImpl.getUser(user);
		}
		
		recommend.setEmail(user.getEmail());
			
		
		return communityServiceImpl.addRecommend(user,recommend);
		
	}
	
	/**
	 * @brief addReport
	 * @detail 게시글, 댓글 신고
	 * @param Report report 신고 도메인
	 * @return int 신고 중복여부 리턴 
	 */
	@RequestMapping(value="/addReport")
	public int addReport(@ModelAttribute("Report")Report report,
						HttpSession session) throws Exception{
		
		System.out.println("addReport() Reprot= "+report);
		
		User user=(User)session.getAttribute("user");
		
		//테스트용 유저정보////////////////////////////
				if(user==null) {
					user=new User();
					user.setEmail("gustn@naver.com");
					user=userServiceImpl.getUser(user);
				}
		
		report.setEmail(user.getEmail());
		
		return communityServiceImpl.addReport(report);
	}
	
	
	/**
	 * @brief addComment
	 * @detail 댓글 추가
	 * @param Comment comment 댓글 도메인
	 * @return int 댓글 추가 성공 여부 리턴
	 */
	@RequestMapping(value="/addComment")
	public int addComment(@RequestBody Comment comment,HttpSession session) throws Exception{
		
	
		User user=(User)session.getAttribute("user");
		//테스트용 유저정보//
		//테스트용 유저정보////////////////////////////
		if(user==null) {
			user=new User();
			user.setEmail("gustn@naver.com");
			user=userServiceImpl.getUser(user);
		}
		
		
		comment.setWriter(user);
		System.out.println(comment);
		
		return communityServiceImpl.addComment(comment);
		
	}
	
	/**
	 * @brief getCommentList
	 * @detail 댓글 리스트 
	 * @param int boardNo 게시글 번호
	 * @return List 댓글리스트 리턴
	 */
	@RequestMapping(value="/getCommentList/{boardNo}")
	public List getCommentList(@PathVariable("boardNo")int boardNo) {
		
		//나중에 주석
		System.out.println("[getCommentList] boardNo= "+boardNo);
		
		List<Comment> commentList;
		commentList=communityServiceImpl.getCommentList(boardNo);
		
		return commentList;
	}
	

	/**
	 * @brief getTagList
	 * @detail 자동완선을 위한 태그목록 요청
	 * @param String tagName 
	 * @return List 태그 리스트 리턴
	 */
	@RequestMapping(value="/getTagNameList")
	public List getTagList(@RequestParam("tagName")String tagName){
		
		Tag tag=new Tag();
		tag.setTagName(tagName);
		List<Tag> tagList=tagServiceImpl.getTagList(tag);
		List<String> tagNameList=new ArrayList<String>();
		for(Tag t: tagList) {
			tagNameList.add(t.getTagName());
		}
		return  tagNameList;
	}
	
	
	//=======================채팅방=============================
	/**
	 * @brief updateChatRoomCurrentUser
	 * @detail 채팅방 현재접속자수 동기화
	 * @param int currentUser 현재유저수
	 * @param String roomId 방번호
	 * @param String roomType 방종류
	 * @return int 수정 된 현재유저수 리턴
	 */
	@RequestMapping(value="/updateChatRoomCurrentUser")
	public int updateChatRoomCurrentUser(@RequestParam("currentUser")int currentUser,
												@RequestParam("roomId")String roomId,
												@RequestParam("roomType")String roomType){
		
		ChatRoom chatRoom=null;
		if(roomType.equals("camchat")) {
			chatRoom=ChatRoom.camChatMap.get(roomId);
		}
		else if(roomType.equals("cast")) {
			chatRoom=ChatRoom.castMap.get(roomId);
		}
		
		chatRoom.setCurrentUser(currentUser);
		
		return chatRoom.getCurrentUser();
	}
	
	
	/**
	 * @brief deleteChatRoom
	 * @detail 채팅방 삭제
	 * @param String type 방종류
	 * @param String roomId 방번호
	 * @return 
	 */
	@RequestMapping(value="/deleteChatRoom")
	public void deleteChatRoom(@RequestParam("type")String type,
								@RequestParam("roomId")String roomId,HttpSession session) {
		
		ChatRoom chatRoom=null;
		if(type.equals("camchat")) {
			chatRoom=ChatRoom.camChatMap.get(roomId);
		}
		else if(type.equals("cast")) {
			chatRoom=ChatRoom.castMap.get(roomId);
		}
		else {
			System.out.println("잘못 된 타입입니다.");
		}

		
		User user=(User)session.getAttribute("user");
		if((user!=null) && (chatRoom!=null)) {
			//System.out.println("user:"+user);
			if(user.getEmail().equals(chatRoom.getHost().getEmail())) {
				System.out.println("방장 확인 방삭제");
				if(type.equals("camchat")) {
					ChatRoom.camChatMap.remove(roomId);
				}
				else if(type.equals("cast")) {
					ChatRoom.castMap.remove(roomId);
				}
			}
		}
		
		
		//System.out.println("deleteChatRoom Test");
	}
	
}
