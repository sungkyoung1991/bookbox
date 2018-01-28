package com.bookbox.common.util;

import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.HashMap;
import java.util.Map;
import java.util.Properties;

import com.bookbox.common.domain.Page;
import com.bookbox.common.domain.Search;
import com.bookbox.service.domain.User;

public class CommonUtil {
	
	private static Properties constProp;
	
	public CommonUtil() {
	}
	
	public static Properties getConstProp() {
		
		if(constProp == null) {
			CommonUtil commonUtil = new CommonUtil();
			try {
				constProp = new Properties();
				constProp.load(new InputStreamReader(commonUtil.getClass().getClassLoader().getResourceAsStream("config/const.properties"),"UTF-8"));
			}catch(FileNotFoundException fnfe) {
				fnfe.printStackTrace();
			}catch(IOException ie) {
				ie.printStackTrace();
			}catch(IllegalArgumentException iae) {
				iae.printStackTrace();
			}catch(Exception e) {
				e.printStackTrace();
			}
		}
		
		return constProp;
	}
	
	/**
	 * @brief category와 target을 Map에 넣어주는 method
	 * @param category
	 * @param target
	 * @return categoryNo와 targetNo를 포함한 Map
	 * @author JW
	 */

	public static Map<String, Object> mappingCategoryTarget(int category, Object target){
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("categoryNo", category);
		map.put("targetNo", target);
		
		return map;
	}
	
	public static Map<String, Object> mappingCategoryTarget(int category, Object target, User user){
		Map<String, Object> map = CommonUtil.mappingCategoryTarget(category, target);
		map.put("user", user);
		
		return map;
	}
	
	public static Map<String, Object> getSearchPageMap(Search search, Page page){
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("search", search);
		map.put("page", page);
		return map;
	}
}
