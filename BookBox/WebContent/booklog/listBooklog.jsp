<%@ page language="java" contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
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

	<style>
		.div-booklog{
			padding: 5px;
		}
	</style>
	
	<script type="text/javascript">
		var isListLoading = false;
		var condition, keyword, currentPage;
		
		$(function(){
			condition = $('input[name="condition"]').val();
			keyword = $('input[name="keyword"]').val();
			currentPage = 1;

			fncBooklogEventOn();
			if( $(window).height() >= $(document).height() ){
				if(!isListLoading){
					fncGetBooklogList();
				}
			}
		});
		
		
		$(window).scroll(function(){
			if($(window).scrollTop() >= $(document).height() - $(window).height() - 40){
				if(!isListLoading){
					fncGetBooklogList();
				}
			}
		});
		
		function fncGetBooklogList(){
			$('.img-loading').show();
			isListLoading = true;
			currentPage = currentPage + 1;
			$.ajax({
				url: 'rest/getBooklogList/'+currentPage,
				method: 'post',
				data: JSON.stringify({
					condition : condition,
					keyword : keyword
				}),
				headers : {
					'Accept' : 'application/json',
					'Content-Type' : 'application/json'
				},
				dataType: 'json',
				success: function(data){
					if(data.booklogList.length == 0){
						$('.img-loading').hide();
						return;
					}
					for(var i=0; i<data.booklogList.length; i++){
						var divHtml = '<div class="col-sm-6"><div class="booklog-card"><div class="booklog-card-board booklog-background"><div class="booklog-img-box">';
						divHtml += '<img class="img-object-fit" src="../resources/upload_files/images/'+data.booklogList[i].booklogImage+'"></div>';
						divHtml += '<div class="booklog-content-box"><input type="hidden" name="booklogNo" value="'+data.booklogList[i].booklogNo+'"><input type="hidden" name="booklogUser" value="'+data.booklogList[i].user.email+'">';
						divHtml += '<p class="lead"><strong>'+data.booklogList[i].booklogName+'</strong></p><p>'+data.booklogList[i].booklogIntro+'</p></div>';
						divHtml += '<div class="booklog-content-count hidden-xs hidden-sm"><div class="content-count-box creation-count"><span class="content-icon"><i class="glyphicon glyphicon-pencil"></i> </span>&nbsp;<span class="content-count"><img class="loading-img" src="../resources/images/loading.gif" style="height: 25px;"></span></div><div class="horizontal-line" style="top: 32.3333333%"></div>';
						divHtml += '<div class="content-count-box posting-count"><span class="content-icon"><i class="glyphicon glyphicon-grain"></i> </span>&nbsp;<span class="content-count"><img class="loading-img" src="../resources/images/loading.gif" style="height: 25px;"></span></div>';
						divHtml += '<div class="horizontal-line" style="top: 65.6666666%"></div><div class="content-count-box bookmark-count"><span class="content-icon"><i class="glyphicon glyphicon-bookmark"></i> </span>&nbsp;<span class="content-count"><img class="loading-img" src="../resources/images/loading.gif" style="height: 25px;"></span></div>';
						divHtml += '</div></div></div></div>';
						$('.booklog-list-box > div').append(divHtml);
					}
					fncFooterPositioning();
					fncBooklogEventOn();
					isListLoading = false;
					$('.img-loading').hide();
				}
			});
			
		}
		function fncBooklogEventOn(){
			$('.booklog-content-box').off('click').on('click', function(){
				var booklogNo = $(this).find('input[name="booklogNo"]').val();
				$(self.location).attr("href","../booklog/getBooklog?booklogNo="+booklogNo);
			});

			for(var i=0; i<$('.booklog-content-count').length; i++){
				var booklogUser = $($('.booklog-content-box')[i]).find('input[name="booklogUser"]').val();
				$.ajax({
					url: 'rest/getCounts/'+booklogUser.split('@')[0]+'/'+booklogUser.split('.')[0].split('@')[1]+'/'+booklogUser.split('.')[1]+'/'+i,
					method: 'get',
					dataType: 'json',
					success: function(data){
						$($($('.booklog-content-count')[data.index]).find('.content-count')[0]).html(data.counts.cc>999? '999+':data.counts.wc).find('.loading-img').hide();
						$($($('.booklog-content-count')[data.index]).find('.content-count')[1]).html(data.counts.pc>999? '999+':data.counts.pc).find('.loading-img').hide();
						$($($('.booklog-content-count')[data.index]).find('.content-count')[2]).html(data.counts.bc>999? '999+':data.counts.bc).find('.loading-img').hide();
						$($('.booklog-content-count')[data.index]).find('i.glyphicon-bookmark').addClass(data.bookmark == 'true'? 'bookmarked':'nobookmarked');
					}
				});
			}
		}
	</script>
	
</head>
<body>
	<jsp:include page="../layout/toolbar.jsp" >
		<jsp:param value="../" name="uri"/>
	</jsp:include>

	<div class="container">
		<input type="hidden" name="condition" value="${search.condition}">
		<input type="hidden" name="keyword" value="${search.keyword}">
	    <div class="row booklog-list-box">
	    	<div class="col-xs-12">
	    
		    	<c:forEach items="${booklogList}" var="booklog">
		    		<div class="col-sm-6">
		    			<div class="booklog-card">
		    				<div class="booklog-card-board booklog-background">
		    					<div class="booklog-img-box">
		    						<img class="img-object-fit" src="../resources/upload_files/images/${booklog.booklogImage}">
		    					</div>
		    					<div class="booklog-content-box">
		    						<input type="hidden" name="booklogNo" value="${booklog.booklogNo}">
		    						<input type="hidden" name="booklogUser" value="${booklog.user.email}">
				    				<p class="lead"><strong>${booklog.booklogName}</strong></p>
				    				<p>${booklog.booklogIntro}</p>
		    					</div>
		    					<div class="booklog-content-count hidden-xs hidden-sm">
		    						<div class="content-count-box creation-count">
										<span class="content-icon"><i class="glyphicon glyphicon-pencil"></i> </span>&nbsp;
										<span class="content-count"><img class="loading-img" src="../resources/images/loading.gif" style="height: 25px;"></span>
		    						</div>
		    						<div class="horizontal-line" style="top: 32.3333333%"></div>
		    						<div class="content-count-box posting-count">
										<span class="content-icon"><i class="glyphicon glyphicon-grain"></i> </span>&nbsp;
										<span class="content-count"><img class="loading-img" src="../resources/images/loading.gif" style="height: 25px;"></span>
		    						</div>
		    						<div class="horizontal-line" style="top: 65.6666666%"></div>
		    						<div class="content-count-box bookmark-count">
										<span class="content-icon"><i class="glyphicon glyphicon-bookmark"></i> </span>&nbsp;
										<span class="content-count"><img class="loading-img" src="../resources/images/loading.gif" style="height: 25px;"></span>
		    						</div>
		    					</div>
		    				</div>
		    			</div>
		    		</div>
		    	</c:forEach>
	    
	    	</div>
			<img class="img-loading" src="../resources/images/loading.gif" style="display: none;">
	    </div>
	</div>
	
	<div style="height: 300px;"></div>

	<footer class="container-fluid">
		<jsp:include page="../layout/tailbar.jsp"/>
	</footer>
	
</body>
</html>