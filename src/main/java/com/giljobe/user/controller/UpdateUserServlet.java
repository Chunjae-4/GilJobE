package com.giljobe.user.controller;

import java.io.IOException;
import java.sql.Date;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.giljobe.common.Constants;
import com.giljobe.user.model.dto.User;
import com.giljobe.user.model.service.UserService;


@WebServlet("/user/updateUser")
public class UpdateUserServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
   
    public UpdateUserServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		HttpSession session = request.getSession();
		
		
//		int userNo= Integer.parseInt(request.getParameter("userNo"));
		
		User user = (User)session.getAttribute("user");
		
		int userNo = user.getUserNo();
		String userId=request.getParameter("userId");
		String newname=request.getParameter("userName");
		String newphone=request.getParameter("userPhone");
		String newnickName =request.getParameter("userNickName");
		String newemail=request.getParameter("userEmail");
		Date newbirth =Date.valueOf(request.getParameter("userBirth"));
		
//		User loginUser = (User)session.getAttribute("user");
		
		User u = User.builder()
				.userNo(userNo)
				.userId(userId)
//				.userPw(loginUser.getUserPw())
				.userName(newname)
				.userPhone(newphone)
				.userNickName(newnickName)
				.userEmail(newemail)
				.userBirth(newbirth)
				.build();	
		
		int result = UserService.userService().updateUser(u);
		
		String msg;
		String loc;
		
		if(result>0) {
			//성공
			msg="회원정보 수정완료";
			
			session.setAttribute("user", u );
		}else {
			//실패
			msg="회원정보 수정 실패";
			
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
