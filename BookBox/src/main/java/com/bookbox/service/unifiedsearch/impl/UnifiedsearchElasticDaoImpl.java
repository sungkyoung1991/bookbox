package com.bookbox.service.unifiedsearch.impl;

import java.io.BufferedInputStream;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.io.IOUtils;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.springframework.stereotype.Service;

import com.bookbox.common.domain.Const.Category;
import com.bookbox.common.domain.Search;
import com.bookbox.common.domain.Tag;
import com.bookbox.service.domain.Board;
import com.bookbox.service.domain.Creation;
import com.bookbox.service.domain.Posting;
import com.bookbox.service.domain.Writing;
import com.bookbox.service.unifiedsearch.UnifiedsearchDAO;

/**
 * @file com.bookbox.service.unifiedsearch.UnifiedsearchElasticDaoImpl.java
 * @brief UnifiedsearchElasticDaoImpl
 * @detail
 * @author JJ
 * @date 2017.11.01
 */

@Service("unifiedsearchElasticDAOImpl")
public class UnifiedsearchElasticDaoImpl implements UnifiedsearchDAO {

	private String url = "http://183.98.215.171:9200/bookbox/";

	public UnifiedsearchElasticDaoImpl() {
		System.out.println("Constructor :: " + this.getClass().getName());
	}

	@Override
	public void elasticInsert(Object object) throws Exception {
		
		Map<String, Object> map = compareToCategory(object);

		String query = url + map.get("category") + "/" + map.get("id");
		sendToElastic(query, map.get("json").toString(), "POST");
	}

	@Override
	public void elasticUpdate(Object object) throws Exception {
		Map<String, Object> map = compareToCategory(object);
		
		String query = url + map.get("category") + "/" + map.get("id");
		sendToElastic(query, map.get("json").toString(), "PUT");
	}

	@Override
	public void elasticDelete(Object object) throws Exception {
		
		if (object.getClass().getSimpleName().equals("Creation")) {
			elasticUpdate(object);
		}

		else {
			Map<String, Object> map = compareToCategory(object);

			String query = url + map.get("category") + "/" + map.get("id");
			sendToElastic(query, map.get("json").toString(), "DELETE");
		}
	}

	@Override
	public JSONObject elasticSearch(Search search) throws Exception {
		String query = url + "/_search";
		String json = "{\"query\":{\"multi_match\":{ \"fields\":[\"title\", \"content\", \"writing\"], \"query\":\""
				+ search.getKeyword() + "\"}}}";

		if (search.getCategory() == Category.CREATION)
			query = url + "creation/_search";
		else if (search.getCategory() == Category.POSTING)
			query = url + "posting/_search";
		else if (search.getCategory() == Category.BOARD)
			query = url + "board/_search";
		else if (search.getCategory() == Category.TAG) {
			query = url + search.getCondition();
			json = "{\"query\":{\"multi_match\":{ \"fields\":[\"tag\"], \"query\":\"" + search.getKeyword() + "\"}}}";
		}

		return sendToElastic(query, json, "POST");
	}

	@SuppressWarnings("unchecked")
	public Map<String, Object> compareToCategory(Object object) throws Exception {
		Map<String, Object> map = new HashMap<String, Object>();
		JSONObject obj = new JSONObject();

		switch (object.getClass().getSimpleName()) {
		case "Creation":
			Creation creation = (Creation) object;

			obj.put("title", creation.getCreationTitle());
			obj.put("content", creation.getCreationIntro());
			obj.put("tag", tagParse(creation.getTagList()));
			obj.put("nick_name", creation.getCreationAuthor().getNickname());
			obj.put("image", creation.getCreationFileName());

			if (creation.getWritingList() != null) {
				List<Writing> writingList = (List<Writing>) creation.getWritingList();
				JSONObject objectTemp = null;
				JSONArray temp = new JSONArray();

				for (Writing writing : writingList) {
					objectTemp = new JSONObject();

					objectTemp.put("title", writing.getWritingTitle());
					objectTemp.put("content", removeTag(writing.getWritingContent()));
					objectTemp.put("_id", writing.getWritingNo());
					if(writing.getWritingFileList().size() > 0) 
						objectTemp.put("image", writing.getWritingFileList().get(0).getFileName());
					
					temp.add(objectTemp);
					
					if(temp.size() > 3) 
						break;
				}

				obj.put("writing", temp);
			}
			
			map.put("category", "creation");
			map.put("id", creation.getCreationNo());
			map.put("json", obj);
			break;

		case "Posting":
			Posting posting = (Posting) object;

			obj.put("title", posting.getPostingTitle());
			obj.put("content", removeTag(posting.getPostingContent()));
			obj.put("tag", tagParse(posting.getPostingTagList()));
			obj.put("nick_name", posting.getUser().getNickname());
			obj.put("image", posting.getPostingFileList().size() == 0 ? "" : posting.getPostingFileList().get(0).getFileName());

			map.put("category", "posting");
			map.put("id", posting.getPostingNo());
			map.put("json", obj);
			break;
		case "Board":
			Board board = (Board) object;

			obj.put("title", board.getBoardTitle());
			obj.put("content", removeTag(board.getBoardContent()));
			obj.put("tag", tagParse(board.getTagList()));
			obj.put("nick_name", board.getWriter().getNickname());
			obj.put("image", board.getThumbnailUrl());

			map.put("category", "board");
			map.put("id", board.getBoardNo());
			map.put("json", obj);
			break;
		}
		return map;
	}

	public List<String> tagParse(List<Tag> tagList) {
		List<String> list = new ArrayList<String>();

		if (tagList != null) {
			for (Tag tag : tagList) {
				list.add(tag.getTagName());
			}
		}
		return list;
	}

	public JSONObject sendToElastic(String query, String json, String type) throws Exception {
		URL url = new URL(query);
		HttpURLConnection conn = (HttpURLConnection) url.openConnection();
		conn.setConnectTimeout(5000);
		conn.setRequestProperty("Content-Type", "application/json; charset=UTF-8");
		conn.setDoOutput(true);
		conn.setDoInput(true);
		conn.setRequestMethod(type);

		OutputStream os = conn.getOutputStream();
		os.write(json.getBytes("UTF-8"));
		os.close();

		InputStream in = new BufferedInputStream(conn.getInputStream());

		JSONParser jsonParser = new JSONParser();
		JSONObject jsonObject = (JSONObject) jsonParser.parse(IOUtils.toString(in, "UTF-8"));

		in.close();
		conn.disconnect();

		return jsonObject;
	}

	public String removeTag(String str) {
		String content = "";

		for (String seq : str.split("<")) {
			if (seq.indexOf(">") != -1) {
				content += seq.substring(seq.indexOf(">") + 1);
			} else {
				content += seq;
			}
		}
		return content;
	}

	@Override
	public JSONObject elasticRelationTagSearch(Search search) throws Exception {
		String query = url + "_search";
		String json = "{\"query\":{\"multi_match\":{\"fields\":[\"title\", \"content\", \"writing\"], \"query\":\""
				+ search.getKeyword() + "\"}}, \"_source\":[\"tag\"]}";

		if (search.getCategory() == Category.CREATION)
			query = url + "creation/_search";
		else if (search.getCategory() == Category.POSTING)
			query = url + "posting/_search";
		else if (search.getCategory() == Category.BOARD)
			query = url + "board/_search";
		else if(search.getCategory() == Category.TAG)
			json = "{\"query\":{\"multi_match\":{\"fields\":[\"tag\"], \"query\":\"" + search.getKeyword() + "\"}}, \"_source\":[\"tag\"]}";

		return sendToElastic(query, json, "GET");
	}
}
