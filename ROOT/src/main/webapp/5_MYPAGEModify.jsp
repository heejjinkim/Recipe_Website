<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page import="java.util.*" %>
<%@ page import="java.io.*" %>
<%@ page import="user.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>RECIPICK</title>
</head>
<body>
<%
	String userID = null;
	if(session.getAttribute("userID") != null) {
		userID = (String)session.getAttribute("userID");
	}

	String realFolder="";
	String saveFolder = "image";		//사진을 저장할 경로
	String encType = "utf-8";				//변환형식
	int maxSize=15*1024*1024;				//사진의 size
	
	ServletContext context = request.getServletContext();		//절대경로를 얻는다
 	realFolder = context.getRealPath(saveFolder);			//saveFolder의 절대경로를 얻음
	MultipartRequest multi = null;

	//파일업로드를 직접적으로 담당		
	multi = new MultipartRequest(request,realFolder,maxSize,encType,new DefaultFileRenamePolicy());
	
	UserDAO userDAO = new UserDAO();
	String userImg;
	String userPr = multi.getParameter("userPr");
	String userName = multi.getParameter("userName");
	String userEmail = multi.getParameter("userEmail");
	String userEmailAD = multi.getParameter("userEmailAD");
	
	if(userEmail == "" || userName == "") {
			PrintWriter script = response.getWriter();
	    	script.println("<script>");
	    	script.println("alert('빈칸을 확인해 주세요')");
	    	script.println("history.back()");
	    	script.println("</script>");
	}
 	if(multi.getFile("userImg") != null){ //userImg 바뀜. 업데이트
 		userImg = multi.getFilesystemName("userImg");		 		
 		userImg = saveFolder + "/" + userImg;
 		userDAO.update(userID, "userImg", userImg);
	}
 	
 	userDAO.update(userID, "userPr", userPr);
 	userDAO.update(userID, "userName", userName);
 	userDAO.update(userID, "userEmail", userEmail);
 	userDAO.update(userID, "userEmailAD", userEmailAD);
 	
	PrintWriter script = response.getWriter();
		
	script.println("<script>");
	script.println("location.href= \'5_MYPAGE.jsp\'"); 
	script.println("</script>");
%>
</body>
</html>