<%@ page language="java" contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
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
p#content{
	text-overflow: ellipsis;
	white-space: normal;
	word-wrap: normal;
	overflow: hidden;
	display: -webkit-box;
	-webkit-line-clamp: 3; /* 라인수 */
	-webkit-box-orient: vertical;
	word-wrap: break-word; 
	line-height: 1.2em;
	height: 3.6em;
}
body{
	padding-top:0px;
}
header{
	background:url(../resources/images/unifiedsearch_search.jpg) no-repeat center;
}
.parallax { 
    background-attachment: fixed;
    background-size: cover;
}

.book{
	margin: 30px 10px 20px 20px;
}
footer{
	margin-top: 80px;
}
.search-hr {
    border: 2px solid #6e6571;
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
#board-title-box{
	padding: 10px 10px 10px 15px; 
	height: 110px;
	background: #74B49B;
}
#board-tag-box{
	padding: 10px 15px 10px 15px;
	height: 110px;
	background: #D3F6D1;
}
.board-total-box{
	padding: 10px 25px 30px 15px;
	height: 260px;
}
.board-content-img{
    background: center center;
    width: 90px;
    height: 90px;
    object-fit:cover;
    border-radius: 50%;
    box-shadow: 3px 3px 3px rgba(128, 128, 128, 0.53);
}
#posting-content{
	border-left: 4px dashed #c59e7d;
}
#posting-content div{
	border-left: 10px;
}
.posting-content-img{
    background: center center;
    height: 145px;
    max-width: 250px;
    box-shadow: 3px 3px 3px rgba(128, 128, 128, 0.53);
}
#posting-shadow-box{
	box-shadow: 0.5px 0.5px 0.5px 1px rgba(128, 128, 128, 0.53);
	padding: 25px 20px 25px 10px; 
	margin: 20px 50px 30px 50px;
}
.posting-content-line{
	text-overflow: ellipsis;
	white-space: normal;
	word-wrap: normal;
	overflow: hidden;
	display: -webkit-box;
	-webkit-line-clamp: 3; /* 라인수 */
	-webkit-box-orient: vertical;
	word-wrap: break-word; 
	line-height: 1.2em;
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
strong {
	color:rgba(82, 76, 76, 0.92);
}
.creation-hr {
    border: 1px solid #6e6571;
}
</style>

<script type="text/javascript">
ToolbarOpacHeight(500);
	
function getBook(isbn) {
	$(self.location).attr("href","../unifiedsearch/getBook?isbn="+isbn);
}

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
	$(".nav-posting").on("click" , function() {
		var targetNo = this.getAttribute('id');
		$(self.location).attr("href","../booklog/getPosting?postingNo=" + targetNo);
	}); 
	$(".nav-community").on("click" , function() {
		var targetNo = this.getAttribute('id');
		$(self.location).attr("href","../community/getBoard?boardNo=" + targetNo);
	});
	$(".nav-writing").on("click" , function() {
		var targetNo = this.getAttribute('id');
		$(self.location).attr("href","../creation/getWriting?writingNo=" + targetNo);
	}); 

	//nav-more
	$(".nav-creation-more").on("click" , function() {
		$(self.location).attr("href","../unifiedsearch/getUnifiedsearchList?category=1&keyword=${search.keyword}");
	});
	$(".nav-board-more").on("click" , function() {
		$(self.location).attr("href","../unifiedsearch/getUnifiedsearchList?category=6&keyword=${search.keyword}");
	});
	$(".nav-posting-more").on("click" , function() {
		$(self.location).attr("href","../unifiedsearch/getUnifiedsearchList?category=5&keyword=${search.keyword}");
	});
	$(".nav-book-more").on("click" , function() {
		$(self.location).attr("href","../unifiedsearch/getBookList?keyword=${search.keyword}");
	});
	$(".nav-tag").on("click" , function() {
		var keyword = this.innerText.replace("#", "");
		$(self.location).attr("href","../unifiedsearch/getUnifiedsearchList?category=11&keyword=${search.keyword}");
	});
});
</script>

<script type="text/ecmascript">
document.onreadystatechange = function () {
	if (document.readyState == "complete") { 
		var container = document.querySelector('#content-view'); 
		var msnry = new Masonry(container);
	}
} 
</script> 

<body>
<jsp:include page="../layout/toolbar.jsp" >
		<jsp:param value="../" name="uri"/>
	</jsp:include>
	<header class="parallax"></header>

	<div class="container">
		<div class="row" style="margin-top:50px">
			<c:if test="${search.category eq 10}">
				<font size="5"><strong>통합검색   "${search.keyword}" 에 대한 검색 결과 총  ${result.total + fn:length(bookList)}건 입니다. </strong></font>
			</c:if>
			<c:if test="${search.category eq 11}">
				<font size="5"><strong>태그  "#${search.keyword}" 에 대한 검색 결과 총  ${result.total + fn:length(bookList)}건 입니다. </strong></font>
			</c:if>
		</div>  
		 
		<div class="row">	
			<hr class="search-hr">
		</div>
			
		<c:if test="${fn:length(bookList) eq 0}">
			<div class="row">
				<font size="5"><strong>관련 도서가 없습니다.</strong></font>
			</div>
		</c:if>
		
		<c:if test="${fn:length(bookList) ne 0}">
			<div class="row">
				<div>도서 검색 ${fn:length(bookList)} 건</div>			
			</div>
		</c:if>	
			
	    <div class="row">
			<c:forEach items="${bookList}" var="book" end="4">
				 <div class="col-md-2 book" onclick="getBook(${book.isbn});">
		       		<c:choose>
  						<c:when test="${book.thumbnail == ''}">
	       		   			<img class="img-thumbnail" src="http://t1.daumcdn.net/book/KOR${book.isbn}" height="240px" width="170px" onerror="this.src='../resources/images/noimage.jpg'">  					
  						</c:when>
  						<c:otherwise>
    						<img class="img-thumbnail" src="http://t1.daumcdn.net/book/KOR${book.isbn}" height="240px" width="170px" onerror="this.src='${book.thumbnail}'">
  						</c:otherwise>
					</c:choose>
					<p>${book.title}</p>
				</div>
			</c:forEach>
	    </div>
	    
	    <c:if test="${fn:length(bookList) ne 0}">
	    	<div class="row">
				<div align="right" class="nav-book-more">더보기</div>
			</div>
		</c:if>	
		
		<div class="row">	
			<hr class="search-hr">
		</div>

		<c:if test="${creationList.total eq 0}">
			<div class="row">
				<font size="5"><strong>관련 작품이 없습니다.</strong></font>
			</div>
		</c:if> 
		
		<c:if test="${creationList.total ne 0}">
			<div class="row">
				<div>작품 검색 ${creationList.total} 건</div>
			</div>
		</c:if>
		
		<c:set var="doneLoop" value="false"/>
			<c:forEach items="${creationList.result}" var="creation" varStatus="status" end="3">
				<div class="row" style="margin-bottom:20px;">
					<div class="col-md-1">
						<img class="creation-img" src="../resources/upload_files/images/${creation.image}" onerror="this.src='../resources/images/noimage.jpg'">
					</div>
					<div class="col-md-9">
						<div class="row nav-creation" style="padding-left:10px" id="${creation.id}"><font size=5>${creation.title}</font>  by ${creation.nick_name}</div> 
						<div class="row" style="padding-left:10px"><p><c:forEach items="${creation.tag}" var="tag" varStatus="status"><span class="tag">#${tag}</span> </c:forEach></div>
					</div>
					<div class="col-md-1">
						<div class="row">게시글 총 ${fn:length(creation.writing)} 건</div>
					</div>
				</div>
					
				<div class="row" style="margin-left:10px;">
					<c:forEach items="${creation.writing}" var="writing">
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
			<c:if test="${status != 3}"><hr class="creation-hr"></c:if>		
		</c:forEach>
		<c:if test="${creationList.total ne 0}">
			 <div class="row">
				<div align="right" class="nav-creation-more">더보기</div>
			</div>
		</c:if>	
		
		<div class="row">	
			<hr class="search-hr">
		</div>

		<c:if test="${boardList.total eq 0}">
			<div class="row">
				<font size="5"><strong>관련 게시판이 없습니다.</strong></font>
			</div>
		</c:if> 
		
		<c:if test="${boardList.total ne 0}">
			<div class="row">
				<div>게시판 검색 ${boardList.total} 건</div>
			</div>
		</c:if>
		
		<div class="row">
		<c:set var="doneLoop" value="false"/>	
		<c:forEach items="${boardList.result}" var="board" varStatus="status">
			<c:if test="${not doneLoop}">
				<c:if test="${status.count == 5}"> 
					<c:set var="doneLoop" value="true"/> 
				</c:if> 
			</c:if> 
			<c:if test="${not doneLoop}"> 
				<div class="col-md-3 board-total-box">
					<div class="row" id="board-title-box">
						<div class="col-md-7 col-xs-7 nav-community" id="${board.id}" style="padding: 5px;">
							<p><strong>${board.title}</strong></p>
						<div>by ${board.nick_name}</div>
					</div>
					<div class="col-md-5 col-xs-5 nav-community" id="${board.id}"  style="padding-right: 0px;" align="right">
						<img class="board-content-img" src="${board.image}" onerror="this.src='../resources/images/noimage.jpg'">
					</div>	
				</div>
				<div class="row" id="board-tag-box">
					<p><c:forEach items="${board.tag}" var="tag" varStatus="status"><span class="tag">#${tag}</span> </c:forEach></p>
				</div>
			</div>
		</c:if>
	</c:forEach>
	</div>
	
	<c:if test="${boardList.total ne 0}">
		<div class="row">
			<div align="right" class="nav-board-more">더보기</div>
		</div>
	</c:if>	
	
	<div class="row">	
		<hr class="search-hr">
	</div>

	<c:if test="${postingList.total eq 0}">
		<div class="row">
			<font size="5"><strong>관련 포스팅이 없습니다.</strong></font>
		</div>
	</c:if> 
	
	<c:if test="${postingList.total ne 0}">
		<div class="row">
			<div>포스팅 검색 ${postingList.total} 건</div>
		</div>
	</c:if>
	
	<c:set var="doneLoop" value="false"/>	
	<c:forEach items="${postingList.result}" var="posting" varStatus="status">
		<c:if test="${not doneLoop}">
			<c:if test="${status.count == 5}"> 
				<c:set var="doneLoop" value="true"/>
			</c:if> 
		</c:if>
		<c:if test="${not doneLoop}"> 
			<div class="row">
				<div class="row" id="posting-shadow-box">
					<div class="col-md-3 nav-posting" id="${posting.id}">
						<img class="posting-content-img" src="../resources/upload_files/images/${posting.image}" onerror="this.src='../resources/images/noimage.png'">							
					</div>
					<div class="col-md-9" style="padding-left:35px; padding-top:5px;">
						<div class="row nav-posting" id="${posting.id}">
							<p><font size="4"><strong>${posting.title}</strong></font>  by ${posting.nick_name}</p>				
						</div>
						<div class="row">
							<p><c:forEach items="${posting.tag}" var="tag" varStatus="status"><span class="tag">#${tag}</span> </c:forEach></p>
						</div>
						<div class="nav-posting" id="${posting.id}">
							<p class="posting-content-line">${posting.content}</p>
						</div>
					</div>
				</div>
			</div>
		</c:if> 
	</c:forEach>
	
	<c:if test="${postingList.total ne 0}">
		<div class="row">
			<div align="right" class="nav-posting-more">더보기</div>
		</div>
	</c:if>
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
