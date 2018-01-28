package com.bookbox.service.booklog.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import com.bookbox.common.statistics.Statistics;
import com.bookbox.service.booklog.BooklogDAO;
import com.bookbox.service.domain.Booklog;
import com.bookbox.service.domain.User;

@Repository("booklogDAOImpl")
public class BooklogDAOImpl implements BooklogDAO {

	@Autowired
	@Qualifier("sqlSessionTemplate")
	private SqlSession sqlSession;
	
	public BooklogDAOImpl() {
		System.out.println("Constructor :: "+getClass().getName());
	}

	@Override
	public List<Booklog> getBooklogList(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return sqlSession.selectList("BooklogMapper.getBooklogList", map);
	}

	@Override
	public Booklog getBooklog(Booklog booklog) {
		// TODO Auto-generated method stub
		booklog = sqlSession.selectOne("BooklogMapper.getBooklog", booklog);
		Map<String, List<Map<String,Object>>> statistics = new HashMap<String, List<Map<String,Object>>>();
		statistics.put("daily", sqlSession.selectList("BooklogMapper.getDailyVisitors", booklog.getBooklogNo()));
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("value", booklog.getBooklogNo());
		map.put("interval", "week");
		statistics.put("weekly", sqlSession.selectList("BooklogMapper.getVisitors", map));
		map.put("interval", "month");
		statistics.put("monthly", sqlSession.selectList("BooklogMapper.getVisitors", map));
		map.put("email", booklog.getUser().getEmail());
		statistics.put("tag", Statistics.calcRatio(sqlSession.selectList("BooklogMapper.getTagStatistics", map)));
		booklog.setVisitorsStatistics(statistics);
		return booklog;
	}

	@Override
	public void updateBooklog(Booklog booklog) {
		// TODO Auto-generated method stub
		sqlSession.update("BooklogMapper.updateBooklog", booklog);
	}

	@Override
	public int addBookmark(User user, Booklog booklog) {
		// TODO Auto-generated method stub
		return sqlSession.insert("BooklogMapper.addBookmark", this.mappingUserBooklog(user, booklog));
	}

	@Override
	public int deleteBookmark(User user, Booklog booklog) {
		// TODO Auto-generated method stub
		return sqlSession.delete("BooklogMapper.deleteBookmark", this.mappingUserBooklog(user, booklog));
	}

	@Override
	public boolean getBookmark(User user, Booklog booklog) {
		// TODO Auto-generated method stub
		String value = (String)sqlSession.selectOne("BooklogMapper.getBookmark", this.mappingUserBooklog(user, booklog));
		if(value == null) {
			return false;
		}else {
			return true;
		}
	}
	
	@Override
	public Map<String, String> getCounts(String email) {
		// TODO Auto-generated method stub
		return sqlSession.selectMap("BooklogMapper.getCounts", email, "counts");
	}

	@Override
	public List<String> getBookLikeList(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return sqlSession.selectList("BooklogMapper.getBookLikeList", map);
	}

	/**
	 * @brief User와 Booklog를 Map에 넣어주는 method
	 * @param user
	 * @param booklog
	 * @return
	 */
	public Map<String, Object> mappingUserBooklog(User user, Booklog booklog){
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("user", user);
		map.put("booklog", booklog);
		
		return map;
	}
	
}
