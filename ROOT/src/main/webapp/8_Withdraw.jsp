<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="user.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
		String userID = request.getParameter("userID");
	
		UserDAO userDAO = new UserDAO();
		PrintWriter script = response.getWriter();
		int result = userDAO.delete(userID);
		if (result == -1) {
			script.println("<script>");
			script.println("alert('다시 시도해주세요')");
			script.println("history.back()");
			script.println("</script>");
		} else {	
			script.println("<script>");
			script.println("alert('회원 탈퇴가 완료되었습니다.')");
			script.println("location.href = './8_Admin_Withdraw.jsp'");
			script.println("</script>");
		}
	%>
</body>
</html>