<%@ page language="java" contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

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
	
	<link rel="stylesheet" href="../resources/css/star.css">
	

<style>
body{
	padding-top:0px;
}
header{
	background:url(../resources/images/unifiedsearch_bookList.jpeg) no-repeat center;
}
.parallax { 
    background-attachment: fixed;
    background-size: cover;
}
footer{
	margin-top: 60px;
}
.book-hr {
    border: 2px solid #a78c86;
}
strong {
	color:rgba(82, 76, 76, 0.92);
}
hr {
	border: 0.5px solid #a78c86;
}
</style>

<script type="text/javascript">
ToolbarOpacHeight(500);

function getBook(isbn) {
	$(self.location).attr("href","../unifiedsearch/getBook?isbn="+isbn);
}
</script>
</head>

<body>
	<jsp:include page="../layout/toolbar.jsp">
		<jsp:param value="../" name="uri" />
	</jsp:include>
	<header class="parallax"></header>

    <div class="container">
    	<div class="row" style="margin-top:50px">
			<font size="5"><strong>도서  "${keyword}" 에 대한 검색 결과 총  ${total}건 입니다. </strong></font>
		</div>  
		 
		<div class="row" style="margin-bottom:3%">	
			<hr class="book-hr">
		</div>
		
		<c:if test="${total == 0}">
			<h5>"${keyword}"에 대한 결과가 없습니다.</h5>
		</c:if>
    
        <div class="row">
           <c:forEach items="${bookList}" var="book">
        	   	<div class="row">
	    	        <div class="col-lg-2 col-lg-offset-1 col-lg-push-0 col-md-3 col-md-offset-1 col-md-push-0 col-md-pull-0 col-xs-12 col-xs-offset-0 col-xs-push-0 col-xs-pull-0">
	    	       		<c:choose>
  							<c:when test="${book.thumbnail == ''}">
		       		   			<img class="img-thumbnail" src="http://t1.daumcdn.net/book/KOR${book.isbn}" height="240px" width="170px" onerror="this.src='../resources/images/noimage.jpg'">  					
  							</c:when>
  							<c:otherwise>
    	  						<img class="img-thumbnail" src="http://t1.daumcdn.net/book/KOR${book.isbn}" height="240px" width="170px" onerror="this.src='${book.thumbnail}'">
  							</c:otherwise>
						</c:choose>
						<div class="grade-avg" style="padding-left:15%;">
		               		<div id="starWrap" class="gradeAvg star${fn:substring(book.grade.average, 0, 1)}"  style="display: inline-block; float:left; padding-top: 1%;">
								<ul style="padding-left:0">
									<li class="s1"></li>
									<li class="s2"></li>
									<li class="s3"></li>
									<li class="s4"></li>
									<li class="s5"></li>
								</ul>
							</div>
						</div>
						<div  style="display:inline-block; float:left;"><strong>(<fmt:formatNumber value="${book.grade.average}" pattern="0.00"/>)</strong></div><br>
		      		</div>
		            <div class="col-lg-7 col-lg-offset-0 col-lg-push-1 col-lg-pull-0 col-md-7 col-md-offset-0 col-md-push-0 book-body" onclick="getBook(${book.isbn});" id="${book.isbn}">
		                <h4><strong>${book.title}</strong></h4>
		                <p class="author"><strong><c:forEach items="${book.authors}" var="str" varStatus="status">
		   			   	 	${str} <c:if test="${!status.last}"> | </c:if>
   						</c:forEach></strong> </p>
       	        	 	<p><c:forEach items="${book.translators}" var="str" varStatus="status">
    	       	 			<c:if test="${status.first}"> 번역가 : </c:if>
					   	 	${str} <c:if test="${!status.last}"> | </c:if>
   						</c:forEach></p>
        	       	 	<p>정가  : ${book.price}원</p>
	       	            <p>출판일 : ${book.datetime}</p>
	       	            <p>출판사 : ${book.publisher}</p>
       	        	 	<p><img class="creationLike-link" src="https://icongr.am/entypo/heart.svg?size=25&color=ff0000"> ${book.like.totalLike}</p>
		            </div>
		            <div class="col-md-12"></div>
	            </div> 
			<div class="row" style="margin:2%">	
				<hr>
			</div>
            </c:forEach> 
        </div>
    </div>
    <footer class="container-fluid">
		<jsp:include page="../layout/tailbar.jsp"/>
	</footer>
</body>
</html>