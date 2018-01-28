<%@ page language="java" contentType="text/html" pageEncoding="UTF-8"%>
<!--  ///////////////////////// JSTL  ////////////////////////// -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
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

	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/Swiper/3.4.2/css/swiper.css">
	 
	<script src="https://cdnjs.cloudflare.com/ajax/libs/Swiper/3.4.2/js/swiper.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/Swiper/3.4.2/js/swiper.jquery.js"></script>
	
	
	<style>
    .swiper-container {
        width: 100%;
        height: 35%;
    }
    .swiper-slide {
        text-align: center;
        font-size: 18px;
        background-color: rgb(245, 238, 238);
        /* margin-bottom:30px; */
         margin: 10px 0px 10px 0px; 
         overflow: none;
                
        /* Center slide text vertically */
        display: -webkit-box;
        display: -ms-flexbox;
        display: -webkit-flex;
        display: flex;
        -webkit-box-pack: center;
        -ms-flex-pack: center;
        -webkit-justify-content: center;
        justify-content: center;
        -webkit-box-align: center;
        -ms-flex-align: center;
        -webkit-align-items: center;
        align-items: center;
    }
    .swiper-slide.swiper-slide-active{
     	margin-right:0px;
     }
    
    body{
    		padding-top:0px;
    		
    	}
    	header{
    		background:url(../resources/images/creationTest7.jpg) no-repeat center;
    	}
    	
    .creation-list{
    	margin : 4px 8px;
    	vertical-align: middle;
	    height: 200px;
    	background-color: none;
    }
    
    .creation-part{
    	margin-top :0px;
    	
    }
    
    .tag-space{
    	font-size: 15px;
	    font-weight: 700;
        padding-left: 30px;
   		padding-top: 33px;
    }
    
    .endfunding-img{
    	background-color:rgba(24, 24, 25, 0.41);
    	position:absolute;
    	top:0;
    	left:0;
    	z-index:3;
    	height:100%;
    	width:100%;
    }
    
    span.tag{
			margin-right: 2px; 
			border: 1px solid;
			border-color: #bbbbbb;
			border-radius: 15px;
			padding: 4px;
			font-weight: bold;
		}
		#more{
			cursor:pointer;
		}
		.button-form{
			cursor:pointer;
		}
		.progress-bar-warning:last-child.progress-bar:before {
		    background-color: rgb(221, 221, 221);
		}
		.progress-bar-warning {
		    background-color: rgba(14, 197, 147, 0.87);
		}
		span.enddate-style{
			    font-size: initial;
		}
		a{
			color:#666666;
		}
		
		.item{
		    margin: 5%;
	            border-bottom: 1px groove;
   			background-color: #fff;
    	}
    	.swiper-pagination-bullet-active {
    		background:#ff2500;
    	}
    	.swiper-button-next, .swiper-container-rtl .swiper-button-prev{
    		background: url(//t1.daumcdn.net/brunch/static/img/help/pc/top/ico_brunch_v8.png) no-repeat;
    		width: 100px;
    		height: 100px;
   		    float: left;
   			background-position: -269px -175px;
   			 text-indent: -9999px;
			display: inline-block;
			line-height: 0;
			vertical-align: top;
    	}
    	.swiper-button-prev, .swiper-container-rtl .swiper-button-next{
   			background: url(//t1.daumcdn.net/brunch/static/img/help/pc/top/ico_brunch_v8.png) no-repeat;
			width: 100px;
   			height: 100px;
    		float: right;
   		 	background-position: -167px -175px;
   			text-indent: -9999px;
   			overflow: hidden;
   			display: inline-block;
   			line-height: 0;
   			vertical-align: top;
   		}
   		.funding-badge{
    	position: absolute;
    	z-index: 3;
   	    transform: translate(-100%,-30%); 
 	    background-color: antiquewhite;
    	border-radius: 50%;
    }
    	
    	
    </style>

	
	 <!-- Initialize Swiper -->
    <script>
    
    ToolbarOpacHeight(500);
    
    $(function(){
   
    //================swiper===============	
    	var swiper = new Swiper('.swiper-container', {
        	pagination: '.swiper-pagination',
        	slidesPerView: 4,
        	paginationClickable: true,
        	spaceBetween: 5,
        /* 	autoplay : {
        		delay : 5000
        	}, */
    		navigation : {
    			nextEl : '.swiper-button-next',
    			prevEl : '.swiper-button-prev',
    		}
	    });
    })

    
    //============= 펀딩글보기 Navigation Event  처리 =============	
$(function() {
	$(".funding-image").on("click" , function() {
		$(self.location).attr("href","../creation/getFunding?fundingNo="+$(this).attr('id').trim());
	}); 
});
    
   //============= 펀딩글보기 Navigation Event  처리 =============	
   $(function() {
   	$(".funding-title").on("click" , function() {
   		$(self.location).attr("href","../creation/getFunding?fundingNo="+$(this).attr('id').trim());
   	}); 
 });
   
   //============= 펀딩리스트 전체보기> Navigation Event  처리 =============	
   $(function() {
	   $("a.fundingMore").on("click" , function() {
   		$(self.location).attr("href","../creation/getFundingList");
   	}); 
 });  
   
   //============= 픽션 창작리스트 전체보기> Navigation Event  처리 =============	
   $(function() {
	   $("a.fictionMore").on("click" , function() {
   		$(self.location).attr("href","../creation/getCreationList?condition=2&keyword=픽션");
   	}); 
 });   
   
   //============= 논픽션 창작리스트 전체보기> Navigation Event  처리 =============	
   $(function() {
	   $("a.nonfictionMore").on("click" , function() {
   		$(self.location).attr("href","../creation/getCreationList?condition=2&keyword=논픽션");
   	}); 
 });   
   
   //============= 창작작품 회차리스트 Navigation Event  처리 =============	
   $(function() {
   	$("a:contains('창작작품명')").on("click" , function() {
   		$(self.location).attr("href","../creation/getWritingList?creationNo=");
   	}); 
 });  
   
   //============= 창작글쓰기 Navigation Event  처리 =============	
   $(function() {
	  $(".addWriting").on("click" , function() {
		  $(self.location).attr("href","../creation/addWriting");
		}); 
 });   
   
   
   //============= 창작작품보러가기 Navigation Event  처리 =============	
   $(function() {
	  $(".creation-title").on("click" , function() {
		  $(self.location).attr("href","../creation/getWritingList?creationNo="+$(this).attr('id'));
   		}); 
 });  
   
   //============= 작가북로그 Navigation Event  처리 =============	
   $(function() {
	  $(".creation-author").on("click" , function() {
		  $(self.location).attr("href","../booklog/getBooklog?user.email="+$(this).attr('id'));
   	}); 
 });  
   

   
	//============= 펀딩 남은기간 계산 =============
   $(function(){
		$('.funding-endDate').html(function(){
			var today =new Date();
			var endDay =new Date($(this).html().trim()+" 00:00:00");
			var diff = endDay.getTime()-today.getTime();
			if(diff < 0){
				return '펀딩마감';
			}

			var days = Math.floor(diff/(1000*60*60*24));
			if(days > 0){
				return '<img src="https://icongr.am/octicons/calendar.svg?size=20px"><span class="enddate-style">앞으로 <strong>'+days + '<strong>일</span>';
			}
			var hours = Math.floor( diff/(1000*60*60) );
			if(hours > 0){
				return hours + '시간 남음';
			}
			var minutes = Math.floor( diff/(1000*60) );
			if(minutes > 0){
				return minutes + '분 남음';
			}else{
				return '마감 임박!!';
			}
			
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
	
	<jsp:include page="creationToolbar.jsp"/>

  <div class="row creation-part">
      <div style="width: 42%;border: #bbbbbb 1px solid;display: inline-block;"></div>
      <div class="text-center" style="width: 15%; display: inline-block; font-size: 27px;font-weight: 400; font-style: italic;">
         <span>FUNDING</span>
      </div>
      <div style="width: 42%;border: #bbbbbb 1px solid;display: inline-block;"></div>
   </div>
	
		   <div class="row text-right col-sm-offset-11 col-sm-1" style="margin-top:50px">
		   		<a  class="fundingMore" id="more">더보기 <img src="https://icongr.am/entypo/chevron-right.svg?size=20px"></a>
		   </div>
	
    <!-- Swiper -->
    	<div class="swiper-container" id= list style="margin-bottom: 50px;background-color: rgb(245, 238, 238);">
        	<div class="swiper-wrapper" >
            <c:forEach items="${fundingList}" var="funding">	
			        
            <div class="swiper-slide" style="overflow:hidden">
				<div class="item" style="width:100%;">
					<div id="${funding.fundingNo}" class="funding-image button-form" style="height:200px; background-color:rgba(114, 114, 114, 0.48);position:relative;overflow:hidden;">
						<img style="width:100%;position: absolute;  left: 50%;  top: 50%; transform: translate(-50%, -50%);" class="img-responsive funding-get img-object-fit" src="../resources/upload_files/images/${funding.fundingFileName}">
					</div>
					<div class="funding-content" style="height:150px;/* background-color:aliceblue; */padding-bottom: 10px; ">
						
						<div class="funding-title button-form" style="margin-left: 10px;padding-top: 15px;height: 75%;">
							<div id="${funding.fundingNo}" class="funding-get text-left funding-title" style="font-size: large;font-weight: bold;">${funding.fundingTitle}</div>
							<div id="${funding.creation.creationAuthor.email}" class="booklog-get text-left creation-author" style="font-size: small;">${funding.creation.creationAuthor.nickname}</div>
						</div>

	                    <div class="progress-form" >      
							<div class="progress progress-xs" style="height: 5px;margin-left: 8px;margin-right: 8px;">
		                          <div class="progress-bar progress-bar-warning progress-bar-striped active" 
		                          		aria-valuenow="${(funding.perFunding * fn:length(funding.payInfoList))/funding.fundingTarget * 100}" aria-valuemin="0" aria-valuemax="100"
		                          		style="min-width: 0.5em; width: ${(funding.perFunding * fn:length(funding.payInfoList))/funding.fundingTarget * 100}%;">
		                          </div>
		                     </div>
	                     </div>
						 <div class="funding-bottom" style="position:relative;margin-right: 10px;">
	                          <div class="funding-endDate" style="padding-left: 10px;bottom: 5px;float: left;">${funding.fundingEndDate }</div>
							  <div class="funding-percent" style="padding-left: 10px;bottom: 5px;float: right;font-size: larger;">
							  <fmt:formatNumber value="${(funding.perFunding * fn:length(funding.payInfoList))/funding.fundingTarget * 100}" pattern="0.0"/>%</div>
						</div>
					</div>
					<c:if test="${funding.active ==0 }">
					<div class="endfunding-img"><strong style="font-size: -webkit-xxx-large; color: burlywood;position: absolute;">펀딩종료</strong></div>
					</c:if>
				</div>
			</div>
		</c:forEach>
     </div>
        <!-- Add Pagination -->
        <div class="swiper-pagination" style="height:6px;"></div>
        <div class="swiper-button-next"></div>
        <div class="swiper-button-prev"></div>
    </div>
        
  <div class="row creation-part" >
      <div style="width: 42%;border: #bbbbbb 1px solid;display: inline-block;"></div>
      <div class="text-center" style="width: 15%; display: inline-block; font-size: 27px;font-weight: 400; font-style: italic;">
         <span>FICTION</span>
      </div>
      <div style="width: 42%;border: #bbbbbb 1px solid;display: inline-block;"></div>
   </div>
   
   <div class="row" style="margin-top:50px">
	   <div class="col-sm-12 col-md-12">
		<c:forEach var="fiction" items="${fictionList }" >
		  		 <div class="row creation-list" >
					<div class="col-sm-4 col-md-4" style="height:100%;background-color:rgba(114, 114, 114, 0.48);">
					<c:if test="${fiction.doFunding }">
							<div class="funding-badge">
							<img src="https://icongr.am/entypo/credit.svg?size=25px&color=ff9a3c" style="position: absolute; left: 50%;top: 50%;transform: translate(30%, -105%);">
							<img src="https://icongr.am/material/account-multiple.svg?size=45px&color=092a35"></div>	
					</c:if>	
						<img style="position: absolute;  left: 50%;  top: 50%; transform: translate(-50%, -50%);" class="img-responsive img-object-fit" alt="Image" src="../resources/upload_files/images/${fiction.creationFileName}" name="creationFile">
					</div>
					<div class="col-sm-8 col-md-8">
						<div class="row">
							<div class="col-sm-12" style="padding-top: 10px;">
								<strong class="creation-title button-form" id="${fiction.creationNo }" style="font-size:x-large;cursor:pointer;">${fiction.creationTitle }   </strong> 
								<span class="creation-author button-form" id=${fiction.creationAuthor.email } style="font-size:15px;cursor:pointer;">   by.${fiction.creationAuthor.nickname }</span>
							</div>
						</div>
						<div class="row">	
							<div class="col-sm-offset-1 col-sm-11 text-left" style="padding-top: 15px;    padding-right: 45px;">
								<span class="posting-content">${fiction.creationIntro }</span>
							</div>
						</div>
						<div class="row">
							<div class="tag-space">
								<c:forEach var="tag" items="${fiction.tagList }">
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
   
   <div class="row text-right col-sm-offset-11 col-sm-1">
		<a  class="fictionMore button-form" id="more">더보기 <img src="https://icongr.am/entypo/chevron-right.svg?size=20px"></a>
	</div>
   
  <div class="row creation-part" >
      <div style="width: 42%;border: #bbbbbb 1px solid;display: inline-block;"></div>
      <div class="text-center" style="width: 15%; display: inline-block; font-size: 27px;font-weight: 400; font-style: italic;">
         <span>MAGAGINES</span>
      </div>
      <div style="width: 42%;border: #bbbbbb 1px solid;display: inline-block;"></div>
   </div>
   
   <div class="row" style="margin-top:50px">
	   <div class="col-sm-12 col-md-12">
		<c:forEach var="nonfiction" items="${nonFinctionList }" >
		  		 <div class="row creation-list" >
					<div class="col-sm-8 col-md-8" >
						<div class="row">
							<div class="col-sm-12" style="padding-top: 10px;">
								<strong class="creation-title button-form" id="${nonfiction.creationNo }" style="font-size:x-large">${nonfiction.creationTitle }   </strong> 
								<span class="creation-author button-form" id=${nonfiction.creationAuthor.email } style="font-size:15px;">   by.${nonfiction.creationAuthor.nickname }</span>
							</div>
						</div>	
						<div class="row">
							<div class="col-sm-offset-1 col-sm-11 text-left"  style="padding-top: 15px;padding-right: 45px;">
								<span class="posting-content">${nonfiction.creationIntro }</span>
							</div>
						</div>
						<div class="row">
							<div class="tag-space">
								<c:forEach var="tag" items="${nonfiction.tagList }">
										<span class="tag button-form">#${tag.tagName }</span>
								</c:forEach>
							</div>
						</div>
					</div>
					<div class="col-sm-4 col-md-4" style="height:100%; background-color:rgba(114, 114, 114, 0.48);">
						<c:if test="${nonfiction.doFunding }">
							<div class="funding-badge">
							<img src="https://icongr.am/entypo/credit.svg?size=25px&color=ff9a3c" style="position: absolute; left: 50%;top: 50%;transform: translate(30%, -105%);">
							<img src="https://icongr.am/material/account-multiple.svg?size=45px&color=092a35"></div>	
						</c:if>
						<img style="position: absolute;  left: 50%;  top: 50%; transform: translate(-50%, -50%);" class="img-responsive img-object-fit" alt="Image" src="../resources/upload_files/images/${nonfiction.creationFileName }" name="creationFile">
					</div>
		   		</div>
		   		<hr>
		</c:forEach>	   
	   </div>
   </div>
    <div class="row text-right col-sm-offset-11 col-sm-1" style="    margin-bottom: 80px;">
		<a  class="nonfictionMore button-form" id="more" >더보기 <img src="https://icongr.am/entypo/chevron-right.svg?size=20px"></a>
	</div>


</div>

	
	<footer class="container-fluid">
		<jsp:include page="../layout/tailbar.jsp"/>
	</footer>
   
</body>
</html>