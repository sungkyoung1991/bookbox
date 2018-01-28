<%@ page language="java" contentType="text/html" pageEncoding="UTF-8"%>
<!--  ///////////////////////// JSTL  ////////////////////////// -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
	<!-- <script src="../resources/javascript/custom.js"></script> -->

	<style>
	
	   body{
    		padding-top:0px;
    		
    	}
    	header{
    		background:url(../resources/images/creationTest7.jpg) no-repeat center;
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
		.check{
			cursor:pointer;
		}
		.funding-get{
			transition: 0.3s;
		}
	
	</style>


	<script type="text/javascript">
	
	ToolbarOpacHeight(500);
	
	
		$(function(){
			$('.funding-image').on('click', function(){
				$(self.location).attr('href', '../creation/getFunding?fundingNo='+$(this).attr('id'));
			});
			$('.funding-title-get').on('click', function(){
				alert($(this).attr('id'));
				$(self.location).attr('href', '../creation/getFunding?fundingNo='+$(this).attr('id'));
			});
			
			
			$('img.funding-get').hover(function(){
				$(this).css('cursor', 'pointer');
				$(this).css('transform', 'scale(1.024)');	//128/125
			}, function(){
				$(this).css('transform', 'scale(0.9765625)');	//125/128
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
						return '<img src="https://icongr.am/octicons/calendar.svg?size=20px" style="padding-bottom: 4px;"><span class="enddate-style">앞으로 <strong>'+days + '<strong>일</span>';
					}
					var hours = Math.floor( diff/(1000*60*60) );
					if(hours > 0){
						return '<img src="https://icongr.am/octicons/calendar.svg?size=20px" style="padding-bottom: 4px;"><span class="enddate-style">앞으로 <strong>'+hours + '<strong>시간</span>';
					}
					var minutes = Math.floor( diff/(1000*60) );
					if(minutes > 0){
						return '<img src="https://icongr.am/octicons/calendar.svg?size=20px" style="padding-bottom: 4px;"><span class="enddate-style">앞으로 <strong>'+minutes + '<strong>분</span>';
					}else{
						return '마감 임박!!';
					}
					
				})
				
			});
		
//================진행중, 마감펀딩 정렬-==============
	
	$(function(){
		
			//진행중 펀딩 목록
			$('.recent-list').on('click', function(){
				$(self.location).attr('href', '../creation/getFundingList?condition=2');
				/* $.ajax({
					url : "rest/getFundingList?condition=2",
					method : "get",
					dataType : "json",
					success : function(JSONData, status) {
						alert(status);
						
						$('.recent-list img').attr('src','https://icongr.am/entypo/check.svg?size=20px');
						$('.enddate-list img').attr('src','https://icongr.am/entypo/check.svg?size=20px&color=bbbbbb');	
						$('.funding-list-form').html('');
						
						for (var i=0; i<JSONData.size(); i++){
						var newBlock = $('.hidden-block').clone();
						$(newBlock).find('.~~~').val(JSONData[i].~);
						
						
						
						$(newBlock).show();
						$('.funding-list-form').append(newBlock);
						
						}
						
					}
				}); */
			});
			
			//마감 펀딩 목록
			$('.enddate-list').on('click', function(){
				$(self.location).attr('href', '../creation/getFundingList?condition=4');
				/* $.ajax({
					url : "rest/getFundingList?condition=4",
					method : "get",
					dataType : "json",
					success : function(JSONData, status) {
						alert(status);
						
						$('.recent-list img').attr('src','https://icongr.am/entypo/check.svg?size=20px&color=bbbbbb');
						$('.enddate-list img').attr('src','https://icongr.am/entypo/check.svg?size=20px');						
					}
				});*/
			}); 
			
		});
		
		
	</script>
</head>

<body>
	<jsp:include page="../layout/toolbar.jsp">
		<jsp:param value="../" name="uri"/>
	</jsp:include>
		<header class="parallax"></header>
	<!-- 여기부터 코딩 -->

    <div class="container" id="list" style="margin-bottom:80px;background-color: rgb(245, 238, 238);">
			<jsp:include page="creationToolbar.jsp"/>
			
			<div class="row" style="">
				<div class="col-md-6 text-left">
					<p class="paging">전체 <strong>${fundingList.size() }</strong> 건수</p>
				</div>
				<div class="col-md-6 col-xs-hidden" style="text-align: right;">
				<c:if test="${search.condition =='0' } or ${search.condition =='1' }">
					<span class="check recent-list"><img src="https://icongr.am/entypo/check.svg?size=20px"> 최신순</span>
					<span class="check enddate-list"><img src="https://icongr.am/entypo/check.svg?size=20px&color=bbbbbb"> 마감순</span>
				</c:if>
				<c:if test="${search.condition ==  '2'}">
					<span class="check recent-list"><img src="https://icongr.am/entypo/check.svg?size=20px"> 진행중</span>
					<span class="check enddate-list"><img src="https://icongr.am/entypo/check.svg?size=20px&color=bbbbbb"> 마감펀딩</span>
				</c:if>
				<c:if test="${search.condition ==  '4'}">
					<span class="check recent-list"><img src="https://icongr.am/entypo/check.svg?size=20px&color=bbbbbb"> 진행중</span>
					<span class="check enddate-list"><img src="https://icongr.am/entypo/check.svg?size=20px"> 마감펀딩</span>
				</c:if>
				</div>
			</div>
			
			<c:if test="${empty fundingList }">
			<div class="row funding-list-form text-center" style="height: 100px;padding-top: 30px"> 등록된 글이 존재하지 않습니다.</div>
			</c:if>
			
			<c:if test="${!empty fundingList }">	
			
				<div class="row funding-list-form">
					<c:forEach var="funding" items="${fundingList }">
						
						<div class= "col-md-3 col-sm-6"> 
					<div class="row each-funding" style="width:100%;margin-left:0px;margin-right:0px;margin-bottom:25px">
					
						<div id="${funding.fundingNo}" class="funding-image button-form" style="height:200px; position:relative;overflow:hidden;">
							<img  class="funding-get img-object-fit" src="../resources/upload_files/images/${funding.fundingFileName}">
						</div>
					
						<div class="funding-content" style="height:170px;background-color:#ffffff;;padding-bottom: 1px;border-bottom: 1px groove;">
						
							<div class="funding-title button-form" style="margin-left: 10px;padding-top: 15px;height: 65%;">
								<div id="${funding.fundingNo}" class="funding-title-get text-left funding-title" style="font-size: large;font-weight: bold;">${funding.fundingTitle}</div>
								<div id="${funding.creation.creationAuthor.email}" class="booklog-get text-left funding-nickname" style="font-size: small;">${funding.creation.creationAuthor.nickname}</div>
							</div>

		                    <div class="progress-form" >      
								<div class="progress progress-xs" style="height: 5px;margin-left: 8px;margin-right: 8px;margin-bottom: 0;">
			                          <div class="progress-bar progress-bar-warning progress-bar-striped active" 
			                          		aria-valuenow="${(funding.perFunding * fn:length(funding.payInfoList))/funding.fundingTarget * 100}" aria-valuemin="0" aria-valuemax="100"
			                          		style="min-width: 0.5em; width: ${(funding.perFunding * fn:length(funding.payInfoList))/funding.fundingTarget * 100}%;">
			                          </div>
			                     </div>
		                     </div>
						 
						 <div class="row funding-bottom" style="position:relative;margin-right: 15px;padding-top:15px;margin-left:10px;">
	                          <div class="funding-endDate" style="bottom: 5px;float: left;">${funding.fundingEndDate }</div>
							  <div class="funding-percent" style="padding-left: 10px;bottom: 5px;float: right;font-size: larger;"><fmt:formatNumber value="${(funding.perFunding * fn:length(funding.payInfoList))/funding.fundingTarget * 100}" pattern="0.0"/>%</div>
						</div>
					</div>
					<c:if test="${funding.active ==0 }">
					<div class="endfunding-img"><strong style="font-size: -webkit-xxx-large; color: burlywood;position: absolute;">펀딩종료</strong></div>
					</c:if>
				</div>
			</div>
					</c:forEach>
				</div>
			</c:if>
			
			
			
						
			<div class= "col-md-3 col-sm-6 hidden-block" style="display: none;"> 
					<div class="row each-funding" style="width:100%;margin-left:0px;margin-right:0px;margin-bottom:25px">
					
						<div id="${funding.fundingNo}" class="funding-image button-form" style="height:200px; position:relative;overflow:hidden;">
							<img  class="funding-get img-object-fit" src="../resources/upload_files/images/${funding.fundingFileName}">
						</div>
					
						<div class="funding-content" style="height:170px;background-color:#ffffff;;padding-bottom: 1px;border-bottom: 1px groove;">
						
							<div class="funding-title button-form" style="margin-left: 10px;padding-top: 15px;height: 65%;">
								<div id="${funding.fundingNo}" class="funding-title-get text-left funding-title" style="font-size: large;font-weight: bold;">${funding.fundingTitle}</div>
								<div id="${funding.creation.creationAuthor.email}" class="booklog-get text-left funding-nickname" style="font-size: small;">${funding.creation.creationAuthor.nickname}</div>
							</div>

		                    <div class="progress-form" >      
								<div class="progress progress-xs" style="height: 5px;margin-left: 8px;margin-right: 8px;margin-bottom: 0;">
			                          <div class="progress-bar progress-bar-warning progress-bar-striped active" 
			                          		aria-valuenow="${(funding.perFunding * fn:length(funding.payInfoList))/funding.fundingTarget * 100}" aria-valuemin="0" aria-valuemax="100"
			                          		style="min-width: 0.5em; width: ${(funding.perFunding * fn:length(funding.payInfoList))/funding.fundingTarget * 100}%;">
			                          </div>
			                     </div>
		                     </div>
						 
						 <div class="row funding-bottom" style="position:relative;margin-right: 15px;padding-top:15px;margin-left:10px;">
	                          <div class="funding-endDate" style="bottom: 5px;float: left;">${funding.fundingEndDate }</div>
							  <div class="funding-percent" style="padding-left: 10px;bottom: 5px;float: right;font-size: larger;"><fmt:formatNumber value="${(funding.perFunding * fn:length(funding.payInfoList))/funding.fundingTarget * 100}" pattern="0.0"/>%</div>
						</div>
					</div>
					<c:if test="${funding.active ==0 }">
					<div class="endfunding-img"><strong style="font-size: -webkit-xxx-large; color: burlywood;position: absolute;">펀딩종료</strong></div>
					</c:if>
				</div>
			</div>
				
					
			</div>
			

    
	<footer class="container-fluid">
		<jsp:include page="../layout/tailbar.jsp"/>
	</footer>

	
</body>
</html>
