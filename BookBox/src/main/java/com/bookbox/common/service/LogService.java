package com.bookbox.common.service;

import java.util.List;

import com.bookbox.common.domain.Log;
import com.bookbox.service.domain.User;

/**
 * @file com.bookbox.common.service.LogService.java
 * @brief Log Service
 * @detail Log Service
 * @author JW
 * @date 2017.10.16
 */

public interface LogService {
	
	public List<Log> getLogList(User user);
	
	public void addLog(Log log);
	
}
