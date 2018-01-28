package email;

import java.sql.Date;

import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMessage.RecipientType;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.mail.javamail.JavaMailSenderImpl;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.web.bind.annotation.RequestMapping;

import com.bookbox.service.domain.User;
import com.bookbox.service.user.MailService;
import com.bookbox.service.user.UserService;


@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations={"classpath:config/context-mail.xml",
																	"classpath:config/context-common.xml",
																	"classpath:config/context-aspect.xml",
																	"classpath:config/context-mybatis.xml",
																	"classpath:config/context-transaction.xml"})
public class MailTest {
	
//	@Autowired
//	@Qualifier("javaMailSenderImplGoogle")
//	private JavaMailSenderImpl javaMailSenderImplGoogle;
//	
//	@Autowired
//	@Qualifier("javaMailSenderImplNaver")
//	private JavaMailSenderImpl javaMailSenderImplNaver;
//	
	@Autowired
	@Qualifier("mailServiceImpl")
	private MailService mailService;
	
	@Test
	public void mailGoogleTest() throws Exception{
		
		System.out.println("[sendMail Start.....]");

		/*
		SimpleMailMessage simpleMailMessage=new SimpleMailMessage();
		simpleMailMessage.setFrom("pmjahy@naver.com");
		simpleMailMessage.setTo("pmjahy@naver.com");
		simpleMailMessage.setSubject("simpleMail");
		simpleMailMessage.setText("test");
		System.out.println("before sendMail");
		javaMailSenderImpl.send(simpleMailMessage);
		System.out.println("send simpleMessage");
		 */
		
		/*MimeMessage mimeMessage=javaMailSenderImplGoogle.createMimeMessage();

		mimeMessage.setFrom(new InternetAddress("hjryu@gmail.com"));
		mimeMessage.addRecipient(RecipientType.TO, new InternetAddress("krinsa@naver.com"));
		mimeMessage.setSubject("테스트 메일 구글계정","utf-8");
		mimeMessage.setText("<p>테스트 메일 메시지<p>","utf-8","html");
		
		javaMailSenderImplGoogle.send(mimeMessage);*/
		
		User user = new User();
		user.setEmail("krinsa@naver.com");
		mailService.sendMail(user);
		
		System.out.println("send MimeMessage");
	
	}
	
	//@Test
//	public void mailNaverTest() throws Exception{
//		
//		System.out.println("[sendMail Start.....]");
//			
//		MimeMessage mimeMessage=javaMailSenderImplNaver.createMimeMessage();
//		
//		mimeMessage.setFrom(new InternetAddress("officialbit@naver.com"));
//		mimeMessage.addRecipient(RecipientType.TO, new InternetAddress("pmjahy@naver.com"));
//		mimeMessage.setSubject("테스트 메일 네이버","utf-8");
//		mimeMessage.setText("<p>테스트 메일 메시지<p>","utf-8","html");
//		
//		javaMailSenderImplNaver.send(mimeMessage);
//		System.out.println("send MimeMessage");
	
//	}
}
