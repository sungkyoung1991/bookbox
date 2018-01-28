package com.bookbox.service.user.impl;

import java.util.HashMap;
import java.util.Map;
import java.util.Random;

import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMessage.RecipientType;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;

import com.bookbox.service.domain.User;
import com.bookbox.service.user.MailService;
import com.bookbox.service.user.UserService;

/**
 * @file com.bookbox.service.user.impl.MailServiceImpl.java
 * @brief 메일 Service impl
 * @detail
 * @author HJ
 * @date 2017.10.11
 */
@Service("mailServiceImpl")
public class MailServiceImpl implements MailService {

	@Value("#mail.properties['accountMail']")
	private String accountMail;
	
	@Autowired
	@Qualifier("javaMailSenderImplGoogle")
	private 		JavaMailSender javaMailSender;
	
	@Autowired
	@Qualifier("userServiceImpl")
	private 		UserService userService;	
	
	/**
	 * @brief sendMail/ 인증메일보내기
	 * @param User user
	 * @throws Exception
	 * @return void
	 */
	public void sendMail(User user) throws Exception{
		
		MimeMessage mimeMessage = javaMailSender.createMimeMessage();

		int ran = new Random().nextInt(100000) + 10000; // 10000 ~ 99999
        String mailSentNo = String.valueOf(ran);
        
        String certificationNo;
        String findPassword;
        
        String subject;
        String mailText;
        
		
        if(user.getNickname() != null) {
        	certificationNo = mailSentNo;
        	System.out.println("테스트No :: "+certificationNo);
        	
        	subject="BookBox 홈페이지 가입 인증메일입니다.";
        	
        	mailText="<p>BookBox 홈페이지 가입 인증번호 확인</p><p><br></p>";
        	mailText +="<p>인증번호<br></p>";
        	mailText +="<a href='http://127.0.0.1:8080/BookBox/user/checkCertNo?";
        	mailText += "email="+user.getEmail();
        	mailText += "&active=1&certificationNo="+certificationNo;
        	mailText += "'>"+certificationNo+"</a>";
			
		}else {
			findPassword = mailSentNo;
        	System.out.println("테스트No :: "+findPassword);
			
			subject="BookBox  임시비밀번호 발송 메일입니다.";
        	
        	mailText="<p>BookBox "+user.getEmail()+"님의 임시비밀번호 입니다.</p><p><br></p>";
        	mailText +="<p>"+findPassword+"</p>";
		}
        
        mimeMessage.setFrom(new InternetAddress("hjryu124@naver.com"));
		mimeMessage.addRecipient(RecipientType.TO, new InternetAddress(user.getEmail()));
		mimeMessage.setSubject(subject,"utf-8");
		mimeMessage.setText(mailText,"utf-8","html");

		//Debug
		System.out.println("From :: "+mimeMessage.getFrom()[0]);
		System.out.println("Recipient :: "+mimeMessage.getAllRecipients()[0]);		
		System.out.println("Subject :: "+mimeMessage.getSubject().toString());
		System.out.println("Text :: "+mimeMessage.getContent());
		
		javaMailSender.send(mimeMessage);
		
		if(user.getNickname() != null) {
			userService.addUser(user);
		
			Map<String, Object> map = new HashMap<>();
			map.put("certificationNo", mailSentNo);
			map.put("email", user.getEmail());
			map.put("active", user.getActive());
			System.out.println("active 확인 :: "+user.getActive());
			System.out.println("email 확인 :: "+user.getEmail());
			System.out.println("certificationNo 확인 :: "+mailSentNo);
        
			userService.updateActive(map);
        }else {
        	user.setPassword(mailSentNo);
        	userService.updateUser(user);
        }
		
		System.out.println("send MimeMessage");
	}
	
}
