package com.giljobe.user.controller;

import java.io.IOException;
import java.net.PasswordAuthentication;
import java.util.Properties;

import javax.mail.Authenticator;
import javax.mail.Session;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


@WebServlet("/user/sendmail")
public class SendMailServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
   
    public SendMailServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		String result = "success";
		
		String title="길잡이 이메일 주소 인증";
		String content = "인증번호는 12345";
		
		String to = request.getParameter("searchPwByEmail");
		
		String user = "";
		String pw = "";
		
		String host = "smtp.naver.com";
		String auth="true";
		int port = 587;
		String tls = "true";
		
		Properties prop = new Properties();
		prop.put("mail.smtp.host",host);
		prop.put("mail.smtp.port",port);
		prop.put("mail.smtp.auth",auth);
		prop.put("mail.smtp.starttls.enable",tls);
		
		Session session = Session.getInstance(prop);
		session = Session.getInstance(prop,new Authenticator(){
//			@Override
//			protected PasswordAuthentication getPasswordAuthentication() {
//				
//				return new PasswordAuthentication(user, AES128.decryptPassword(user,pw));
//			}
		});
		
		
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
