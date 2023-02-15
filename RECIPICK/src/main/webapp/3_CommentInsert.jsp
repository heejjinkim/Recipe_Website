<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="comment.CommentDAO" %>
<%@ page import="java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
</head>
<body>
	 <%
	 	CommentDAO commentDAO = new CommentDAO();
	 	int boardID = 0;
		int commentID = commentDAO.getMaxCommentID();
		String content = request.getParameter("content");
	 	String userID = null;
		if (request.getParameter("boardID") != null){
			boardID = Integer.parseInt(request.getParameter("boardID"));
		}
	 	if(session.getAttribute("userID") != null){
	 		userID = (String) session.getAttribute("userID");
	 	}
	 	commentID++;
	 	if(userID == null){
	 		PrintWriter script = response.getWriter();
	 		script.println("<script>");
			script.println("alert('로그인을 해주세요.')");
	 		script.println("location.href = '2_LOGIN.jsp'");
	 		script.println("</script>");
	 	} 
	 	else{
		 	if (request.getParameter("commentID") != null){
		 		commentID = Integer.parseInt(request.getParameter("commentID"));
		 	}
		 	
	 		int ckID = commentDAO.write(commentID, boardID, content, userID);
	 		if (ckID == -1){
		 		PrintWriter script = response.getWriter();
		 		script.println("<script>");
		 		script.println("alert('댓글 쓰기에 실패했습니다.')");
		 		script.println("history.back()");
		 		script.println("</script>");
		 	}
	 		else{
		 		PrintWriter script = response.getWriter();
		 		script.println("<script>");
		 		script.println("location.href=document.referrer;");
		 		script.println("</script>");
			}
	 	}
	 %>
</body>
</html>