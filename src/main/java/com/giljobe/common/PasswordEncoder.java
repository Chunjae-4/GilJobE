package com.giljobe.common;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.Base64;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletRequestWrapper;

public class PasswordEncoder extends HttpServletRequestWrapper{

	public PasswordEncoder(HttpServletRequest request) {
		super(request);
		// TODO Auto-generated constructor stub
	}
	@Override
	public String getParameter(String oriPw) {
		//request.getParameter 메소드를 재정의해서
		if(oriPw.equals("userPw")) {//request.getParameter("userPw")와 같다면 
			return getSHA512(super.getParameter(oriPw));//wrapper처리한 값을 반환
		}
		if(oriPw.equals("newPw")) {
			return getSHA512(super.getParameter(oriPw));
		}
		if(oriPw.equals("resetPw")) {
			return getSHA512(super.getParameter(oriPw));
		}
		if(oriPw.equals("companyPw")) {
			return getSHA512(super.getParameter(oriPw));
		}
		return super.getParameter(oriPw);//해당안되면 그냥 보내줘
	}
	
	
	private String getSHA512(String oriPw) {
		// TODO Auto-generated method stub
		MessageDigest md = null;
				
		try {
			md=MessageDigest.getInstance("SHA-512");
		} catch (NoSuchAlgorithmException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		byte[] oriValArr = oriPw.getBytes();
		md.update(oriValArr);
		byte[] encodedValArr = md.digest();
		
		String encodedPw = Base64.getEncoder().encodeToString(encodedValArr);
		
		return encodedPw;
	}
}
