package com.bookbox.web.creation;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.codehaus.jackson.map.ObjectMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.core.io.FileSystemResource;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import com.bookbox.common.domain.Const;
import com.bookbox.common.domain.Grade;
import com.bookbox.common.domain.Page;
import com.bookbox.common.domain.Reply;
import com.bookbox.common.domain.Search;
import com.bookbox.common.domain.Tag;
import com.bookbox.common.domain.UploadFile;
import com.bookbox.common.service.TagService;
import com.bookbox.common.util.CommonUtil;
import com.bookbox.service.creation.CreationService;
import com.bookbox.service.creation.FundingService;
import com.bookbox.service.creation.WritingService;
import com.bookbox.service.domain.Creation;
import com.bookbox.service.domain.Funding;
import com.bookbox.service.domain.PayInfo;
import com.bookbox.service.domain.User;


/**
 * @file com.bookbox.web.creation.CreationRestController.java
 * @brief 창작공간 RestController
 * @detail
 * @author HJ
 * @date 2017.10.24
 */
@RestController
@RequestMapping("/creation/rest/*")
public class CreationRestController {

	
	/**
	 * @brief Field
	 */
	@Autowired
	@Qualifier("creationServiceImpl")
	private CreationService creationService;

	@Autowired
	@Qualifier("tagServiceImpl")
	private TagService tagService;
	
	@Autowired
	@Qualifier("writingServiceImpl")
	private WritingService writingService;
	
	@Autowired
	@Qualifier("fundingServiceImpl")
	private FundingService fundingService;
	
	@Autowired
	@Qualifier("uploadDirResource")
	private FileSystemResource uploadDirResource;
	
	@Value("#{commonProperties['pageUnit']}")
	int pageUnit;
	@Value("#{commonProperties['pageSize']}")
	int pageSize;
		
	/**
	 * @brief Constructor
	 */
	public CreationRestController() {
		System.out.println("CreationRestController :: "+getClass().getName());
	}
	
	
	/**
	 * @brief addCreationSubscribe/구독신청                           
	 * @details GET
	 * @param creationNo ,HttpSession 
	 * @throws Exception
	 * @return boolean
	 */	
	@RequestMapping(value="addCreationSubscribe", method=RequestMethod.GET )
	public boolean addCreationSubscribe(@RequestParam("creationNo") int creationNo,
																		HttpSession session) throws Exception {
		System.out.println("CreationRestController :: /creation/rest/doCreationSubscribe : GET ===> START\n");
		
		Map<String, Object> map = CommonUtil.mappingCategoryTarget(Const.Category.CREATION, creationNo,(User)session.getAttribute("user"));

		Creation creation = creationService.getCreation(map);
		creationService.addCreationSubscribe((User)session.getAttribute("user"), creation);

		System.out.println("CreationRestController :: /creation/rest/doCreationSubscribe : GET ===> END\n\n");
		
		return creationService.addCreationSubscribe((User)session.getAttribute("user"), creation);
	}
	
	/**
	 * @brief deleteCreationSubscribe/구독신청 취소                          
	 * @details GET
	 * @param creationNo ,HttpSession 
	 * @throws Exception
	 * @return boolean
	 */	
	@RequestMapping(value="deleteCreationSubscribe", method=RequestMethod.GET )
	public boolean deleteCreationSubscribe(@RequestParam("creationNo") int creationNo,
																		HttpSession session) throws Exception {
		
		System.out.println("CreationRestController :: /creation/rest/deleteCreationSubscribe : GET ===> START\n");
		
		Map<String, Object> map = CommonUtil.mappingCategoryTarget(Const.Category.CREATION, creationNo,(User)session.getAttribute("user"));

		Creation creation = creationService.getCreation(map);
		creationService.deleteCreationSubscribe((User)session.getAttribute("user"), creation);

		System.out.println("CreationRestController :: /creation/rest/deleteCreationSubscribe : GET ===> END\n\n");
		return creationService.deleteCreationSubscribe((User)session.getAttribute("user"), creation);
	}
	
	/**
	 * @brief addCreationLike/작품 좋아요                           
	 * @details GET
	 * @param Creation ,HttpSession 
	 * @throws Exception
	 * @return boolean
	 */	
	@RequestMapping(value="addCreationLike", method=RequestMethod.GET )
	public boolean addLike(@RequestParam("creationNo") int creationNo,
																		HttpSession session) throws Exception {
		System.out.println("CreationRestController :: /creation/rest/addCreationLike : GET ===> START\n");
		
		Map<String, Object> map = CommonUtil.mappingCategoryTarget(Const.Category.CREATION, creationNo,(User)session.getAttribute("user"));
		Creation creation = creationService.getCreation(map);

		System.out.println("CreationRestController :: /creation/rest/addCreationLike : GET ===> END\n\n");
	
		return creationService.addCreationLike((User)session.getAttribute("user"), creation);
	}
	
	/**
	 * @brief deleteCreationLike/좋아요 취소                          
	 * @details GET
	 * @param creationNo ,HttpSession 
	 * @throws Exception
	 * @return boolean
	 */	
	@RequestMapping(value="deleteCreationLike", method=RequestMethod.GET )
	public boolean deleteCreationLike(@RequestParam("creationNo") int creationNo,
																		HttpSession session) throws Exception {
		System.out.println("CreationRestController :: /creation/rest/deleteCreationLike : GET ===> START\n");
		
		Map<String, Object> map = CommonUtil.mappingCategoryTarget(Const.Category.CREATION, creationNo,(User)session.getAttribute("user"));
		Creation creation = creationService.getCreation(map);

		System.out.println("CreationRestController :: /creation/rest/deleteCreationLike : GET ===> END\n\n");
		
		return creationService.deleteCreationLike((User)session.getAttribute("user"), creation);
	}
	
	/**
	 * @brief getTag/태그자동완성                           
	 * @details POST
	 * @param Creation ,HttpSession 
	 * @throws Exception
	 * @return 
	 */	
	@RequestMapping(value="getTagList", method=RequestMethod.POST )
	public List<Tag> getTag(@RequestBody Tag tag,
																		HttpSession session) throws Exception {
		
		tagService.getTagList(tag);
		
		return null;
	}
	
	/**
	 * @brief addCreation/ 창작작품 등록
	 * @details POST
	 * @param  creation,HttpServeltRequest, MutipartFile, HttpSession
	 * @throws Exception
	 * @return Map<String, Object>
	 */
	@RequestMapping(value="addCreation", method=RequestMethod.POST)
	public Map<String, Object> addCreation(@RequestParam("creation") String json, 
																					HttpServletRequest request,
																					@RequestParam(value="file", required=false) MultipartFile multipartFile,
																					HttpSession session) throws Exception{
		// TODO addCreation
		System.out.println("CreationRestController :: /creation/rest/addCreation : POST ===> START");
		
		User user = (User)session.getAttribute("user");
		System.out.println("addCreation :: "+user.getEmail());
	
		Creation creation = new ObjectMapper().readValue(json.toString(), Creation.class);
		System.out.println("restController :: addCreation :: creation ::"+creation);
		
		String path = request.getServletContext().getRealPath("/resources/upload_files/images/");
		
		UploadFile uploadFile = creationService.saveFile(multipartFile, path);
		creation.setCreationFileName(uploadFile.getFileName());
		creation.setCreationOriginName(uploadFile.getOriginName());
		
		List<Tag> tagList = new ArrayList<>();
		String[] dbTag = request.getParameterValues("tag");
		
		for (String tag : dbTag) {
			if (!tag.equals("")) {
				tagList.add(new Tag(tag));
			}
		}	
		
		creation.setTagList(tagList);
		creation.setCreationAuthor(user);
		
		if (creation.getCreationNo() == 0) {
			creationService.addCreation(user, creation);
		}
		
		Map<String, Object> map = new HashMap<>();
		map.put("user", session.getAttribute("user"));
		
		Search search = new Search();
		search.setCondition("4");
		map.put("search", search);
		
		List<Creation> creationList =creationService.getCreationList(map);
		
		map.put("creationList", creationList);
		map.put("creation", creation);
		
		System.out.println("CreationRestController :: /creation/rest/addCreation ==> END");
		
		return map;
	}
	
	/**
	 * @brief getCreation/ 창작작품 정보조회
	 * @details GET
	 * @param CreationNo, HttpSession
	 * @throws Exception
	 * @return Creation
	 */
	@RequestMapping(value="getCreation", method=RequestMethod.GET)
	public Creation getCreation(@RequestParam("creationNo") int creationNo,
															HttpSession session) throws Exception{
		System.out.println("CreationRestController :: /creation/rest/getCreation : GET ===> START");
		// TODO getCreation
		
		Map<String, Object> map = CommonUtil.mappingCategoryTarget(Const.Category.CREATION, creationNo,(User)session.getAttribute("user"));
		Creation creation = creationService.getCreation(map);
		
		List<Tag> tagList =tagService.getTagGroupList(Const.Category.CREATION, creation.getCreationNo());
		creation.setTagList(tagList);

		System.out.println("CreationRestController :: /creation/rest/getCreation : GET ===> END");
		return creation;
	}
	
	/**
	 * @brief updateCreation/작품수정
	 * @details POST
	 * @param Creation, HttpServletRequest, MultipartFile, HttpSession 
	 * @throws Exception
	 * @return boolean
	 */
	@RequestMapping( value="updateCreation", method=RequestMethod.POST )
	public boolean updateCreation(@RequestBody Creation creation, 
																HttpServletRequest request,
																@RequestParam(value="file", required=false)MultipartFile multipartFile,
																HttpSession session) throws Exception{
		// TODO updateCreation
		System.out.println("CreationController :: rest/creation/updateCreation : POST ===> START");
		//Business Logic
		
		User user= (User)session.getAttribute("user");
		System.out.println("updateCreation :: "+creation+"\n");
		
		if (multipartFile != null && !multipartFile.isEmpty()) {
			String path = request.getServletContext().getRealPath("/resources/upload_files/images/");
			
			UploadFile uploadFile = creationService.saveFile(multipartFile, path);
			creation.setCreationFileName(uploadFile.getFileName());
			creation.setCreationOriginName(uploadFile.getOriginName());
		}
		
		
		List<Tag> tagList = new ArrayList<>();
		String[] dbTag = request.getParameterValues("tag");
		
		for (String tag : dbTag) {
			if (!tag.equals("")) {
				tagList.add(new Tag(tag));
			}
		}	
		
		creation.setTagList(tagList);
		creation.setCreationAuthor(user);
		
		creationService.updateCreation(user, creation);
		
		System.out.println("CreationController :: rest/creation/updateCreation : POST ===> END");
		
		return true;
	}
	
	/**
	 * @brief addFunding/ 펀딩가능여부 확인
	 * @details GET
	 * @param condition, HttpSession
	 * @throws Exception
	 * @return List<Creation>
	 */
	@RequestMapping(value="addFunding", method=RequestMethod.GET)
	public List<Creation> checkFunding(@RequestParam("condition") String condition ,HttpSession session) throws Exception{
		// TODO addFunding
		System.out.println("CreationRESTController :: /creation/rest/addFunding : GET ===> START");
		
		//Business Logic
		User user = (User)session.getAttribute("user");
		Search search = new Search();
		search.setCondition(condition);
		System.out.println("RestController :: addFunding :: "+user.getEmail());
		System.out.println("RestController :: addFunding :: search.condition :: "+search.getCondition());
		
		Map<String, Object> map = new HashMap<>();
		map.put("user", user);
		map.put("search", search);
		map.put("categoryNo", Const.Category.CREATION);
		List<Creation> creationList =creationService.getCreationList(map);
			
		System.out.println("CreationREST Controller :: /creation/rest/addFunding : GET ===> END");
	
		return creationList;
	}
	
	/**
	 * @brief getFundingList/펀딩글리스트 조회
	 * @details GET
	 * @param Search, Page, HttpSession
	 * @throws Exception
	 * @return "forward:listFunding.jsp"
	 */
	@RequestMapping( value="getFundingList", method=RequestMethod.GET )
	public List<Funding> getFundingList(@RequestParam("condition") String condition,
																				HttpSession session) throws Exception {
		System.out.println("CreationRESTController :: /creation/rest/getFundingList : GET\n");

		Search search =new Search();
		search.setCondition(condition);
		Page page = new Page();
		
		//Business Logic
		if(search.getKeyword() == null) {
			search.setKeyword("");
		}
		if(search.getCondition() ==null) {
			search.setCondition("0");
		}
		if(page.getPageSize() ==0) {
			page.setPageSize(pageSize);
		}
		if(page.getPageUnit()==0) {
			page.setPageUnit(pageUnit);
		}
		System.out.println("getFundingList :: getSearch :: "+search+"\n");
		System.out.println("getFundingList :: getPage :: "+page+"\n");
		
		Map<String, Object> map = new HashMap<>();
		map.put("search", search);
		map.put("page", page);
		map.put("user",(User)session.getAttribute("user"));

		List<Funding> fundingList = fundingService.getFundingList(map);
		
		System.out.println("CreationRESTController :: /creation/rest/getFundingList : GET ===> END\n\n");
		
		return fundingList;
	}
	
	/**
	 * @brief addPayInfo/ 펀딩결제정보 등록
	 * @details POST
	 * @param PayInfo, HttpSession
	 * @throws Exception
	 * @return boolean
	 */
	@RequestMapping(value="addPayInfo", method=RequestMethod.POST)
	public boolean addPayInfo(@RequestBody PayInfo payInfo,
													HttpSession session) throws Exception{
		// TODO addPayInfo
		System.out.println("CreationRestController :: /creation/rest/addPayInfo : POST ===> START");
		
		User user = (User)session.getAttribute("user");
		payInfo.setUser(user);
		fundingService.addPayInfo(payInfo.getUser(), payInfo);
		
		System.out.println("CreationRestController :: /creation/rest/addPayInfo ==> END");
		
		return true;
	}
	
	/**
	 * @brief getPayInfo/ 펀딩결제정보조회
	 * @details GET
	 * @param fundingNo, HttpSesseion
	 * @throws Exception
	 * @return PayInfo
	 */
	@RequestMapping(value="getPayInfo", method=RequestMethod.GET)
	public PayInfo getPayInfo(@RequestParam("fundingNo") int fundingNo,
													HttpSession session) throws Exception{
		// TODO getPayInfo
		System.out.println("CreationRestController :: /creation/rest/getPayInfo : GET ===> START");
		
		User user = (User)session.getAttribute("user");
		PayInfo payInfo = new PayInfo();
		payInfo.setFundingNo(fundingNo);
		payInfo.setUser(user);
		
		payInfo = fundingService.getPayInfo(user, payInfo);
		
		System.out.println("CreationRestController :: /creation/rest/getPayInfo ==> END\n\n");
		
		return payInfo;
	}
	
	/**
	 * @brief addGrade/ 창작글 별점등록
	 * @details GET
	 * @param targetNo, grade, HttpSession
	 * @throws Exception
	 * @return boolean
	 */
	@RequestMapping(value="addGrade/{targetNo}/{grade}", method=RequestMethod.GET)
	public boolean addGrade(@PathVariable("targetNo") int targetNo,
														@PathVariable("grade") int grade,	HttpSession session) throws Exception{
		// TODO addGrade
		System.out.println("CreationRestController :: /creation/rest/addGrade : GET ===> START");
		
		Grade g =new Grade();
		g.setUserCount(grade);
		Map<String, Object> map = CommonUtil.mappingCategoryTarget(Const.Category.WRITING, targetNo, (User)session.getAttribute("user"));
		
		map.put("grade", g);
		
		writingService.addGrade(map);
		
		System.out.println("CreationRestController :: /creation/rest/addGrade : GET ==> END");
		
		return true;
	}
	
	/**
	 * @brief addReply/ 댓글등록
	 * @details POST
	 * @param Reply, writingNo, HttpSession
	 * @throws Exception
	 * @return boolean
	 */
	@RequestMapping(value="addReply/{writingNo}", method=RequestMethod.POST)
	public boolean addReply(@RequestBody Reply reply,	
														@PathVariable("writingNo") int writingNo, HttpSession session) throws Exception{
		// TODO addReply
		System.out.println("CreationRestController :: /creation/rest/addReply : GET ===> START");
		
		
		Map<String, Object> map = CommonUtil.mappingCategoryTarget(Const.Category.WRITING, writingNo, (User)session.getAttribute("user"));
		map.put("reply", reply);
		
		writingService.addReply(map);
		
		System.out.println("CreationRestController :: /creation/rest/addReply : GET ==> END");
		
		return true;
	}
	
	
	
}
