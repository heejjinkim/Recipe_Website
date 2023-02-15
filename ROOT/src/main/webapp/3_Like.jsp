<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="like.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
	 	String userID = (String) session.getAttribute("userID");
	 	int boardID = Integer.parseInt(request.getParameter("boardID"));
	 	LikeDAO likeDAO = new LikeDAO();
	 	int exist = likeDAO.LikeChk(userID, boardID);
	 	int likeID = likeDAO.getMaxLikeID();
	 	likeID++;
	 	out.println(exist);
	 	// exist -> 1 : 좋아요 누름 -> 삭제 진행
	 	// exist -> 0 : 좋아요 안 누름 -> 누르자
	 	if (exist == 0){
	 		int like = likeDAO.Like(likeID, userID, boardID);
	 		likeDAO.boardUp(boardID);
	 		if(like == -1) {
	 			PrintWriter script = response.getWriter();
		 		script.println("<script>");
		 		script.println("alert('좋아요를 다시 눌러주세요!')");
		 		script.println("history.back()");
		 		script.println("</script>");
	 		} else {
	 			PrintWriter script = response.getWriter();
	 			script.println("<script>");
	 			script.println("location.href=document.referrer;");
	 			script.println("</script>");
	 		}
	 		
	 	} else {
	 		int lDel = likeDAO.LikeDelete(userID, boardID);
	 		likeDAO.boardUpdate(boardID);
	 		if(lDel == -1) {
	 			PrintWriter script = response.getWriter();
		 		script.println("<script>");
		 		script.println("alert('좋아요 취소를 다시!')");
		 		script.println("history.back()");
		 		script.println("</script>");
	 		} else {
	 			PrintWriter script = response.getWriter();
		 		script.println("<script>");
		 		script.println("location.href=document.referrer;");
		 		script.println("</script>");
	 		}
	 	}
	 %>
</body>
</html>