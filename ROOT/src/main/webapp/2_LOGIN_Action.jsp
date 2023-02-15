<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="user.UserDAO" %>
<%@ page import="java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8"); %>

<!DOCTYPE html>

<html lang="ko">

    
    <body>
        <%
        String userID		= request.getParameter("userID");
        String userPassword = request.getParameter("userPassword");
        
        UserDAO userDAO = new UserDAO();
        int result = userDAO.login(userID, userPassword);
        if(userID == "") {
        	PrintWriter script = response.getWriter();
        	script.println("<script>");
        	script.println("alert('아이디를 입력해 주세요.')");
        	script.println("history.back()");
        	script.println("</script>");
        }
        else if(userPassword == ""){
        	PrintWriter script = response.getWriter();
        	script.println("<script>");
        	script.println("alert('비밀번호를 입력해 주세요.')");
        	script.println("history.back()");
        	script.println("</script>");
        }
        else{       	
	        if(result == 1) {
	        	session.setAttribute("userID", userID);
	        	PrintWriter script = response.getWriter();
	        	script.println("<script>");
	        	script.println("location.href = './1_MAINPAGE.jsp'");
	        	script.println("</script>");
	        } else if(result == 0) {
	        	PrintWriter script = response.getWriter();
	        	script.println("<script>");
	        	script.println("alert('비밀번호가 틀립니다.')");
	        	script.println("history.back()");
	        	script.println("</script>");
	        } else if(result == -2) {
	        	PrintWriter script = response.getWriter();
	        	script.println("<script>");
	        	script.println("alert('아이디를 확인해주세요.')");
	        	script.println("history.back()");
	        	script.println("</script>");
	        } else if(result == -1) {
	        	PrintWriter script = response.getWriter();
	        	script.println("<script>");
	        	script.println("alert('서버 오류 입니다.')");
	        	script.println("location.href = './1_MAINPAGE.jsp'");
	        	script.println("</script>");
	        }
        }
        %>
    </body>
    
</html>