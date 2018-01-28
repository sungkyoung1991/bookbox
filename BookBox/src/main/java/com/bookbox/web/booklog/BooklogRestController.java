package com.bookbox.web.booklog;

import java.io.File;
import java.io.PrintWriter;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.codehaus.jackson.map.ObjectMapper;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import com.bookbox.common.domain.Log;
import com.bookbox.common.domain.Page;
import com.bookbox.common.domain.Search;
import com.bookbox.common.domain.Tag;
import com.bookbox.common.service.LogService;
import com.bookbox.common.service.TagService;
import com.bookbox.common.util.CommonUtil;
import com.bookbox.service.booklog.BooklogService;
import com.bookbox.service.booklog.PostingService;
import com.bookbox.service.domain.Booklog;
import com.bookbox.service.domain.User;

/**
 * @file com.bookbox.service.web.booklog.BooklogRestController.java
 * @author JW
 * @date 2017.10.20
 * @brief BooklogRestController
 */
@RestController
@RequestMapping("booklog/rest/*")
public class BooklogRestController {
	
	@Autowired
	@Qualifier("booklogServiceImpl")
	private BooklogService booklogService;
	
	@Autowired
	@Qualifier("postingServiceImpl")
	private PostingService postingService;
	
	@Autowired
	@Qualifier("tagServiceImpl")
	private TagService tagService;
	
	@Autowired
	@Qualifier("logServiceImpl")
	private LogService logService;

	//한페이지에 보여줄 갯수
	@Value("#{commonProperties['pageSize']}")
	int pageSize;
	
	public BooklogRestController() {
		System.out.println("Constructor :: "+this.getClass().getName());
	}

	/**
	 * @brief CKEditor용 upload 기능
	 * @param file : 전달받은 file
	 * @param CKEditor : ??
	 * @param CKEditorFuncNum : 어디서 호출되었는지 확인용
	 * @param request : getRealPath()용
	 * @param response : 업로드된 파일정보를 cookie에 담아서 실제 반영되는지 여부 확인
	 * @throws Exception
	 */
	@RequestMapping( value="uploadFile", method=RequestMethod.POST )
	public void uploadFile(@RequestParam("upload")MultipartFile file, 
							@RequestParam(value="CKEditor", required=false)String CKEditor,
							@RequestParam(value="CKEditorFuncNum", required=false)String CKEditorFuncNum,
							HttpServletRequest request,
							HttpServletResponse response) throws Exception{
		
		if(file != null) {
		
			String originName = file.getOriginalFilename();
			String fileName = UUID.randomUUID().toString() + originName.substring(originName.lastIndexOf('.'));
			String fileURL = request.getServletContext().getRealPath("/resources/upload_files/images/");
			String callbackURL = new StringBuilder()
								.append("<script type='text/javascript'>")
								.append("window.parent.CKEDITOR.tools.callFunction(")
								.append(CKEditorFuncNum)
								.append(",")
								.append("'../resources/upload_files/images/"+fileName+"'")
								.append(",")
								.append("'Upload Success!')</script>").toString();
			file.transferTo(new File(fileURL, fileName));
			
			Cookie cookie = new Cookie(fileName, URLEncoder.encode("file:"+originName,"UTF-8"));
			cookie.setPath("/");
			response.addCookie(cookie);
			
			System.out.println(callbackURL);
			
			PrintWriter printWriter = response.getWriter();
			printWriter.println(callbackURL);
			printWriter.flush();
			printWriter.close();
			
		}else {
			System.out.println("hi");
			
		}
		
	}
	
	/**
	 * @brief CKEditor용 drag&drop upload 기능
	 * @param file
	 * @param request
	 * @param response
	 * @return uploaded, fileName, url
	 * @throws Exception
	 */
	@RequestMapping( value="uploadFileDragAndDrop", method=RequestMethod.POST )
	public String uploadFileDragAndDrop(@RequestParam("upload")MultipartFile file, 
							HttpServletRequest request,
							HttpServletResponse response) throws Exception{

		JSONObject jsonObject = new JSONObject();
		
		if(file != null) {
		
			String originName = file.getOriginalFilename();
			String fileName = UUID.randomUUID().toString() + originName.substring(originName.lastIndexOf('.'));
			String fileURL = request.getServletContext().getRealPath("/resources/upload_files/images/");
			file.transferTo(new File(fileURL, fileName));
			
			Cookie cookie = new Cookie(fileName, URLEncoder.encode("file:"+originName,"UTF-8"));
			cookie.setPath("/");
			response.addCookie(cookie);
			
			jsonObject.put("uploaded", 1);
			jsonObject.put("fileName", fileName);
			jsonObject.put("url", "../resources/upload_files/images/"+fileName);
			
		}else {
			System.out.println("hi");
			
		}
		
		System.out.println(jsonObject.toString());
		return jsonObject.toString();
	}

	/**
	 * @brief tagName autocomplete용 rest
	 * @param tagName
	 * @return 자동완성목록
	 */
	@RequestMapping( value="tag", method=RequestMethod.POST )
	public List<String> getTagList(@RequestParam("tagName") String tagName) {
		
		List<Tag> tagList = tagService.getTagList(new Tag(tagName)); 
		List<String> stringTagList = new ArrayList<String>();
		for(Tag tag : tagList) {
			stringTagList.add(tag.getTagName());
		}
		
		return stringTagList;
	}
	
	/**
	 * @brief 책갈피추가
	 * @param email : 책갈피를 추가하려고 하는 booklog 주인 email
	 * @param booklogNo : 책갈피를 추가하려고 하는 booklogNo
	 * @param session : 서비스를 요청한 user 획득용
	 * @return 성공여부
	 */
	@RequestMapping( value="addBookmark/{email}/{booklogNo}", method=RequestMethod.GET )
	public boolean addBookmark(@PathVariable("email") String email, @PathVariable("booklogNo") int booklogNo, HttpSession session) {
		User targetUser = new User();
		Booklog booklog = new Booklog();
		targetUser.setEmail(email);
		booklog.setBooklogNo(booklogNo);
		booklog.setUser(targetUser);
		
		User user = (User)session.getAttribute("user");
		
		return booklogService.addBooklogBookmark(user, booklog);
	}
	
	/**
	 * @brief 책갈피 삭제
	 * @param email : 책갈피를 삭제하려는 booklog 주인 email
	 * @param booklogNo : 책갈피를 삭제하려는 booklogNo
	 * @param session : 서비스를 요청한 user 획득용
	 * @return 성공여부
	 */
	@RequestMapping( value="deleteBookmark/{email}/{booklogNo}", method=RequestMethod.GET )
	public boolean deleteBookmark(@PathVariable("email") String email, @PathVariable("booklogNo") int booklogNo, HttpSession session) {
		User targetUser = new User();
		Booklog booklog = new Booklog();
		targetUser.setEmail(email);
		booklog.setBooklogNo(booklogNo);
		booklog.setUser(targetUser);
		
		User user = (User)session.getAttribute("user");
		
		return booklogService.deleteBooklogBookmark(user, booklog);
	}
	
	/**
	 * @brief email 유저의 로그 목록 호출
	 * @param email 로그를 가져올 유저 email
	 * @param active 가져올 페이지 넘버(currentPage 역할)
	 * @return 해당 유저의 해당 페이지 로그리스트
	 */
	@RequestMapping( value="getLogList/{email}/{active}", method=RequestMethod.GET )
	public List<Log> getLogList(@PathVariable("email") String email, @PathVariable("active") int active){
		User booklogUser = new User();
		booklogUser.setEmail(email);
		booklogUser.setActive(active * 10);
		
		return logService.getLogList(booklogUser);
	}
	
	/**
	 * @brief 북로그 프로필에 보여질 창작작품수, 포스팅수, 책갈피수를 가져옴
	 * @param id 유저 이메일의 id
	 * @param domain 유저 이메일의 domain
	 * @param dot 유저 이메일의 마지막
	 * @param index
	 * @param session
	 * @return
	 */
	@RequestMapping( value="getCounts/{id}/{domain}/{dot}/{index}", method=RequestMethod.GET )
	public Map<String, String> getCounts(@PathVariable("id") String id, @PathVariable("domain") String domain,
											@PathVariable("dot") String dot, @PathVariable("index") int index,
											HttpSession session){
		String email = id+"@"+domain+"."+dot;
		Map<String, String> map = booklogService.getCounts(email);
		map.put("index", index+"");
		Booklog booklog= new Booklog();
		User booklogUser = new User();
		booklogUser.setEmail(email);
		booklog.setUser(booklogUser);
		User user = (User)session.getAttribute("user");
		map.put("bookmark", booklogService.getBookmark(user, booklog) + "");
		return map;
	}
	
	/**
	 * @brief 북로그목록 호출(REST)
	 * @param search
	 * @param currentPage
	 * @return booklogList
	 */
	@RequestMapping( value="getBooklogList/{currentPage}" )
	public Map<String, Object> getBooklogList(@RequestBody Search search, @PathVariable int currentPage) {

		Page page = new Page();
		page.setCurrentPage(currentPage);
		page.setPageSize(pageSize);
		Map<String, Object> map = CommonUtil.getSearchPageMap(search, page);
		map.put("booklogList", booklogService.getBooklogList(map));
		
		return map;
	}
	
	/**
	 * @brief 포스팅목록 호출(REST)
	 * @param search
	 * @param currentPage
	 * @return postingList
	 */
	@RequestMapping( value="getPostingList/{currentPage}" )
	public Map<String, Object> getPostingList(@RequestBody Search search, @PathVariable int currentPage) {

		Page page = new Page();
		page.setCurrentPage(currentPage);
		page.setPageSize(pageSize);
		Map<String, Object> map = CommonUtil.getSearchPageMap(search, page);
		Map<String, Object> postingListMap = postingService.getPostingList(map); 
		map.put("postingList", postingListMap.get("postingList"));
		
		return map;
	}
	
	/**
	 * @brief 북로그 표지편집
	 * @param json : booklog 객체
	 * @param session : 서비스를 요청한 user 획득용
	 * @param file : booklogImage
	 * @param request : getRealPath()용
	 * @return : true
	 * @throws Exception
	 */
	@RequestMapping( value="updateBooklog", method=RequestMethod.POST )
	public boolean updateBooklog(@RequestParam("booklog") String json, HttpSession session,
									@RequestParam(value = "file", required = false)MultipartFile file, HttpServletRequest request) throws Exception {
		
		Booklog booklog = new ObjectMapper().readValue(json.toString(), Booklog.class);
		if(file != null && !file.isEmpty()) {
			file.transferTo(new File(request.getServletContext().getRealPath("/resources/upload_files/images/"),file.getOriginalFilename()));
			booklog.setBooklogImage(file.getOriginalFilename());
			User user = (User)session.getAttribute("user");
			user.setBooklogImage(file.getOriginalFilename());
			session.setAttribute("user", user);
		}
		booklogService.updateBooklog((User)session.getAttribute("user"), booklog);
		
		return true;
	}
}
