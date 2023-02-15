<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>  
<%@ page import="user.*" %>
<%@ page import="bbs.*" %>
<%@ page import="like.*" %>
<%@ page import="java.util.ArrayList"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>RECIPICK</title>
    <link rel = "stylesheet" href = ".\css\recipe_zip.css">
    <link rel = "stylesheet" href = ".\css\5_MYLIKE.css?ads">
</head>
<%
	String userID = null;
	int boardID;
	if(session.getAttribute("userID") != null){
		userID = (String) session.getAttribute("userID");
	}
	BbsDAO bbsDAO = new BbsDAO();
	LikeDAO likeDAO = new LikeDAO();
	UserDAO userDAO = new UserDAO();
	
	ArrayList<LikeDTO> likeList = likeDAO.getLikelist(userID);
	
%>
<body>
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
            <div id="cathdr">MYPAGE</div>
            <ul class="CATEGORY">
	            <li><a href="5_MYRECIPE.jsp">나의 레시피</a></li>
	            <li><a href="5_MYLIKE.jsp">좋아요 누른 게시물</a></li>
	            <li><a href="5_MYPAGE.jsp">회원정보 수정</a></li>
	            <li><a href="5_PW.jsp">비밀번호 변경</a></li>
	        </ul>
	        </div>
        </div>
        <div class="rightcolumn">
            <div class="card">
            <form action="5_MYLIKEDelete.jsp" method="post">
            <div class="sub_title">
                <h2>좋아요 누른 게시물</h2>
	            <input class="delete" type="submit" value="삭제"/>
            </div>
            <div class="imgbox">
           	<%
           		for(int i=0; i<likeList.size(); i++){
           			boardID = likeList.get(i).getBoardID();
           			BbsDTO bbs = bbsDAO.getBbs(boardID);
           			UserDTO postUser = userDAO.getUser(bbs.getUserID());
            %>
                <div class="recipe">
                    <input type="checkbox" name="deleteCheck" value=<%=boardID %>>
                    <img src=<%=bbs.getThumb() %> alt="">
                    <p><a href="3_POST.jsp?boardID=<%=boardID %>"><%=bbs.getTitle() %></a></p>
                    <p class="writer">by <%=postUser.getUserName() %></p>
                </div>
           <%} %>
            </div>
           </form>
        	</div>
    	</div>
    </div>
</body>
</html>