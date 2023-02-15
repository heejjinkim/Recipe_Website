<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>  
<%@ page import="user.*" %>
<%@ page import="bbs.*" %>
<%@ page import="calendar.*" %>
<%@page import="calendar.MyCalendar"%>
<%@page import="java.util.Date"%>
<%@ page import="java.io.PrintWriter" %>
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
		String userID = null;
		if (session.getAttribute("userID") != null) {//유저아이디이름으로 세션이 존재하는 회원들은 
			userID = (String) session.getAttribute("userID");//유저아이디에 해당 세션값을 넣어준다.
		}
		int pk = 0; String meal = null;
		if (request.getParameter("pk") != null) {
			pk = Integer.parseInt(request.getParameter("pk"));
		}
		if (request.getParameter("meal") != null) {
			meal = request.getParameter("meal");
		}
		if (pk == 0) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('유효하지 않습니다.')");
			script.println("history.back()");
			script.println("</script>");
		}
		CalendarDAO calDAO = new CalendarDAO();
		CalendarDTO calDTO = calDAO.getCal(pk);
	
		PrintWriter script = response.getWriter();
		int result = calDAO.delete(calDTO, meal);
		if (result == -1) {
			script.println("<script>");
			script.println("alert('다시 시도해주세요')");
			script.println("history.back()");
			script.println("</script>");
		} else {
			if(calDAO.count(pk)==0){
				result = calDAO.vanish(pk);
				if (result == -1) {
					script.println("<script>");
					script.println("alert('삭제에 실패하였습니다.')");
					script.println("history.back()");
					script.println("</script>");
				}
			}
			script.println("<script>");
			script.println("location.href=document.referrer;");
			script.println("</script>");
		}
	%>
</body>
</html>