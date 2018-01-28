<%@ page language="java" contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
	<!-- 기본설정 -->
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="../resources/bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" href="../resources/css/custom.css">
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" ></script>
	<!-- 기본설정 끝 -->
	<script src="../resources/javascript/toolbar_opac.js"></script>
	<script src="../resources/javascript/custom.js"></script>
	
	<script src="http://ajax.googleapis.com/ajax/libs/jqueryui/1.8/jquery-ui.min.js"></script> 
	<script src="https://unpkg.com/masonry-layout@4/dist/masonry.pkgd.min.js"></script>
	
<style>
body{
	padding-top:0px;
}
header{
	background:url(../resources/images/unifiedsearch_creation.jpg) no-repeat center;
}
.parallax { 
    background-attachment: fixed;
    background-size: cover;
}
strong {
	color:rgba(82, 76, 76, 0.92);
}
.creation-hr {
    border: 2px solid #a2b2b1;

}
.content-hr {
    border: 1px solid #a2b2b1;

}
footer{
	margin-top: 60px;
}
#floatMenu {
	position: absolute;
	width: 200px;
	right: 8%;
	top: 600px;
	padding : 10px 20px 10px 20px;
	background-color: #a09aa2;
	color: rgb(246, 245, 247);
	transition: 0.5s;
}
.creation-img{
    background: center center;
    maring: 5px;
    width: 70px;
    height: 70px;
    object-fit:cover;
    border-radius: 50%;
    box-shadow: 3px 3px 3px rgba(128, 128, 128, 0.53);
}
.writing-title{
	text-align: center;
    width: 170px;
    height: 50px;
    padding: 5px;
}
.writing-img{
	background: center center;
    width: 170px;
    height: 130px;
}
.writing-total{
	width: 170px;
	margin: 30px;
    box-shadow: 2px 2px 2px 3px rgba(128, 128, 128, 0.53);
}
</style>
<script type="text/ecmascript">
document.onreadystatechange = function () {
	if (document.readyState == "complete") { 
		var container = document.querySelector('#content-view'); 
		var msnry = new Masonry(container);
	}
} 
</script> 
<script type="text/javascript">
	ToolbarOpacHeight(500);var floatPosition = parseInt($("#floatMenu").css('top'));
	
$(function() {
	$(window).scroll(function() {
		var scrollTop = $(window).scrollTop();
		console.log(scrollTop);
		if(scrollTop > 500){
			
			var newPosition = scrollTop + 200;
	
			$("#floatMenu").css("top" , newPosition);
		}
	})

	$(".nav-creation").on("click" , function() {
		var targetNo = this.getAttribute('id');
		$(self.location).attr("href","../creation/getWritingList?creationNo=" + targetNo);
	});
	$(".nav-writing").on("click" , function() {
		var targetNo = this.getAttribute('id');
		$(self.location).attr("href","../creation/getWriting?writingNo=" + targetNo);
	}); 
});
</script>

</head>

<body>
	<jsp:include page="../layout/toolbar.jsp" >
		<jsp:param value="../" name="uri"/>
	</jsp:include>
	<header class="parallax"></header>

	<div class="container">
		<div class="row" style="margin-top:50px">
			<font size="5"><strong>작품   "${search.keyword}" 에 대한 검색 결과 총  ${total}건 입니다. </strong></font>
		</div>   
		
		<div class="row">	
			<hr class="creation-hr">
		</div>

		<c:if test="${total == 0}">
			<div class="row" style="padding-left:50px;">
				<p>"${keyword}"에 대한 검색 결과가 없습니다.</p>
			</div>
		</c:if>
			
		<c:forEach items="${result}" var="result">
				<div class="row" style="margin-bottom:20px;">
					<div class="col-md-1">
						<img class="creation-img" src="../resources/upload_files/images/${result.image}" onerror="this.src='../resources/images/noimage.jpg'">
					</div>
					<div class="col-md-9">
						<div class="row nav-creation" style="padding-left:10px" id="${result.id}"><font size=5>${result.title}</font>  by ${result.nick_name}</div> 
						<div class="row" style="padding-left:10px"><p><c:forEach items="${result.tag}" var="tag" varStatus="status"><span class="tag">#${tag}</span> </c:forEach></div>
					</div>
					<div class="col-md-1">
						<div class="row">게시글 총 ${fn:length(result.writing)} 건</div>
					</div>
				</div>
					
				<div class="row" style="margin-left:10px;">
					<c:forEach items="${result.writing}" var="writing">
						<div class="col-md-3 nav-writing writing-total" id="${writing.writingNo}">
							<div class="row writing-title">
								${writing.writingTitle}
							</div>
							<div class="row">
								<img class="writing-img" src="../resources/upload_files/images/${writing.writingAuthor}" onerror="this.src='../resources/images/noimage.jpg'">
							</div>		
						</div>
					</c:forEach>
				</div>
			<hr class="content-hr">			
		</c:forEach>
  	</div>  	
  	<div id="floatMenu">
  		<div class="row" style="margin:10%;">
  			<strong>관련 태그</strong>
  		</div>
  	<c:if test="${fn:length(tagList) eq 0}">
  		<div class="row" style="margin:10%;">
  			관련 태그가 없습니다.
  		</div>
  	</c:if>
  		<c:forEach items="${tagList}" var="tag">
  			<div class="row" style="margin:10%;">
  				<span class="tag">#${tag}</span>
  			</div>
  		</c:forEach>
  	</div>
  	
   	<footer class="container-fluid">
		<jsp:include page="../layout/tailbar.jsp"/>
	</footer>
   </body>
</html>