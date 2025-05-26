package com.giljobe.program.controller;

import java.io.IOException;
import java.io.InputStream;
import java.util.Properties;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.giljobe.common.Constants;


@WebServlet("/program/map")
public class ProgramMapServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	
    public ProgramMapServlet() {
        super();
    }
    
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		// 1. properties 파일 불러오기
	    Properties prop = new Properties();
	    try (InputStream input = getClass().getClassLoader().getResourceAsStream("api/naver.properties")) {
	        if (input != null) {
	            prop.load(input);
	            String mapKey = prop.getProperty("naver.map.key");

	            // 2. JSP에서 사용할 수 있도록 request에 저장
	            request.setAttribute("naverMapKey", mapKey);
	        } else {
	            System.err.println("naver.properties 파일을 찾을 수 없습니다.");
	        }
	    } catch (IOException e) {
	        e.printStackTrace();
	    }
		
	    // 3. map.jsp로 포워딩
		request.getRequestDispatcher(Constants.WEB_VIEWS+"program/map.jsp").forward(request, response);
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
