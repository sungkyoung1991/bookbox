package com.bookbox.service.community;

import java.util.List;
import java.util.Map;

import com.bookbox.service.domain.Board;
import com.bookbox.service.domain.ChatRoom;
import com.bookbox.service.domain.Comment;
import com.bookbox.service.domain.Recommend;
import com.bookbox.service.domain.Report;
import com.bookbox.service.domain.User;

/**
 * @file com.bookbox.service.CommunityService.java
 * @brief CommunityService
 * @detail 소모임 서비스
 * @author HS
 * @date 2017.11.20
 */
public interface CommunityService {

	/**
	 * @brief addBoard
	 * @detail 게시글 추가  
	 * @param User user 로그 남기기용 
	 * @param Board board 게시글 도메인
	 * @return int 게시글 추가 성공여부
	 */
	public int addBoard(User user,Board board) throws Exception;
	
	/**
	 * @brief getBoard
	 * @detail 게시글 조회
	 * @param User user 로그 남기기용
	 * @param Board board 게시글 도메인
	 * @return Board 
	 */
	public Board getBoard(User user,Board board);
	
	/**
	 * @brief deleteBoard
	 * @detail 게시글 삭제
	 * @param int boardNo 게시글 번호
	 * @return int 삭제 성공 여부 
	 */
	public int deleteBoard(int boardNo) throws Exception;
	
	/**
	 * @brief updateBoard
	 * @detail 게시글 수정
	 * @param Board board 게시글 도메인
	 * @return int 수정 성공 여부 
	 */
	public int updateBoard(Board board) throws Exception;
	
	/**
	 * @brief getBoardList
	 * @detail 게시글 목록 조회
	 * @param Map map ("search","page")
	 * @return List<Board> 
	 */
	public List<Board> getBoardList(Map map);
	
	/**
	 * @brief getBoardListUserTagMapper
	 * @detail 게시글 목록 조회 !!쓰지않는다.
	 * @param Map map ("search","page")
	 * @return List<Board> 
	 */
	public List<Board> getBoardListUserTagMapper(Map map);
	
	/**
	 * @brief addRecommend
	 * @detail 추천추가
	 * @param User user 로그남기기용
	 * @param Recommend recommend 추천 도메인
	 * @return int 성공 여부 
	 */
	public int addRecommend(User user,Recommend recommend);
	
	/**
	 * @brief getCommentList
	 * @detail 댓글 목록 조회
	 * @param int boardNo 게시글 번호
	 * @return List<Comment> 댓글 목록 리턴 
	 */
	public List getCommentList(int boardNo);
	
	/**
	 * @brief addReport
	 * @detail 게시글, 댓글 신고추가
	 * @param Report report 신고 도메인
	 * @return int 성공 여부
	 */
	public int addReport(Report report);
	
	/**
	 * @brief addComment
	 * @detail 댓글 추가
	 * @param Comment comment 댓글 도메인
	 * @return int 성공 여부 
	 */
	public int addComment(Comment comment);
	
	/**
	 * @brief addChatRoom
	 * @detail 채팅방 생성
	 * @param ChatRoom chatroom 채팅방 도메인
	 * @param User user 
	 * @return int 성공 여부 
	 */
	public int addChatRoom(User user,ChatRoom chatroom);
	
	/**
	 * @brief getCamChat
	 * @detail 화상채팅 조회
	 * @param String roomid
	 * @param User user 
	 * @return boolean 존재여부
	 */
	public boolean getCamChat(User user,String roomId);
	
	/**
	 * @brief getCast
	 * @detail 방송 조회
	 * @param String roomid
	 * @param User user 
	 * @return boolean 존재여부
	 */
	public boolean getCast(User user,String roomId);

	/**
	 * @brief getCamChatList
	 * @detail 화상채팅 목록 조회
	 * @param Map map ("search","page") 
	 * @return List<chatRoom> 존재여부
	 */
	public List getCamChatList(Map map);
	
	/**
	 * @brief getCastList
	 * @detail 방송 목록 조회
	 * @param Map map ("search","page") 
	 * @return List<chatRoom> 존재여부
	 */
	public List getCastList(Map map);
	
	/**
	 * @brief deleteChatRoom
	 * @detail 채팅방 삭제
	 * @param String roomId 
	 * @return
	 */
	public void deleteChatRoom(String roomId);
}
