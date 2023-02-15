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
	int boardID = Integer.parseInt(request.getParameter("boardID"));
	BbsDAO bbsDAO = new BbsDAO();
	BbsDTO bbs = bbsDAO.getBbs(boardID);
	StepDAO stepDAO = new StepDAO();
	int curMaxStep = stepDAO.getMaxStep(boardID);
	
	
	MultipartRequest multi = null;
	String realFolder="";
	String saveFolder = "image";		//사진을 저장할 경로
	String encType = "utf-8";				//변환형식
	int maxSize=15*1024*1024;				//사진의 size
	
	ServletContext context = request.getServletContext();		//절대경로를 얻는다
 	realFolder = context.getRealPath(saveFolder);			//saveFolder의 절대경로를 얻음
	multi = new MultipartRequest(request,realFolder,maxSize,encType,new DefaultFileRenamePolicy());
	
	String title = multi.getParameter("title");
	String intro = multi.getParameter("intro");
	String theme = multi.getParameter("theme");
	String sort = multi.getParameter("sort");
	String ingredient = multi.getParameter("ingredient");
	String ingList = multi.getParameter("ingList");
	String[] stepList = multi.getParameterValues("step");
	ArrayList<String> stepImgs = new ArrayList<String>();
	String thumb;
 	
	if(session.getAttribute("userID") != null) {
		userID = (String)session.getAttribute("userID");
	}
	
	boolean checkS = false;	
	
	for(int i=0; i < stepList.length; i++) {
		if(stepList[i].length() == 0) 
			checkS = true;
	}
	
	if(userID == null){
 		PrintWriter script = response.getWriter();
 		script.println("<script>");
		script.println("alert('로그인을 해주세요.')");
 		script.println("location.href = '2_LOGIN.jsp'");
 		script.println("</script>");
 	} else {
 		
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
 		} else {
 			
 		 	if(multi.getFile("thumb") != null){ //썸네일 바뀜. 업데이트
 				thumb = multi.getFilesystemName("thumb");		 		
 				thumb = saveFolder + "/" + thumb;
 				bbsDAO.update(boardID, "thumb", thumb);
 			}
 		 	
 			for(int i=1; i<=stepCnt; i++){
 				if(multi.getFile("stepImg" + i) == null){//step 사진 안바뀜
 					int curStepID = i;
 					StepDTO curStep = stepDAO.getStep(boardID,curStepID);
 					String originFile = curStep.getImageFile();
 					stepImgs.add(originFile); 
 				}
 				else{ //step 사진 바뀜
 					String newStepImg = multi.getFilesystemName("stepImg" + i);
 					newStepImg = saveFolder + "/" + newStepImg;
 					stepImgs.add(newStepImg);
 				}
 			}

 			//bbs 업데이트
 			bbsDAO.update(boardID, "title", title);
 			bbsDAO.update(boardID, "intro", intro);
 			bbsDAO.update(boardID, "theme", theme);
 			bbsDAO.update(boardID, "sort", sort);
 			bbsDAO.update(boardID, "ingredient", ingredient);
 			bbsDAO.update(boardID, "ingList", ingList);

 			stepDAO.deleteStep(boardID); //기존 step 다 삭제
 			stepDAO.setStep(stepList, stepImgs, boardID); //새로 바뀐 step 다시 삽입
 		
	 		PrintWriter script = response.getWriter();
			
	 		script.println("<script>");
			script.println("location.href= \'1_MAINPAGE.jsp?boardID="+boardID+"\'"); 
	 		script.println("</script>");
		 	
	 	}
 	}
%>
</body>
</html>