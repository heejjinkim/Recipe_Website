<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="step.*"%>
<%@ page import="bbs.*"%>
<%@ page import="java.util.ArrayList"%>
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
<%
	String userID = null;
	if (session.getAttribute("userID") != null) {
		userID = (String) session.getAttribute("userID");
	}
	if (userID == null) {
	PrintWriter script = response.getWriter();
	script.println("<script>");
	script.println("alert('로그인을 하세요.')");
	script.println("location.href = '2_LOGIN.jsp'");
	script.println("</script>");
	} 
	int boardID = 0;
	if (request.getParameter("boardID") != null){
		boardID = Integer.parseInt(request.getParameter("boardID"));
	}
	if (boardID == 0) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('유효하지 않은 글 입니다.')");
		script.println("history.back()");
		script.println("</script>");
	
	}
	
	BbsDTO bbsDTO = new BbsDAO().getBbs(boardID);
	if (!userID.equals(bbsDTO.getUserID())) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('권한이 없습니다.')");
		script.println("history.back()");
		script.println("</script>");				
	}
	
	StepDAO stepDAO = new StepDAO();
	String theme = bbsDTO.getTheme();
	String sort = bbsDTO.getSort();
	String ingredient = bbsDTO.getIngredient();
	String thumb = bbsDTO.getThumb();
	String ingList = bbsDTO.getIngList();
	String title = bbsDTO.getTitle();
	String intro = bbsDTO.getIntro();
%>
<script>
	var cnt = <%=stepDAO.getMaxStep(boardID)%>;
	
	function formpost() {
		var form = document.getElementById("form1");
		var url = "3_MODIFY_Action.jsp?cnt=" + cnt + "&&boardID=" + <%=boardID%>;
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
   		//console.log("input:" + input.name);
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
            <h2>레시피 수정</h2>
            <span class="text" id="recipeTitle">레시피 제목</span> 
            <textarea id="title" name="title" rows="1" cols="83"><%=title %></textarea><br>
            <span class="text" id="recipeIntro">레시피 소개</span> 
            <textarea id="intro" name="intro" rows="7" cols="83"><%=intro %></textarea><br>
            <span class="text" id="recipeCategory">카테고리</span>
            <div id="category">
                <select name="theme">
                    <option <%if(theme == null){ %>selected<%} %>>--주제별--</option>
                    <option <%if(theme.equals("한식")){ %>selected<%} %>>한식</option>
                    <option <%if(theme.equals("중식")){ %>selected<%} %>>중식</option>
                    <option <%if(theme.equals("양식")){ %>selected<%} %>>양식</option>
                    <option <%if(theme.equals("일식")){ %>selected<%} %>>일식</option>
                    <option <%if(theme.equals("동남아식")){ %>selected<%} %>>동남아식</option><option>기타</option>
                </select> 
                <select name="sort">
                    <option <%if(sort == null){ %>selected<%} %>>--종류별--</option>
                    <option <%if(sort.equals("국/탕")){ %>selected<%} %>>국/탕</option>
                    <option <%if(sort.equals("밑반찬")){ %>selected<%} %>>밑반찬</option>
                    <option <%if(sort.equals("메인반찬")){ %>selected<%} %>>메인반찬</option>
                    <option <%if(sort.equals("디저트")){ %>selected<%} %>>디저트</option>
                    <option <%if(sort.equals("면")){ %>selected<%} %>>면</option>
                    <option <%if(sort.equals("기타")){ %>selected<%} %>>기타</option>
                </select>
                <select name="ingredient">
                    <option <%if(ingredient == null){ %>selected<%} %>>--재료별--</option>
                    <option <%if(ingredient.equals("육류")){ %>selected<%} %>>육류</option>
                    <option <%if(ingredient.equals("채소류")){ %>selected<%} %>>채소류</option>
                    <option <%if(ingredient.equals("해물류")){ %>selected<%} %>>해물류</option>
                    <option <%if(ingredient.equals("달걀")){ %>selected<%} %>>달걀</option>
                    <option <%if(ingredient.equals("가공식품")){ %>selected<%} %>>가공식품</option>
                    <option <%if(ingredient.equals("기타")){ %>selected<%} %>>기타</option>
                </select>
                </div>
                <div class="upload" style="left: 850px">
                    <img src=<%=thumb%> id="thumb" class="preview" /><br>
                    <input type="file" accept="imgae/*" name="thumb" onchange="readURL(this);">
                </div>
        </div>
        <div class="column">
            <span id="ingredien"><B>재료</B></span>
			<textarea id="ing" name="ingList" rows="1" cols="83" ><%=ingList %></textarea><br>
			
            <span id="recipe"><B>Recipe</B></span>
			<div class="steps">
			<%
				ArrayList<StepDTO> stepList = stepDAO.getStepList(boardID);
				for(int i=0; i<stepList.size(); i++){	
			%>
	            <div class="step">
		            <textarea class="content" name="step" rows="11" cols="83" ><%=stepList.get(i).getStepContent()%></textarea>
	             	<div class="upload">
	             		<img src=<%=stepList.get(i).getImageFile()%> id=<%="step"+(i+1)%> class="preview"/><br>
		            	<input type="file" accept="image/*" name=<%="stepImg"+(i+1)%> onchange="readURL(this);">
		            </div>
            	</div>
            <%} %>
            </div>
            
            <button id="order" type="button" onclick="addStep()">+ Step</button>
            <button id="reOrder" type="button" onclick="removeStep()">- Step</button>
            <div class="but">
	            <input type="reset" class="btn" value="원래대로">
		        <input type="button" value="저장" class="btn" onclick="formpost()">
		        <button class="btn" onclick="location.href='1_MAINPAGE.jsp' ">취소</button>
            </div>
        </div>
   	</div>
   	</form>
</body>
</html>