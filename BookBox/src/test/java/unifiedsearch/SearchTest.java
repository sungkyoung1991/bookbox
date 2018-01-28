package unifiedsearch;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.bookbox.common.domain.Const;
import com.bookbox.common.domain.Const.Category;
import com.bookbox.common.domain.Search;
import com.bookbox.common.domain.Tag;
import com.bookbox.common.domain.UploadFile;
import com.bookbox.common.util.CommonUtil;
import com.bookbox.service.creation.CreationService;
import com.bookbox.service.creation.WritingService;
import com.bookbox.service.domain.Board;
import com.bookbox.service.domain.ChatRoom;
import com.bookbox.service.domain.Creation;
import com.bookbox.service.domain.Posting;
import com.bookbox.service.domain.User;
import com.bookbox.service.domain.Writing;
import com.bookbox.service.unifiedsearch.UnifiedsearchDAO;
import com.bookbox.service.unifiedsearch.UnifiedsearchService;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = { "classpath:config/context-mybatis.xml", "classpath:config/context-common.xml",
		"classpath:config/context-transaction.xml", "classpath:config/context-aspect.xml",
		"classpath:config/context-mail.xml" })

public class SearchTest {

	@Autowired
	@Qualifier("unifiedsearchServiceImpl")
	private UnifiedsearchService unifiedsearchService;

	@Autowired
	@Qualifier("unifiedsearchElasticDAOImpl")
	private UnifiedsearchDAO unifiedsearchDAO;

	@Autowired
	@Qualifier("writingServiceImpl")
	private WritingService writingService;

	@Autowired
	@Qualifier("creationServiceImpl")
	private CreationService creationService;
	
	//@Autowired
	//@Qualifier("creationDAOImpl")
	//private CreationDAO creationDAO;


	private Posting posting = new Posting();
	private Creation creation = new Creation();
	private Board board = new Board();
	private ChatRoom chatroom = new ChatRoom();
	private Search search = new Search();
	private User user = new User();
	private Tag tag = new Tag();

	@Test
	public void serviceTest() throws Exception {
		
		user.setNickname("디제이");
		user.setEmail("1015wlswn@naver.com");
		
		Map<String, Object> map = CommonUtil.mappingCategoryTarget(Const.Category.CREATION, 6, user);
		List<Tag> tagList = new ArrayList<Tag>();
		tag.setTagName("태그다");
		Tag tag2 = new Tag();
		tag2.setTagName("태그2222");

		tagList.add(tag);
		tagList.add(tag2);
		creation.setCreationIntro("이것은 창작이다 창작이다");
		creation.setCreationNo(6);
		creation.setCreationTitle("창작 제목");
		creation.setCreationAuthor(user);
		creation.setTagList(tagList);
		map.put("creation", creation);
		
		Writing writing = new Writing();
		List<Writing> list = new ArrayList<Writing>();
		
		writing.setWritingTitle("이것은 게시글 제목이다");
		writing.setWritingContent("이것은 게시글 내용이다");
		writing.setWritingNo(1);

		list.add(writing);
		
		Writing tempWriting = new Writing();
		
		List<UploadFile> lill = new ArrayList<UploadFile>();
		UploadFile uploadFile = new UploadFile();
		uploadFile.setFileName("ddd");
		lill.add(uploadFile);
		
		tempWriting.setWritingTitle("bbb");
		tempWriting.setWritingContent("aaaaa");
		tempWriting.setWritingFileList(lill);
		tempWriting.setWritingNo(2);
		tempWriting.setCreationNo(6);
		
		list.add(tempWriting);
		
		creation.setWritingList(list);
		
		search.setCategory(Category.CREATION);
		search.setKeyword("사람");
		//map =  unifiedsearchService.elasticSearch(search);
		
		//unifiedsearchDAO.elasticUpdate(creation);
		
		//map.put("targetNo", "18");
		//creationService.getCreation(map);
		writingService.addWriting(user, tempWriting);
		//System.out.println(creationService.getCreation(map).toString());
		
		
		
		unifiedsearchDAO.elasticInsert(creationService.getCreation(map));
		
		//List<Unifiedsearch> unifiedsearch =  (List<Unifiedsearch>)map.get("result");
	/*	
		for(Unifiedsearch temp : unifiedsearch) {
			System.out.println(temp.getTitle());
			
			System.out.println(temp.getWriting().toString());
						
			if(temp.getWriting() != null) {
				System.out.println("이거이거");
				
				List<Writing> temp1 = (List<Writing>) temp.getWriting();
				//System.out.println("이고이고" + temp1.getCreationNo());
			}
		}
	*/	//unifiedsearchDAO.elasticInsert(creation);
		// unifiedsearchDAO.elasticDelete(creation);
		//System.out.println(unifiedsearchService.elasticTagSearch(search).toString());
		
		
		
		//Map<String, Object> temp = (Map<String, Object>) map.get("creationList");

		
		
		//System.out.println(temp.get("total").toString());
		//List<Unifiedsearch> search  = (List<Unifiedsearch>)temp.get("result");
		//System.out.println(search.get(0).getTitle());
		//Unifiedsearch unifiedsearch = (Map)map.get("creation");
		
		//unifiedsearch.toString();
/*		for(int i = 0; i < Integer.parseInt((map.get("total").toString())); i++) {
			
			System.out.println(i + "=============================");
			System.out.println("category : " + unifiedsearch.getCategory());
			System.out.println("title : " + unifiedsearch.getTitle());
			System.out.println("content : " + unifiedsearch.getContent());
			System.out.println("nick_name : " + unifiedsearch.getNick_name());
			System.out.println("id : " + unifiedsearch.getId());
			System.out.println("tag : " + unifiedsearch.getTag().toString());
		}
*/	}
}
