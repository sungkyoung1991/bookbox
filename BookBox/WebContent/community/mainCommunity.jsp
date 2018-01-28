<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"  %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="initial-scale=1.0, maximum-scale=1.0, width=device-width">
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" ></script>
	
	<script src="../resources/javascript/toolbar_opac.js"></script>
	<script src="../resources/javascript/custom.js"></script>
	
	
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" >
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" >

  	<link rel="stylesheet" href="../resources/bootstrap/css/bootstrap.min.css">
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
   			font-weight: 500;
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
   			width: 35px;
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
   		
   	/*============ 게시판 CSS==================*/
   		
   		/*게시판 v2 */
   		.board-item-v2{
   			height: 175px;
   			width:100%;

   			margin-top: 20px;
   			border-left: solid 10px #62BFAD;
   		}
   		.board-img-v2{
   			/*width: 220px;*/
   			height: 175px;
   			
   			margin: 0;
   			padding: 0 !important;
			overflow: hidden;   			
   		}
   		.board-img-v2 img{
   			height:100%;
   			width:100%;   	
   			transform:scale(1.0); 
   			transition: transform .35s; 	
   			object-fit:cover;
   		}
   		.board-img-v2 img:hover{
   			transform:scale(1.2); 
   			transition: transform .35s; 	
   			object-fit:cover;
   		}
   		
   		
   		.board-content-v2{
   			height: 165px;
   		
   			padding: 0 !important;
   			
   		}
   		.board-content-v2 .board-head-v2{
   			height: 30px;
   			background-color: #62BFAD;
   			/*background-color:floralwhite;*/
   			margin-left:0 !important;
   			color: floralwhite;
   			font-weight: 500;
   			font-size: 20px;
   			
   		}
   		.board-content-v2 .board-head-v2 div{
   			display: inline-block;
   		}
	   		.board-content-v2 .board-head-v2 .title{
	   			margin-left:20px; 
	   		}
	   		.board-content-v2 .board-head-v2 .comment-count{
	   			font-size: 13px;
	   		}
	   		
	   		.board-content-v2 .board-head-v2 .writer{
	   			margin-right:10px; 
	   		}
   		.board-content-v2 .board-body-v2{
   			height: 135px;
   		/*	background: linear-gradient( to bottom,floralwhite ,#ffffff00 );*/
   			/*background-color: floralwhite;*/
   		}
   				
		   		.board-content-v2 .board-body-v2 .date,.nickname{
		   			padding-top: 5px;
		   			height: 25px;
		   		}
		   		
		   		.board-content-v2 .board-body-v2 .nickname{
		   			padding-top: 5px;
		   			padding-left: 30px;
		   		}
		   		.board-content-v2 .board-body-v2 .nickname img{
		   			height: 16px;
		   			width: 16px;
		   			object-fit: cover;
		   			border-radius: 50%;
		   		}
		   		
		   		.board-content-v2 .board-body-v2 .regdate{
		   			overflow: hidden;
		   			max-height: 25px;
		   		}
		   		
		   		.board-content-v2 .board-body-v2 .content{
		   			height: 80px;
		   			overflow: hidden;
		   			line-height: 25px;
		   			padding-top: 5px;
		   			padding-left: 30px;
		   			padding-right: 30px;
		   		}
		   		.board-content-v2 .board-body-v2 .tag-list{
		   			padding-top: 10px;
		   			padding-left:20px; 
		   			height: 35px;
		   			/*background-color: floralwhite;*/
		   			overflow: hidden;
		   		}
   		
 
		
		.btn-create{
			margin: 10px 0 0 0;
			border: 1px solid;
	   		border-radius: 7px;
	   		padding: 8px;
			font-size: 20px;
			color: #777;
		}
		.btn-create img{
			height: 20px;
			margin-right: 5px;
		}
    </style>
    
    <script type="text/javascript">
    var condition;
	ToolbarOpacHeight(500);
    //채팅방 상세보기 이벤트
    $(function(){
   /* 
    	$(".room_item").on("click",function(){
    		//alert($("input",this).val())
    		self.location=$("input",this).val();
    	});
    */ 	
    	
    	$(".room_item .room-image").on("click",function(){
    		//alert($("input",this).val())
    		self.location=$(this).parent().find("input").val();
    	});
    
    	
    });
    
    $(function(){
    	//게시판 상세보기 이벤트	
    	 /* 
    	$(".board-item-v2").on("click",function(){
    		//alert($(this).html());
    		var boardNo=$(this).find(".boardNo").val();                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         
    		self.location="getBoard?boardNo="+boardNo;
    	})
    	 */
   	 	$(".board-item-v2 .board-head-v2").on("click",function(){
       		//alert($(this).html());
       		var boardNo=$(this).parent().parent().parent().parent().find(".boardNo").val();                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         
       		self.location="getBoard?boardNo="+boardNo;
       	});
    	 
    	$(".board-item-v2 .board-img-v2").on("click",function(){
        		//alert($(this).html());
        		var boardNo=$(this).parent().find(".boardNo").val();                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         
        		self.location="getBoard?boardNo="+boardNo;
        });
    	 ////////////////
    	$("#moreBoard").on("click",function(){
    		self.location="getBoardList";
    	})
    	
    	$("#moreCast").on("click",function(){
    		self.location="getCastList";
    	})
    	
    	$("#moreCamChat").on("click",function(){
    		self.location="getCamChatList";
    	})
    	
    
    
    });
    
    
    </script>
</head>
<body>

	<jsp:include page="../layout/toolbar.jsp" >
		<jsp:param value="../" name="uri"/>
	</jsp:include>
	<header class="parallax"></header>
	
		
	<div class="container">
		<div class="row">
			<br/><br/>
			<!-- 생성버튼 -->
			<div class="col-xs-12 text-left">
				<div class="" style="display: inline-block;">
					<a class="btn-create addChatRoomModal" data-toggle="modal" data-target="#addChatRoom">
						<img src="../resources/images/community/btn_cast.png">채팅방 생성
					</a>
				</div>
				<div class="" style="display: inline-block;">
				<!--  <a class="btn btn-default" href="addChatRoom">채팅방 생성</a> -->
					<a class="btn-create" href="addBoard">
						<img src="../resources/images/community/btn_board.png">게시글 작성
					</a>
				<!-- <a class="btn addBoardModal" data-toggle="modal" data-target="#addBoard">게시판 생성</a>-->
				</div>
			</div>
			<br>
			<!-- 생성버튼 끝 -->
			
			<!-- 검색부분 제거 -->
			<!-- 
		 	<form class="form-inline text-right col-md-6" action="getCommunityMain" method="get">
			  <div class="form-group">
			    <div class="input-group">
			      <div class="input-group-addon">
			      	<select class="form-control">
			      		<option>옵션</option>
			      	</select>
			      </div>
			      <input type="text" class="form-control" name="keyword" id="keyword" placeholder="검색어">
			  	 	<div class="input-group-addon">
			  			<button type="submit" class="btn">검색</button>
					</div>
			    </div>
			  </div>
			</form>
			 -->

		</div>
		<!--   ==================방송=========================     -->
		<div class="row" style="height: 70px;">
			<div class="col-xs-8">
				<h1>방송</h1> 
			</div>
			<div class="col-xs-4 text-right" style="height: 100%; vertical-align: bottom; display: table;">
				<a class="moreCast" id="moreCast" style="display: table-cell; vertical-align: bottom; ">더보기></a>
			</div>
		</div>
		<hr/>
		<div class="row">
			<c:forEach items="${castList}" var="room">
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
					
		<br/>
			<!--   ==================채팅방=========================     -->
		<div class="row" style="height: 70px;">
			<div class="col-xs-8">
				<h1>화상채팅</h1> 
			</div>
			<div class="col-xs-4 text-right" style="height: 100%; vertical-align: bottom; display: table;">
				<a class="moreChatChat" id="moreCamChat" style="display: table-cell; vertical-align: bottom; ">더보기></a>
			</div>
		</div>
		<hr/>
		<div class="row">
		<c:forEach items="${camChatList}" var="room">
			<!--  
			<div class="col-md-3 col-sm-4 col-xs-6">
			-->
				<div class="room_item room_item col-lg-3 col-md-4 col-sm-6">
					<input type="hidden" value="getCamChat?roomId=${room.roomId}">
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
		
		
		<br/>
		<div class="row" style="height: 70px;">
			<div class="col-xs-6">
				<h1>게시판</h1> 
			</div>
			<div class="col-xs-6 text-right" style="height: 100%; display: table;">
				<a class="moreBoard" href="getBoardList" style="display: table-cell; vertical-align: bottom; ">더보기></a>
			</div>
		</div>
		<hr/>
		
			<!--  게시글 v2 -->
			
				<c:forEach items="${ boardList }" var="board">
			
					<div class="board-item-v2 row">
						<input type="hidden" value="${board.boardNo }" class="boardNo">
						<div class="board-img-v2 col-xs-3">
							<c:if test="${empty board.thumbnailUrl}">
								<img src="../resources/images/community/noimage.png">
							</c:if>
							<c:if test="${!empty board.thumbnailUrl}">
								<img src="${board.thumbnailUrl}" onerror="this.src='../resources/images/community/noimage.png'">
							</c:if>
						</div>
						<div class="board-content-v2 col-xs-9">
							<div class="board-head-v2">
								<div class="title">${board.boardTitle}</div><div class="comment-count">[${board.commentCount}]</div>
							</div>
							<div class="board-body-v2">
								<div class="date text-right row">
									<div class="nickname col-xs-6 text-left">
										<img src="../resources/upload_files/images/${board.writer.booklogImage}" onerror="this.src='../resources/images/no_booklog_image.png'">
										<strong>${board.writer.nickname}</strong>
									</div>
									<div class="regdate col-xs-6">
										<strong>${board.boardRegDate}</strong>
									</div>
								</div>
								<!-- 
								<div class="nickname text-right">
									<img src="../resources/upload_files/${room.host.booklogImage}" onerror="this.src='../resources/images/no_booklog_image.png'">
									<strong>${board.writer.nickname}</strong>
								</div>
								 -->
								<div class="content">
									${board.contentText}
								</div>
								<div class="tag-list">
									<c:forEach items="${board.tagList}" var="tag" >
										<span class="tag">#${tag.tagName}</span>
									</c:forEach>
								</div>
							</div>
						</div>
					
					</div>
				</c:forEach>
		
		
		
			<div>
		
				
				
			</div>		
	
	</div>
	
	<div class="modal fade" id="addChatRoom" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
	  <div class="modal-dialog" role="document">
	    <div class="modal-content">
	      <div class="modal-header">
	        <h3 class="modal-title" id="exampleModalLabel">채팅방 생성</h3>
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
	          <span aria-hidden="true">&times;</span>
	        </button>
	      </div>
	      <div class="modal-body">
	       	<jsp:include page="addChatRoomViewModal.jsp"></jsp:include>
	      </div>
	      <div class="modal-footer">
	        <button class="submit addChatRoom btn prime-btn">생성</button>
	        <button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
	      </div>
	    </div>
	  </div>
	</div>
	
	
	<div class="modal fade" id="addBoard" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
	  <div class="modal-dialog" role="document">
	    <div class="modal-content">
	      <div class="modal-header">
	        <h4 class="modal-title" id="exampleModalLabel">게시글 생성</h4>
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
	          <span aria-hidden="true">&times;</span>
	        </button>
	      </div>
	      <div class="modal-body">
	       	<jsp:include page="addBoardViewModal.jsp"></jsp:include>
	      </div>
	      <div class="modal-footer">
	        <button class="submit addBoard btn prime-btn">생성</button>
	        <button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
	      </div>
	    </div>
	  </div>
	</div>
	
	
	<footer class="container-fluid">
		<jsp:include page="../layout/tailbar.jsp"/>
	</footer>
</body>
</html>