package com.bookbox.service.user;

import com.bookbox.service.domain.User;

/**
 * @file com.bookbox.service.user.mailService.java
 * @brief 메일 Service
 * @detail 인터페이스
 * @author HJ
 * @date 2017.10.11
 */
public interface MailService {

	/**
	 * @brief sendMail/ 인증메일보내기
	 * @param User user
	 * @throws Exception
	 * @return void
	 */
	public void sendMail(User user) throws Exception;
}
