<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="initial-scale=1.0, maximum-scale=1.0, width=device-width">
	
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" ></script>
	
	<script src="../resources/javascript/toolbar_opac.js"></script>
	<script src="../resources/javascript/custom.js"></script>
	
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" >
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" >

<!-- 
 -->
    <link rel="stylesheet" href="../resources/css/custom.css">
	
<title>BookBox Community</title>

<style type="text/css">

	body{
    	padding-top:0px;
    }
    
    header{
    	background:url(../resources/images/community.jpeg) no-repeat center;
    }

	.container img{
		max-width: none;
	}
	
	.board{ 
	}
	
	.board-main{
		/*border: solid 1px;*/
	}
	.board-main .title{
		padding: 0 0 0 20px;
		background-color: #62BFAD;
		height: 50px; 
		font-size: 30px;
		font-weight: 500;
		color: floralwhite;
	}
	.board-main	.board-info{
		height: 60px;
		margin-top: 10px;
		padding: 0 20px 0 20px;
	}
	.board-main .board-info .writer{
		height: 100%;
	}
	.board-main .board-info .writer img{
		height: 35px;
		width: 35px;
		border-radius: 50%;	
		object-fit:cover;
	}
	
	.board-main .content{
		padding: 20px;
	}
	.board-main .content img{
		max-width: 100%;
		object-fit: contain;
	}
	
	.board-main .tag-list{
		margin-bottom: 20px;
		padding: 0 20px 0 20px;
	}
	
	.blind{
		color: 	#FF1493;	
	}

	/*댓글*/
	.media{
		/*border: solid 1px;*/
		padding: 10px 0 10px 10px;

	}
	
	.media .media-left{
		/*border-left: dashed 1px;*/ 
		height: 100%;
		padding-bottom: 0px;
		overflow: hidden;
	}
	
	.media .media-left img{
		height: 40px;
		width: 40px;
		border-radius:50%;
		object-fit:cover;
	}
	.media .empty{
		width: 20px;
		border-right: dotted 1px;
		margin-top: 10px;

	}
	
	.media-heading{
		height: 30px;
		padding-top: 8px;
		background-color: florawhite;
	}
	.media-heading .regdatea{
		height: 100%;
		padding-top: 10px;
	}
	.media-heading strong{
		font-size: 12px;
	}
	
	.test{
		padding: 10px 10px 5px 10px;
		background-color: #62bfad38;
		border-bottom: 5px solid #62bfadff; 
	}
	
	.media .append-area{
		
	}
	
	.comment-textarea{
		margin: 10px 0 10px 0;
		width: 100%;
		height: 100px;
	}
	.comment-input-container{
		margin: 10px 0 0 0;
	}
	.btn-custom{
		cursor: pointer;
		border: 1px #888 solid;
		border-radius:5px;
		color: #888;
		padding: 5px;
	}
	.btn-custom img{
		height: 15px;
		width: 15px;
		margin: 0 3px 0 0;
		object-fit:contain;
	}
	
	.btn{
		padding: 6px 6px 6px 6px;
	}
	.btn img{
		height: 15px;
		width: 15px;
		margin: 0 3px 0 0;
		object-fit:contain;
	}
</style>

<script type="text/javascript">
var condition;
ToolbarOpacHeight(500);
//게시글 추천,신고 버튼 이벤트 초기화
	$(function(){
		
		$("#recommend").on("click",function(){
			var boardNo=$("input[name=boardNo]").val();
			var param="targetNo="+boardNo+"&category=board&pref=up";
			sendRecommend(param);
		});
		$("#unRecommend").on("click",function(){
			var boardNo=$("input[name=boardNo]").val();
			var param="targetNo="+boardNo+"&category=board&pref=down";
			sendRecommend(param);
		});
		
		$("#report").on("click",function(){
			var boardNo=$("input[name=boardNo]").val();
			var param="targetNo="+boardNo+"&category=board";
			sendReport(param);
		});
		
		//게시글의 답변 버튼 이벤트
		commentEventInit($(".board"));
		
		$("#addComment").on("click",function(){
			
			var boardNo=$("input[name=boardNo]").val();
			var content=$(this).parent().parent().find("textarea").val();
			var level = -1;
			var commentNo=0;
			
		
			//alert(boardNo+","+content+","+level+","+commentNo);
			
		 	$.ajax({
				url: "rest/addComment",
				method: "POST",
				crossDomain:true,
				headers : {
					"Accept" : "application/json",
					"Content-Type" : "application/json"
				},
				data :JSON.stringify({
					"boardNo": boardNo,
					"content" : content,
					"level" : parseInt(level)+1,
					"seniorCommentNo":commentNo
				}),
				success:function(){
					//alert("addComment success");
					
				 	loadComment();
				}
		 	});//ajax 끝 
		});
		
		/////수정버튼//////////////
		$("#updateBoard").on("click",function(){
			self.location="updateBoard?boardNo="+${board.boardNo};
		});
		//목록가기 버튼
		$("#goList").on("click",function(){
			self.location="getBoardList";	
		});
		
	});
	
	
	function sendRecommend(param){
		
		$.ajax({
			url: "rest/addRecommend",
			method: "POST",
			data: param,
			success:function(data,status){
				if(data==99999){
					alert("이미 추천 또는 비추천을 누루셨습니다.")
				}
				else{
					$("#recommedCount").text(data);
					
				}
				
			}
		});
		
	}
//////////////////////	신고 추가 부분 //////////////////
	function sendReport(param){
		//alert(param);
			
		$.ajax({
			url: "rest/addReport",
			method: "POST",
			data: param,
			success:function(data,status){
				if(data==99999){
					alert("이미 신고를 하셨습니다.")
				}else{
					alert("신고 완료")	;
				}
					
			}
		});
	 
	}

	
////////////////////댓글 로딩////////////////////////////
	$(function(){
		
		loadComment();
	});
	
	function loadComment(){
		var boardNo=$("input[name=boardNo]").val();
			
		$.ajax({
			url: "rest/getCommentList/"+boardNo,
			method: "GET",
			dataType:"json",
			crossDomain:true,
			success:function(data){
		
			var commentListDiv=$(".commentList");
			
			$(".commentList").html("");
			
			appendComment(commentListDiv,data);
			
			//추가부분
			$(".empty").each(function(index,elem){
				var parentHeight=$(elem).parent().css("height");
					parentHeight.replace("px","");
					parentHeight=parseInt(parentHeight);
					parentHeight-=50;
				$(elem).css("height",parentHeight+"px");
				
			});
			//
			}
	 	});//ajax 끝 
	}
	//댓글 로딩 끝
	
	//대댓글 재귀함수
	function appendComment(parentObj,commentList){
		
		var appendPoint=parentObj.find(".media-body .append-area");
		
		//레벨 0댓글일 경우 comment 부분에 추가
		if(!appendPoint.length){
			appendPoint=$(".commentList");
		}
		
		
		for(var i=0; i<commentList.length; i++){
			//alert(commentList[i].content);
				var comment=commentList[i];
				
				var commentObj=$("<div class='media'>"+
									"<input name='commentNo' type='hidden' value='"+comment.commentNo+"'>"+ //히든처리할거
									"<input name='level' type='hidden' value='"+comment.level+"'>"+ //히든처리할거
									"<div class='media-left'>"+
										"<div>"+
										"<img src='../resources/upload_files/images/"+comment.writer.booklogImage+"'"+ 
											"onerror=\"this.src='../resources/images/no_booklog_image.png'\">"+
										"</div>"+
										"<div class='empty'></div>"+
									"</div>"+
									"<div class='media-body'>"+
										"<h4 class='media-heading row'>"+
											"<div class='col-xs-6'>"+ 
												comment.writer.nickname +
											"</div>"+
											"<div class='col-xs-6 text-right regdate'>"+
											"<strong>"+comment.regDate+"</strong>"+
											"</div>"+
										"</h4>"+
										"<div class='test'>"+
											"<p class='comment-content'>"+comment.content+"</p>"+
											"<a class='btn' id='addCommentArea'><img src='../resources/images/community/btn_comment2.png'>답변</a>"+
											"<a class='btn report'><img src='../resources/images/community/btn_report.png'>신고</a>"+
										"</div>"+
										"<div class='inputarea'>"+
										"</div>"+
										"<div class='append-area'></div>"+
									"</div>"+
								"</div>"	);
				
				//블라인드 처리
				if(comment.blind==true){
					//alert("blindTest")
					
					commentObj.find(".comment-content").before("<p class='blind'>블라인드 된 글 입니다.<a class='btn viewBlind'>보기</a></p>");
					commentObj.find(".comment-content").css("display","none");
				}
				//
			commentEventInit(commentObj);
			
			appendPoint.append(commentObj);
			
			if(commentList[i].comment!=null){
				appendComment(commentObj,commentList[i].comment);
			}
			
		}
		
	}
	//대댓글 재귀함수 끝
	
	//대댓글 이벤트 초기화 함수
	function commentEventInit(commentObj){
		//alert(commentObj.html());
		
		//댓글 입력창 , 댓글달기 이벤트 추가 부분
		commentObj.find("#addCommentArea").on("click",function(){
			
			if(commentObj.find(".inputarea").html()!=''){
				commentObj.find(".inputarea:first").html('');
				return;
			}
			
			var inputObj=$("<div class='comment-input-container'>"+
								"<textarea class='comment-textarea'></textarea>"+
								"<br/>"+
								"<div class='text-right'>"+
								"<a class='btn btn-custom'>등록</div>"+
								"</div>");
			
			inputObj.find("a").on("click",function(){
				
				var boardNo=$("input[name=boardNo]").val();
				var content=inputObj.find("textarea").val();
				var level = commentObj.find("input[name='level']").val();
				var commentNo=commentObj.find("input[name='commentNo']").val();
				
				
				if(level==undefined){
					level=-1;
					commentNo=0;
				}
				
			
				//alert(boardNo+","+content+","+level+","+commentNo);
				
			 	$.ajax({
					url: "rest/addComment",
					method: "POST",
					crossDomain:true,
					headers : {
						"Accept" : "application/json",
						"Content-Type" : "application/json"
					},
					data :JSON.stringify({
						"boardNo": boardNo,
						"content" : content,
						"level" : parseInt(level)+1,
						"seniorCommentNo":commentNo
					}),
					success:function(){
						//alert("addComment success");
						
					 	loadComment();
					}
			 	});//ajax 끝 
			 
				commentObj.find(".inputarea").html(""); //등록후 입력창 없애기 , 댓글영역을 리로드할 예정 필요없을지도
			});//등록 클릭이벤트 끝
			
			commentObj.find(".inputarea:first").append(inputObj);
			
		});//댓글 입력창 , 댓글달기 이벤트 추가 부분
		
		//신고 이벤트 등록 시작 
		//alert(commentObj.hasClass("board"));
		if(!commentObj.hasClass("board")){
			commentObj.find(".btn.report").on("click",function(){
				//alert($(this).html());
				var commentNo=commentObj.find("input[name='commentNo']").val();
				var param="targetNo="+commentNo+"&category=comment";
				sendReport(param);
			});
		}
		//신고 이벤트 등록 끝
		
		//블라인드 보기 
		if(commentObj.find(".viewBlind").length!=0){
			commentObj.find(".viewBlind").on("click",function(){
				commentObj.find(".comment-content:first").css("display","");
				commentObj.find(".blind:first").remove();
			//	alert(commentObj.html());
			});
		}
		//
		
	}//이벤트 초기화끝
</script>

</head>
<body>
	<jsp:include page="../layout/toolbar.jsp" >
		<jsp:param value="../" name="uri"/>
	</jsp:include>
	<header class="parallax"></header>
	<div class="container">
		
		<div class="board">
			<input type="hidden" value="${board.boardNo}" name="boardNo" readonly="readonly"/>
			<input type="hidden" value="-1" name="level">
			<div class="board-main">
				<div class="title">
					<span>${board.boardTitle}</span>
				</div>
				<div class="board-info row text-right">
					<!-- 추천 신고 -->
					<div class="writer col-xs-6 text-left">
						<img src="../resources/upload_files/${room.host.booklogImage}" 
								onerror="this.src='../resources/images/no_booklog_image.png'">
						<strong>${board.writer.nickname}</strong>
					</div>
					<div class="col-xs-6">
						<div><strong>${board.boardRegDate}</strong></div>
						<c:if test="${enableUpdate==true}">
						<a class="btn recommend" id="updateBoard"><img src='../resources/images/community/btn_edit.png'>수정</a>
						</c:if>
						<a class="btn recommend" id="recommend"><img src='../resources/images/community/btn_recommend.png'>추천</a> 
						<span id="recommedCount">${board.recommend}</span>
						<a class="btn recommend" id="unRecommend"><img src='../resources/images/community/btn_unrecommend.png'>비추천</a>
						<a class="btn report" id="report"><img src='../resources/images/community/btn_report.png'>신고</a>
					</div>
				</div>
				<div class="content">
					<br/>
					${board.boardContent}
				</div>
				<div class="tag-list">
					<c:forEach items="${board.tagList}" var="tag" >
							<span class="tag">#${tag.tagName}</span>
					</c:forEach>
				</div>
			</div>
			<hr/>
			<div class="text-right"><a class="btn-custom" id="goList"><img src='../resources/images/community/btn_list.png'>목록</a></div>
			<div class="board-comment">
			
				<a class="btn-custom" id=addCommentArea>답변</a>
				<div class="inputarea">
					<div class='comment-input-container'>
						<textarea class='comment-textarea'></textarea>
						<br/>
						<div class="text-right">
							<a class='btn btn-custom' id="addComment">등록</a>
						</div>
					</div>
				
				</div><!-- 여기 무조건 붙어있어야함 -->
				<div class="commentList">
				</div><!-- 댓글부분 끝 -->
				
			</div>	
		</div>

		
	
	<br/><br/><br/><br/>			
				
	</div><!-- 컨테이너 끝 -->
	
	
	
	
	<footer class="container-fluid">
		<jsp:include page="../layout/tailbar.jsp"/>
	</footer>
</body>
