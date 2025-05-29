package com.giljobe.program.controller;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

import com.giljobe.common.Constants;
import com.giljobe.company.model.dto.Company;
import com.giljobe.program.model.dto.Program;
import com.giljobe.program.model.service.ProgramService;

@WebServlet("/program/insert")
@MultipartConfig(
	maxFileSize = 1024 * 1024 * 50, // 50MB 제한
    fileSizeThreshold = 1024 * 1024	
) //multipart/form-data 요청 파싱하려면 필요
public class InsertProgramServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public InsertProgramServlet() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//		폼에서 전달된 데이터 수집 (multipart/form-data)
//		대표 이미지 저장 → /resources/upload/comNo/proNo/1.png - 나중에 여러 이미지 넣으면 2,3,4.png 될 것
//		주소 → 위도/경도 변환 (지금은 더미값으로 처리하자)
//		Program 객체 생성
//		DB 저장 → proNo 확보
//		회차 등록 페이지로 redirect
		
		request.setCharacterEncoding("UTF-8");
        HttpSession session = request.getSession();
        // 로그인된 기업 회원 정보
        int comNo = ((Company) session.getAttribute("company")).getComNo();
//        int comNo = 1;
        
        // 1. 폼 파라미터 수집
        String proName = request.getParameter("proName");
        String proType = request.getParameter("proType");
        String proLocation = request.getParameter("proLocation");
        String proCategory = request.getParameter("proCategory");

        // 2. 주소로부터 위도/경도 변환 (지금은 더미 값으로 처리)
        double latitude = 37.478668;
        double longitude = 126.884986;

        // 3. 파일 저장
        Part filePart = request.getPart("programImage");
        String tempProNo = "temp_" + System.currentTimeMillis(); // DB에 안 넣으므로 임시값

//        // insert 하기 전이므로 임시로 nextval 예측
//        int proNo = ProgramService.getInstance().getNextProNo();
        String relativePath = comNo + "/" + tempProNo; // Constants.DEFAULT_UPLOAD_PATH는 뺀 경로
        String uploadDir = getServletContext().getRealPath(Constants.DEFAULT_UPLOAD_PATH + relativePath);

        // 디렉토리 생성
        File dir = new File(uploadDir);
        if (!dir.exists()) dir.mkdirs();

        // 확장자 추출
        String originalFileName = filePart.getSubmittedFileName();
        String ext = originalFileName.substring(originalFileName.lastIndexOf(".")); // ex: .jpg

        // 저장 파일명: 1.jpg, 1.png ...
        String savedFileName = "1" + ext;
        File imageFile = new File(dir, savedFileName);

        // 실제 파일 저장
        try (InputStream in = filePart.getInputStream()) {
            Files.copy(in, imageFile.toPath());
        } catch (IOException e) {
            e.printStackTrace();
            throw new ServletException("이미지 업로드 실패", e);
        }

        // ✅ DB에 저장할 경로는 upload 루트 기준 상대 경로만 저장 (ex: 1/1/1.png)
        // 이제는 그냥 세션에만 저장하는거고 DB 저장은 나중에
        String imagePath = relativePath + "/" + savedFileName;
        
        // 추후에 여러 이미지를 업로드하게 되었을때에 확장 가능한 구조

        // 4. DTO 구성
        Program program = Program.builder()
                .proName(proName)
                .proType(proType)
                .proLocation(proLocation)
                .proLatitude(latitude)
                .proLongitude(longitude)
                .proCategory(proCategory)
                .proImageUrl(imagePath)
                .comNoRef(comNo)
                .build();

//      // 5. DB 저장
//      int result = ProgramService.getInstance().insertProgram(program); // insert + selectKey로 proNo 설정
// 		5. 세션에 보관 → 나중에 회차와 함께 DB insert
        session.setAttribute("pendingProgram", program);
        
        
// 		6. 회차 입력 폼으로 이동
        response.sendRedirect(request.getContextPath() + "/round/add-with-detail");
        
//        // 6. 성공 후 회차 입력 페이지로 이동
//        if (result>0) {
//            int savedProNo = program.getProNo(); 
//         System.out.println("savedProNo 확인 : "+savedProNo);// insert 후 채워졌는지 확인
//            response.sendRedirect(request.getContextPath() + "/round/add-with-detail?proNo=" + savedProNo);
//        } else {
//            request.setAttribute("msg", "프로그램 등록에 실패했습니다.");
//            request.setAttribute("loc", request.getContextPath() + "/program/new");
//            request.getRequestDispatcher("/WEB-INF/views/common/msg.jsp").forward(request, response);
//        }
		
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
