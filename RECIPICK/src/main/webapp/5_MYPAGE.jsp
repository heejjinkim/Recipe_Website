<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="user.*"%>    
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>RECIPICK</title>
    <link rel = "stylesheet" href = ".\css\recipe_zip.css">
    <link rel = "stylesheet" href = ".\css\5_MYPAGE.css?adfss">
</head>
<script>
	function pwCheck() {
		window.open(
			"6_PWcheck.html",
			"PASSWORD CHECK",
			"width=400, height=300, top=50, left=50, resizable=no"
		)
	}
</script>
<body>
<%
	String userID = "";
	if(session.getAttribute("userID") != ""){
		userID = (String) session.getAttribute("userID");
	}
	
	if(userID == null){		//로그인이 되어있지 않은 경우
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("location.href = './2_LOGIN.jsp'");
		script.println("</script>");
	} 
	else {

		UserDAO userDAO = new UserDAO();
		UserDTO user = userDAO.getUser(userID);
		String userPr = user.getUserPr();
		String userName = user.getUserName();
		String userImg = user.getUserImg();
		String userEmail = user.getUserEmail();
		String userEmailAD = user.getUserEmailAD();
%>
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
        <form enctype="multipart/form-data" method="post" action="5_MYPAGEModify.jsp">
        <div class="rightcolumn">
            <div class="card">
                <h2>회원정보 수정</h2>
				<table>
                <tbody>
                    <tr id="profile">
                        <th scope="row">프로필</th>
                        <td>
                            <div class="profile_img">
                                <img src=<%=userImg%>>
                            </div>
                            <br>
                            <input type="file" accept="image/*" name="userImg" >
                        </td>
                    </tr>
                    <tr id="intro">
                        <th scope="row">자기소개</th>
                        <td><input type="text" name="userPr" value="<%=userPr%>"></td>
                    </tr>
                    <tr>
                        <th scope="row">닉네임</th>
                        <td>
                            <input type="text" name="userName" value=<%=userName%>>
                        </td>
                    </tr>
                    <tr>
                        <th scope="row">이메일</th>
                        <td>
                            <input type="text" name="userEmail" value=<%=userEmail%>>
                            <select name="userEmailAD">
                                <option value="@gmail.com" <%if(userEmailAD.equals("@gmail.com")){ %>selected<%} %>>@gmail.com</option>
                                <option value="@naver.com" <%if(userEmailAD.equals("@naver.com")){ %>selected<%} %>>@naver.com</option>
                                <option value="@daum.net" <%if(userEmailAD.equals("@daum.net")){ %>selected<%} %>>@daum.net</option>
                            </select>
                        </td>
                    </tr>
                </tbody>
            </table>
            <input type="submit" value="저장" id="save">
            <button name="leave" onclick="pwCheck()" 
            style="position:relative; top: 0px; left: 660px; font-size: 15px;">회원 탈퇴</button>
        	</div>
    	</div>
    	</form>
   	</div>
   	<%}%>
</body>
</html>