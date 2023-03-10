<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>  
<%@ page import="user.*" %>
<%@ page import="bbs.*" %>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="java.util.ArrayList"%>

<% request.setCharacterEncoding("UTF-8"); %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>RECIPICK</title>
    <link rel = "stylesheet" href = ".\css\recipe_zip.css?after">
    <link rel = "stylesheet" href = ".\css\4_RANKING.css?after">
</head>
<%
	String userID = null;
	if(session.getAttribute("userID") != null){
		userID = (String) session.getAttribute("userID");
	}
	BbsDAO bbsDAO = new BbsDAO();
	int cnt = bbsDAO.boardNum();
	int pageSize = 16;
	String pageNum = request.getParameter("pageNum");
	if(pageNum == null){
		pageNum = "1";
	}
	
	// 첫행번호를 계산
	int currentPage = Integer.parseInt(pageNum);	
	int startRow = (currentPage-1)*pageSize + 1;
%>

<body>
	<div id="wrap">
	<div id="body-warp">
    <div class="header">
        <div class="header_wrap">
            <a href="1_MAINPAGE.jsp"><img src="images/LOGO.png" class="logo" ></a>
            <div class="searchbox">            
                <form id="form" action="4_SEARCH.jsp" method="post">
                    <input type="text" id="ex_input" name="searchText"></input>
                </form>
            </div>
            <div class="menubar">
	        	<nav id="menu">
		            <ul>
		                <li><a href="4_CATEGORY.jsp">CATEGORY</a></li>
		                <li><a href="4_RANKING.jsp">RANKING</a></li>
		                <li><a href="5_MYPAGE.jsp">MYPAGE</a></li>
		            </ul>
	        	</nav>
	        	<div class="sub__menubar">
	      			<%
					if(userID == null){		//로그인이 되어있지 않은 경우
					%><a href="2_LOGIN.jsp">로그인</a><% 
					} else {%><a href="2_LOGOUT.jsp">로그아웃</a><%}%>
			        <a href="3_POSTING.jsp">글쓰기</a>
	        	</div>
		    </div>
	    </div>
    </div>
    <div class="box">
        <div class="leftcolumn">
            <div class="card">
            <div id="cathdr">BEST PICK</div>
            <ul class="CATEGORY">
                <li>레시피</li>
		 	</ul>
	        </div>
        </div>
        <div class="rightcolumn">
            <div class="card">
	            <div class=POSTING_>
                    <%
	            	ArrayList<BbsDTO> list = bbsDAO.getRanking(startRow, pageSize);
	           		for(int i=0; i<list.size(); i++){       	
		            	userID = list.get(i).getUserID();
		            	UserDAO userDAO = new UserDAO();
		            	UserDTO user = userDAO.getUser(userID);
		 				String userName = user.getUserName();						
		            %>
	                <div class="recipe">
	                <img src=<%=list.get(i).getThumb() %>>
	                <div class="info">
	                <a href="3_POST.jsp?boardID=<%=list.get(i).getBoardID() %>"><%=list.get(i).getTitle() %></a>
	                <p>by <%=userName %></p></div> 
	        		</div>
			        <%
			        }
			        %>
        		</div>
        	</div>
    	</div>
    	<div id="page_control">
			<%if(cnt != 0){ 
				int pageCount = cnt / pageSize + (cnt%pageSize==0?0:1);
				int pageBlock = 5;
				int startPage = ((currentPage-1)/pageBlock)*pageBlock+1;
				int endPage = startPage + pageBlock-1;
				if(endPage > pageCount)
					endPage = pageCount;
			%>
		    
			<% if(startPage>pageBlock){ %>
				<a href="4_RANKING.jsp?pageNum=<%=startPage-pageBlock%>">Prev</a>
			<%} %>
		    
			<% for(int i=startPage;i<=endPage;i++){ %>
				<a href="4_RANKING.jsp?pageNum=<%=i%>"><%=i %></a>
			<%} %>
		    
			<% if(endPage<pageCount){ %>
				<a href="4_RANKING.jsp?pageNum=<%=startPage+pageBlock%>">Next</a>
			<%} %>
			<%} %>
		</div>
   	</div>
   	<div id="footer">RECIPIC  Web Programming 2022.11.30  @Copyright 김희진 | 신지영 | 하유경</div>
   	</div>
	</div>
</body>
</html>