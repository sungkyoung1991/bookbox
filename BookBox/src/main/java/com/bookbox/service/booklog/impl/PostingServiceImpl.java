package com.bookbox.service.booklog.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.bookbox.common.domain.Const;
import com.bookbox.common.domain.Search;
import com.bookbox.common.domain.UploadFile;
import com.bookbox.common.service.CommonDAO;
import com.bookbox.common.service.TagService;
import com.bookbox.common.util.CommonUtil;
import com.bookbox.service.booklog.PostingDAO;
import com.bookbox.service.booklog.PostingService;
import com.bookbox.service.domain.Posting;
import com.bookbox.service.domain.User;
import com.bookbox.service.unifiedsearch.UnifiedsearchDAO;

@Service("postingServiceImpl")
public class PostingServiceImpl implements PostingService {

	@Autowired
	@Qualifier("postingDAOImpl")
	private PostingDAO postingDAO;
	
	@Autowired
	@Qualifier("tagServiceImpl")
	private TagService tagService;
	
	@Autowired
	@Qualifier("commonDAOImpl")
	private CommonDAO commonDAO;
	
	@Autowired
	@Qualifier("unifiedsearchElasticDAOImpl")
	private UnifiedsearchDAO unifiedsearchDAO;

	public PostingServiceImpl() {
		System.out.println("Constructor :: "+this.getClass().getName());
	}
	
	@Override
	public boolean addPosting(User user, Posting posting) throws Exception{
		// TODO Auto-generated method stub
		postingDAO.addPosting(posting);
		if(posting.getPostingTagList() != null && posting.getPostingTagList().size() != 0) {
			tagService.addTagGroup(Const.Category.POSTING, posting.getPostingNo(), posting.getPostingTagList());
		}
		this.insertPostingNoIntoUploadFileList(posting);
		if(posting.getPostingFileList() != null && posting.getPostingFileList().size() != 0) {
			commonDAO.addUploadFile(posting.getPostingFileList());
		}
		
		unifiedsearchDAO.elasticInsert(posting);
		return true;
	}

	@Override
	public Posting getPosting(User user, Posting posting) {
		// TODO Auto-generated method stub
		return postingDAO.getPosting(posting);
	}

	@Override
	public Map<String, Object> getPostingList(Map<String, Object> map) {
		// TODO Auto-generated method stub
		Map<String, Object> postingListMap = new HashMap<String, Object>();
		List<Posting> postingList = postingDAO.getPostingList(map); 
		for(Posting posting : postingList) {
			StringBuffer content = new StringBuffer();
			for(String seq : posting.getPostingContent().split("<")) {
				if(seq.indexOf(">") != -1) {
					content.append(seq.substring(seq.indexOf(">")+1));
				}else {
					content.append(seq);
				}
			}
			posting.setPostingContent(content.toString());
		}
		
		postingListMap.put("postingList", postingList);
		postingListMap.put("totalCount", postingDAO.getPostingCount((Search)map.get("search")));
		return postingListMap;
	}

	@Override
	public boolean updatePosting(User user, Posting posting) throws Exception{
		// TODO Auto-generated method stub
		postingDAO.updatePosting(posting);
		if(posting.getPostingTagList() != null && posting.getPostingTagList().size() != 0) {
			tagService.updateTagGroup(Const.Category.POSTING, posting.getPostingNo(), posting.getPostingTagList());
		}
		this.insertPostingNoIntoUploadFileList(posting);
		if(posting.getPostingFileList() != null && posting.getPostingFileList().size() != 0) {
			commonDAO.updateUploadFile(posting.getPostingFileList());
		}else {
			Map<String, Object> map = CommonUtil.mappingCategoryTarget(Const.Category.POSTING, posting.getPostingNo());
			commonDAO.deleteUploadFile(map);
		}
		
		unifiedsearchDAO.elasticInsert(posting);
		return true;
	}
	
	
	/**
	 * @brief postingFileList 내의 uploadFile에 categoryNo를 넣어주는 method
	 * @param posting
	 */
	public void insertPostingNoIntoUploadFileList(Posting posting) {
		for(UploadFile uploadFile : posting.getPostingFileList()) {
			uploadFile.setCategoryNo(Const.Category.POSTING);
			uploadFile.setTargetNo(posting.getPostingNo());
		}
	}

}
