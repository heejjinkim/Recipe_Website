<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>  
<%@ page import="user.*" %>
<%@ page import="bbs.*" %>
<%@ page import="calendar.*" %>
<%@page import="calendar.MyCalendar"%>
<%@page import="java.util.Date"%>
<%@ page import="java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8"); %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>RECIPICK</title>
    <link rel = "stylesheet" href = "css\recipe_zip.css?after">
    <link rel = "stylesheet" href = "css\7_MYCALENDAR.css?after">
</head>
<%
	String userID = null;
	if(session.getAttribute("userID") != null){
		userID = (String) session.getAttribute("userID");
	}
	UserDAO userDAO = new UserDAO();
	UserDTO user = userDAO.getUser(userID);
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
	      			<a href="2_LOGOUT.jsp">로그아웃</a>
			        <a href="3_POSTING.jsp">글쓰기</a>
	        	</div>
		    </div>
	    </div>
    </div>
    <div class="box">
	    <div class="leftcolumn">
        <div class="PROFILE">
	        <div class="profile"><img src="<%=user.getUserImg()%>"></div>
	        <div id="text"><%=user.getUserName()%></div>
        </div>
	    <%
			Date date = new Date();
			int year = date.getYear() +1900;
			int month = date.getMonth() +1;
			year = Integer.parseInt(request.getParameter("year"));
			month = Integer.parseInt(request.getParameter("month"));
			if(month>=13){
				year++;
				month =1;
			}else if(month <=0){
				year--;
				month =12;
			}
		%>
			<table cellpadding="5" cellspacing="0">
				<thead>
				<tr>
					<th id = "title" colspan="5"><%=year%>년  <%=month%>월</th>
					<th><a href ="?year=<%=year%>&month=<%=month-1%>"><</a></th>
					<th><a href ="?year=<%=year%>&month=<%=month+1%>">></a></th>
				</tr>
				</thead>
				<tbody>
				<tr>
					<td class = "day">일</td>
					<td class = "day">월</td>
					<td class = "day">화</td>
					<td class = "day">수</td>
					<td class = "day">목</td>
					<td class = "day">금</td>
					<td class = "day">토</td>
				</tr>
				<tr>
				<%
			    	CalendarDAO cal = new CalendarDAO();
					int first = MyCalendar.weekDay(year, month, 1);
					int start = 0 ;
					for(int i= 1; i<= first; i++){ 
							%><td><br></td><%
					}	
					for(int i = 1; i <= MyCalendar.lastDay(year, month); i++){
						String caldate = (year+"-" + month+"-" +i);
						int pk = cal.getKey(userID,caldate);
						int m1=0; int m2=0; int m3=0;
						if(!cal.getTitle(userID, caldate, "breakfast").equals("")){
							CalendarDTO calDTO = cal.getCal(pk);
							m1 = calDTO.getBreakfast();
						}
						if(!cal.getTitle(userID, caldate, "lunch").equals("")){
							CalendarDTO calDTO = cal.getCal(pk);
							m2 = calDTO.getLunch();
						}
						if(!cal.getTitle(userID, caldate, "dinner").equals("")){
							CalendarDTO calDTO = cal.getCal(pk);
							m3 = calDTO.getDinner();
						}
						if(m1==0 & m2==0 & m3==0){
							%><td class ='etc'><img src='images/hat1.png'><br><%
						}
						else if(m1!=0 & m2!=0 & m3!=0){
							%><td class ='etc'><img src='images/hat4.png'><br><%
						}
						else if((m1!=0 & m2==0 & m3==0)||(m1==0 & m2!=0 & m3==0)||(m1==0 & m2==0 & m3!=0)){
							%><td class ='etc'><img src='images/hat2.png'><br><%
						}
						else{
							%><td class ='etc'><img src='images/hat3.png'><br><%
						}
						%>
						<a href ="?year=<%=year%>&month=<%=month%>&day=<%=i%>"><%=i %></a></td><%
						if(MyCalendar.weekDay(year, month, i) == 6 && i != MyCalendar.lastDay(year, month))
							out.println("</tr><tr>");	
					}
					if(MyCalendar.weekDay(year, month, MyCalendar.lastDay(year, month)) !=6)
						for(int i = MyCalendar.weekDay(year, month, MyCalendar.lastDay(year, month))+1; i < 7; i++)
							out.println("<td></td>");
				%>
				</tr>
				</tbody>
			</table>
		</div>
	    <div class="rightcolumn">
	   	<%	
	    	CalendarDAO calDAO = new CalendarDAO();
			String day = (request.getParameter("year") +"-" + request.getParameter("month") +"-" + request.getParameter("day"));
			int pk = calDAO.getKey(userID,day);
			CalendarDTO calDTO = calDAO.getCal(pk);			
			BbsDAO bbsDAO = new BbsDAO();
			if(calDAO.calNum(userID)==0){
	   	%>
	   		<div id="txt">레시픽에서 요리를 기록해보세요!</div><%}
			else{%>
	    	<div id="txt">레시픽으로 <%=calDAO.calNum(userID) %>일 요리했어요</div>
	    	<%} %>
	    	<div class="mealbox">
	    		<div class="meal">🥐아침</div>
	    		<%if(!calDAO.getTitle(userID, day, "breakfast").equals("")){%>
	    		<%
				BbsDTO bbs = bbsDAO.getBbs(calDTO.getBreakfast());
	    		%>
	    		<div class="post__">
	    			<div class="post__tit">
		    			<a href="3_POST.jsp?boardID=<%=calDTO.getBreakfast()%>"><%=bbs.getTitle() %></a>
		    			<a class="dlt" onclick="return confirm('정말로 삭제하시겠습니까?')" href = "7_MYCALDelete.jsp?pk=<%=pk %>&meal=breakfast">x</a>
	    			</div>
	    			<div class="post__cat"><%=bbs.getTheme() %></div>
	    		</div>
	    		<%} %>
	    	</div>
 		    <div class="mealbox">
	    		<div class="meal">🍱점심</div>
	    		<%if(!calDAO.getTitle(userID, day, "lunch").equals("")){%>
	    		<%
				BbsDTO bbs = bbsDAO.getBbs(calDTO.getLunch());
	    		%>
	    		<div class="post__">
	    			<div class="post__tit">
		    			<a href="3_POST.jsp?boardID=<%=calDTO.getLunch()%>"><%=bbs.getTitle() %></a>
		    			<a class="dlt" onclick="return confirm('정말로 삭제하시겠습니까?')" href = "7_MYCALDelete.jsp?pk=<%=pk %>&meal=lunch">x</a>
	    			</div>
	    			<div class="post__cat"><%=bbs.getTheme() %></div>
	    		</div>
	    		<%} %>
	    	</div>
 		    <div class="mealbox">
	    		<div class="meal">🍲저녁</div>
	    		<%if(!calDAO.getTitle(userID, day, "dinner").equals("")){%>
	    		<%
				BbsDTO bbs = bbsDAO.getBbs(calDTO.getDinner());
	    		%>
	    		<div class="post__">
	    			<div class="post__tit">
	    				<a href="3_POST.jsp?boardID=<%=calDTO.getDinner()%>"><%=bbs.getTitle() %></a>
	    				<a class="dlt" onclick="return confirm('정말로 삭제하시겠습니까?')" href = "7_MYCALDelete.jsp?pk=<%=pk %>&meal=dinner">x</a>
	    			</div>
	    			<div class="post__cat"><%=bbs.getTheme() %></div>
	    		</div>
	    		<%} %>
	    	</div>
	    </div>    
   	</div>
   	<div id="footer">RECIPIC  Web Programming 2022.11.30  @Copyright 김희진 | 신지영 | 하유경</div>
   	</div>
	</div>
</body>
</html>