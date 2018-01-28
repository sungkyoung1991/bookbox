package creation;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;

import org.junit.Assert;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.web.multipart.MultipartFile;

import com.bookbox.common.domain.Tag;
import com.bookbox.common.domain.UploadFile;
import com.bookbox.service.creation.CreationService;
import com.bookbox.service.creation.WritingService;
import com.bookbox.service.domain.Creation;
import com.bookbox.service.domain.User;
import com.bookbox.service.domain.Writing;
import com.bookbox.service.user.UserService;

@RunWith(SpringJUnit4ClassRunner.class)


//@ContextConfiguration(locations = { "classpath:config/context-*.xml" })
@ContextConfiguration	(locations = {"classpath:config/context-common.xml",
																		"classpath:config/context-aspect.xml",
																		"classpath:config/context-mail.xml",
																		"classpath:config/context-mybatis.xml",
																		"classpath:config/context-transaction.xml" })
//@ContextConfiguration(locations = { "classpath:config/context-common.xml" })
public class CreationTest {

	@Autowired
	@Qualifier("creationServiceImpl")
	private CreationService creationService;

	@Autowired
	@Qualifier("writingServiceImpl")
	private WritingService writingService; 
	
	@Autowired
	@Qualifier("userServiceImpl")
	private UserService userService;
	
	@Test
	public void testAddWriting() throws Exception {
		// TODO testAddWriting()
		/////////SET 
		User user = new User();
		user.setEmail("krinsa@naver.com");
		user = userService.getUser(user);
		
		
		UploadFile uploadFile = new UploadFile();
		uploadFile.setOriginName("Creation.jsp");
		uploadFile.setFileName(String.valueOf(Calendar.getInstance().getTimeInMillis())
													+uploadFile.getOriginName().substring(uploadFile.getOriginName().lastIndexOf(".")));
		
		String fileName = String.valueOf(Calendar.getInstance().getTimeInMillis())
				+uploadFile.getOriginName().substring(uploadFile.getOriginName().lastIndexOf("."));
	
		Creation creation = new Creation();
		creation.setCreationNo(29);
		creation.setCreationTitle("창작공간 픽션글 1호");
		creation.setCreationIntro("창작작품 테스트 첫번째 Title ");
		creation.setCreationAuthor(user);
		creation.setCreationHead("픽션");
		creation.setCreationFileName(fileName);
		creation.setCreationOriginName("Creation.jsp");
		
		List<UploadFile> uploadFileList =new ArrayList<>();
		
		UploadFile uploadFile1 = new UploadFile(fileName,"2-1 이미지1.jsp");
		uploadFile1.setMainFile(0);
		UploadFile uploadFile2 = new UploadFile(fileName,"2-2 이미지2.jsp");
		uploadFile2.setMainFile(0);
		UploadFile uploadFile3 = new UploadFile(fileName,"2-3 이미지3.jsp");
		uploadFile3.setMainFile(0);
		
		uploadFileList.add(uploadFile1);
		uploadFileList.add(uploadFile2);
		uploadFileList.add(uploadFile3);
		
		Writing writing = new Writing();
		writing.setWritingTitle("첫번째 창작글 테스트 Title(2)");
		writing.setWritingContent("첫번째 창작글 테스트 두번째 글입니다. ");
		writing.setWritingFileList(uploadFileList);
		
		
		Tag tag = new Tag();
		tag.setTagName("#토요일#픽션#좋은날씨#세번째");
		///////////SET END
				
		List<Tag> tagList = new ArrayList<>();
		String[] dbTag =  tag.getTagName().split("#");
		
		for (int i = 0; i < dbTag.length; i++) {
			tagList.add(new Tag(dbTag[i]));
		}	
		creation.setTagList(tagList);
		
		//==> console 확인
		System.out.println("Creation :: "+creation);
		System.out.println("Writing :: "+writing);
		System.out.println("Tag :: "+tag);
		System.out.println("UploadFile :: "+uploadFile);
		
		////////INSERT
		//creationService.addCreation(user, creation);
		writing.setCreationNo(creation.getCreationNo());
		writing.setCreationNo(30);
		writingService.addWriting(user, writing);
		///////
		
		
	}

	
	
	//@Test
	private void testLogin() throws Exception{
	
		User user = new User();
		user.setEmail("xptmxm@nate.com");
		user.setPassword("updatepassword");
		user.setOuterAccount(0);
		
		User dbUser = userService.getUser(user);

	}	
	

	//@Test
	 public void testUpdateCreation() throws Exception{
		 
	///////// Creation Update Test///////////////
			User user = new User();
			user.setEmail("wndhks@naver.com");
			user = userService.getUser(user);
			
			
			UploadFile uploadFile = new UploadFile();
			uploadFile.setOriginName("change.jpg");
			uploadFile.setFileName(String.valueOf(Calendar.getInstance().getTimeInMillis())
														+uploadFile.getOriginName().substring(uploadFile.getOriginName().lastIndexOf(".")));
			
			String fileName = String.valueOf(Calendar.getInstance().getTimeInMillis())
					+uploadFile.getOriginName().substring(uploadFile.getOriginName().lastIndexOf("."));
		
			Creation creation = new Creation();
			creation.setCreationNo(24);
			creation.setCreationTitle("창작공간 픽션글 3호 수정글");
			creation.setCreationIntro("화요일이니까 수정해야지 조회도 해야징");
			creation.setCreationAuthor(user);
			creation.setCreationHead("논픽션");
			creation.setCreationFileName(fileName);
			creation.setCreationOriginName("change.jpg");
		
			Tag tag = new Tag();
			tag.setTagName("#수정#화요일#우울#졸려");
			///////////SET END
					
			List<Tag> tagList = new ArrayList<>();
			String[] dbTag =  tag.getTagName().split("#");
			
			for (int i = 0; i < dbTag.length; i++) {
				tagList.add(new Tag(dbTag[i]));
			}	
			creation.setTagList(tagList);
			
			//==> console 확인
			System.out.println("Creation :: "+creation);
			System.out.println("Tag :: "+tag);

			
			////////UPDATE
			creationService.updateCreation(user, creation);
			///////
		
	 }
	
	//@Test
	public void testWritingUpdate() throws Exception {
			// TODO testWritingUpdate()
			
			User user = new User();
			user.setEmail("wndhks@naver.com");
			user = userService.getUser(user);
		
			List<UploadFile> uploadFileList =new ArrayList<>();
			UploadFile uploadFile = new UploadFile();
			uploadFile.setOriginName("Creation.jsp");
			String fileName = String.valueOf(Calendar.getInstance().getTimeInMillis())
					+uploadFile.getOriginName().substring(uploadFile.getOriginName().lastIndexOf("."));
			
			UploadFile uploadFile1 = new UploadFile(fileName,"오리진파일1수정.jsp");
			uploadFile1.setMainFile(0);
			UploadFile uploadFile2 = new UploadFile(fileName,"오리진파일2수정.jsp");
			uploadFile2.setMainFile(0);
			UploadFile uploadFile3 = new UploadFile(fileName,"오리진파일3수정.jsp");
			uploadFile3.setMainFile(1);
			
			uploadFileList.add(uploadFile1);
			uploadFileList.add(uploadFile2);
			uploadFileList.add(uploadFile3);
			
			Writing writing = new Writing();
			writing.setWritingNo(17);
			writing.setWritingTitle("10월 24일 화요일 수정글");
			writing.setWritingContent("테스트 빨리 끝내자아아아아");
			writing.setWritingFileList(uploadFileList);
			
			//Console 확인
			System.out.println("Writing :: "+writing);
			System.out.println("UploadFile :: "+uploadFile);
			
			////////UPDATE
			writingService.updateWriting(user, writing);
			///////
		
	}
	 
	//@Test
	public void testGetWriting() throws Exception {
		
		User user = new User();
		user.setEmail("wndhks@naver.com");
		user = userService.getUser(user);
		
		Creation creation = new Creation();
		Writing writing = new Writing();
		creation.setCreationNo(24);
		writing.setWritingNo(17);	
		//writing.setCreationNo(creation);
		
		writing = writingService.getWriting(user, writing);
		
		//==> console 확인
		System.out.println("testGetWriting() :: "+writing);

	}
	
	
}