<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel = "stylesheet" href = ".\css\recipe_zip.css">
    <link rel = "stylesheet" href = ".\css\2_LOGIN.css">
	<title>RECIPICK</title>
</head>
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
		        	<a href="2_LOGIN.jsp">로그인</a>
		        	<a href="3_POSTING.html">글쓰기</a>
	        	</div>
			</div>
		</div>
	</div>
	<div class="box">
        <div class="column">
            <img src="images/LOGIN.png">
            <form action="./2_LOGIN_Action.jsp" method="POST" name="loginform">
            <span id="register">회원이 아니신가요? <a href="2_REGISTER.jsp">회원가입하기</a></span>
                <div class="LOGIN__BOX">
                    <input id="username" type="text" name="userID" placeholder="아이디">
                    <label for="username">아이디</label>
                </div>
                <div class="LOGIN__BOX">
                    <input id="password" type="password" name="userPassword" placeholder="비밀번호">
                    <label for="password">비밀번호</label>
                </div>
                <input type="submit" value="로그인" onclick="loginCheck()">
            </form>
        </div>
    </div>
</body>
</html>