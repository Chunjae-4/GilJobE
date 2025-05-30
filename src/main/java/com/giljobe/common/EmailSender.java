package com.giljobe.common;

import java.io.FileReader;
import java.io.IOException;
import java.util.Properties;

import jakarta.mail.Authenticator;
import jakarta.mail.Message;
import jakarta.mail.MessagingException;
import jakarta.mail.PasswordAuthentication;
import jakarta.mail.Session;
import jakarta.mail.Transport;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;

public class EmailSender {
	private static final Properties mailProps = new Properties();

	static {
		try {
			// 클래스패스에서 파일 경로 얻기
			String path = EmailSender.class.getClassLoader().getResource("/email.properties").getPath();
			FileReader fr = new FileReader(path);
			mailProps.load(fr);
			fr.close();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	//프로퍼티에 있는 값 저장하기
	private static final String HOST = mailProps.getProperty("mail.host");
	private static final String PORT = mailProps.getProperty("mail.port");
	private static final String MAIL_ID = mailProps.getProperty("mail.id");
	private static final String MAIL_PW = mailProps.getProperty("mail.password");

	//SMTP 설정 메소드
	private Session config() {
		
		Properties props = new Properties();
		

//		props.put("mail.transport.protocol", "smtp");
		props.put("mail.smtp.host", HOST);
		props.put("mail.smtp.port", PORT);
		props.put("mail.smtp.starttls.enable", "true");
//		props.put("mail.smtp.ssl.trust", HOST);
		props.put("mail.smtp.auth", "true");

		//발송인 아이디 비번
		Session session = Session.getInstance(props, new Authenticator(){
			@Override
			protected PasswordAuthentication getPasswordAuthentication() {

				return new PasswordAuthentication(MAIL_ID, MAIL_PW);
			}
		});
		
		return session;
	}
	
	//여기서 메세지 전송
	public void sendEmail(String title, String content, String to) throws MessagingException {
		
		//세션 설정 불러오고
		Session session = config();
		
		// Mail 객체 생성 및 조립
		Message mimeMessage = new MimeMessage(session);
		mimeMessage.setFrom(new InternetAddress(MAIL_ID));
		mimeMessage.setRecipients(Message.RecipientType.TO, new InternetAddress[] {new InternetAddress(to)});
		// 메일 제목
		mimeMessage.setSubject(title);
		// 메일 본문 (.setText를 사용하면 단순 텍스트 전달 가능)
		mimeMessage.setContent(content, "text/html; charset=UTF-8");

		// Mail 발송
		Transport.send(mimeMessage);
		
	}

}
