package com.bookbox.service.unifiedsearch.impl;

import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.springframework.stereotype.Service;

import com.bookbox.common.domain.Search;
import com.bookbox.common.domain.Tag;
import com.bookbox.common.util.HttpUtil;
import com.bookbox.service.domain.Book;
import com.bookbox.service.unifiedsearch.BookSearchDAO;

/**
 * @file com.bookbox.service.unifiedsearch.BookSearchKakaoAladinDAOImpl.java
 * @brief BookSearchKakaoAladinDAOImpl
 * @detail
 * @author JJ
 * @date 2017.11.03
 */

@Service("bookSearchKakaoAladinDAOImpl")
public class BookSearchKakaoAladinDAOImpl implements BookSearchDAO {

	public BookSearchKakaoAladinDAOImpl() {
		System.out.println("Constructor :: " + this.getClass().getName());
	}

	@Override
	public List<Book> getBookList(Search search) throws Exception {
		String text = URLEncoder.encode(search.getKeyword(), "UTF-8");		
		String daumOpenAPIURL = "https://dapi.kakao.com/v2/search/book?query=" + text;
		Map<String, String> map = new HashMap<String, String>();
		
		map.put("Authorization", "KakaoAK d4677d98128ed114d1c0f5f0cb5ad784");
		map.put("sort", "recency");
		map.put("category", search.getCondition());
		map.put("size", search.getOrder());
		
		return jsonParser(HttpUtil.requestMethodGet(daumOpenAPIURL, map));
	}

	@Override
	public Book getBook(String isbn) throws Exception {
		String text = URLEncoder.encode(isbn, "UTF-8");
		String daumOpenAPIURL = "https://dapi.kakao.com/v2/search/book?query=" + text;

		Map<String, String> map = new HashMap<String, String>();
		map.put("Authorization", "KakaoAK ac6d1184e1fd2f18d5318e71495354e7");

		return jsonParser(HttpUtil.requestMethodGet(daumOpenAPIURL, map)).size()==0?null:jsonParser(HttpUtil.requestMethodGet(daumOpenAPIURL, map)).get(0);
	}
	
	@Override
	public List<Book> getRecommendBookList(String type) throws Exception {
		Map<String, String> hm = new HashMap<String, String>();
		hm.put("output", "js&Version=20131101");
		hm.put("MaxResults", "10");
		hm.put("start", "1");
		hm.put("SearchTarget", "Book");
		hm.put("QueryType", type);
		hm.put("ttbkey", "ttb1015wlswn1921003");
		hm.put("MaxResults", "4");
		hm.put("Cover", "Big");

		StringBuffer sb = new StringBuffer();
		Iterator<String> iter = hm.keySet().iterator();

		while (iter.hasNext()) {
			String key = iter.next();
			sb.append(key).append("=").append(hm.get(key)).append("&");
		}
		return AladinPaser(HttpUtil.requestMethodGet("http://www.aladin.co.kr/ttb/api/ItemList.aspx?" + sb.toString(), hm));
	}
	
	public List<Book> AladinPaser(String str) throws Exception {
		JSONParser jsonParser = new JSONParser();
		List<Book> bookList = new ArrayList<Book>();
		List<String> list;
		Book book;

		// JSON데이터를 넣어 JSON Object 로 만들어 준다.
		JSONObject jsonObject = (JSONObject) jsonParser.parse(str);

		// books의 배열을 추출
		JSONArray bookInfoArray = (JSONArray) jsonObject.get("item");

		for (int i = 0; i < bookInfoArray.size(); i++) {
			JSONObject bookObject = (JSONObject) bookInfoArray.get(i);
			if (bookObject.get("isbn").equals(null) == false) {
				list = new ArrayList<String>();
				book = new Book();
				
				if (book != null) {
					book.setIsbn((String) bookObject.get("isbn13"));
					book.setTitle((String) bookObject.get("title"));
					book.setThumbnail((String) bookObject.get("cover"));
					list.add((String) bookObject.get("author"));
					book.setAuthors(list);
					bookList.add(book);
				}
			}
		}
		return bookList;
	}

	public List<Book> jsonParser(String str) throws Exception {

		JSONParser jsonParser = new JSONParser();
		List<Book> bookList = new ArrayList<Book>();
		Book book;

		// JSON데이터를 넣어 JSON Object 로 만들어 준다.
		JSONObject jsonObject = (JSONObject) jsonParser.parse(str);

		// books의 배열을 추출
		JSONArray bookInfoArray = (JSONArray) jsonObject.get("documents");

		for (int i = 0; i < bookInfoArray.size(); i++) {

			JSONObject bookObject = (JSONObject) bookInfoArray.get(i);
			if (bookObject.get("isbn").equals(null) == false) {

				book = parser(bookObject);
				if (book != null) {
					bookList.add(book);
				}
			}
		}
		return bookList;
	}

	@SuppressWarnings("unchecked")
	public Book parser(JSONObject bookObject) {
		Book book = null;

		if (((String) bookObject.get("isbn")).length() > 13) {
			book = new Book();

			book.setIsbn((String) bookObject.get("isbn"));
			book.setTitle((String) bookObject.get("title"));
			book.setAuthors((List<String>) bookObject.get("authors"));
			book.setPrice((Long) bookObject.get("price"));
			book.setPublisher((String) bookObject.get("publisher"));
			book.setDatetime((String) bookObject.get("datetime"));
			book.setThumbnail((String) bookObject.get("thumbnail"));
			book.setContents((String) bookObject.get("contents"));
			book.setUrl((String) bookObject.get("url"));
			book.setTranslators((List<String>) bookObject.get("translators"));
			book.setTag(new Tag((String) bookObject.get("category")));
		}
		return book;
	}
}
