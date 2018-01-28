package booklog;

import java.util.ArrayList;
import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.bookbox.common.domain.Location;
import com.bookbox.common.domain.Search;
import com.bookbox.common.domain.Tag;
import com.bookbox.service.booklog.PostingService;
import com.bookbox.service.domain.Posting;
import com.bookbox.service.domain.User;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations={"classpath:config/context-mybatis.xml",
									"classpath:config/context-common.xml",
									"classpath:config/context-transaction.xml",
									"classpath:config/context-aspect.xml",
									"classpath:config/context-mail.xml"})
public class PostingTest {
	
	@Autowired
	@Qualifier("postingServiceImpl")
	private PostingService postingService;
	
	@Test
	public void addPostingTest() throws Exception{
		User user = new User();
		user.setEmail("wndhks@naver.com");
		
		Posting posting = new Posting();
		posting.setPostingNo(3);
		posting.setPostingTitle("육성재으로 올리는 포슽잉");
		posting.setPostingContent("포스팅놈이 있는 상태에서 넣으면 어떻게될까?");
		posting.setUser(user);
//		Location location = new Location();
//		location.setLocationName("우리집");
//		location.setLocationLatitude(37.367795);
//		location.setLocationLongitude(127.161255);
//		List<Location> locationList = new ArrayList<Location>();
//		locationList.add(location);
//		posting.setPostingLocationList(locationList);
		List<Tag> tagList = new ArrayList<Tag>();
		tagList.add(new Tag("밀리터리"));
		tagList.add(new Tag("군바으리"));
		posting.setPostingTagList(tagList);
		
		postingService.addPosting(user, posting);
		System.out.println(posting.getPostingNo());
	}

//	@Test
	public void getPostingTest() throws Exception{
		
		User user = new User();
		user.setEmail("xptmxm@nate.com");
		Posting posting = new Posting();
		posting.setPostingNo(8);
		
		System.out.println(postingService.getPosting(new User(), posting));
	}
	
//	@Test
	public void getPostingListTest() throws Exception{
		Search search = new Search();
		search.setCondition("booklog");
		search.setKeyword("wndhks@naver.com");
		
		
//		System.out.println(postingService.getPostingList(search));
	}
	
//	@Test
	public void updatePostingTest() throws Exception{
		User user = new User();
		user.setEmail("wndhks@naver.com");
		
		Posting posting = new Posting();
		posting.setPostingNo(8);
		posting.setPostingTitle("오번째으로 수정된 포스팅");
		posting.setPostingContent("다섯번째 포스팅은 위치를 포함했었지 rmfjgkek");
		posting.setUser(user);
		Location location = new Location();
		location.setLocationName("우리집");
		location.setLocationLatitude(37.367795);
		location.setLocationLongitude(127.161255);
		List<Location> locationList = new ArrayList<Location>();
		locationList.add(location);
		
		
		postingService.updatePosting(user, posting);
	}
	
}
