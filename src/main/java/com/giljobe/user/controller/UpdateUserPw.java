package com.giljobe.user.controller;

import java.io.IOException;
import java.io.PrintWriter;

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
		
	   
	    
	    String msg;
	    String loc;
	    
//	    if(newPw.equals(confirmPw)) {
//	    	msg="새 비밀번호가 일치하지 않습니다.";
//	    	loc="/mypage/mypageview";
//	    	request.getRequestDispatcher(Constants.MSG).forward(request, response);
//	    }
	    
	    if(u!=null) {
	    	//일반적인 내정보에서 비밀번호 수정
	    	String userPw = request.getParameter("userPw");
		    String newPw = request.getParameter("newPw");
//		    String confirmPw = request.getParameter("confirmPw"); 세션엔 비밀번호 없어
		    int userNo = u.getUserNo();
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
	    }else {
	    	//세션에 비밀번호 찾기 아이디만 있을 때
	        String userId = (String)session.getAttribute("authenticUserId");
	        String resetPw = request.getParameter("resetPw");
	        
	        int result = UserService.userService().updateUserPwById(userId,resetPw);
	        //인증 필요없이 그냥 갖다 덮어씌워야해서 이렇게만 넘겨주고
	        PrintWriter out = response.getWriter();
	        if(result > 0) {
	            out.print("success");
	            // 재설정 후 인증 세션 정보 삭제
	            session.removeAttribute("authenticUserId");
	        } else {
	            out.print("fail");
	        }
	        out.close();
	    }
	    
	    
	    

		
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
