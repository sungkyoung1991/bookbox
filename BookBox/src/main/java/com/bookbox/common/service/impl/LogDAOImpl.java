package com.bookbox.common.service.impl;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import com.bookbox.common.domain.Log;
import com.bookbox.common.service.LogDAO;
import com.bookbox.common.util.CommonUtil;
import com.bookbox.service.domain.User;
import com.bookbox.service.unifiedsearch.BookSearchDAO;

/**
 * @file com.bookbox.common.service.impl.LogDAOImpl.java
 * @brief Log DAO Implement
 * @detail Log DAO Implement
 * @author JW
 * @date 2017.10.16
 */

@Repository("logDAOImpl")
public class LogDAOImpl implements LogDAO {

	@Autowired
	@Qualifier("sqlSessionTemplate")
	private SqlSession sqlSession;
	
	@Autowired
	@Qualifier("bookSearchKakaoAladinDAOImpl")
	private BookSearchDAO bookSearchDAO;
	
	public LogDAOImpl() {
		System.out.println("Constructor :: "+getClass().getName());
	}

	@Override
	public List<Log> getLogList(User user) {
		// TODO Auto-generated method stub
		List<Log> logList = sqlSession.selectList("LogMapper.getLogList", user);
		for(Log log : logList) {
			Map<String, Object> map = CommonUtil.mappingCategoryTarget(log.getCategoryNo(), log.getTargetNo());
			map.put("category", CommonUtil.getConstProp().getProperty("S_C"+log.getCategoryNo()));
			if(log.getCategoryNo() != 9) {
				log.setTargetName( (String)sqlSession.selectOne("LogMapper.getTargetName", map) );
			}else {
				try {
					log.setTargetName( bookSearchDAO.getBook(log.getTargetNo().toString()).getTitle() );
				} catch (Exception e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
		}
		return logList;
	}

	@Override
	public void addLog(Log log) {
		// TODO Auto-generated method stub
		sqlSession.insert("LogMapper.addLog", log);
	}
	
	
}
