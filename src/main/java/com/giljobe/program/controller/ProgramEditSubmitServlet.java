package com.giljobe.program.controller;

import static com.giljobe.common.NaverGeoUtils.getCoordinatesFromAddress;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import com.giljobe.common.Constants;
import com.giljobe.program.model.dto.Program;
import com.giljobe.program.model.service.ProgramService;

@WebServlet("/program/edit-submit")
@MultipartConfig // programEditForm.jsp 에서 enctype="multipart/form-data" 하면 해줘야 하는 어노테이션
public class ProgramEditSubmitServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public ProgramEditSubmitServlet() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");

		System.out.println("proNo param: " + request.getParameter("proNo")); // 디버깅용

        int proNo = Integer.parseInt(request.getParameter("proNo"));
        String proName = request.getParameter("proName");
        String proType = request.getParameter("proType");
        String proLocation = request.getParameter("proLocation");
        String proCategory = request.getParameter("proCategory");

        // 1. 기존 이미지 정보 가져오기
        Program original = ProgramService.getInstance().selectProgramByNo(proNo);
        String existingImagePath = original.getProImageUrl();

        // 2. 주소 → 위경도 변환
        double[] coordinates = getCoordinatesFromAddress(proLocation);
        double latitude = coordinates[0];
        double longitude = coordinates[1];

        // 3. 이미지 업로드 처리
        Part imagePart = request.getPart("proImage");
        String savePath = request.getServletContext().getRealPath(Constants.DEFAULT_UPLOAD_PATH);
        String fileName = imagePart.getSubmittedFileName();

        String newImagePath = existingImagePath; // 기본은 기존 이미지 유지
        if (fileName != null && !fileName.isEmpty()) {
            String ext = fileName.substring(fileName.lastIndexOf("."));
            int companyNo = original.getComNoRef(); // ✅ 회사 번호 가져오기
            newImagePath = String.format("%d/%d/1%s", companyNo, proNo, ext); // 회사번호/프로그램번호/1.jpg 형식
            imagePart.write(savePath + "/" + newImagePath);
        }

        // 4. DTO 구성
        Program updated = Program.builder()
                .proNo(proNo)
                .proName(proName)
                .proType(proType)
                .proLocation(proLocation)
                .proLatitude(latitude)
                .proLongitude(longitude)
                .proCategory(proCategory)
                .proImageUrl(newImagePath)
                .build();

        // 5. DB 반영
        ProgramService.getInstance().updateProgram(updated);

        // 6. 상세 페이지로 리다이렉트
        response.sendRedirect(request.getContextPath() + "/program/detail?proNo=" + proNo);
    }

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
