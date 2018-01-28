<%@ page language="java" contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="initial-scale=1.0, maximum-scale=1.0, width=device-width">
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" >
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" >
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" ></script>
   
  	<script src="../resources/javascript/toolbar_opac.js"></script>
	<script src="../resources/javascript/custom.js"></script>
   
  	<script src="../resources/javascript/toolbar_opac.js"></script>
   
   <link rel="stylesheet" href="../resources/css/custom.css">
	
	<style>
		/*======공통============*/
		body{
    		padding-top:0px;
    	}
    	header{
    		background:url(../resources/images/community.jpeg) no-repeat center;
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
   			font-weight: bold;
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
		   		
		   		.board-content-v2 .board-body-v2 .content{
		   			height: 80px;
		   			overflow: hidden;
		   			line-height: 25px;
		   			padding-top: 5px;
		   			padding-left: 20px;
		   			padding-right: 20px;
		   		}
		   		.board-content-v2 .board-body-v2 .tag-list{
		   			padding-top: 10px;
		   			padding-left:20px; 
		   			height: 35px;
		   			/*background-color: floralwhite;*/
		   			overflow: hidden;
		   		}
		   		
	#loadingImg{
		display: none;
	}
    </style>
    <script type="text/javascript">
    var condition;
	ToolbarOpacHeight(500);
    
	$(function(){
		$(".board-item-v2").on("click",function(){
			self.location="getBoard?boardNo="+$(this).find(".boardNo").val();
		});
		
		//정렬순서 클릭이벤트
		$("span.check").on("click",function(){
			self.location="getBoardList?order="+$("input",this).val();
		});
		
	});
	
	
	
	var maxHeight=0;
	var currentHeight=0;
	var enableLoad=true;
    	$(function(){
    		$(".board_item").on("click",function(){
    			self.location="getBoard?boardNo="+$(this).find(".boardNo").val();
    			
    		});
    		
    		//무한스크롤
			$(window).scroll(function(){
				
				maxHeight=$(document).height();
				currentHeight=$(window).scrollTop()+$(window).height();
				//console.log("maxHeight"+maxHeight);
				//console.log("currentHeight"+currentHeight);
				
				if(maxHeight<=currentHeight && enableLoad){
					
					
					enableLoad=false; //로딩중 재 이벤트방지
				
					var currentPage=parseInt($("#currentPage").val());
					
				
					var maxPage=$("#maxPage").val();
					
					if(currentPage>=maxPage){  //현재페이지가 끝페이지일때 요청보내지않음
						return;
					}
					//요청 시작
					currentPage+=1;
					$("#currentPage").val(currentPage);
					var condition=$("#condition").val();
					var keyword=$("#keyword").val();
					var order=$("#order").val();
					
					$("#loadingImg").css("display","initial"); //로딩 이미지 출력
					console.log("requestPage"+currentPage);
					console.log("eventON!!!!");
					$.ajax({
						url:"rest/getBoardList",
						method: "post",
						dataType: "JSON",
						data:{condition: condition,
								keyword: keyword,
								order: order,
								currentPage: currentPage},
						success:function(data){
							console.log(data);
							enableLoad=true; //로딩가능상태로 변경
								
							var dataObj;
							//받은 정보 화면에 출력
							for(var i=0;i<data.boardList.length;i++){
							dataObj=data.boardList[i];
							var appendHtml=		
										"<div class=\"board-item-v2 row\">"+
											"<input type=\"hidden\" value=\""+dataObj.boardNo+ "\" class=\"boardNo\">"+
											"<div class=\"board-img-v2 col-xs-3\">"+
												"<img src=\""+dataObj.thumbnailUrl+"\" onerror=\"this.src='../resources/images/community/noimage.png'\">"+
											"</div>"+
											"<div class=\"board-content-v2 col-xs-9\">"+
												"<div class=\"board-head-v2\">"+
													"<div class=\"title\">"+dataObj.boardTitle+"</div>"+"<div class=\"comment-count\">["+dataObj.commentCount+"]</div>"+
												"</div>"+
												"<div class=\"board-body-v2\">"+
													"<div class=\"date text-right row\">"+
														"<div class=\"nickname col-xs-6 text-left\">"+
															"<img src=\"../resources/upload_files/images/"+dataObj.writer.booklogImage+"\" onerror=\"this.src='../resources/images/no_booklog_image.png'\">"+
															"<strong>"+dataObj.writer.nickname+"</strong>"+
														"</div>"+
														"<div class=\"col-xs-6\">"+
															"<strong>"+dataObj.boardRegDate+"</strong>"+
														"</div>"+
													"</div>"+
											
													"<div class=\"content\">"+
													dataObj.contentText+
													"</div>"+
													"<div class=\"tag-list\">";
													for(var j=0;j<dataObj.tagList.length;j++){
														appendHtml+="<span class=\"tag\">#"+ dataObj.tagList[j].tagName+"</span>";
													}
									appendHtml+=
													"</div>"+
												"</div>"+
											"</div>"+
										"</div>";
							
								var appendObj=$(appendHtml);
								
								//클릭이벤트
								appendObj.on("click",function(){
									self.location="getBoard?boardNo="+$(this).find(".boardNo").val();
								});
								//alert(appendObj);
								$(".board-list").append(appendObj);
							}
							//출력끝
							
							$("#loadingImg").css("display","none"); //로딩이미지 숨김
							
						}
						
					});
					
				}
			});    		
    		
    	})
    </script>
</head>
<body>
	<jsp:include page="../layout/toolbar.jsp" >
		<jsp:param value="../" name="uri"/>
	</jsp:include>
	<header class="parallax"></header>
	
	<div class="container">
	<!--  검색창 사라질 가능성 
		<form class="form-inline text-right">
		  <div class="form-group">
		    <div class="input-group">
		      <div class="input-group-addon">
		      	<select class="form-control">
		      		<option value='0'>제목</option>
		      		<option value='1'>닉네임</option>
		      		<option value='2'>태그</option>
		      	</select>
		      </div>
		      <input type="text" class="form-control" id="keyword" placeholder="검색어">
		  	 	<div class="input-group-addon">
		  			<button type="submit" class="btn">검색</button>
				</div>
		    </div>
		  </div>
		</form>
	 -->
	 	<br/>
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
				<span class="check enddate-list">
					<input type="hidden" value="2">
					<c:if test="${search.order==2 }">
						<img src="https://icongr.am/entypo/check.svg?size=20px">
					</c:if>
					<c:if test="${search.order!=2 }">
						<img src="https://icongr.am/entypo/check.svg?size=20px&color=bbbbbb">
					</c:if>
					댓글</span>
			</div>
		 </div>
		<!-- 
		<a class="btn btn-default" href="#">인기</a>
		<a class="btn btn-default" href="#">최신</a>
		<a class="btn btn-default" href="#">댓글순</a>
		 -->
				
		<input  type="hidden" id="keyword" value="${search.keyword}">
		<input type="hidden" id="condition" value="${search.condition}">
		<input type="hidden" id="order" value="${search.order}">
		<input type="hidden" id="currentPage" value="${page.currentPage}">
		<input type="hidden" id="maxPage" value="${page.maxPage}">
	
		<br/>
		<h1>BOARD</h1>
		<hr/>
			<div class="board-list">
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
										<img src="../resources/upload_files/images/${room.host.booklogImage}" onerror="this.src='../resources/images/no_booklog_image.png'">
										<strong>${board.writer.nickname}</strong>
									</div>
									<div class="col-xs-6">
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
			</div>		
	
			<div class="text-center">
			 <img id="loadingImg" src="../resources/images/community/loading.gif" >
			</div>
	</div>
	
	
		<footer class="container-fluid">
		<jsp:include page="../layout/tailbar.jsp"/>
		</footer>
</body>
</html>