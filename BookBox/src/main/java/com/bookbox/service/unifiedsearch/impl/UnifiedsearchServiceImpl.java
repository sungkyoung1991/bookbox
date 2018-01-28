package com.bookbox.service.unifiedsearch.impl;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.bookbox.common.domain.Const.Category;
import com.bookbox.common.domain.Search;
import com.bookbox.service.domain.Unifiedsearch;
import com.bookbox.service.domain.Writing;
import com.bookbox.service.unifiedsearch.UnifiedsearchDAO;
import com.bookbox.service.unifiedsearch.UnifiedsearchService;

/**
 * @file com.bookbox.service.unifiedsearch.UnifiedsearchServiceImpl.java
 * @brief UnifiedsearchServiceImpl
 * @detail
 * @author JJ
 * @date 2017.11.02
 */

@Service("unifiedsearchServiceImpl")
public class UnifiedsearchServiceImpl implements UnifiedsearchService {

	@Autowired
	@Qualifier("unifiedsearchElasticDAOImpl")
	private UnifiedsearchDAO unifiedsearchDAO;

	public UnifiedsearchServiceImpl() {
		System.out.println("Constructor :: " + this.getClass().getName());
	}

	@Override
	public Map<String, Object> elasticSearch(Search search) throws Exception {
		Map<String, Object> map = new HashMap<String, Object>();
		Search temp = new Search();
		temp.setKeyword(search.getKeyword());

		if (search.getCategory() == Category.UNIFIEDSEARCH) {
			temp.setCategory(Category.UNIFIEDSEARCH);
			map.put("result", convertToMap(unifiedsearchDAO.elasticSearch(temp)));

			temp.setCategory(Category.CREATION);
			map.put("creationList", convertToMap(unifiedsearchDAO.elasticSearch(temp)));

			temp.setCategory(Category.BOARD);
			map.put("boardList", convertToMap(unifiedsearchDAO.elasticSearch(temp)));

			temp.setCategory(Category.POSTING);
			map.put("postingList", convertToMap(unifiedsearchDAO.elasticSearch(temp)));

			return map;

		} else if (search.getCategory() == Category.TAG) {
			temp.setCategory(Category.TAG);

			temp.setCondition("_search");
			map.put("result", convertToMap(unifiedsearchDAO.elasticSearch(temp)));

			temp.setCondition("creation/_search");
			map.put("creationList", convertToMap(unifiedsearchDAO.elasticSearch(temp)));

			temp.setCondition("board/_search");
			map.put("boardList", convertToMap(unifiedsearchDAO.elasticSearch(temp)));

			temp.setCondition("posting/_search");
			map.put("postingList", convertToMap(unifiedsearchDAO.elasticSearch(temp)));

			return map;
		}
		return convertToMap(unifiedsearchDAO.elasticSearch(search));
	}

	public Map<String, Object> convertToMap(JSONObject jsonObject) throws Exception {
		Map<String, Object> map = new HashMap<String, Object>();
		Unifiedsearch unifiedsearch = null;
		JSONObject object = (JSONObject) jsonObject.get("hits");
		JSONArray jsonArray = (JSONArray) object.get("hits");
		List<Unifiedsearch> list = new ArrayList<Unifiedsearch>();

		for (int i = 0; i < jsonArray.size(); i++) {
			JSONObject jo = (JSONObject) jsonArray.get(i);
			JSONObject lastJo = (JSONObject) jo.get("_source");
			unifiedsearch = new Unifiedsearch();

			if ((boolean) lastJo.containsKey("writing")) {
				JSONArray wriringList = (JSONArray) lastJo.get("writing");
				List<Writing> tempList = new ArrayList<Writing>();

				for (int j = 0; j < wriringList.size(); j++) {
					JSONObject temp = (JSONObject) wriringList.get(j);
					Writing writing = new Writing();

					writing.setWritingTitle(temp.get("title").toString());
					writing.setWritingNo(Integer.parseInt(temp.get("_id").toString()));
					writing.setWritingContent(temp.get("content").toString());

					if (temp.get("image") != null)
						writing.setWritingAuthor(temp.get("image").toString());

					tempList.add(writing);

					if (tempList.size() > 4)
						break;
				}
				unifiedsearch.setWriting(tempList);
			}
			unifiedsearch.setContent(lastJo.get("content") == null ? "" : lastJo.get("content").toString());
			unifiedsearch.setTitle(lastJo.get("title") == null ? "" : lastJo.get("title").toString());
			unifiedsearch.setNick_name(lastJo.get("nick_name") == null ? "" : lastJo.get("nick_name").toString());
			unifiedsearch.setId(jo.get("_id") == null ? "" : jo.get("_id").toString());
			unifiedsearch.setCategory(jo.get("_type").toString());
			unifiedsearch.setTag((List<String>) lastJo.get("tag"));
			unifiedsearch.setImage(lastJo.get("image") == null ? "" : lastJo.get("image").toString());
			list.add(unifiedsearch);
		}
		map.put("total", object.get("total"));
		map.put("result", list);

		return map;
	}

	@Override
	public List<String> elasticRelationTagSearch(Search search) throws Exception {
		JSONObject object = (JSONObject) (unifiedsearchDAO.elasticRelationTagSearch(search)).get("hits");
		JSONArray jsonArray = (JSONArray) object.get("hits");
		JSONArray temp = null;
		List<String> list = new ArrayList<String>();

		for (int i = 0; i < jsonArray.size(); i++) {
			JSONObject jo = (JSONObject) jsonArray.get(i);
			JSONObject lastJo = (JSONObject) jo.get("_source");

			if (lastJo.get("tag") != null) {
				temp = (JSONArray) lastJo.get("tag");

				for (int j = 0; j < temp.size(); j++) {
					list.add(temp.get(j).toString());
				}
			}
		}

		return counting(list);
	}

	public List<String> counting(List<String> list) {
		Map<String, Integer> map = new HashMap<String, Integer>();

		for (String str : list) {
			if (map.containsKey(str))
				map.put(str, map.get(str) + 1);

			else
				map.put(str, 1);
		}

		List<String> tagList = sortByValue(map);
		List<String> tag = new ArrayList<String>();

		for (int i = 0; i < tagList.size(); i++) {

			if (!tagList.get(i).equals("픽션") && !tagList.get(i).equals("논픽션"))
				tag.add(tagList.get(i));

			if (tag.size() > 4)
				break;
		}
		return tag;
	}

	@SuppressWarnings("unchecked")
	public List<String> sortByValue(Map<String, Integer> map) {
		List<String> list = new ArrayList<String>();
		list.addAll(map.keySet());

		Collections.sort(list, new Comparator() {
			public int compare(Object o1, Object o2) {
				Object v1 = map.get(o1);
				Object v2 = map.get(o2);

				return ((Comparable) v1).compareTo(v2);
			}

		});
		Collections.reverse(list); // 주석시 오름차순
		return list;
	}
}
