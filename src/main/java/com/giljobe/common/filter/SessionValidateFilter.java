package com.giljobe.common.filter;

import java.io.IOException;
import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.giljobe.user.model.dto.User;

/**
 * Servlet Filter implementation class SessionValidateFilter
 */
@WebFilter("/mypage/*")
public class SessionValidateFilter extends HttpFilter implements Filter {
       
    /**
     * @see HttpFilter#HttpFilter()
     */
    public SessionValidateFilter() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see Filter#destroy()
	 */
	public void destroy() {
		// TODO Auto-generated method stub
	}

	/**
	 * @see Filter#doFilter(ServletRequest, ServletResponse, FilterChain)
	 */
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
		// TODO Auto-generated method stub
		// place your code here
		HttpServletRequest httpRequest = (HttpServletRequest)request;
		HttpServletResponse httpResponse = (HttpServletResponse)response;
		HttpSession session = httpRequest.getSession();
		
		String userType;
	
		if(session!=null) {
			//세션이 있으면 유저타입을 세션에서 받아오기 없으면 로그인하라고 쫓아내기
			userType = (String)session.getAttribute("userType");
			
			if(userType!=null) {
				//세션이 있고 그중에서 유저면 
				if(userType.equals("user")) {
					//저장된 애가 유저면
					
					chain.doFilter(request, response);
					 return;
					 
				}else if(userType.equals("company")) {
					
					chain.doFilter(request, response);
					 return;
					 
				}else {
					
					httpResponse.sendRedirect(httpRequest.getContextPath());
					
					return;
				}
			}
			
		}else {
			//세션이 없으면 센드리다이렉트로 서블렛안남기고 바로 주소로 재요청
			httpResponse.sendRedirect(httpRequest.getContextPath());
			return;
		}
		
		

		// pass the request along the filter chain
	}

	/**
	 * @see Filter#init(FilterConfig)
	 */
	public void init(FilterConfig fConfig) throws ServletException {
		// TODO Auto-generated method stub
	}

}
