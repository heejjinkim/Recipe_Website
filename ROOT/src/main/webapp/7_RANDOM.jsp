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
    <link rel = "stylesheet" href = "css\7_RANDOM.css?s">
</head>
<%
	String userID = null;
	if(session.getAttribute("userID") != null){
		userID = (String) session.getAttribute("userID");
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
    	<form action="7_RANDOM_Action.jsp">
		    <div id=container>
		    	<img id="boxTitle" src="images/random_letter.png">
		    	<img id="chief" src="images/cheif.png">
			    <div id="category">
			    <select name="theme">
			        <option selected>--주제별--</option>
			        <option>한식</option><option>중식</option>
			        <option>양식</option><option>일식</option>
			        <option>동남아식</option><option>기타</option>
			    </select> 
			    <select name="sort">
			        <option selected>--종류별--</option>
			        <option>국/탕</option><option>밑반찬</option>
			        <option>메인반찬</option><option>디저트</option>
			        <option>면</option><option>기타</option>
			    </select>
			    <select name="ingredient">
			        <option selected>--재료별--</option>
			        <option>육류</option><option>채소류</option>
			        <option>해물류</option><option>달걀</option>
			        <option>가공식품</option><option>기타</option>
			    </select>
			    <br>
			    <input type="submit" value="뽑기">
			    </div>
		    </div>
	    </form>
    </div>
    </div>
</body>
</html>