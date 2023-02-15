<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="bbs.BbsDTO" %>
<%@ page import="bbs.BbsDAO" %>
<%@ page import="step.StepDAO" %>
<%@ page import="step.StepDTO" %>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page import="java.util.*" %>
<%@ page import="java.io.*" %>
<%@ page import="java.util.ArrayList" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>RECIPICK</title>
</head>
<body>
<%
	String userID = null;
	int stepCnt = Integer.parseInt(request.getParameter("cnt"));
	out.println("cnt: " + stepCnt); //step의 수
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
	
	String search = multi.getParameter("search");
	String title = multi.getParameter("title");
	String intro = multi.getParameter("intro");
	String theme = multi.getParameter("theme");
	String sort = multi.getParameter("sort");
	String ingredient = multi.getParameter("ingredient");
	String thumb = multi.getFilesystemName("thumb");
	String ingList = multi.getParameter("ingList");
	String[] stepList = multi.getParameterValues("step");
	ArrayList<String> stepImgs = new ArrayList<String>();


	boolean checkI = false;
	boolean checkS = false;
	
	for(int i=0; i<stepCnt; i++){
		stepImgs.add(multi.getFilesystemName("stepImg" + (i+1)));
	}
	
	for(int i=0; i < stepList.length; i++) {
		if(stepList[i].length() == 0) 
			checkS = true;
		if(stepImgs.get(i) == null)
			checkI = true;
	}
	
	if(userID == null){
 		PrintWriter script = response.getWriter();
 		script.println("<script>");
		script.println("alert('로그인을 해주세요.')");
 		script.println("location.href = '2_LOGIN.jsp'");
 		script.println("</script>");
 	} else {
 		BbsDTO bbs = new BbsDTO();
 		StepDTO step = new StepDTO();
 		
 		if(title == "" || intro.length() == 0 || checkS) {
 			PrintWriter script = response.getWriter();
 	    	script.println("<script>");
 	    	script.println("alert('빈칸을 확인해 주세요')");
 	    	script.println("history.back()");
 	    	script.println("</script>");
 		} else if(theme.length() == 7 || sort.length() == 7 || ingredient.length() == 7) {
 			PrintWriter script = response.getWriter();
 	    	script.println("<script>");
 	    	script.println("alert('카테고리를 설정해 주세요')");
 	    	script.println("history.back()");
 	    	script.println("</script>");
 		} else if(thumb == null || checkI) {
 			PrintWriter script = response.getWriter();
 	    	script.println("<script>");
 	    	script.println("alert('이미지를 선택해 주세요')");
 	    	script.println("history.back()");
 	    	script.println("</script>");
 		} else {
 			BbsDAO BbsDAO = new BbsDAO();
 			StepDAO StepDAO = new StepDAO();
 		
 			int boardID = BbsDAO.getMaxID(); boardID++;
 			
 			int stepID = StepDAO.getMaxStep(boardID);
 			int likes = 0;
 			
 			thumb = saveFolder + "/" + thumb; //thumb에 파일 경로 추가
 			for(int i=0; i<stepImgs.size(); i++){//image에 파일 경로 추가
 				stepImgs.set(i, saveFolder + "/" + stepImgs.get(i)); 
 			}
 			
 			bbs.setBoardID(boardID);
 			bbs.setUserID(userID);
 			bbs.setTitle(title);
 			bbs.setIntro(intro);
 			bbs.setTheme(theme);
 			bbs.setSort(sort);
 			bbs.setIngredient(ingredient);
 			bbs.setThumb(thumb);
 			bbs.setIngList(ingList);
 			bbs.setLikes(likes);
 			
 			
	 		int bbsID = BbsDAO.post(bbs);
	 		if (bbsID == -1){
		 		PrintWriter script = response.getWriter();
		 		script.println("<script>");
		 		script.println("alert('글쓰기에 실패했습니다.')");
		 		script.println("history.back()");
		 		script.println("</script>");
		 	}
		 	else{
	 			StepDAO.setStep(stepList, stepImgs, boardID);
		 		PrintWriter script = response.getWriter();
		 		script.println("<script>");
				script.println("location.href= \'1_MAINPAGE.jsp?boardID="+boardID+"\'"); 
		 		script.println("</script>");
		 	}
	 	}
 	}
%>
</body>
</html>