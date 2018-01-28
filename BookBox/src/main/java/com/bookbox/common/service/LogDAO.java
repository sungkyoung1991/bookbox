package com.bookbox.common.service;

import java.util.List;

import com.bookbox.common.domain.Log;
import com.bookbox.service.domain.User;

/**
 * @file com.bookbox.common.service.LogDAO.java
 * @brief Log DAO
 * @detail Log DAO
 * @author JW
 * @date 2017.10.16
 */

public interface LogDAO {

	public List<Log> getLogList(User user);
	
	public void addLog(Log log);
	
}
