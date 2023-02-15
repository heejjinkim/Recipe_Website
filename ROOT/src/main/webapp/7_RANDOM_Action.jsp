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
    <link rel = "stylesheet" href = "css\7_RANDOM.css?ss">
</head>
<%
	String userID = null;
	if(session.getAttribute("userID") != null){
		userID = (String) session.getAttribute("userID");
	}
	String theme = request.getParameter("theme");
	String sort = request.getParameter("sort");
	String ingredient = request.getParameter("ingredient");
	
	BbsDAO bbsDAO = new BbsDAO();
	BbsDTO bbs = bbsDAO.getRandom(theme, sort, ingredient);
	if(bbs==null){
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('해당하는 레시피가 없습니다.')");
		script.println("history.back()");
		script.println("</script>");
	}
	UserDAO userDAO = new UserDAO();
	String randomUserID = bbs.getUserID();
	UserDTO bbsUser = userDAO.getUser(randomUserID);
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
	    <div id="container">
	    	<img id="boxTitle" src="images/random_letter.png">
	    	<img id="chief" src="images/cheif.png">
			<div id="box">
		        <div class="recipe">
		           <img src=<%=bbs.getThumb() %>>
		           <p><a href="3_POST.jsp?boardID=<%=bbs.getBoardID() %>"><%=bbs.getTitle() %></a></p>
		           <p class="writer">by <%=bbsUser.getUserName()%></p>
		   		</div>
	   		</div>
	    <button id="reDraw" onclick="location.href='7_RANDOM.jsp' ">다시 뽑기</button>		
    	</div>
    </div>
</body>
</html>