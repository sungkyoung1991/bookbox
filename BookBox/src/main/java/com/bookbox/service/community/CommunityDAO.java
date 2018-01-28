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
 * @file com.bookbox.service.CommunityDAO.java
 * @brief CommunityDAO
 * @detail 소모임 DAO
 * @author HS
 * @date 2017.11.20
 */
public interface CommunityDAO {
	
	/**
	 * @brief addBorad
	 * @detail 게시글 추가  
	 * @param Board board 게시글 도메인
	 * @return int 게시글 추가 성공여부
	 */
	public int addBorad(Board board);
	
	/**
	 * @brief getBoard
	 * @detail 게시글 조회
	 * @param Board board 게시글 도메인
	 * @return Board 
	 */
	public Board getBoard(int boardNo);
	
	/**
	 * @brief updateBoard
	 * @detail 게시글 수정
	 * @param Board board 게시글 도메인
	 * @return int 수정 성공 여부 
	 */
	public int updateBoard(Board board);
	
	/**
	 * @brief deleteBoard
	 * @detail 게시글 삭제
	 * @param int boardNo 게시글 번호
	 * @return int 삭제 성공 여부 
	 */
	public int deleteBoard(int boardNo);
	
	/**
	 * @brief getBoardList
	 * @detail 게시글 목록 조회
	 * @param Map map ("search","page")
	 * @return List<Board> 
	 */
	public List getBoardList(Map map);
	
	/**
	 * @brief getBoardListUserTagMapper
	 * @detail 게시글 목록 조회 !!쓰지않는다.
	 * @param Map map ("search","page")
	 * @return List<Board> 
	 */
	public List getBoardListUserTagMapper(Map map);
	
	/**
	 * @brief getBoardTotal
	 * @detail 조건에 맞는 게시글 총개수 
	 * @param Map map ("search","page")
	 * @return int 게시글 개수 리턴
	 */
	public int getBoardTotal(Map map);
	
	/**
	 * @brief addComment
	 * @detail 댓글 추가
	 * @param Comment comment 댓글 도메인
	 * @return int 성공 여부 
	 */
	public int addComment(Comment comment);
	
	/**
	 * @brief getComment
	 * @detail 댓글 조회  
	 * @param int commentNo 댓글 번호 
	 * @return Comment
	 */
	public Comment getComment(int commentNo);
	
	/**
	 * @brief updateCommnet
	 * @detail 댓글 수정   
	 * @param Comment comment 댓글 도메인 
	 * @return int 성공여부
	 */
	public int updateCommnet(Comment comment);
	
	/**
	 * @brief getCommentList
	 * @detail 댓글 목록 조회
	 * @param int boardNo 게시글 번호
	 * @return List<Comment> 댓글 목록 리턴 
	 */
	public List<Comment> getCommentList(int boardNo);
	
	/**
	 * @brief getCommentMaxLevel
	 * @detail 댓글 최대 깊이 탐색   
	 * @param int boardNo 해당 게시글번호
	 * @return int 최대 깊이 리턴
	 */
	public int getCommentMaxLevel(int boardNo);
	
	/**
	 * @brief addRecommend
	 * @detail 추천추가
	 * @param Recommend recommend 추천 도메인
	 * @return int 성공 여부 
	 */
	public int addRecommend(Recommend recommend);
	
	/**
	 * @brief getRecommend
	 * @detail 추천 중복 검사
	 * @param Recommend recommend
	 * @return int 중복여부 리턴
	 */
	public int getRecommend(Recommend recommend);
	
	/**
	 * @brief addReport
	 * @detail 게시글, 댓글 신고추가
	 * @param Report report 신고 도메인
	 * @return int 성공 여부
	 */
	public int addReport(Report report);
	
	/**
	 * @brief getReport
	 * @detail 신고 중복 검사  
	 * @param Report report
	 * @return int 중복여부 리턴
	 */
	public int getReport(Report report);
	
	/**
	 * @brief addChatRoom
	 * @detail 채팅방 생성
	 * @param ChatRoom chatroom 채팅방 도메인
	 * @return int 성공 여부 
	 */
	public int addChatRoom(ChatRoom chatroom);
	
	/**
	 * @brief getCamChat
	 * @detail 화상채팅 조회
	 * @param String roomid
	 * @return boolean 존재여부
	 */
	public boolean getCamChat(String roomId);
	
	/**
	 * @brief getCast
	 * @detail 방송 조회
	 * @param String roomid
	 * @return boolean 존재여부
	 */
	public boolean getCast(String roomId);

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
