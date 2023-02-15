<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="user.*" %>
<%@ page import="java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8"); %>

<%	
		PrintWriter writer = response.getWriter();

        String userID		= request.getParameter("id");
    	UserDTO userDTO = new UserDTO();
       	userDTO.setUserID(userID);
       	UserDAO userDAO = new UserDAO();
       	
        boolean result = userDAO.ID_Check(userID);
        
        if(userID.length() < 6 || userID.length() > 20){
	       	writer.print(0);
        }
        if(result == false) {
	       	writer.print(1);
        } else {
	       	writer.print(2);
        }
%>
