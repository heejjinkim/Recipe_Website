<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>RECIPICK</title>
    <link rel = "stylesheet" href = ".\css\recipe_zip.css">
    <link rel = "stylesheet" href = ".\css\5_PW.css">
    <script>
    function chkSubmit(){
    	//id 체크 정규식 : 숫자, 영문만 입력 가능 
    	var form = document.pwform;
		const prePassword = document.getElementById('prePassword').value;
		const userPassword = document.getElementById('userPassword').value;
		const userPassword2 = document.getElementById('userPassword2').value;
    	if(userPassword.length<8||userPassword.length>20){
    		alert("비밀번호는 8자리 이상 20자리 이하로 입력 가능합니다.");
    		document.pwform.pwChk.value = 'f';
    		return;
    	}
    	if(userPassword!=userPassword2){
    		alert("비밀번호가 틀립니다.");
    		document.pwform.pwChk.value = 'f';
    		return;
    	}
    	document.pwform.pwChk.value = 't';
		//모두 테스트 통과 시 submit 처리
		form.submit();
    }
    
    </script>
</head>
<%
	String userID = null;
	if(session.getAttribute("userID") != null){
		userID = (String) session.getAttribute("userID");
	}
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
            <div class="sub_title">
                <h2>비밀번호 변경</h2>
            </div>
            <br><br>       
            <div class="PWD_header">※주기적인 비밀번호 변경을 통해 개인정보를 안전하게 보호하세요</div>
            <br><br>
            <form action="./2_PW_Action.jsp" method="POST" name="pwform">
                <div class="PW__BOX">
                    <input type="password" name="prePassword" id="prePassword">
                    <label>현재 비밀번호</label>
                </div>   
                <div class="PW__BOX">
                    <input type="password" name="userPassword" id="userPassword">
                    <label>새 비밀번호</label>
                </div>
                <div class="PW__BOX">
                    <input type="password" name="userPassword2" id="userPassword2">
                    <label>새 비밀번호 확인</label>
                </div>
                 <input type="hidden" name="pwChk" value="f"/>
                <input type="submit" value="비밀번호 저장" onclick="return chkSubmit()">
            </form>
            </div>
        </div>
    </div>
</body>
</html>