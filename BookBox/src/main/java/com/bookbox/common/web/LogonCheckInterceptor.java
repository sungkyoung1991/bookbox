package com.bookbox.common.web;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.bookbox.service.domain.User;

public class LogonCheckInterceptor extends HandlerInterceptorAdapter {

	public LogonCheckInterceptor() {
		System.out.println("Constructor :: "+getClass().getName());
	}
	
	public boolean preHandle( HttpServletRequest request,
								HttpServletResponse response,
								Object handler ) throws Exception{
		
		System.out.println("[LogonCheckInterceptor start]");
		
		//==> 로그인 유무 확인
		HttpSession session = request.getSession();
		User user = (User)session.getAttribute("user");
		String uri = request.getRequestURI();
		
		//==> 로그인한 회원이라면...
		if( user != null ) {
			//==> 로그인 상태에서 접근 불가 URI
			if ( uri.indexOf("addUser") != -1 || uri.indexOf("login") != -1 || uri.indexOf("checkDuplication") != -1 ) {
				request.getRequestDispatcher("../index.jsp").forward(request, response);
				System.out.println("[로그인 상태에서 불필요한 요청]");
				System.out.println("[LogonCheckInterceptor end]");
				return false;
			}
			
			System.out.println("[로그인 상태]");
			System.out.println("[LogonCheckInterceptor end]");
			return true;
			
		}else {//==> 미로그인한 회원이라면
			//==> 로그인 시도중
			if ( uri.indexOf("addUser") != -1 || uri.indexOf("login") != -1 || uri.indexOf("checkDuplication") != -1 ) {
				System.out.println("[로그인 시도 상태]");
				System.out.println("[LogonCheckInterceptor end]");
				return true;
			}
			
			request.getRequestDispatcher("../index.jsp").forward(request, response);
			System.out.println("[로그인 이전]");
			System.out.println("[LogonCheckInterceptor end]");
			return false;
		}
		
	}
}
