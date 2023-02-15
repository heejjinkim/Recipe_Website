<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
	<!--          meta 선언          -->
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    
    <!--          link 선언          -->
    <link rel = "stylesheet" href = ".\css\recipe_zip.css">
    <link rel = "stylesheet" href = ".\css\2_REGISTER.css">
    <script src="https://code.jquery.com/jQuery-3.6.0.js"></script>
    <script>
    $(document).ready(function() {
		$("#dupl").click(function () {
			var id = $("#id").val();
			$.ajax({
				type: "POST",
				url: "2_REGISTER_Idchk.jsp",
				data: {'id' : id},
				dataType: 'text',
				success: function(result) {
					if(result.charAt(0) == '0') {
						$("#message").text("아이디는 6자리 이상 20자리 이하로 입력 가능합니다.");
						$("#message").css("color", "red");
					} else if(result.charAt(0) == '1') {
						$("#message").text("이미 아이디가 존재합니다.");
						$("#message").css("color", "red");
					} else if (result.charAt(0) == '2') {
						$("#message").text("사용가능한 아이디입니다.");
						$("#message").css("color", "green");
						$("input[name=idDupChk]").val('t');
						$("input[name=idDupChk]").prop('readonly', true);
					}
				}
			})
		})
		
		$("#chkSub").click(function() {
			var form = document.loginform;

			if($("#id").val().length < 6 || $("#id").val().length > 20) {
				alert("아이디는 6자리 이상 20자리 이하로 입력 가능합니다.");
				$("input[name=loginChk]").val('f');
	    		return false;
			}
	    	if($("#password").val().length < 8 || $("#password").val().length > 20){
	    		alert("비밀번호는 8자리 이상 20자리 이하로 입력 가능합니다.");
	    		$("input[name=loginChk]").val('f');
	    		return false;
	    	}
	    	if($("#pwCk").val() != $("#password").val()){
	    		alert("비밀번호가 틀립니다.");
	    		$("input[name=loginChk]").val('f');
	    		return false;
	    	}
	    	if($("#userName").val().length == 0) {
	    		alert("닉네임을 입력해주세요.");
	    		$("input[name=loginChk]").val('f');
	    		return false;
	    	}
	    	if($("#userName").val().length > 8) {
	    		alert("닉네임은 1자리 이상 8자리 이하로 입력 가능합니다.");
	    		$("input[name=loginChk]").val('f');
	    		return false;
	    	}
	    	if($("#userEmail").val().length == 0) {
	    		alert("이메일을 입력해주세요.");
	    		$("input[name=loginChk]").val('f');
	    		return false;
	    	}
	    	$("input[name=loginChk]").val('t');
	    	
			//모두 테스트 통과 시 submit 처리
			form.submit();
		})
	});
    </script>

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
			        <a href="3_POSTING.jsp">글쓰기</a>
	        	</div>
		    </div>
	    </div>
    </div>
    <div class="box">
        <div class="column">
            <img src="images/REGISTER.png">
            <form action="./2_REGISTER_Action.jsp" method="POST" name="loginform">
                <div class="REG__BOX">
                	<span id="message" style="font-size: 13px;"></span>
                    <input type="text" name="userID" id="id" placeholder="아이디 입력(6~20자)"/>
                    <input type="button" id="dupl" name="checkuserID" value="중복확인">
                    <input type="hidden" name="idDupChk" value="f"/>
                </div>
                <div class="REG__BOX">
                    <input type="password" id="password" name="userPassword" placeholder="비밀번호 입력(문자, 숫자, 특수문자 포함 8~20자)"/>
                </div>
                <div class="REG__BOX">
                    <input type="password" id="pwCk" placeholder="비밀번호 확인"/>
                </div>
                <div class="REG__BOX">
                    <input type="text" id="userName" name="userName" placeholder="닉네임 입력(1~8자)"/>
                </div>
                <div class="REG__BOX">
                    <input type="text" id="userEmail" name="userEmail" placeholder="이메일 입력"/>
                    <select name="userEmailAD">
	                       <option value="@gmail.com">@gmail.com</option>
	                       <option value="@naver.com">@naver.com</option>
	                       <option value="@daum.net">@daum.net</option>
                    </select>
                </div>
                <input type="hidden" name="loginChk" value="f"/>
                <input type="submit" value="가입" id="chkSub">
            </form>
        </div>
    </div>
</body>
</html>