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

import com.giljobe.common.PasswordEncoder;


@WebFilter(servletNames = {"EnrollUserEndServlet","LoginEndServlet","EnrollCompanyEndServlet","LoginCompanyServlet","UpdateUserPwServlet","UpdateCompanyPwServlet"})

public class PasswordEncodeFilter extends HttpFilter implements Filter {
       
   
    public PasswordEncodeFilter() {
        super();
        // TODO Auto-generated constructor stub
    }

	public void destroy() {
		// TODO Auto-generated method stub
	}

	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
		// TODO Auto-generated method stub
		// place your code here
		PasswordEncoder pe = new PasswordEncoder((HttpServletRequest) request);//wrapper로 감싼 비밀번호
		// pass the request along the filter chain
//		chain.doFilter(request, response);
		chain.doFilter(pe, response);//wrapper 처리한 request로 필터링하기
	}

	
	public void init(FilterConfig fConfig) throws ServletException {
		// TODO Auto-generated method stub
	}

}
