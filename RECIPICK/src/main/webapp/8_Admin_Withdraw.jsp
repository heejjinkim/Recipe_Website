<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>  
<%@ page import="user.*" %>
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
    <link rel = "stylesheet" href = "css\8_Admin_Withdraw.css?s">
</head>
<%
	String userID = null;
	if(session.getAttribute("userID") != null){
		userID = (String) session.getAttribute("userID");
	}
	UserDAO userDAO = new UserDAO();
	userDAO.getUserList();
	ArrayList<UserDTO> userList = userDAO.getUserList();
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
	            <div class="PROFILE">
	            	<% UserDTO manager = userDAO.getUser(userID); %>
		            <div class="profile"><img src="<%=manager.getUserImg()%>"></div>
		            <div id="text"> <h4><%=manager.getUserName()%></h4> </div>
		            <a href="8_Admin_Withdraw.jsp">USER 관리</a>
	        	</div>
	        </div>
	        <div class="rightcolumn">
		        <div id="mana">회원 관리</div>
		        	
				    	<table border="1" id="userTable">
							<tr>
								<th>아이디</th>
								<th>비밀번호</th>
								<th>닉네임</th>
								<th>자기소개</th>
								<th>이메일</th>
								<th>회원 탈퇴</th>
							</tr>
							<%
							for(int i=0;i<userList.size(); i++){
								UserDTO user = (UserDTO) userList.get(i);
							%>
							<form action="8_Withdraw.jsp?userID=<%=user.getUserID() %>" method="post">
								<tr>
									<td><%=user.getUserID() %></td>
									<td><%=user.getUserPassword() %></td>
									<td><%=user.getUserName() %></td>
									<td><%=user.getUserPr() %></td>
									<td><%=user.getUserEmail() %><%=user.getUserEmailAD()%></td>
									<td align="center"><input type="submit" value="탈퇴"></td>
								</tr>
							</form>
							<%
							}
							%>
						</table>
			    </div>
		    </div>
	    </div>
    </div>
</body>
</html>