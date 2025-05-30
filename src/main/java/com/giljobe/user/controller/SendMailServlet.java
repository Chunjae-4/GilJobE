package com.giljobe.user.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.giljobe.common.EmailSender;

import jakarta.mail.MessagingException;


@WebServlet("/user/sendmail")
public class SendMailServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
   
    public SendMailServlet() {
        super();
        // TODO Auto-generated constructor stub
    }
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		EmailSender emailSender = new EmailSender();
		String title="길잡이 이메일 주소 인증";
		String number = String.valueOf(Math.floor(Math.random()*89999)+10000);//랜덤값을 보내고
		String content = """
				  <div style="font-family: Arial, sans-serif; max-width: 480px; margin: auto; padding: 20px; border: 1px solid #eee; border-radius: 8px;">
			    <h2 style="color: #333;">[길잡이] 이메일 인증번호 안내</h2>
			    <p style="font-size: 16px; color: #555;">
			      아래의 인증번호를 입력해 주세요:
			    </p>
			    <div style="font-size: 24px; font-weight: bold; background-color: #f4f4f4; padding: 15px; text-align: center; border-radius: 6px; letter-spacing: 4px; margin: 20px 0;">
			      """ + number + """
			    </div>
			    <p style="font-size: 14px; color: #888;">
			      인증번호는 5분간 유효합니다. 본인이 요청하지 않았다면 이 메일을 무시해 주세요.
			    </p>
			    <p style="font-size: 12px; color: #ccc; margin-top: 30px;">
			      © 길잡이 - All rights reserved.
			    </p>
			  </div>
			""";
		
		String to = request.getParameter("searchPwByEmail");
		
		//여기서 메세지 전송 메소드 실행
		try {
			emailSender.sendEmail(title, content, to);
		} catch (MessagingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
