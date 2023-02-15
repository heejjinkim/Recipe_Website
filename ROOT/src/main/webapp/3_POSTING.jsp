<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="java.io.PrintWriter" %>
    
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>RECIPICK</title>
    <link rel = "stylesheet" href = ".\css\recipe_zip.css">
    <link rel = "stylesheet" href = ".\css\3_POSTING.css?adsc">
</head>
<script>
	var cnt = 1;
	
	function formpost() {
		var form = document.getElementById("form1");
		var url = "3_POSTInsert.jsp?cnt=" + cnt;
		form.action = url;
		form.submit();
	}
	
   	function addStep() {
   		cnt++;
   		
   		var br = document.createElement("br");
   		var imgFile = document.createElement("input");
   		var obj = document.querySelector(".steps");
   		var stepDiv = document.createElement("div");
        var newStep = document.createElement("textarea");
        var uploadbox = document.createElement("div");
        var newImg = document.createElement("img");
		var add = document.getElementById("order");
		var rem = document.getElementById("reOrder");
		
   		imgFile.setAttribute("type", "file");
   		imgFile.setAttribute("name", "stepImg"+cnt);
        imgFile.setAttribute("onchange", "readURL(this);");
		
        newImg.setAttribute("id", "step"+cnt);
        newImg.classList.add("preview");
 
        uploadbox.classList.add("upload");
        uploadbox.appendChild(newImg);
        uploadbox.appendChild(br);
        uploadbox.appendChild(imgFile);

        newStep.setAttribute("rows", 11);
        newStep.setAttribute("cols", 83);
        newStep.setAttribute("name", "step");
        newStep.setAttribute("class", "content");

   		stepDiv.classList.add("step");
		stepDiv.appendChild(newStep);
		stepDiv.appendChild(uploadbox);
       	obj.appendChild(stepDiv);
   	}
   	
   	function removeStep() {
   		if(cnt == 1);
   		else {
   			cnt--;
	   		var obj = document.querySelector(".steps");
	   		var step = document.getElementsByClassName("step");
	   		var lastStep = step.item(step.length-1);
	   		lastStep.remove();
   		}
   	}
   	
   	function readURL(input) { //사진 미리보기
   	  if (input.files && input.files[0]) {
   		var inputName = input.name;
   	    var reader = new FileReader();
   	    reader.onload = function(e) {
   	    	if(inputName == "thumb"){ //thumb 사진
	   	      document.getElementById('thumb').src = e.target.result;   	    		
   	    	}
   	    	else{ //step에 대한 사진
   	    		var stepNum = inputName.substr(7, inputName.length);
   	    		console.log("stepNum: " + stepNum);
   	    		document.getElementById('step'+stepNum).src = e.target.result;
   	    	}
   	    };
   	    reader.readAsDataURL(input.files[0]);
   	  } else {
   	    document.getElementById('thumb').src = "";
   	  }
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
		        	<%
					if(userID == null){		//로그인이 되어있지 않은 경우
					%><a href="2_LOGIN.jsp">로그인</a><% 
					} else {%><a href="2_LOGOUT.jsp">로그아웃</a><%}%>
			        <a href="3_POSTING.jsp">글쓰기</a>
	        	</div>
		    </div>
	    </div>
    </div>
    
	<form id="form1" method="post" enctype="multipart/form-data" onsubmit="return false;">
    <div class="box">
        <div class="column">
            <h2>레시피 등록</h2>
            <span class="text" id="recipeTitle">레시피 제목</span> 
            <textarea id="title" name="title" rows="1" cols="83"></textarea><br>
            <span class="text" id="recipeIntro">레시피 소개</span> 
            <textarea id="intro" name="intro" rows="7" cols="83"></textarea><br>
            <span class="text" id="recipeCategory">카테고리</span>
            <div id="category">
                <select name="theme">
                    <option selected>--주제별--</option>
                    <option>한식</option><option>중식</option>
                    <option>양식</option><option>일식</option>
                    <option>동남아식</option><option>기타</option>
                </select> 
                <select name="sort">
                    <option selected>--종류별--</option>
                    <option>국/탕</option><option>밑반찬</option>
                    <option>메인반찬</option><option>디저트</option>
                    <option>면</option><option>기타</option>
                </select>
                <select name="ingredient">
                    <option selected>--재료별--</option>
                    <option>육류</option><option>채소류</option>
                    <option>해물류</option><option>달걀</option>
                    <option>가공식품</option><option>기타</option>
                </select>
                </div>
                <div class="upload" style="left: 850px">
                    <img id="thumb" class="preview"/><br>
                    <input type="file" accept="imgae/*" name="thumb" onchange="readURL(this);">
                </div>
        </div>
        <div class="column">
            <span id="ingredien"><B>재료</B></span>
			<textarea id="ing" name="ingList" rows="1" cols="83" ></textarea><br>
			
            <span id="recipe"><B>Recipe</B></span>
			<div class="steps">
	            <div class="step">
		            <textarea class="content" name="step" rows="11" cols="83" ></textarea>
	             	<div class="upload">
	             		<img id="step1" class="preview"/><br>
		            	<input type="file" accept="image/*" name="stepImg1" onchange="readURL(this);">
		            </div>
            	</div>
            </div>
            
            <button id="order" type="button" onclick="addStep()">+ Step</button>
            <button id="reOrder" type="button" onclick="removeStep()">- Step</button>
            <div class="but">
	            <input type="reset" class="btn" value="다시쓰기">
		        <input type="button" value="게시" class="btn" onclick="formpost()">
		        <button class="btn" onclick="location.href='1_MAINPAGE.jsp' ">취소</button>
            </div>
        </div>
   	</div>
   	</form>
   	 <%} %>
</body>
</html>