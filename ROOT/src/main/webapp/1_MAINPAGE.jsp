<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>  
<%@ page import="user.*" %>
<%@ page import="bbs.*" %>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="java.util.ArrayList"%>

<%@page import="java.util.Date"%>
<%@page import="java.util.*"%>
<%@page import="java.text.SimpleDateFormat" %>


<% request.setCharacterEncoding("UTF-8"); %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>RECIPICK</title>
    <link rel = "stylesheet" href = "css\recipe_zip.css?after">
    <link rel = "stylesheet" href = "css\1_MAINPAGE.css?dfg">
</head>
<%
	String userID = null;
	if(session.getAttribute("userID") != null){
		userID = (String) session.getAttribute("userID");
	}
	BbsDAO bbsDAO = new BbsDAO();
	int cnt = bbsDAO.boardNum();
	int pageSize = 9;
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
            <div class="PROFILE">
            <%
				UserDAO userDAO = new UserDAO();
            	String manager = "manager";
	            if(userID != null && userID.equals(manager)) {
	            	UserDTO user = userDAO.getUser(userID);
	        %>
	            <div class="profile"><img src="<%=user.getUserImg()%>"></div>
	            <div id="text">
			            <h4><%=user.getUserName()%></h4>
				</div>
	        <% } else if(userID != null){		//로그인이 되어있는 경우
            		UserDTO user = userDAO.getUser(userID);
            		Date date = new Date();
            		SimpleDateFormat sDate = new SimpleDateFormat("yyyy-MM-dd");
        			String strdate = sDate.format(date);
        			Calendar cal = Calendar.getInstance();
			%>
		            <div class="profile"><img src="<%=user.getUserImg()%>"></div>
		            <div id="text">
			            <h4><%=user.getUserName()%></h4>
			            <p><b>포스트</b> <%=bbsDAO.getUserBbsNum(userID) %> <b>좋아요</b> <%=bbsDAO.userGetLikes(userID) %> </p>
			            <p style="text-align : left;"><%=user.getUserPr()%></p>
			            <p style="text-align : left;"><a href="7_MYCALENDAR.jsp?year=<%=cal.get(Calendar.YEAR)%>&month=<%=cal.get(Calendar.MONTH)+1%>&day=<%=cal.get(Calendar.DATE)%>">내 달력</a></p>	            
		            </div>
            <%
				}else{//로그인이 되어있지 않은 경우
			%>		<div class="profile"><img src="images/레시피.jpg"></div>
		            <div id="text">
			            <h4>레시픽</h4>
			            <p><b>총 포스트</b> <%=bbsDAO.boardNum()%><br></p>
			            <p style="text-align : left;">레시피 검색은 레시픽에서~!</p>
		            </div> 
            <%
				}
	            if(userID != null && userID.equals(manager)) {%> 
	            	<a href="8_Admin_Withdraw.jsp">USER 관리</a>
	            	</div> 
	        <%  } else {
			%>		<br>
					<a href="7_RANDOM.jsp">>>뭐 해먹지 고민일 땐?<<</a>
	            	</div> 
            <%  } %>
        </div>
        <div class="rightcolumn">
            <div class="card">
	            <div class=POSTING_>
	            <%
	            	ArrayList<BbsDTO> list = bbsDAO.getList(startRow, pageSize);
	           		for(int i=0; i<list.size(); i++){       	
		            	userID = list.get(i).getUserID();
		            	userDAO = new UserDAO();
		            	UserDTO user = userDAO.getUser(userID);					
	            %>
                <div class="recipe">
                <img src=<%=list.get(i).getThumb() %>>
                <div class="info">
                <a href="3_POST.jsp?boardID=<%=list.get(i).getBoardID() %>"><%=list.get(i).getTitle() %></a>
                <p>by <%=user.getUserName()%></p></div> 
        		</div>
		        <%
		        }
		        %>
       		</div>
        	</div>
    	</div>
    	<div id="page_control">
			<%if(cnt != 0){ 
				////////////////////////////////////////////////////////////////
				// 페이징 처리
				// 전체 페이지수 계산
				int pageCount = cnt / pageSize + (cnt%pageSize==0?0:1);
				// 한 페이지에 보여줄 페이지 블럭
				int pageBlock = 10;
				// 한 페이지에 보여줄 페이지 블럭 시작번호 계산
				int startPage = ((currentPage-1)/pageBlock)*pageBlock+1;
				// 한 페이지에 보여줄 페이지 블럭 끝 번호 계산
				int endPage = startPage + pageBlock-1;
				if(endPage > pageCount){
					endPage = pageCount;
				}	
			%>
		    
			<% if(startPage>pageBlock){ %>
				<a href="1_MAINPAGE.jsp?pageNum=<%=startPage-pageBlock%>">Prev</a>
			<%} %>
		    
			<% for(int i=startPage;i<=endPage;i++){ %>
				<a href="1_MAINPAGE.jsp?pageNum=<%=i%>"><%=i %></a>
			<%} %>
		    
			<% if(endPage<pageCount){ %>
				<a href="1_MAINPAGE.jsp?pageNum=<%=startPage+pageBlock%>">Next</a>
			<%} %>
			<%} %>
		</div>
   	</div>
   	<div id="footer">RECIPIC  Web Programming 2022.11.30  @Copyright 김희진 | 신지영 | 하유경</div>
   	</div>
	</div>
</body>
</html>