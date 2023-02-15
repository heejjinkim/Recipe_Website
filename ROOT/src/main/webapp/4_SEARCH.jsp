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
    <link rel = "stylesheet" href = "css\recipe_zip.css?after">
    <link rel = "stylesheet" href = "css\4_SEARCH.css?after">
</head>
<%
	String userID = null;
	if(session.getAttribute("userID") != null){
		userID = (String) session.getAttribute("userID");
	}
	int boardID = 1;
	BbsDAO bbsDAO = new BbsDAO();
	String searchText = null;
	if(request.getParameter("searchText")!=null){
		searchText = (String) request.getParameter("searchText");
	}
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
        <div class="rightcolumn">
            <div class="card">
            <span>"<b><%=searchText %></b>" 에 관련된 레시피입니다.</span><br><br>
	            <div class=POSTING_>
	            <%
	            	
	            	ArrayList<BbsDTO> list = bbsDAO.getSearch(searchText);
		            if (list.size() == 0) {
						PrintWriter script = response.getWriter();
						script.println("<script>");
						script.println("alert('검색결과가 없습니다.')");
						script.println("history.back()");
						script.println("</script>");
						System.out.print(searchText);
					}
					for (int i = 0; i < list.size(); i++) {
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

   	</div>
   	<div id="footer">RECIPIC  Web Programming 2022.11.30  @Copyright 김희진 | 신지영 | 하유경</div>
   	</div>
	</div>
</body>
</html>