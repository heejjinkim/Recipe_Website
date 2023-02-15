<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="user.*"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="java.io.File" %>
<%
 request.setCharacterEncoding("UTF-8");
%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>RECIPICK</title>
</head>
<body>
	<%
		String userID = (String) session.getAttribute("userID");
		String pwd = request.getParameter("password");
		UserDTO user = new UserDAO().getUser(userID);

		if (!pwd.equals(user.getUserPassword())) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('Password를 확인해 주세요.')");
			script.println("history.back()");
			script.println("</script>");				
		} else {
			UserDAO userDAO = new UserDAO();
			PrintWriter script = response.getWriter();
			int result = userDAO.delete(userID);
			if (result == -1) {
				script.println("<script>");
				script.println("alert('다시 시도해주세요')");
				script.println("history.back()");
				script.println("</script>");
			} else {
				session.invalidate();		
				script.println("<script>");
				script.println("window.close()");
				script.println("window.opener.location.href='1_MAINPAGE.jsp';");
				script.println("alert('회원 탈퇴가 완료되었습니다.')");
				script.println("</script>");
			}
		}
	%>
</body>
</html>