package com.giljobe.love.controller;

import java.io.IOException;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.giljobe.company.model.dto.Company;
import com.giljobe.love.model.service.LoveService;
import com.giljobe.user.model.dto.User;
import com.google.gson.Gson;

@WebServlet("/ajax/love/toggle")
public class LoveToggleServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public LoveToggleServlet() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//		역할:좋아요 눌렀는지 확인 (hasLoved)
//			눌렀으면 삭제, 안 눌렀으면 추가
//			바뀐 좋아요 수 응답
		
		request.setCharacterEncoding("UTF-8");
		response.setContentType("application/json;charset=UTF-8");
		Map<String, Object> resultMap = new java.util.HashMap<>();

		HttpSession session = request.getSession(false);
		
		// ✅ 세션 존재 확인 먼저
	    if (session == null) {
	        resultMap.put("success", false);
	        resultMap.put("message", "세션이 만료되었거나 로그인 상태가 아닙니다.");
	        new Gson().toJson(resultMap, response.getWriter());
	        return;
	    }
		
	    // ✅ 로그인 기업회원 확인
 		Company loginCompany = (Company) session.getAttribute("company");
 		if (loginCompany != null) {
 			resultMap.put("success", false);
 			resultMap.put("message", "일반 이용자만 이용 가능합니다.");
 			new Gson().toJson(resultMap, response.getWriter());
 			return;
 		}
	 		
		// ✅ 로그인 사용자 확인
		User loginUser = (User) session.getAttribute("user");
		if (loginUser == null) {
			resultMap.put("success", false);
			resultMap.put("message", "로그인이 필요합니다.");
			new Gson().toJson(resultMap, response.getWriter());
			return;
		}

		int userNo = loginUser.getUserNo();
		int proNo = Integer.parseInt(request.getParameter("proNo"));

		boolean hasLiked = LoveService.getInstance().hasLoved(userNo, proNo);
		int result;

		if (hasLiked) {
			result = LoveService.getInstance().removeLove(proNo, userNo);
		} else {
			result = LoveService.getInstance().addLove(proNo, userNo);
		}

		int likeCount = LoveService.getInstance().countLoveByProgram(proNo);

		resultMap.put("success", result > 0);
		resultMap.put("liked", !hasLiked);
		resultMap.put("likeCount", likeCount);
		
		new Gson().toJson(resultMap, response.getWriter());
		
//		 programList.jsp와 programDetail.jsp에 있는 ♥ 버튼에 이벤트를 연결하고,
//		 data-prono 등으로 클릭된 프로그램 번호를 알아내고,
//		 AJAX로 서블릿에 요청을 보내고,
//		 버튼 스타일과 좋아요 수를 업데이트
		
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
