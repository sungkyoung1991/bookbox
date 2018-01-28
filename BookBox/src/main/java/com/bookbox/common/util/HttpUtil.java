package com.bookbox.common.util;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.DataOutputStream;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.Iterator;
import java.util.Map;

/**
 * @file com.bookbox.common.util.HttpUtil.java
 * @brief Http 요청시 사용될 util method
 * @author JW
 * @date 2017.10.18
 */
public class HttpUtil {
	
	public static HttpURLConnection getURLConnection(URL url, Map<String, String> headers) throws Exception{
		HttpURLConnection con = (HttpURLConnection)url.openConnection();
		Iterator<String> requestHeaders = headers.keySet().iterator();
		while(requestHeaders.hasNext()) {
			String key = requestHeaders.next();
			con.setRequestProperty(key, (String)headers.get(key));
		}
		return con;
	}
	
	public static String requestMethodGet(String url) throws Exception{
		return HttpUtil.requestMethodGet(new URL(url));
	}
	
	public static String requestMethodGet(String url, Map<String, String> headers) throws Exception{
		return HttpUtil.requestMethodGet(new URL(url), headers);
	}
	
	/**
	 * @brief GET method 요청시 호출
	 * @param url : 요청할 url
	 * @return response body json string
	 * @throws Exception
	 */
	public static String requestMethodGet(URL url) throws Exception{
		return HttpUtil.requestMethodGet((HttpURLConnection)url.openConnection());
	}

	/**
	 * @brief GET method 요청시 호출(headers 포함)
	 * @param url : 요청할 url
	 * @param headers : 요청시 필요한 headers, ex) key="X-Auth-Token", value="tokenwowunbelievable"
	 * @return response body json string
	 * @throws Exception
	 */
	public static String requestMethodGet(URL url, Map<String, String> headers) throws Exception {
		return HttpUtil.requestMethodGet(HttpUtil.getURLConnection(url, headers));
	}
	
	public static String requestMethodGet(HttpURLConnection con) throws Exception{
		con.setRequestMethod("GET");
		return HttpUtil.httpRequest(con);
	}
	
	
	public static String requestMethodPost(String url, Map<String, String> headers, String data) throws Exception{
		return HttpUtil.requestMethodPost(new URL(url), headers, data);
	}
	
	/**
	 * @brief 
	 * @param url
	 * @param headers
	 * @param data
	 * @return
	 * @throws Exception
	 */
	public static String requestMethodPost(URL url, Map<String, String> headers, String data) throws Exception{
		return HttpUtil.requestMethodPost(getURLConnection(url, headers), data);
	}
	
	public static String requestMethodPost(HttpURLConnection con, String data) throws Exception{
		con.setRequestMethod("POST");
		
		StringBuffer urlParameters = new StringBuffer();
		urlParameters.append(data);
		
		con.setDoOutput(true);
		BufferedWriter bw = new BufferedWriter(new OutputStreamWriter(new DataOutputStream(con.getOutputStream()), "UTF-8"));
		bw.write(urlParameters.toString());
		bw.flush();
		bw.close();
		
		return HttpUtil.httpRequest(con);
		
	}
	
	public static String httpRequest(HttpURLConnection con) throws Exception{
		int responseCode = con.getResponseCode();
		
		BufferedReader br = null;
		
		if(responseCode == 200) {
			br = new BufferedReader(new InputStreamReader(con.getInputStream(), "UTF-8"));
		}else {
			br = new BufferedReader(new InputStreamReader(con.getErrorStream(), "UTF-8"));
		}
		
		String jsonData = "";
		StringBuffer response = new StringBuffer();
		
		while((jsonData = br.readLine()) != null) {
			response.append(jsonData);
		}
		
		br.close();
		
		return response.toString();
	}
}
