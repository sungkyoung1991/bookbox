package com.bookbox.service.user.impl;

import com.bookbox.service.domain.User;
import com.bookbox.service.user.MailService;

/**
 * @file com.bookbox.service.user.impl.MailRunnableImpl.java
 * @author JW
 * @brief 메일전송시 유저가 대기하는것을 방지하기 위해 Thread로 구현
 *
 */
public class MailRunnableImpl implements Runnable {
	
	/* Field */
	private MailService mailService;
	private User user;
	
	/* Constructor */
	public MailRunnableImpl() {
		super();
	}
	
	public MailRunnableImpl(MailService mailService, User user) {
		this.mailService = mailService;
		this.user = user;
	}
	
	@Override
	public void run() {
		// TODO Auto-generated method stub
		while(true) {
			try {
				mailService.sendMail(user);
				break;
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
				System.out.println("메일전송실패! 재시도...");
			}
		}
	}

}
