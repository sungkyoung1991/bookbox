<%@ page language="java" contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="initial-scale=1.0; maximum-scale=1.0; width=device-width;">
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" >
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" >
	
	
	<script src="../resources/javascript/toolbar_opac.js"></script>
	<script src="../resources/javascript/custom.js"></script>
	
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" ></script>
    <script src="../resources/javascript/toolbar_opac.js"></script>
    
    
    <link rel="stylesheet" href="../resources/css/custom.css">
    
    
	<style>
   			body{
    		padding-top:0px !important;
    	}
    	header{
    		background:url(../resources/images/community.jpeg) no-repeat center;
    	}
	
   		.room_item{
   			height: 460px;
 			/*border: 1px solid red;*/
 			margin: 10px 0 0 0;
   		/*	width: 250px; */
   		/*	border: solid 2px #62BFAD; */
   		/*	display: inline-block;       */
   		/*	box-shadow: 3px 3px 3px #62BFAD; */
   			/*margin: 10px;*/
   		}
   		.room_item .room-user{
   			/*
   			height: 45%;
   			*/
   			padding-bottom: 3px;
   			padding-left: 5px;
   			border-bottom: solid 10px #62BFAD;
   			overflow: hidden;
   			height: 40px;
   			font-size: 17px;
   		}
		   		.room_item .room-user img{
		   			height: 70%;
		   		}
   		.room_item .room-image{
   			/*
   			height: 45%;
   			*/
   			/*border-top: solid 10px #62BFAD;*/
   			overflow: hidden;
   			height: 200px;
   		}
   		.room_item .room-image img{
   			/*
   			*/
   			height: 100%;
   			/*width:250px;*/
   			width:100%;
   			object-fit: cover;
   			/*background-color: #F9F7E8;*/
   			
   			transform:scale(1.0); 
   			transition: transform .35s; 
   			
   		}
   		
   		.room_item .room-image img:hover{
   			transform:scale(1.3); 
   			transition: transform .35s; 	
   		}
   		
   		.room_item .content{
   			/*background-color: #F9F7E8;*/
			/*
   			height: 55%;
   			*/
   			height: 220px;
   			overflow: hidden;
   			text-overflow:ellipsis;
   			width: 100%;
   		}
   		.room_item .content div {
   			text-overflow:ellipsis;
   			width: 100%;
   			margin: 0;
   			
   		}
   		.room_item .content .content-titlee{
   			height: 35px;		
   			background-color: 	#62BFAD;
   			color:floralwhite;
   			font-weight: bold;
   			overflow: hidden;
   			font-size: 25px;
   			
   		}
   		.room_item .content .content-nickname{
   			height: 40px;
   			padding-right: 10px;
   			padding-top: 5px;
   		}
   		.room_item .content .content-nickname img{
   			height: 35px;
   			object-fit: cover;
   			border-radius: 50%;
   		}
   		.room_item .content .content-content{
   			padding : 5px 10px 5px 10px;
   			height: 110px;
   			overflow: hidden;
   			
   		}
   		.room_item .content .content-user{
   			height: 25px;
   			padding-left: 10px;
   		}
   		.room_item .content .content-tag{
   			height: 25px;
   			padding-left: 10px;
   		}
    </style>
    <script type="text/javascript">
	    var condition;
		ToolbarOpacHeight(500);
    </script>
</head>
<body>
	<jsp:include page="../layout/toolbar.jsp" >
		<jsp:param value="../" name="uri"/>
	</jsp:include>
	<header class="parallax"></header>
	<div class="container">	
	
		<div class="row">
			 <div class="col-md-6 text-left">
			 				<!-- 
							<p class="paging">전체 ${page.totalCount } 건수, 현재
							${page.currentPage} 페이지</p>
			 				 -->
			 				 <p class="paging">전체 ${page.totalCount } 건수</p>
			</div>
			<div class="col-md-6 col-xs-hidden" style="text-align: right;">
	
				<span class="check recent-list" >
					<input type="hidden" value="0">
					<c:if test="${search.order==0 }">
						<img src="https://icongr.am/entypo/check.svg?size=20px">
					</c:if>
					<c:if test="${search.order!=0 }">
						<img src="https://icongr.am/entypo/check.svg?size=20px&color=bbbbbb">
					</c:if>
				최신</span>
				<span class="check enddate-list">
					<input type="hidden" value="1">
					<c:if test="${search.order==1 }">
						<img src="https://icongr.am/entypo/check.svg?size=20px">
					</c:if>
					<c:if test="${search.order!=1 }">
						<img src="https://icongr.am/entypo/check.svg?size=20px&color=bbbbbb">
					</c:if>
					인기</span>
			</div>
		 </div>
	
		<div class="row" style="height: 70px;">
				<div class="col-xs-6">
					<h1>화상채팅</h1> 
				</div>
				<div class="col-xs-6 text-right" style="height: 100%; vertical-align: bottom; display: table;">
				</div>
			</div>
			<hr/>
			<div class="row">
				<c:forEach items="${camChatList}" var="room">
				<!--  
				<div class="col-md-3 col-sm-4 col-xs-6">
				-->
					<div class="room_item room_item col-lg-3 col-md-4 col-sm-6">
						<input type="hidden" value="getCast?roomId=${room.roomId}">
						<div class="room-user"><img src="../resources/images/community/person2.png">${ room.currentUser }/${ room.maxUser }</div>
						<div class="room-image text-center">
							<c:if test="${empty room.image }">
								<img src="../resources/images/community/noimage.png">
							</c:if>
							<c:if test="${!empty room.image }">
								<img src="${room.image}">
							</c:if>
						</div>
						<div class="content">
							<div class="content-titlee text-center">${room.title}</div>
							<div class="content-nickname text-right">
								<img src="../resources/upload_files/images/${room.host.booklogImage}" onerror="this.src='../resources/images/no_booklog_image.png'">
								<strong>${room.host.nickname}</strong>
							</div>
							<div class="content-content">${room.content}</div>
							<div class="content-tag">
							<c:forEach items="${room.tagList}" var="tag">
								<span class="tag">#${tag.tagName}</span>
							</c:forEach>
							</div>
						</div>
					 </div>			
				<!-- 
				</div>
				 -->	
			</c:forEach>
			</div>
	</div>
	
	<footer class="container-fluid">
		<jsp:include page="../layout/tailbar.jsp"/>
	</footer>
</body>
</html>