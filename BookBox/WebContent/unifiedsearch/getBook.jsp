<%@ page language="java" contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
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
	
	<link href="//netdna.bootstrapcdn.com/font-awesome/3.2.1/css/font-awesome.css" rel="stylesheet">
	<link rel="stylesheet" href="../resources/css/star.css">
	<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.7.0/Chart.bundle.js"></script>
    <script src="../resources/daumeditor/js/utils.js"></script>
	
<style type="text/css">
body{
	padding-top:0px;
}
header{
	background:url(../resources/images/unifiedsearch_book.jpeg) no-repeat center;
}
.parallax { 
    background-attachment: fixed;
    background-size: cover;
}

canvas {
	-moz-user-select: none;
	-webkit-user-select: none;
	-ms-user-select: none;
}
footer{
	margin-top: 100px;
}
.btn-form{
	     	border: 2px groove; 
		    padding: 5px;
		    border-radius: 7px; 
		    display:inline-block;
	        padding-left: 15px;
   			padding-right: 15px;
   			cursor:pointer;
		}
.btn-send {
     	border: 2px groove; 
	    padding: 5px;
	    border-radius: 7px; 
	    display:inline-block;
        padding-left: 15px;
   		padding-right: 15px;
		cursor:pointer;
		background: gray;
		color: white;
		
}
hr {
	border: 1px solid #a78c86;
}
.gradeAvg{
	display: inline-block; 
	float:left;
	padding-top: 0.2%;
	padding-left: 0.5%;
}
.add-grade{
	display: inline-block; float:left;margin-left: 2%;border-left: 2px groove;padding-left: 0.5%;
}
</style>

<script type="text/javascript">
ToolbarOpacHeight(500);
//차트
    var age = ["0", "10", "20", "30", "40", "50", "60", "70"];

    var config = {
        type: 'line',
        data: {
            labels: ["0", "10", "20", "30", "40", "50", "60", "70"],
            datasets: [{
                label: "여성",
                fill: false,
                borderColor: window.chartColors.red,
                backgroundColor: window.chartColors.red,
                data: [
                	${women.age_0},
                	${women.age_10},
                	${women.age_20},
                	${women.age_30},
                	${women.age_40},
                	${women.age_50},
                	${women.age_60},
                	${women.age_70}
                ]
            }, {
                label: "남성",
                fill: false,
                borderColor: window.chartColors.blue,
                backgroundColor: window.chartColors.blue,
                data: [
                	${men.age_0},
                	${men.age_10},
                	${men.age_20},
                	${men.age_30},
                	${men.age_40},
                	${men.age_50},
                	${men.age_60},
                	${men.age_70}
                ]
            }]
        },
        options: {
            responsive: true,
            title: {
                display: true,
                text: "도서 조회 수 통계 그래프"
            },
            scales: {
                xAxes: [{
                    display: true,
                    ticks: {
                        callback: function(dataLabel, index) {
                            // Hide the label of every 2nd dataset. return null to hide the grid line too
                            return index % 2 === 0 ? dataLabel : '';
                        }
                    }
                }],
                yAxes: [{
                    display: true,
                    beginAtZero: false
                }]
            }
        }
    };

    window.onload = function() {
        var ctx = document.getElementById("canvas").getContext("2d");
        window.myLine = new Chart(ctx, config);
    };
    
//댓글 추가
$(function(){
	$('div.add-reply').on('click',function(){
		fncAddReply();
	});
	
})
function fncAddReply() {
	targetNo = ${book.isbn};
	var content = $('input.reply-content').val();
	var curDate = new Date();
	var date = curDate.getFullYear() + "-" + (curDate.getMonth() + 1) + "-" + curDate.getDate();
	var hourTime = curDate.getHours()+":"+curDate.getMinutes()+":"+curDate.getSeconds();
	var regDate=date+" "+hourTime;
	
	if(content == '') {
		alert('댓글을 입력하세요.');
	} else {		
		$.ajax ({
		url : "../unifiedsearch/rest/addReply",
			method : "POST",
			data : {"content" : content, "isbn" : targetNo},
			success:function(){
				
				var prependReply='';
				prependReply+='<div class="row" style="margin:auto;">';
				prependReply+='<div class="reply-user" style="display:inline-block;float:left;font-weight: bold">${user.nickname}</div>';	
				prependReply+='<div class="reply-regdate"style="display:inline-block;float:right;">'+regDate+'</div></div>'
				prependReply+='<div class="reply-content">'+content+'</div><hr>'
				 
				$(".reply-list").prepend(prependReply);
				$('input.reply-content').val("");
			} 
		});
	}		
}
//좋아요 추가
function addLike(isbn) {
	var total=parseInt($("#likeSum").text())+1;
	
	$.ajax ({
		url : "../unifiedsearch/rest/addLike",
		method : "POST",
		data : {"isbn" : isbn},
		success:function(){
			$(".addLike").replaceWith("<div class='deleteLike btn-form' onclick='deleteLike(${book.isbn})'><img src='https://icongr.am/entypo/heart.svg?size=25&color=ff0000'><span id='likeSum'> "+total+" </span></div>");

			alert("좋아요를 등록하셨습니다.");
		 } 
	});
}
//좋아요 삭제
function deleteLike(isbn) {
	var total=parseInt($("#likeSum").text())-1;
	
	$.ajax ({
		url : "../unifiedsearch/rest/deleteLike",	
		method : "POST",
		data : {"isbn" : isbn},
		success:function(){
			$(".deleteLike").replaceWith("<div class='addLike btn-form' onclick='addLike(${book.isbn})'><img src='https://icongr.am/entypo/heart-outlined.svg?size=25&color=ff0000'><span id='likeSum'> "+total+" </span></div>");
			alert("좋아요를 취소하셨습니다.");
 		} 
	});
}
//별점 이벤트
$(function() {
	$(document).ready(function() {
		if ('${grade.doGrade}' == 'true' || '${user.email}' == '') {
			$('.gradeAvg ul li').off();
		}
	});

	$('.gradeAvg ul li').mouseenter(function() {
  		var idx = $(this).index() + 1;  	
		$('.gradeAvg').removeClass().addClass('gradeAvg star' + idx);
	});

	$(".gradeAvg ul li").click(function() {
		$(this).mouseenter();
		var idx = $(this).index() + 1;
		$('.gradeAvg ul li').off();
		
		if ("${book.grade.doGrade}" == "true") {
			alert("이미 평점을 등록하셨습니다.");
		} else {
			alert(idx + "점을 등록하시겠습니까?");
			
			$.ajax({
				url: "../unifiedsearch/rest/addGrade",
				method: "POST",
				data: {"isbn": '${book.isbn}', "userCount": idx},
				success: function(data) {
					alert("평점이 등록되었습니다.");
					var avg = ${book.grade.average};
					var userCount = ${book.grade.userCount};
					$("#get-gradeAvg").html("("+ (idx + (avg * userCount))/(userCount+1) +")");
					$('.gradeAvg-result').removeClass().addClass('star'+Math.floor((idx + (avg * userCount))/(userCount+1)));
					$('.add-grade-form').html('&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;이미 참여하였습니다.');
				} 
			});
		}
	});
})
</script>
</head>

<body>
	<jsp:include page="../layout/toolbar.jsp">
		<jsp:param value="../" name="uri" />
	</jsp:include>
	<header class="parallax"></header>
	
	<div class="container">
		<div class="row">
			<div style="padding: 0px 50px 50px 50px; margin-top: 60px; border-top: 2px groove; background-color: rgba(221, 221, 221, 0.12);">
					<div class="grade-part" style="padding-left: 1.5%;">
						<div  style="display: inline-block; float:left;">별점</div>	
						<div id="starWrap" class="gradeAvg-result star${fn:substring(book.grade.average, 0, 1)}" style="display: inline-block; float:left;padding-top: 0.2%;padding-left: 0.5%;">
								<ul style="padding-left:0;">
									<li class="s1" style="cursor:auto;"></li>
									<li class="s2" style="cursor:auto;"></li>
									<li class="s3" style="cursor:auto;"></li>
									<li class="s4" style="cursor:auto;"></li>
									<li class="s5" style="cursor:auto;"></li>
								</ul>
						</div>
						<div class="get-gradeAvg" style="display: inline-block; float:left;"><strong id="get-gradeAvg">(<fmt:formatNumber value="${book.grade.average}" pattern="0.00"/>)</strong></div>
						<div class="add-grade">별점주기</div>
						<div class="add-grade-form">
					<c:if test="${!book.grade.doGrade }">
           	 		<div id="starWrap" class="gradeAvg star${fn:substring(book.grade.average, 0, 1)}"  style="display: inline-block;" >
						<ul style="padding:0px;">
							<li class="s1"></li>
							<li class="s2"></li>
							<li class="s3"></li>
							<li class="s4"></li>
							<li class="s5"></li>
						</ul>
					</div>
					</c:if>
					<c:if test="${book.grade.doGrade }">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;이미 참여하였습니다.	</c:if>
				</div>
            </div>
		</div>
	
	<c:if test="${bookEmpty}">
		<h3>해당도서에 대한 결과가 없습니다.</h3>
	</c:if>
	
	<div class="row" style="margin-top:30px;">
	    <div class="col-md-8 post-title">
           <h3>${book.title}</h3>
                <p class="author"><strong>
                	<c:forEach items="${book.authors}" var="str" varStatus="status">
		   				${str}<c:if test="${!status.last}"> | </c:if></c:forEach><br>
   					<c:forEach items="${book.translators}" var="str" varStatus="status">
             			${str}<c:if test="${!status.last}"> | </c:if></c:forEach>
             		<br>출판사 : ${book.publisher}
             		<br>정가 : ${book.price}원</strong> 
              		<br>출판일 : <span class="text-muted">${book.datetime}</span>
                </p>
                </div>
            	    <div class="col-md-4">
           			<c:choose>
						<c:when test="${book.thumbnail == ''}">
						<div>
     		   				<img class="img-thumbnail" src="http://t1.daumcdn.net/book/KOR${book.isbn}" height="240px" width="170px" onerror="this.src='../resources/images/noimage.jpg'">
     		   			</div>  					
					</c:when>
					<c:otherwise>
						<div>
	  						<img class="img-thumbnail" src="http://t1.daumcdn.net/book/KOR${book.isbn}" height="240px" width="170px" onerror="this.src='${book.thumbnail}'">
						</div>
					</c:otherwise>
				</c:choose>
            </div>
		</div>
            
            <div class="col-lg-7 col-lg-offset-0 col-lg-push-1 col-lg-pull-0 col-md-7 col-md-offset-0 col-md-push-0 post-body">
                <p>줄거리 : ${book.contents}</p>
                <p><a target="_blank" href="${book.url}">판매 페이지로 이동</a></p>
                
                <c:choose>
					<c:when test="${user.email == null}">
					</c:when>
					
					<c:when test="${book.like.doLike == false}">
						<div class="addLike btn-form" onclick="addLike(${book.isbn});">
							<img src="https://icongr.am/entypo/heart-outlined.svg?size=25&color=ff0000">
							<span id="likeSum">${book.like.totalLike}</span>
						</div>
					</c:when>
					
					<c:when test="${book.like.doLike == true}">
						<div class="deleteLike btn-form" onclick="deleteLike(${book.isbn});">
							<img src="https://icongr.am/entypo/heart.svg?size=25&color=ff0000">
							<span id="likeSum">${book.like.totalLike}</span>
						</div>
					</c:when>
				</c:choose>
            </div>
            </div>
            
            <div class="row">
            	<div class="col-md-10" style="margin:8% 10% 8% 15%;">            
                 	<div style="width:75%;">
                    	<canvas id="canvas"></canvas>
 					</div>
				</div>
           	</div>
                  
            <div class="row">
            	<hr>
            </div>
        <div class="row reply-form" style="margin: 2% 13%;">
				<div class="row reply-head" style="margin: auto;font-size: x-large;">댓글쓰기 ${book.replyList.size() }</div>
				<div class="reply-border" style="padding: 2%;border: 1px groove; height:150px;">
					<strong>${user.nickname}</strong> 
				<c:if test="${user.email eq null}">
					<input class="form-control reply-content" type="text" id="reply-content" placeholder="댓글 입력" readonly>
					<div class="btn btn-form " style="margin-top: 1%;float:right;border: none;" disabled>등록</div>
				</c:if>
				<c:if test="${user.email ne null}">
					<input class="form-control reply-content" type="text" id="reply-content" placeholder="댓글 입력">
					<div class="btn btn-form add-reply" style="margin-top: 1%;float:right;border: none;">등록</div>
				</c:if>
			</div>
			
		<hr>
		
		<div class="row" id="restReply">
			<div class="row reply-list" style="margin:auto;height:150px;padding: 0% 2%;">
				<c:forEach items="${book.replyList}" var="reply">
					<div class="row" style="margin:auto;">
						<div class="reply-user" style="display:inline-block;float:left;font-weight: bold">${reply.user.nickname}</div>
							<div class="reply-regdate"style="display:inline-block;float:right;">${reply.regDate}</div> 
						</div>	
					<div class="reply-content">${reply.content}</div>
					<hr>
				</c:forEach>			
			</div>
		</div>
	</div>
	</div>
	
	<footer class="container-fluid">
		<jsp:include page="../layout/tailbar.jsp"/>
	</footer>
</body>
</html>