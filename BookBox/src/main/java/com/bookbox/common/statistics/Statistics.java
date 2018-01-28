package com.bookbox.common.statistics;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

public class Statistics {
	
	public static List<Map<String, Object>> calcRatio(List<Map<String, Object>> target){

		List<Map<String, Object>> returnList = new ArrayList<Map<String, Object>>();
		long totalCount = 0;
		
		for(Map<String, Object> map : target) {
			totalCount += (Long)map.get("count");
		}
		
		if(totalCount != 0) {
			for(Map<String, Object> map : target) {
				map.put("per", (Long)map.get("count")/(double)totalCount*100);
				returnList.add(map);
			}
		}
		
		return returnList;
	}
}
