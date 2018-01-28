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

<style>
body{
	padding-top:0px;
}
header{
	background:url(../resources/images/unifiedsearch_community.jpeg) no-repeat center;
}
.parallax { 
    background-attachment: fixed;
    background-size: cover;
}
.community-hr {
    border: 2px solid #56624b;
}
#content{
	border-left: 4px dashed #5c8350;
}
strong {
	color:rgba(82, 76, 76, 0.92);
}
#title-box{
	padding: 10px 5px 10px 10px; 
	height: 100px;
	background: #74B49B;
}
#tag-box{
	padding: 10px 15px 10px 15px;
	height: 100px;
	background: #D3F6D1;
}
.total-box{
	padding: 10px 35px 30px 35px;
	height: 240px; 
}
.content-img{
    background: center center;
    width: 70px;
    height: 70px;
    object-fit:cover;
    border-radius: 50%;
    box-shadow: 3px 3px 3px rgba(128, 128, 128, 0.53);
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
</style>
<script type="text/javascript">
	ToolbarOpacHeight(500);

	$(window).scroll(function() {
		var scrollTop = $(window).scrollTop();
		console.log(scrollTop);
		if(scrollTop > 500){
			
			var newPosition = scrollTop + 200;
	
			$("#floatMenu").css("top" , newPosition);
		}
	})
	
	$(function() {
		$(".nav-tag").on("click" , function() {
			var keyword = this.innerText.replace("#", "");
			$(self.location).attr("href","../unifiedsearch/getUnifiedsearchList?category=11&keyword="+keyword);
		});
		$(".nav-community").on("click" , function() {
			var targetNo = this.getAttribute('id');
			$(self.location).attr("href","../community/getBoard?boardNo=" + targetNo);
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
			<font size="5"><strong>게시판   "${search.keyword}" 에 대한 검색 결과 총  ${total}건 입니다. </strong></font>
		</div>  
		 
		<div class="row">	
			<hr class="community-hr">
		</div>
				
		<c:if test="${total == 0}">
			<div class="row" style="padding-left:50px;">
				<p>"${keyword}"에 대한 검색 결과가 없습니다.</p>
			</div>
		</c:if>
					
		<c:forEach items="${result}" var="result">
			<div class="col-md-3 total-box">
				<div class="row" id="title-box">
					<div class="col-md-7 col-xs-7 nav-community" style="padding: 5px;" id="${result.id}">
						<p><strong>${result.title}</strong></p>
						<div >${result.nick_name}</div>
					</div>
					<div class="col-md-5 col-xs-5"  style="padding-right: 0px;" align="right">
						<img class="content-img" src="${result.image}" onerror="this.src='../resources/images/noimage.jpg'">
					</div>
				</div>
				<div class="row" id="tag-box">
					<p><c:forEach items="${result.tag}" var="tag" varStatus="status"><span class="tag">#${tag}</span> </c:forEach></p>
				</div>
			</div>
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