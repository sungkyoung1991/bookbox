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
	<script src="../resources/javascript/toolbar_opac.js"></script>
	<script src="../resources/javascript/custom.js"></script>

	<!-- Swiper 설정 -->
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/Swiper/4.0.3/css/swiper.css">
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/Swiper/4.0.3/css/swiper.min.css">
	 
	<script src="https://cdnjs.cloudflare.com/ajax/libs/Swiper/4.0.3/js/swiper.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/Swiper/4.0.3/js/swiper.min.js"></script>
	<!-- Swiper 설정 끝 -->

    <style>
	    .swiper-container {
	        width: 100%;
	        height: 550px;
	        padding-top: 50px;
	        padding-bottom: 50px;
	    }
	    .swiper-slide {
	        background-position: center;
	        background-size: cover;
	        width: 90%;
	    }


    	body{
    		padding-top: 0px;
    	}
    	header{
    		background: url(../resources/images/posting.jpeg) no-repeat center;
    	}
    	
    	.swiper-posting1, .swiper-posting2, .swiper-posting3,
    	.swiper-posting4, .swiper-posting5, .swiper-posting6,
    	.swiper-posting7, .swiper-posting8, .swiper-posting9,
    	.swiper-posting10{
    		position: absolute;
    		margin: 0;
    		padding: 0;
    	}
    	.swiper-posting1 > *, .swiper-posting2 > *, .swiper-posting3 > *,
    	.swiper-posting4 > *, .swiper-posting5 > *, .swiper-posting6 > *,
    	.swiper-posting7 > *, .swiper-posting8 > *, .swiper-posting9 > *,
    	.swiper-posting10 > *{
    		position: absolute;
    		margin: 0;
    		padding: 0;
    		top: 0;
    		left: 0;
    	}
    	.swiper-posting1, .swiper-posting5, .swiper-posting6, .swiper-posting9{
			top: 0;
			left: 0;
    	}
    	.swiper-posting1{
    		height: 100%;
    		width: 38%;
    	}
    	.swiper-posting2{
    		height: 55%;
    		width: 62%;
    		top: 0;
    		left: 38%;
    	}
    	.swiper-posting3, .swiper-posting4{
    		height: 45%;
    		width: 31%;
    		top: 55%;
    	}
    	.swiper-posting3{
    		left: 38%;
    	}
    	.swiper-posting4{
    		left: 69%;
    	}
    	.swiper-posting5, .posting-img-box, .posting-content{
    		height: 100%;
    		width: 100%;
    	}
    	.swiper-posting6{
    		height: 100%;
    		width: 50%;
    	}
    	.swiper-posting7, .swiper-posting8{
    		height: 50%;
    		width: 50%;
    		left: 50%;
    	}
    	.swiper-posting7{
    		top: 0;
    	}
    	.swiper-posting8{
    		top:50%;
    	}
    	.swiper-posting9, .swiper-posting10{
    		height: 100%;
    		width: 50%;
    	}
    	.swiper-posting10{
    		top: 0;
    		left: 50%;
    	}
    	.posting-img-box{
    		overflow: hidden;
    	}
    	.posting-list{
    		bottom: -1%;
    	}
    	.posting-content h3, .posting-content p{
    		color: #ffffff;
    	}
    	.posting-content{
    		background: rgba(0, 0, 0, 0.2);
    		cursor: pointer;
    	}
    	.div-posting{
		    width: 80%;
			position: absolute;
		    top: 50%;
		    left: 50%;
		    text-align: center;    	
		    -webkit-transform: translate(-50%, -50%);
		       -moz-transform: translate(-50%, -50%);
				    transform: translate(-50%, -50%);
    	}
    	
    	
    </style>
	
	<script type="text/javascript">
		var condition;
		ToolbarOpacHeight(500);
		$(function(){
			condition = $('input[name="condition"]').val();
			
			$('a.booklog-list').on('click', function(){
				$(self.location).attr("href","../booklog/getBooklogList?condition="+condition);
			});
			$('a.posting-list').on('click',function(){
				$(self.location).attr('href','../booklog/getPostingList?condition='+condition);
			});
			
			$('.booklog-content-box').on('click', function(){
				var booklogNo = $(this).find('input[name="booklogNo"]').val();
				$(self.location).attr("href","../booklog/getBooklog?booklogNo="+booklogNo);
			});
	
			$('.posting-content').on('click', function(){
				var postingNo = $(this).find('input[name="postingNo"]').val();
				$(self.location).attr("href","../booklog/getPosting?postingNo="+postingNo+"&condition="+condition);
			});
			$('.posting-content').hover(function(){
				$(this).parent().find('img.posting-img').css('-webkit-transform', 'scale(1.1)')
						.css('-moz-transform', 'scale(1.1)')
						.css('transform', 'scale(1.1)');
				$(this).css('background', 'rgba(0, 0, 0, 0.6)');
			}, function(){
				$(this).parent().find('img.posting-img').css('-webkit-transform', 'initial')
						.css('-moz-transform', 'initial')
						.css('transform', 'initial');
				$(this).css('background', 'rgba(0, 0, 0, 0.2)');
			});
			
			//이미지 불러오기 실패시 기본 이미지 출력
			$('img.posting-img').on('error', function(){
				$(this).attr('src', '../resources/images/posting_noimage.jpeg');
			});

			var p1 = $('.swiper-posting1').clone(true);
			var p2 = $('.swiper-posting2').clone(true);
			var p3 = $('.swiper-posting3').clone(true);
			var p4 = $('.swiper-posting4').clone(true);
			var p5 = $('.swiper-posting5').clone(true);
			var p6 = $('.swiper-posting6').clone(true);
			var p7 = $('.swiper-posting7').clone(true);
			var p8 = $('.swiper-posting8').clone(true);
			var p9 = $('.swiper-posting9').clone(true);
			var p10 = $('.swiper-posting10').clone(true);
			$('.posting-slide1').append(p1.show()).append(p2.show()).append(p3.show()).append(p4.show());
			$('.posting-slide2').append(p5.show());
			$('.posting-slide3').append(p6.show()).append(p7.show()).append(p8.show());
			$('.posting-slide4').append(p9.show()).append(p10.show());

			
			
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
		});

		
		$(function(){	        
	        var postingSwiper = new Swiper('.posting-swiper-container', {
	        	spaceBetween: 0,
	        	pagination:{
	        		el: '.swiper-pagination',
	        		clickable: true,
	        	},
	        	slidesPerView: 'auto',
	        	centeredSlides: true,
	        });
	    })
	    

	</script>
</head>
<body>
	<jsp:include page="../layout/toolbar.jsp" >
		<jsp:param value="../" name="uri"/>
	</jsp:include>
	<header class="parallax"></header>
	<!-- 여기부터 코딩 -->
	
	<div class="container" style="padding: 20px 15px;">
		<input type="hidden" name="condition" value="${search.condition}">

		<c:set var="i" value="0"/>
		<c:forEach items="${postingList}" var="posting">
			<c:set var="i" value="${i+1}"/>
			<div class="swiper-posting${i}" style="display: none;">
				<div class="posting-img-box">
					<img class="img-object-fit posting-img" src="../resources/upload_files/images/${posting.postingFileList[0].fileName}">
				</div>
				<div class="posting-content">
					<input type="hidden" name="postingNo" value="${posting.postingNo}"/>
					<div class="div-posting" style="height: auto;">
						<h3>${posting.postingTitle}</h3>
						<p>by. ${posting.user.nickname}</p>
					</div>
				</div>
			</div>
		</c:forEach>

		<div class="row text-center category-space">
			<h2>- 인기 포스팅 -</h2>
		</div>
		
		<div class="row">
			<div class="col-xs-12">
		
				<div class="posting-swiper-container swiper-container">
					<div class="swiper-wrapper">
						<div class="swiper-slide posting-slide1 col-md-9"></div>
						<div class="swiper-slide posting-slide2 col-md-9"></div>
						<div class="swiper-slide posting-slide3 col-md-9"></div>
						<div class="swiper-slide posting-slide4 col-md-9"></div>
					</div>
			        <div class="swiper-pagination swiper-pagination-black"></div>
					<a class="posting-list">더보기 <span><i class="glyphicon glyphicon-chevron-right"></i></span></a>
				</div>

			</div>
		</div>

		<div class="row text-center category-space">
			<h2>- 인기 북로그 -</h2>
		</div>

	    
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
		    
				<a class="booklog-list">더보기 <span><i class="glyphicon glyphicon-chevron-right"></i></span></a>
	    	</div>
	    </div>
		

	    
	</div>
	
	<div style="height: 300px;"></div>

	<footer class="container-fluid">
		<jsp:include page="../layout/tailbar.jsp"/>
	</footer>
	
</body>
</html>