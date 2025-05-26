<%@page import="com.giljobe.user.model.dto.User"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"  pageEncoding="UTF-8" import="com.giljobe.common.Constants"%>
<%@ page import="java.util.*,com.giljobe.program.model.dto.Program" %>
<%
	User loginUser = (User)session.getAttribute("user");
%>
<form action="" onsubmit="return fn_validate()">
			<table>
				<tr>
					<th>아이디</th>
					<td><input type="text" value="<%=loginUser.getUserId()%>"
						name="userId" id="userId_" readonly></td>
				</tr>
				<tr>
					<th>이름</th>
					<td><input type="text" name="userName" id="userName"
						value="<%=loginUser.getUserName()%>"></td>
				</tr>
				<tr>
					<th>생년월일</th>
					<td><input type="date" name="age" id="age"
						value="<%=loginUser.getUserBirth()%>"></td>
				</tr>
				<tr>
					<th>이메일</th>
					<td><input type="email" placeholder="abc@xyz.com" name="email"
						id="email" value="<%=loginUser.getUserEmail()%>"></td>
				</tr>
				<tr>
					<th>휴대폰</th>
					<td><input type="tel" placeholder="(-없이)01012345678"
						name="phone" id="phone" maxlength="11" required
						value="<%=loginUser.getUserPhone()%>"></td>
				</tr>
				<tr>
					<th>닉네임</th>
					<td><input type="text" placeholder="닉네임" name="nickName"
						id="nickName" value="<%=loginUser.getUserNickName()%>"></td>
				</tr>
			</table>
			<input type="submit" value="수정"> <input type="submit"
				value="비밀번호수정">
		</form>
