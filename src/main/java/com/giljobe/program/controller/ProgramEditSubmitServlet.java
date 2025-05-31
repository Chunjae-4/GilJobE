package com.giljobe.program.controller;

import static com.giljobe.common.NaverGeoUtils.getCoordinatesFromAddress;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import com.giljobe.program.model.dto.Program;
import com.giljobe.program.model.service.ProgramService;

@WebServlet("/program/edit-submit")
public class ProgramEditSubmitServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public ProgramEditSubmitServlet() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO: 수정 처리 후 리다이렉트
		request.setCharacterEncoding("UTF-8");

        int proNo = Integer.parseInt(request.getParameter("proNo"));
        String proName = request.getParameter("proName");
        String proType = request.getParameter("proType");
        String proLocation = request.getParameter("proLocation");
        String proCategory = request.getParameter("proCategory");

        // 주소 → 위도 경도 변환 (Naver API 사용)
        double[] coordinates = getCoordinatesFromAddress(proLocation);
        double latitude = coordinates[0];
        double longitude = coordinates[1];

        // 이미지 업로드 처리
        Part imagePart = request.getPart("proImage");
        String savePath = request.getServletContext().getRealPath("/resources/upload/");
        String fileName = imagePart.getSubmittedFileName();

        String newImagePath = null;
        if (fileName != null && !fileName.isEmpty()) {
            String ext = fileName.substring(fileName.lastIndexOf("."));
            newImagePath = String.format("1/%d/1%s", proNo, ext);
            imagePart.write(savePath + "/" + newImagePath);
        }

        // DB 업데이트
        Program updated = Program.builder()
                .proNo(proNo)
                .proName(proName)
                .proType(proType)
                .proLocation(proLocation)
                .proLatitude(latitude)
                .proLongitude(longitude)
                .proCategory(proCategory)
                .proImageUrl(newImagePath) // null이면 기존 이미지 유지 처리해야 함
                .build();

//        ProgramService.getInstance().updateProgram(updated);

        response.sendRedirect(request.getContextPath() + "/program/detail?proNo=" + proNo);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
