<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="user.*" %>
<%@ page import="java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8"); %>

<!DOCTYPE html>

<html lang="ko">
    <head>
        <meta charset="UTF-8">
    </head>
    
    <body>
        <%
        String userID		= request.getParameter("userID");
        String userPassword = request.getParameter("userPassword");
        String userEmail	= request.getParameter("userEmail");
        String userName 	= request.getParameter("userName");
        String userEmailAD 	= request.getParameter("userEmailAD");
        String idDupChk = request.getParameter("idDupChk");
        String loginChk = request.getParameter("loginChk");
        
     	// -1: 서버 오류 / 1: 성공
        if(loginChk.charAt(0)=='f'){
        	PrintWriter script = response.getWriter();
        	script.println("<script>");        	
        	script.println("history.back()");
        	script.println("</script>");
        } else if(idDupChk.charAt(0)=='f'){
           	PrintWriter script = response.getWriter();
           	script.println("<script>");
           	script.println("alert('아이디 중복 확인을 해주세요')");
           	script.println("history.back()");
           	script.println("</script>");
        } else {
        	UserDTO userDTO = new UserDTO();
        	userDTO.setUserID(userID);
        	userDTO.setUserPassword(userPassword);
        	userDTO.setUserEmail(userEmail);
        	userDTO.setUserName(userName);
        	userDTO.setUserEmailAD(userEmailAD);
        	
        	UserDAO userDAO = new UserDAO();
            int result = userDAO.join(userDTO);
            	
            if(result == -1) {
            	PrintWriter script = response.getWriter();
            	script.println("<script>");
            	script.println("alert('서버오류')");
            	script.println("history.back()");
            	script.println("</script>");
            } else {
            	PrintWriter script = response.getWriter();
            	script.println("<script>");
            	script.println("alert('회원가입을 축하드립니다.')");
            	script.println("location.href = './1_MAINPAGE.jsp'");
            	script.println("</script>");
            }
        }
        %>
    </body>
    
</html>