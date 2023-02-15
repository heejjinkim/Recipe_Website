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
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <link rel = "stylesheet" href = "css\recipe_zip.css">
    <link rel = "stylesheet" href = "css\4_CATEGORY.css">
</head>
<script>
	$(document).ready(function() {
		
		$("input:button[class='sel']").click(function () {
			var name = $(this).attr('name')
			$.ajax({
				type: "POST",
				url: "4_CATEGORY.jsp",
				data: { "name": name, "value": $(this).val() },
				dataType: 'html',
				success:function(data) {
					$('body').html(data);
				}
			});
		});
	});
</script> 
<%
	String userID = null;
	if(session.getAttribute("userID") != null){
		userID = (String) session.getAttribute("userID");
	}
	BbsDAO bbsDAO = new BbsDAO();
	int pageSize = 16;
	String pageNum = request.getParameter("pageNum");
	if(pageNum == null){
		pageNum = "1";
	}
	
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
            <form id="form1" method="post">
            <div id="cathdr">CATEGORY</div>
            <ul class="CATEGORY">
				<li>
					<details>
						<summary>주제별</summary>
						<ul class="sub_category">                 
		                    <li><input type="button" class="sel" name="theme" value="한식"></li>
		                    <li><input type="button" class="sel" name="theme" value="중식"></li>
		                    <li><input type="button" class="sel" name="theme" value="양식"></li>
		                    <li><input type="button" class="sel" name="theme" value="일식"></li>
		                    <li><input type="button" class="sel" name="theme" value="동남아식"></li>
		                    <li><input type="button" class="sel" name="theme" value="기타"></li>
                		</ul>
					</details>
				</li>
				<li>
					<details>
						<summary>재료별</summary>
						<ul class="sub_category">                 
		                    <li><input type="button" class="sel" name="sort" value="국/탕"></li>
		                    <li><input type="button" class="sel" name="sort" value="밑반찬"></li>
		                    <li><input type="button" class="sel" name="sort" value="메인반찬"></li>
		                    <li><input type="button" class="sel" name="sort" value="디저트"></li>
		                    <li><input type="button" class="sel" name="sort" value="면"></li>
		                    <li><input type="button" class="sel" name="sort" value="기타"></li>
                		</ul>
					</details>
				</li>
				<li>
					<details>
						<summary>종류별</summary>
						<ul class="sub_category">                 
		                    <li><input type="button" class="sel" name="ingredient" value="육류"></li>
		                    <li><input type="button" class="sel" name="ingredient" value="채소류"></li>
		                    <li><input type="button" class="sel" name="ingredient" value="해물류"></li>
		                    <li><input type="button" class="sel" name="ingredient" value="달걀"></li>
		                    <li><input type="button" class="sel" name="ingredient" value="가공식품"></li>
		                    <li><input type="button" class="sel" name="ingredient" value="기타"></li>
                		</ul>
					</details>
				</li>
            </ul>
            </form>
            </div>
        </div>
        <div class="rightcolumn">
            <div class="card">
            	<div class="place">
            		<%
		            String name = request.getParameter("name");
		            String value = request.getParameter("value");
		            if(name == null) {
		            	name = "theme";
		            	value = "한식";
		            }%>
		            <%= value %>
            	</div>
	            <div class=POSTING_>
		            <%
	            	ArrayList<BbsDTO> list = bbsDAO.getCategory(name, value, startRow, pageSize);
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
			<%if(list.size() != 0){ 
				int pageCount = list.size() / pageSize + (list.size()%pageSize==0?0:1);
				int pageBlock = 5;
				int startPage = ((currentPage-1)/pageBlock)*pageBlock+1;
				int endPage = startPage + pageBlock-1;
				if(endPage > pageCount)
					endPage = pageCount;
			%>
		    
			<% if(startPage>pageBlock){ %>
				<a href="4_CATEGORY.jsp?pageNum=<%=startPage-pageBlock%>&&name=<%=name %>&&value=<%=value %>">Prev</a>
			<%} %>
		    
			<% for(int i=startPage;i<=endPage;i++){ %>
				<a href="4_CATEGORY.jsp?pageNum=<%=i%>&&name=<%=name %>&&value=<%=value %>"><%=i %></a>
			<%} %>
		    
			<% if(endPage<pageCount){ %>
				<a href="4_CATEGORY.jsp?pageNum=<%=startPage+pageBlock%>&&name=<%=name %>&&value=<%=value %>">Next</a>
			<%} %>
			<%} %>
		</div>
  	</div>
	<div id="footer">RECIPIC  Web Programming 2022.11.30  @Copyright 김희진 | 신지영 | 하유경</div>
   	</div>
	</div>
</body>
</html>