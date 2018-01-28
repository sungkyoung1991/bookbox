<%@ page language="java" contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
	<!-- 기본설정 -->
    <meta charset="utf-8">
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
    		position: relative;
    		background: url(../resources/upload_files/images/${empty mainFile? '../../images/posting_noimage.jpeg':mainFile.fileName}) no-repeat center;
    	}
    	.posting-title{
    		position: absolute;
    		padding: 0 25px;
    		width: 100%;
    		top: 80%;
    		left: 50%;
    		background: rgba(238, 238, 238, 0.25);
    		color: #112D42;
    		-webkit-transform: translate(-50%, -50%);
    		   -moz-transform: translate(-50%, -50%);
    				transform: translate(-50%, -50%);
    	}
    	.posting-title h2{
    		font-family: NanumPen, Roboto, 'Helvetica Neue', Helvetica, Arial, sans-serif;
    	}
    	.posting-title p{
    		font-family: NanumGothic, Roboto, 'Helvetica Neue', Helvetica, Arial, sans-serif;
    	}
    	.posting-list{
    		position: relative !important
    	}
	</style>

	<script type="text/javascript">
		var condition;
		var keyword;
		ToolbarOpacHeight(500);
		$(function(){
			condition = $('input[name="condition"]').val();
			keyword = $('input[name="keyword"]').val();
			
			$('.btn-form.posting-list:contains("목록")').on('click',function(){
				$(self.location).attr('href','../booklog/getPostingList?condition='+condition+'&keyword='+keyword);
			});
			$('.btn-form.posting-update:contains("수정")').on('click',function(){
				$(self.location).attr('href','../booklog/updatePosting?postingNo='+$('input[name="postingNo"]').val());
			});
		});
	</script>
</head>
<body>
	<jsp:include page="../layout/toolbar.jsp" >
		<jsp:param value="../" name="uri"/>
	</jsp:include>
	<header class="parallax">
		<div class="posting-title text-center">
			<input type="hidden" name="postingNo" value="${posting.postingNo}">
			<h2 class="booklog-font-color" style="font-weight: bold;"><em>${posting.postingTitle}</em></h2>
			<p><strong>by ${posting.user.nickname}</strong></p>
		</div>
	</header>
	
	<!-- 여기부터 코딩 -->
	
	<div class="container booklog-background" style="padding: 30px; overflow-x: scroll;">
		<div class="row">
			<div class="col-sm-offset-1 col-sm-10">
				<p>조회수 : ${posting.viewCount}, 작성일 : ${posting.postingRegDate}</p>
				${posting.postingContent} <br/><br/>
				<c:forEach items="${posting.postingTagList}" var="tag" >
					<span class="tag">#${tag.tagName}</span> 
				</c:forEach>
			</div>
		</div>
	</div>
	<div class="container">
		<input type="hidden" name="condition" value="${search.condition}">
		<input type="hidden" name="keyword" value="${search.keyword}">
		<div class="row" style="margin: 15px;">
			<div class="col-xs-4 col-md-3 text-center">
				<div class="btn-form posting-list">목록</div>
			</div>
			<div class="col-xs-offset-4 col-xs-4 col-md-offset-6 col-md-3 text-center">
				<c:if test="${sessionScope.user.email == posting.user.email}">
					<div class="btn-form posting-update">수정</div>
				</c:if>
			</div>
		</div>
	</div>
	
	<div style="height: 300px;"></div>

	<footer class="container-fluid">
		<jsp:include page="../layout/tailbar.jsp"/>
	</footer>
	
</body>
</html>