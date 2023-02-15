<%@ page language="java" contentType = "text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="comment.*" %>
<%@ page import="java.io.File" %>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.sql.*"%> 
<%@ page import="user.*" %>
<%@ page import="bbs.*" %>
<%@ page import="step.*" %>
<%@ page import="like.*" %>
<% request.setCharacterEncoding("utf-8"); %>

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <script src="https://code.jquery.com/jQuery-3.6.0.js"></script>
    <title>RECIPICK</title>
    <link rel = "stylesheet" href = ".\css\recipe_zip.css">
    <link rel = "stylesheet" href = ".\css\3_POST.css">
</head>
<%
	String userID = null;
	if(session.getAttribute("userID") != null){
		userID = (String) session.getAttribute("userID");
	}

	BbsDAO bbsDAO = new BbsDAO();
	int boardID = Integer.parseInt(request.getParameter("boardID"));
	BbsDTO bbs = bbsDAO.getBbs(boardID);
	bbsDAO.viewUpdate(boardID);
	StepDAO stepDAO = new StepDAO();
	String stepContent;
	String stepImg;
	
	int commentID;
	CommentDAO commentDAO = new CommentDAO();
	int maxCommentID = commentDAO.getMaxCommentID();
	
	LikeDAO likeDAO = new LikeDAO();
	int likeChk = likeDAO.LikeChk(userID, boardID);
	String color;
	if(likeChk == 1) {
		color = "rgb(178,34,34)";
	} else {
		color = "black";
	}
%>
<script>
	$(document).ready(function() {
		var boardID = <%= boardID %>;
		var like = 0;
		if(<%=likeChk%> == 1) like = 1; 
		var count = 0;
		$("#favorite").click(function () {
			var likenum = <%=likeDAO.getLikeNum(boardID)%>;
			$.ajax({
				type: "POST",
				url: "3_Like.jsp",
				data: {'boardID' : boardID },
				dataType: 'text',
				success:function() {
					like++; count++;
					console.log(count);
					if((like % 2) == 0) {
						$("#favorite").css('color', 'black');
						$("#favorite").css('width', '50px');
						if((count % 2) == 0) {
							$("#likenum").text(likenum);
						} else {
							$("#likenum").text(likenum - 1);
						}
					} else {
						$("#favorite").css('color', 'rgb(178,34,34)');
						$("#favorite").css('width', '50px');
						if((count % 2) == 0) {
							$("#likenum").text(likenum);
						} else {
							$("#likenum").text(likenum + 1);
						}
					}
				}
			});
		});
	});
</script> 
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
    <div class="post">
	   <div class="box">
	        <div class="mainview">
	           	<div class="view_img">
		            <img src=<%=bbs.getThumb() %> id="postImg">
	            </div>
	            <div class="view_info">
		            <ul class="clr">
		            	<li><img src="images/rec_icon1.png"><%=bbs.getViews() %></li>
		            	<li><img src="images/rec_icon2.png"><span id="likenum"><%=likeDAO.getLikeNum(boardID)%></span></li>
		            </ul><hr>
	            	<span class="P__text"><%=bbs.getTitle() %></span> <br>
	            	<span class="cate" style="font-size: 18px;"><%=bbs.getTheme()%>&nbsp/&nbsp  <%=bbs.getSort()%>&nbsp/&nbsp  <%=bbs.getIngredient()%></span>
		            <p><%=bbs.getIntro() %></p><br><br>
	            	<div class="ingredient">
		            	<span id="in">재료</span><br>
		            	<%=bbs.getIngList() %><br><br>
		            </div>
		            <div class="mealbox">
	    				<div class="meal">
	    				<form action = "7_MYCALInsert.jsp?">
	    					<input type="submit" value="😋달력에 추가" >
	    					<select name="mealChk">
						        <option>아침</option><option>점심</option><option>저녁</option>
						    </select> 
						    <input type="hidden" value=<%=boardID %> name="boardID">
						</form>
						<% if(userID != null) { %>
		             	<div id="favorite" style="width: 50px; color: <%=color%>">♥</div>  <% } %>       
	    				</div>
	    			</div>
    	            <div class="postaction">
		        		<% String manager = "manager";
			            if(userID==null){} else if(userID.equals(manager) || userID.equals(bbs.getUserID())){%>
						<a href = "3_POST_MODIFY.jsp?boardID=<%=boardID %>">수정</a>
						<a onclick="return confirm('정말로 삭제하시겠습니까?')" href = "3_POSTDelete.jsp?boardID=<%=boardID %>">삭제</a>
						<% } %>
		            </div>
				</div>
         	</div>
         	<div class="hr"><hr></div>	
	        <div class="contentview">
	        	<div class="card">
	        	<%
	            	ArrayList<StepDTO> Steplist = stepDAO.getStepList(boardID);
	           		for(int i=0; i<Steplist.size(); i++){       	
		            	stepContent = Steplist.get(i).getStepContent();
		            	stepImg = Steplist.get(i).getImageFile();
				%>
	        		<div class=stepbox>
	        			<div class=view_step><img src=<%=stepImg %> class="STEP__IMG"></div>
						<div class="step">
							<%=stepContent %>
		                </div>
	                </div>		
				<%
	           		}
	        	%>      
                </div>
				<div class="card">
					<% ArrayList<CommentDTO> list = commentDAO.getList(boardID); %>
		            <span id="comment">댓글</span><span id="count"><%=list.size() %></span>
                	<div class="chr"><hr></div>	
					<%
						for(int i=list.size()-1; i>=0; i--){										
							String commentuserID = list.get(i).getUserID();
							
							UserDAO userDAO = new UserDAO();
			            	UserDTO user = userDAO.getUser(commentuserID);
			 				String userName = user.getUserName();
					%>
					        <table align="center" width="100%">
								<tr><td><span class="name"><%=userName%>  </span>
								<span class="date"><%=list.get(i).getDate()%></span>  
							<%
					            if(userID==null){}
					            else if(userID.equals(manager) || userID.equals(commentuserID)) {
							%>
								| <a onclick="return confirm('정말로 삭제하시겠습니까?')" href="3_CommentDelete.jsp?boardID=<%=boardID%>&commentID=<%=list.get(i).getCommentID()%>">삭제</a></td></tr>
							  <%}%>
								<tr><td><span class="text"><%=list.get(i).getContent()%></span></td></tr>
		            <% } %>
							</table>
					<br>
		            <form method="post" action="3_CommentInsert.jsp">
                	<div class="COM__BOX">
				        <textarea cols ="150" rows = "3" name="content" placeholder="댓글을 남겨주시면 작성자가 힘을 얻어요!" style="resize:none"></textarea>
						<input type="hidden" name=boardID value="<%=request.getParameter("boardID")%>">
						<input type="submit" value="등록" id="asl">
					</div>
					</form>
				</div>
	      	</div>
	    </div>
	</div>    
</body>
</html>