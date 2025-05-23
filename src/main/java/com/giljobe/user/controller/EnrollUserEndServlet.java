package com.giljobe.user.controller;

import java.io.IOException;
import java.sql.Date;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.giljobe.common.Constants;
import com.giljobe.user.model.dto.User;
import com.giljobe.user.model.service.UserService;


@WebServlet(urlPatterns = "/user/enrolluserend", name="EnrollUserEndServlet")
public class EnrollUserEndServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    
    public EnrollUserEndServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		//전체적으로 encoding필터 거쳐서 필요없음
		//login.jsp에서 정보를 받아서 가져온 뒤 객체 생성
		String nickName=request.getParameter("userNickName");
		String id = request.getParameter("userId");
		String name = request.getParameter("userName");
		String password = request.getParameter("userPw");
		//비밀번호 암호화
		String phone = request.getParameter("userPhone");
		String email = request.getParameter("userEmail");
		String birth = request.getParameter("userBirth");
		Date birthDate = Date.valueOf(birth);
		
		User user = User.builder()
						//userNo는 시퀀스로 필요없지
						.userNickName(nickName)
						.userId(id)
						.userName(name)
						.userPw(password)
						.userPhone(phone)
						.userEmail(email)
						.userBirth(birthDate)
						.build();
		
		//생성한 유저 객체를 서비스로 보내면 서비스가 dao한테 conn과함께 유저를 넘기겠지 
		//결과에 따라 보내야할 화면 변경
		int result = UserService.userService().enrollUser(user);
		String url = "";
		if(result>0) {
			//성공하면 메인화면으로
			url="/";
		}else {
			//실패하면 회원가입화면으로 다시
			url="/user/enrollUser.jsp";
		}
		
		//완료되면 메인화면으로, 실패하면 분기처리
		//이 정보들이 다시 호출되지않게 redirect로 전송
		response.sendRedirect(request.getContextPath()+url);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
