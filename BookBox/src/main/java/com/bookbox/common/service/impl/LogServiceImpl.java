package com.bookbox.common.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.bookbox.common.domain.Log;
import com.bookbox.common.service.LogDAO;
import com.bookbox.common.service.LogService;
import com.bookbox.service.domain.User;

/**
 * @file com.bookbox.common.service.impl.LogServiceImpl.java
 * @brief Log Service Implement
 * @detail Log Service Implement
 * @author JW
 * @date 2017.10.16
 */

@Service("logServiceImpl")
public class LogServiceImpl implements LogService {

	@Autowired
	@Qualifier("logDAOImpl")
	private LogDAO logDAO;
	
	public LogServiceImpl() {
		System.out.println("Constructor :: "+getClass().getName());
	}

	@Override
	public List<Log> getLogList(User user) {
		// TODO Auto-generated method stub
		return logDAO.getLogList(user);
	}

	@Override
	public void addLog(Log log) {
		// TODO Auto-generated method stub
		logDAO.addLog(log);
	}
	
	
}
