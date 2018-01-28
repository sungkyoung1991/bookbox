package user;

import java.sql.Date;
import java.util.Calendar;
import java.util.HashMap;
import java.util.Map;
import java.util.Random;

import org.junit.Assert;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.bookbox.common.domain.Search;
import com.bookbox.service.domain.User;
import com.bookbox.service.user.UserDAO;
import com.bookbox.service.user.UserService;

@RunWith(SpringJUnit4ClassRunner.class)


//@ContextConfiguration(locations = { "classpath:config/context-*.xml" })
@ContextConfiguration	(locations = {"classpath:config/context-common.xml",
																	"classpath:config/context-aspect.xml",
																	"classpath:config/context-mybatis.xml",
																	"classpath:config/context-transaction.xml" })
//@ContextConfiguration(locations = { "classpath:config/context-common.xml" })
public class UserTest {

	@Autowired
	@Qualifier("userServiceImpl")
	private UserService userService;

	@Autowired
	@Qualifier("userDAOImpl")
	private UserDAO userDAO; 
	
	//@Test
	public void testAddUser() throws Exception {
		
		User user = new User();
		user.setEmail("xptmxm@nate.com");
		user.setNickname("간닷");
		user.setPassword("xptmxm1234");
		user.setGender("여");
				
		Date birth = new Date(new Calendar.Builder().setDate(1990, 1, 1).build().getTimeInMillis());
		user.setBirth(birth);
		
		System.out.println(userService);
		
		userService.addUser(user);
		User dbuser = userService.getUser(user);
		
		//==> console 확인
		System.out.println(dbuser);
		
		//==> API 확인
		Assert.assertEquals("xptmxm@nate.com", dbuser.getEmail());
		Assert.assertEquals("간닷", dbuser.getNickname());
		Assert.assertEquals("xptmxm1234", dbuser.getPassword());
		Assert.assertEquals("여", dbuser.getGender());
	}

	
	//@Test
	public void testGetUser() throws Exception {
		
		User user = new User();
		user.setEmail("xptmxm@nate.com");
		user.setNickname("간닷");
		user.setPassword("xptmxm1234");
		user.setGender("여");
		
		user = userService.getUser(user);

		//==> console 확인
		System.out.println("testGetUser() :: "+user);
		
		//==> API 확인
				Assert.assertEquals("xptmxm@nate.com", user.getEmail());
				Assert.assertEquals("간닷", user.getNickname());
				Assert.assertEquals("xptmxm1234", user.getPassword());
				Assert.assertEquals("여", user.getGender());
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
	 public void testUpdateUser() throws Exception{
		 
		 User user = new User();
		 user.setEmail("xptmxm@nate.com");
		 
		 User getUser = userService.getUser(user);
		 System.out.println("testUpdateUser()==> getUser() :: "+getUser);
		
		//Assert.assertNotNull(user);
		
		//==> API 확인
		Assert.assertEquals("xptmxm@nate.com", getUser.getEmail());
		Assert.assertEquals("간닷", getUser.getNickname());
		Assert.assertEquals("xptmxm1234", getUser.getPassword());
		Assert.assertEquals("여", getUser.getGender());

		getUser.setPassword("updatepassword");
		getUser.setNickname("수정한닷");
		
		userService.updateUser(getUser);
		
		user = userService.getUser(user);
		Assert.assertNotNull(user);
		
		//==> console 확인
		//System.out.println(user);
			
		//==> API 확인
		Assert.assertEquals("xptmxm@nate.com", user.getEmail());
		Assert.assertEquals("수정한닷", user.getNickname());
		Assert.assertEquals("updatepassword", user.getPassword());
		Assert.assertEquals("여", user.getGender());
	 }
	 
	@Test
	public void testCheckEmailValidation() throws Exception{

		int ran = new Random().nextInt(100000) + 10000; // 10000 ~ 99999
        String joinCode = String.valueOf(ran);
       
        System.out.println("테스트No :: "+joinCode);
		

			User user = new User();
			user.setEmail("xptmxm@nate.com");
		
			userService.checkEmailValidation(user);
		
		//==> console 확인
		System.out.println("testCheckEmailValidation :: "+userService.checkEmailValidation(user));
	 	
		//==> API 확인
		Assert.assertFalse(userService.checkEmailValidation(user));		 	
	}
	
	//@Test
	public void testCheckNicknameValidation() throws Exception{


			User user = new User();
			user.setEmail("xptmxm@nate.com");
			user.setNickname("수정한닷");
		
			userService.checkNicknameValidation(user);
		
		//==> console 확인
			System.out.println("testCheckNicknameValidation :: "+userService.checkNicknameValidation(user));
		 	
			//==> API 확인
			Assert.assertFalse(userService.checkNicknameValidation(user));		 	
		 	
	}	
	
	//@Test
	public void testUpdateActive() throws Exception{

		Map<String, Object> map = new HashMap<>();
		map.put("email", "xptmxm@nate.com");
		map.put("active", 2);
			
		userService.updateActive(map);
	
		User user = new User();
		user.setEmail("xptmxm@nate.com");
		
		//==> API 확인
		Assert.assertTrue(userService.getUser(user)==null);		 	
		 	
	}	
	
	

	//@Test
//	 public void testGetUserListAll() throws Exception{
//		 
//	 	Search search = new Search();
//	 	search.setCurrentPage(1);
//	 	search.setPageSize(3);
//	 	Map<String,Object> map = userService.getUserList(search);
//	 	
//	 	List<Object> list = (List<Object>)map.get("list");
//	 	Assert.assertEquals(3, list.size());
//	 	
//		//==> console 확인
//	 	//System.out.println(list);
//	 	
//	 	Integer totalCount = (Integer)map.get("totalCount");
//	 	System.out.println(totalCount);
//	 	
//	 	System.out.println("=======================================");
//	 	
//	 	search.setCurrentPage(1);
//	 	search.setPageSize(3);
//	 	search.setSearchCondition("0");
//	 	search.setSearchKeyword("");
//	 	map = userService.getUserList(search);
//	 	
//	 	list = (List<Object>)map.get("list");
//	 	Assert.assertEquals(3, list.size());
//	 	
//	 	//==> console 확인
//	 	//System.out.println(list);
//	 	
//	 	totalCount = (Integer)map.get("totalCount");
//	 	System.out.println(totalCount);
//	 }
	 
	 /*	
	 //@Test
	 public void testGetUserListByUserId() throws Exception{
		 
	 	Search search = new Search();
	 	search.setCurrentPage(1);
	 	search.setPageSize(3);
	 	search.setSearchCondition("0");
	 	search.setSearchKeyword("admin");
	 	Map<String,Object> map = userService.getUserList(search);
	 	
	 	List<Object> list = (List<Object>)map.get("list");
	 	Assert.assertEquals(1, list.size());
	 	
		//==> console 확인
	 	//System.out.println(list);
	 	
	 	Integer totalCount = (Integer)map.get("totalCount");
	 	System.out.println(totalCount);
	 	
	 	System.out.println("=======================================");
	 	
	 	search.setSearchCondition("0");
	 	search.setSearchKeyword(""+System.currentTimeMillis());
	 	map = userService.getUserList(search);
	 	
	 	list = (List<Object>)map.get("list");
	 	Assert.assertEquals(0, list.size());
	 	
		//==> console 확인
	 	//System.out.println(list);
	 	
	 	totalCount = (Integer)map.get("totalCount");
	 	System.out.println(totalCount);
	 }
	 
	 //@Test
	 public void testGetUserListByUserName() throws Exception{
		 
	 	Search search = new Search();
	 	search.setCurrentPage(1);
	 	search.setPageSize(3);
	 	search.setSearchCondition("1");
	 	search.setSearchKeyword("SCOTT");
	 	Map<String,Object> map = userService.getUserList(search);
	 	
	 	List<Object> list = (List<Object>)map.get("list");
	 	Assert.assertEquals(3, list.size());
	 	
		//==> console 확인
	 	//System.out.println(list);
	 	
	 	Integer totalCount = (Integer)map.get("totalCount");
	 	System.out.println(totalCount);
	 	
	 	System.out.println("=======================================");
	 	
	 	search.setSearchCondition("1");
	 	search.setSearchKeyword(""+System.currentTimeMillis());
	 	map = userService.getUserList(search);
	 	
	 	list = (List<Object>)map.get("list");
	 	Assert.assertEquals(0, list.size());
	 	
		//==> console 확인
	 	//System.out.println(list);
	 	
	 	totalCount = (Integer)map.get("totalCount");
	 	System.out.println(totalCount);
	 }	 */
}