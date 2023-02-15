<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="like.*"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<%

	LikeDAO likeDAO = new LikeDAO();
	PrintWriter script = response.getWriter();
	String userID = null;
	if (session.getAttribute("userID") != null) {//유저아이디이름으로 세션이 존재하는 회원들은 
		userID = (String) session.getAttribute("userID");//유저아이디에 해당 세션값을 넣어준다.
	}
	
	String[] deleteList = request.getParameterValues("deleteCheck");
	if(deleteList==null){
		script.println("<script>");
		script.println("history.back()");
		script.println("</script>");
	}
	else{
		for(String item : deleteList){
			int result = likeDAO.LikeDelete(userID, Integer.parseInt(item));
			if(result == -1) {
				script.println("<script>");
		 		script.println("alert('삭제를 다시 진행해주세요.')");
		 		script.println("history.back()");
				script.println("</script>");
			}
		}
		script.println("<script>");
 		script.println("alert('삭제 완료되었습니다.')");
 		script.println("location.href='5_MYLIKE.jsp'");
		script.println("</script>");
	}
%>
</body>
</html>