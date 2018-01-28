<%@ page language="java" contentType="text/html" pageEncoding="UTF-8"%>
<!--  ///////////////////////// JSTL  ////////////////////////// -->
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
	<script src="../resources/javascript/custom.js"></script>

	<!-- 평점 별 css -->
	<link rel="stylesheet" href="../resources/css/star.css">
	
	<style>
 
        body{
    		padding-top:0px;
    		
    	}
    	header{
    		background:url(../resources/images/newCreationTest2.jpg) no-repeat center;
    	}
    	.creation-list{
	    	margin : 4px 8px;
	    	vertical-align: middle;
		    height: 220px;
	    	background-color: none;/* rgba(255, 236, 218, 0.63); */
	    	position: relative;
   		}
   		.tag-space{
	    	font-size: 12px;
		    font-weight: 700;
	        padding-left: 30px;
	   		padding-bottom: 20px;
    }
    .button-form{
    	cursor:pointer;
    }
    .funding-badge{
    	position: absolute;
    	z-index: 3;
   	     transform: translate(-50%,-30%); 
   	    background-color: antiquewhite;
    	border-radius: 50%;
    }
 
    </style>

	

    <script>
	   ToolbarOpacHeight(500);
    
   $(function() {
	   
  //============= 창작글리스트 조회 Navigation Event  처리 =============	
	  $("a.creationTitle").on("click" , function() {
   		$(self.location).attr("href","../creation/getWritingList?creationNo="+$(this).attr("id"));
   	
   	}); 
           
   //============= 검색 Event  처리 =============	
	  $("a.creationSearch").on("click" , function() {
   		$(self.location).attr("href","../creation/getCreationList?condition="+$("select[name='condition']").val()+"&keyword="+$("input[name='keyword']").val());
   	
   	}); 
   
	   //============= 창작글회차 리스트 Event  처리 =============	
	  $(".creation-title").on("click" , function() {
   		$(self.location).attr("href","../creation/getWritingList?creationNo="+$(this).attr('id'));
		}); 
	  
	//============= 작가북로그 Navigation Event  처리 =============
	  $(".creation-author").on("click" , function() {
		  $(self.location).attr("href","../booklog/getBooklog?user.email="+$(this).attr('id'));
   		}); 
	
   });
   
   $(function(){
	  	$('.grade-list').on('click',function(){
	  		
	  		
	  		
	  	})	   
   })

   
    </script>
		

</head>
<body>
	<jsp:include page="../layout/toolbar.jsp" >
		<jsp:param value="../" name="uri"/>
	</jsp:include>
	<header class="parallax"></header>
	
		<div class="container" >
				<jsp:include page="creationToolbar.jsp"/>
      	  
		<div class="row" >
					<div class="col-md-6 text-left">
						<p class="paging">전체 ${creationList.size() } 건수</p>
					</div>
					<div class="col-md-6 col-xs-hidden" style="text-align: right;">
						<span class="check recent-list"><img src="https://icongr.am/entypo/check.svg?size=20px"> 최신순</span>
						<span class="check grade-list"><img src="https://icongr.am/entypo/check.svg?size=20px&color=bbbbbb">별점순</span>
						<span class="check keyword-fintion-list"><img src="https://icongr.am/entypo/check.svg?size=20px&color=bbbbbb">픽션</span>
						<span class="check keyword-nonfiction-list"><img src="https://icongr.am/entypo/check.svg?size=20px&color=bbbbbb">논픽션</span>
					</div>
		</div>
	
	   <div class="row" style="margin-top:30px">
	   <div class="col-sm-12 col-md-12">
	   	   		<div class="row">
				<c:forEach var="creation" items="${creationList }" >
				  		 <div class="row creation-list" >
				  		 <c:if test="${creation.doFunding }">
				  		 	<div class="funding-badge">
							<img src="https://icongr.am/entypo/credit.svg?size=25px&color=ff9a3c" style="position: absolute; left: 50%;top: 50%;transform: translate(30%, -105%);">
							<img src="https://icongr.am/material/account-multiple.svg?size=45px&color=092a35"></div>	
								
						 </c:if>	
							<div class="col-sm-4 col-md-4" style="padding: 0;height:100%;background-color:rgba(114, 114, 114, 0.48);overflow:hidden;">
								<img  class="img-responsive img-object-fit" alt="Image" src="../resources/upload_files/images/${creation.creationFileName}" name="creationFile">
							</div>
							<div class="col-sm-8 col-md-8" style="height:100%">
								<div class="row">
									<div class="col-sm-12" style="padding-top: 10px;">
										<strong class="creation-title button-form" id="${creation.creationNo }" style="font-size:x-large">${creation.creationTitle }   </strong> 
										<span class="creation-author button-form" id=${creation.creationAuthor.email } style="font-size:15px;">   by.${creation.creationAuthor.nickname }</span>
									</div>
									<div class="grade-avg" style="padding-left: 2.3%;">
										<div id="starWrap" class="gradeAvg star${fn:substring(creation.grade.average, 0, 1)}"  style="display: inline-block; float:left;    padding-top: 0.6%;" >
											<ul style="padding-left:0">
												<li class="s1"></li>
												<li class="s2"></li>
												<li class="s3"></li>
												<li class="s4"></li>
												<li class="s5"></li>
											</ul>
										</div>
									</div>
										<div  style="display: inline-block; float:left;"><strong>(<fmt:formatNumber value="${creation.grade.average}" pattern="0.00"/>)</strong></div>
									
								</div>
								<div class="row">	
									<div class="col-sm-offset-1 col-sm-11 text-left" style="padding-top: 15px;    padding-right: 45px;">
										<span class="posting-content">${creation.creationIntro }</span>
									</div>
								</div>
								<div class="row" style="bottom: 0;position: absolute;">
									<div class="tag-space">
										<c:forEach var="tag" items="${creation.tagList }">
												<span class="tag button-form">#${tag.tagName }</span>
										</c:forEach>
									</div>	
								</div>
							</div>
				   		</div>
				   		<hr>
				</c:forEach>	   
			</div>	
	   </div>
   </div>
	
	
	

<%-- 	<div class="row creation-list" style="margin-left: 15px;margin-right: 15px;">
		<c:forEach var="creation" items="${creationList}" >
		<div class="row creation-row">
			<input type ="text" name="creationNo" value="${creation.creationNo }"/>
			<div class="col-md-5">
				<img class="img-responsive creation-img" src="../resources/upload_files/images/${creation.creationFileName}" alt="Image" onerror="this.src='../resources/images/noimage.jpg'">
				<!-- <img class="img-responsive creation-img" src="../resources/images/creation_noimage.jpg" alt="Image"> -->
				<p>펀딩여부</p>
			</div>
			<div class="col-md-7">
				<p><a  class="creationTitle" id="${creation.creationNo }">${creation.creationTitle }</a></p>
				<p>${creation.creationAuthor.nickname }</p>
					<c:forEach var="tag" items="${creation.tagList }">	
						<span>#${tag.tagName }</span>
					</c:forEach>
						
				<!-- 별점 -->
				<div id="starWrap" class="star5${book.grade.average}">
					<ul>
						<li class="s1"></li>
						<li class="s2"></li>
						<li class="s3"></li>
						<li class="s4"></li>
						<li class="s5"></li>
					</ul>
				</div>
				<!-- 별점끝 -->	
			</div>
		</div>        
		</c:forEach>
	</div> --%>
		
        	
</div>

	<footer class="container-fluid">
		<jsp:include page="../layout/tailbar.jsp"/>
	</footer>

</body>
</html>