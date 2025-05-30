package com.giljobe.user.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.giljobe.common.Constants;
import com.giljobe.user.model.dto.User;
import com.giljobe.user.model.service.UserService;


@WebServlet(urlPatterns = "/user/updatePw", name="UpdateUserPwServlet")
public class UpdateUserPw extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    
    public UpdateUserPw() {
        super();
        // TODO Auto-generated constructor stub
    }

	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		HttpSession session = request.getSession();
		User u = (User)session.getAttribute("user");
		String userPw = request.getParameter("userPw");
	    String newPw = request.getParameter("newPw");
//	    String confirmPw = request.getParameter("confirmPw");
	    
	    int userNo = u.getUserNo();
	    
	    String msg;
	    String loc;
	    
//	    if(newPw.equals(confirmPw)) {
//	    	msg="새 비밀번호가 일치하지 않습니다.";
//	    	loc="/mypage/mypageview";
//	    	request.getRequestDispatcher(Constants.MSG).forward(request, response);
//	    }
	    
	    int result = UserService.userService().updateUserPw(userNo,userPw, newPw);
	    
	    if(result==-1) {
			//비밀번호 다름
			msg=" 현재 비밀번호를 정확하게 입력하세요";
		}else if(result>0) {
			//성공
			msg="비밀번호 수정완료";
		}else {
			//실패
			msg="비밀번호 수정실패";
			
		}
		loc="/mypage/mypageview";
		request.setAttribute("msg", msg);
		request.setAttribute("loc", loc);
		request.getRequestDispatcher(Constants.MSG).forward(request, response);
		
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
