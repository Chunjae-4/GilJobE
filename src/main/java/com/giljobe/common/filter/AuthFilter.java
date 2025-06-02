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
@WebFilter(urlPatterns = {"/mypage/companymypageview","/mypage/mypageview"})
public class AuthFilter extends HttpFilter implements Filter {
       
    /**
     * @see HttpFilter#HttpFilter()
     */
    public AuthFilter() {
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
		
		//로그인 하지 않은 사용자가 mypage접근을 막고 회사가 유저, 유저가 회사 마이페이지 들어가는걸 막기
		HttpServletRequest httpRequest = (HttpServletRequest)request;
		HttpServletResponse httpResponse = (HttpServletResponse)response;
		HttpSession session = httpRequest.getSession(false);//세션이 없으면 생성하니까 false로 놔
		
		String uri = httpRequest.getRequestURI();//현재 요청 주소 위의 서블릿 매핑된 주소들
		String userType = null;
		
		
		//기업 마이페이지와 유저 마이페이지를 매핑했을때
		if(session!=null) {
			//세션이 있으면 사용자가 누군지 받아와 
			 userType =(String)session.getAttribute("userType");
		}
		
		
		if (userType == null) {
			//로그인 되어있지 않다면 null일거니까 login으로 추방시켜
            httpResponse.sendRedirect(httpRequest.getContextPath()+"/user/login");
            return;
        }
		
		if("user".equals(userType)&&uri.endsWith("/mypage/companymypageview")) {
			 httpResponse.sendRedirect(httpRequest.getContextPath());
			 return;
		}//유저로그인된 상태로 기업 들어가지마
		
		if("company".equals(userType)&&uri.endsWith("/mypage/mypageview")) {
			 httpResponse.sendRedirect(httpRequest.getContextPath());
			 return;
		}//기업로그인된채로 유저 들어가지마
		
		//조건문에 안빠졌으면 통과 마이페이지 들어가도 좋아
		chain.doFilter(httpRequest, httpResponse);
		
		
		
		

		// pass the request along the filter chain
	}

	/**
	 * @see Filter#init(FilterConfig)
	 */
	public void init(FilterConfig fConfig) throws ServletException {
		// TODO Auto-generated method stub
	}

}
