package com.bookbox.service.booklog.impl;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import com.bookbox.common.domain.Search;
import com.bookbox.service.booklog.PostingDAO;
import com.bookbox.service.domain.Posting;

@Repository("postingDAOImpl")
public class PostingDAOImpl implements PostingDAO {

	@Autowired
	@Qualifier("sqlSessionTemplate")
	private SqlSession sqlSession;
	
	public PostingDAOImpl() {
		System.out.println("Constructor :: "+this.getClass().getName());
	}

	@Override
	public boolean addPosting(Posting posting) {
		// TODO Auto-generated method stub
		sqlSession.insert("PostingMapper.addPosting", posting);
		return true;
	}

	@Override
	public Posting getPosting(Posting posting) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("PostingMapper.getPosting", posting);
	}

	@Override
	public List<Posting> getPostingList(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return sqlSession.selectList("PostingMapper.getPostingList", map);
	}

	@Override
	public boolean updatePosting(Posting posting) {
		// TODO Auto-generated method stub
		sqlSession.update("PostingMapper.updatePosting", posting);
		return true;
	}

	@Override
	public int getPostingCount(Search search) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("PostingMapper.getPostingCount", search);
	}
	
}
