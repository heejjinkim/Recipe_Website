<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="user.UserDAO" %>
<%@ page import="user.UserDTO" %>
<%@ page import="java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8"); %>

<!DOCTYPE html>

<html lang="ko"> 
    <body>
        <%
   		String userID = (String) session.getAttribute("userID");
        String prePassword  = request.getParameter("prePassword");
        String userPassword = request.getParameter("userPassword");
        String userPassword2  = request.getParameter("userPassword2");
        String pwChk = request.getParameter("pwChk");
        UserDTO user = new UserDAO().getUser(userID);
        
        if(userPassword == null || prePassword == null || userPassword2 ==null) {
        	PrintWriter script = response.getWriter();
        	script.println("<script>");
        	script.println("alert('빈칸을 확인해 주세요')");
        	script.println("history.back()");
        	script.println("</script>");
        } else if(pwChk.charAt(0)=='f'){
        	PrintWriter script = response.getWriter();
        	script.println("<script>");
        	script.println("history.back()");
        	script.println("</script>");
        }
        else if(!prePassword.equals(user.getUserPassword())){
        	PrintWriter script = response.getWriter();
        	script.println("<script>");
        	script.println("alert('현재 비밀번호가 틀립니다.')");
        	script.println("history.back()");
        	script.println("</script>");
        }
        else {
        	UserDTO userDTO = new UserDTO();
        	UserDAO userDAO = new UserDAO();
        	userDTO.setUserID(userID);
        	userDTO.setUserPassword(userPassword);
        	
            int result = userDAO.changePassword(userDTO);
            	
            if(result == -1) {
            	PrintWriter script = response.getWriter();
            	script.println("<script>");
            	script.println("alert('서버오류')");
            	script.println("history.back()");
            	script.println("</script>");
            } else {
            	PrintWriter script = response.getWriter();
            	script.println("<script>");
            	script.println("alert('성공적으로 비밀번호를 변경하였습니다.')");
            	script.println("location.href = './1_MAINPAGE.jsp'");
            	script.println("</script>");
            }
        }
        %>
    </body>
    
</html>