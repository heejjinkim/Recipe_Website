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
		CalendarDAO calDAO = new CalendarDAO();
		
		int pk = calDAO.getMaxpk(); int boardID = 0;
		String meal = null;
		if (request.getParameter("boardID") != null){
			boardID = Integer.parseInt(request.getParameter("boardID"));
		}
		if (request.getParameter("mealChk") != null) {
			meal = request.getParameter("mealChk");
		}
		if(meal.equals("아침")) meal = "breakfast";
		else if(meal.equals("점심")) meal = "lunch";
		else meal = "dinner";
		pk++;
	 	if(userID == null){
	 		PrintWriter script = response.getWriter();
	 		script.println("<script>");
			script.println("alert('로그인을 해주세요.')");
	 		script.println("location.href = '2_LOGIN.jsp'");
	 		script.println("</script>");
	 	} 
	 	else {
		 	if(calDAO.chkCal(userID) != 0){
		 		CalendarDTO calDTO = calDAO.getCal(calDAO.chkCal(userID));
		 		int result = calDAO.update(calDTO, meal, boardID);
		 		PrintWriter script = response.getWriter();
		 		script.println("<script>");
		 		script.println("alert('업데이트 하였습니다!')");
		 		script.println("history.back()");
		 		script.println("</script>");
		 	}
		 	else{
		 		int result = calDAO.add(pk, userID, meal, boardID);
		 		if (result == -1){
			 		PrintWriter script = response.getWriter();
			 		script.println("<script>");
			 		script.println("alert('추가에 실패했습니다.')");
			 		script.println("history.back()");
			 		script.println("</script>");
			 	}
		 		else{
			 		PrintWriter script = response.getWriter();
			 		script.println("<script>");
			 		script.println("alert('추가에 성공했습니다.')");
			 		script.println("history.back()");
			 		script.println("</script>");
				}
		 	}
	 	}
	%>
</body>
</html>