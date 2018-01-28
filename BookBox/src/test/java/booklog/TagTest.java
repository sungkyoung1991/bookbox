package booklog;

import java.util.ArrayList;
import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.bookbox.common.domain.Const;
import com.bookbox.common.domain.Tag;
import com.bookbox.common.service.TagDAO;
import com.bookbox.common.service.TagService;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations={"classpath:config/context-mybatis.xml",
									"classpath:config/context-common.xml",
									"classpath:config/context-transaction.xml",
									"classpath:config/context-aspect.xml"})
public class TagTest {
	
	@Autowired
	@Qualifier("tagServiceImpl")
	private TagService tagService;
	
	@Autowired
	@Qualifier("tagDAOImpl")
	private TagDAO tagDAO;
	
//	@Test
	public void addTagGroupTest() throws Exception {
		List<Tag> tagList = new ArrayList<Tag>();
		tagList.add(new Tag("SF"));
		tagList.add(new Tag("액션"));
		tagList.add(new Tag("판타지"));
		tagList.add(new Tag("드라마"));
		tagList.add(new Tag("스릴러"));
		
		System.out.println(tagService.addTagGroup(Const.Category.POSTING, 2, tagList));
		
	}
	
//	@Test
	public void addTagTest() throws Exception{
		Tag tag = new Tag("판타스틱");
		tagDAO.addTag(tag);
		System.out.println(tag.getTagNo());
	}
	
//	@Test
	public void getTagListTest() throws Exception{
		Tag tag = new Tag("없");
		System.out.println(tagService.getTagList(tag));
	}
	
	@Test
	public void getTagGroupListTest() throws Exception{
		System.out.println(tagService.getTagGroupList(Const.Category.POSTING, 2));
	}
	
//	@Test
	public void updateTagGroupListTest() throws Exception{
		List<Tag> tagList = new ArrayList<Tag>();
		tagList.add(new Tag("공상과학"));
		tagList.add(new Tag("액션"));
		tagList.add(new Tag("판타지"));
		tagList.add(new Tag("판타스틱"));
		
		System.out.println(tagService.updateTagGroup(Const.Category.POSTING, 2, tagList));
	}
}
