<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
	<!-- 기본설정 -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="./resources/bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" href="./resources/css/custom.css">
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" ></script>
	<!-- 기본설정 끝 -->
	
	<!-- 툴바 투명해지는 스크립트 -->
	<script src="./resources/javascript/toolbar_opac.js"></script>
	
	<!-- 스와이퍼 -->
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/Swiper/4.0.5/css/swiper.css">
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/Swiper/4.0.5/css/swiper.min.css">
	 
	<script src="https://cdnjs.cloudflare.com/ajax/libs/Swiper/4.0.5/js/swiper.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/Swiper/4.0.5/js/swiper.min.js"></script>
	
	<style>
		body{
			padding-top: 0;
		}
		header{
			background-image: url('./resources/images/main_title.jpg');
			min-height: 100%;
		}
		.backg{
			height: 100%;
			width: 100%;
			background: rgba(255, 255, 255, 0.2);
		}
		.container{
			height: 100%;
		}
		.display-middle{
			top: 45%;
		}
		#main-box{
			position: relative;
		}
		#main-box > .row{
			position: absolute;
			top: 50%;
			left: 50%;
			width: 100%;
			margin: 0;
			-webkit-transform: translate(-50%, -50%);
			   -moz-transform: translate(-50%, -50%);
					transform: translate(-50%, -50%);
		}
		#main-search{
		    height: 80px;
		    width: 500px;
		    padding: 20px;
		    position: absolute;
		    top: 55%;
		    left: 50%;
		    transform: translate(-50%, -50%);
   		}
   		#main-search input{
   		    background: rgba(0, 0, 0, 0.3) !important;
		    width: 100% !important;
		    height: 100% !important;
		    box-shadow: inset 0px 0px 2px 0px rgba(255, 152, 0, 0.1) !important;
		    border: 4px solid rgba(255, 255, 255, 0.8);
		    padding: 0 40px 0 10px !important;
		    color: #cccccc !important;
		    font-size: 20px !important;
   		}
   		#main-search input:focus{
		    outline: none !important;
		    background: rgba(0, 0, 0, 0.6) !important;
   		}
   		#main-search button{
   			position: absolute;
   		    height: 100%;
		    width: 100%;
		    font-size: 23px !important;
		    background: rgba(255, 255, 255, 0) !important;
		    border: none !important;
		    color: rgb(240, 255, 255) !important;
		    padding: 0 !important;
   		}
   		.search-menu{
   		    position: absolute;
		    top: 0;
		    right: 0;
		    transform: translate(-20px, 20px);
		    height: 40px;
		    width: 40px;
   		}
   		.search-menu ul{
   			background: none !important;
   			min-width: 0 !important;
   			-webkit-transform: translate(-5px, 0) !important;
   			   -moz-transform: translate(-5px, 0) !important;
		   			transform: translate(-5px, 0) !important;
   		}
   		.search-menu li{
   			font-size: 19px !important;
   			width: 50px !important;
   			-webkit-transition: 0.5s;
   			   -moz-transition: 0.5s;
		   			transition: 0.5s;
   		}
   		.search-menu li a{
   			padding: 3px !important;
   			width: 100% !important;
   			text-align: center !important;
   		}
   		
		#main-recommend-book{
			position: relative;
			margin-top: 10px;
			margin-bottom: 60px;
			height: 400px !important;
		}
		.book-content-box{
			height: 50%;
			width: 100%;
			position: relative;
		}
		.book-pos-abs{
			position: absolute;
			top: 0;
			left: 0;
			height: 100%;
			width: 100%;
			padding: 5%;
			text-align: center;
		}
		.book-preview{
			padding: 0 20%;
		}
		.book-preview-content{
			overflow-y: hidden;
			height: 0;
			width: 100%;
			padding: 0 5%;
			text-align: center;
			background: rgba(0, 0, 0, 0.4);
			-webkit-transition: 0.3s;
			   -moz-transition: 0.3s;
					transition: 0.3s;
		}
		.book-img{
			z-index: 0;
			height: 100%;
			object-fit: cover;
			opacity: 0.75;
			-webkit-transition: 0.1s;
			   -moz-transition: 0.1s;
					transition: 0.1s;
		}


		.font-large{
			font-size: 24px!important;
		}
		.font-small{
			font-size: 16px!important;
		}
		.theme-black{
			color: #fff!important;
			background-color: #000!important;
		}
		.theme-white{
			color: #fff!important;
		}
		.padding-large{
			padding: 12px 30px!important;
		}
		.wide{
			letter-spacing: 15px;
		}
		.narrow{
			letter-spacing: 5px;
		}
		
		.intro-box{
			position: relative;
			overflow: hidden;
			height: 600px;
			width: 100%;
		}
		.category-intro{
			position: absolute;
			height: 100%;
			width: 100%;
			top: 0;
			cursor: pointer;
			-webkit-transition: 0.3s;
			   -moz-transition: 0.3s;
					transition: 0.3s;
		}
		#creation-intro{
			z-index: 5;
			left: 0;
			/* background: rgb(240, 128, 128); */
			background: url(./resources/images/main_creation_cover.jpeg) no-repeat center;
			background-size: cover;
		}
		#community-intro{
			z-index: 6;
			left: 10%;
			/* background: rgb(144, 238, 144); */
			background: url(./resources/images/main_community_cover.jpeg) no-repeat center;
			background-size: cover;
		    background-position-x: -100px;
		}
		#booklog-intro{
			z-index: 7;
			left: 20%;
			/* background: rgb(173, 216, 230); */
			background: url(./resources/images/main_booklog_cover.jpeg) no-repeat center;
			background-size: cover;
   		}
		#recommend-book{
			z-index: 8;
			left: 30%;
			/* background: rgb(250, 250, 210); */
			background: url(./resources/images/main_book_cover.jpeg) no-repeat center;
			background-size: cover;
		}
		.active-category{
			cursor: auto;
		}
		.intro-icon{
			position: absolute;
			top: 0;
			left: 0;
			color: #ffffff;
			height: 100%;
			width: 10%;
			text-align: center;
			line-height: 22;
			font-size: 2em;
		}
		.intro-icon i{
			background: rgba(0, 0, 0, 0.5);
		    border-radius: 100%;
		}
		.intro-content{
			position: absolute;
			top: 0;
			left: 10%;
			height: 100%;
			width: 60%;
			padding: 5%;
		}
		.intro-content h1{
			font-size: 33px;
		}
		.intro-content *{
			color: #ffffff !important;
		}
		.intro-cover{
			position: absolute;
			top: 0;
			left: 10%;
			background: rgba(0, 0, 0, 0.3);
			height: 100%;
			width: 90%;
		}
		
		@media (min-width: 768px){
			.intro-icon{
				font-size: 3em;
				line-height: 15;
			}
			.intro-content h1{
				font-size: 56px;
			}
		}
		
		@media (min-width: 992px){
			#community-intro{
			    background-position-y: -40px;
			}
			.intro-icon{
				font-size: 4em;
				line-height: 11;
			}
		}
		
		@media (min-width: 1200px){
			#community-intro{
			    background-position-y: -180px;
			}
		}
		
		.content-part{
		    padding-left: 40px;
    		padding-top: 20px;
		}
		
	</style>
	
	<script>
		var bookSlideUnit = 2;
		var bookSwiper;
		
		//Toolbar 투명도 설정
		ToolbarOpacHeight($(window).height());
		//Window Resize시 Toolbar 투명도, BookContainer 높이, Parallax background-position 재설정
		$(window).resize(function(){
			ToolbarOpacHeight($(window).height());
			$('#main-search').css('width', $('#main-bookbox').width());
		});
		
		
		$(function(){
			if($(window).innerWidth() < 768){
				bookSlideUnit = 1;
			}
			//툴바 검색창 숨김
			$('.bookbox-navigation .search-group').hide();
			//메인배너 클릭시 스크롤이동 이벤트
			$('#main-bookbox').on('click', function(){
				var offset = $('#main-box').offset();
				$('html, body').animate({scrollTop : offset.top - 52}, 1000);
			});
			$('#main-search').css('width', $('#main-bookbox').width());
			
			//검색창 드롭다운버튼 이벤트
			$('#main-search li a').on('click', function(){
				$('button.selected-menu').attr('aria-expanded', $(this).attr('class'))
										.html($(this).html());
			});
			//검색입력창 EnterKey 이벤트
			$('#main-search input').on('keydown', function(event){
				if(event.which == 13){
					event.preventDefault();
					fncSearch();
				}
			});
			//추천도서 hover 이벤트
			$('.book-content-box').hover(function(){
				$(this).find('.book-img').css('opacity', 0.2);
				$(this).find('.book-preview-content').css('height', '100%');
			}, function(){
				$(this).find('.book-img').css('opacity', 1);
				$(this).find('.book-preview-content').css('height', 0);
			});
			
			$('#creation-intro').on('click', function(){
				fncRecommendMoveRight();
				fncBooklogMoveRight();
				fncCommunityMoveRight();
				fncRemoveActiveClass();
				$(this).addClass('active-category');
			});
			$('#community-intro').on('click', function(){
				fncCommunityMoveLeft();
				fncRecommendMoveRight();
				fncBooklogMoveRight();
				fncRemoveActiveClass();
				$(this).addClass('active-category');
			});
			$('#booklog-intro').on('click', function(){
				fncCommunityMoveLeft();
				fncBooklogMoveLeft();
				fncRecommendMoveRight();
				fncRemoveActiveClass();
				$(this).addClass('active-category');
			});
			$('#recommend-book').on('click', function(){
				fncCommunityMoveLeft();
				fncBooklogMoveLeft();
				fncRecommendMoveLeft();
				fncRemoveActiveClass();
				$(this).addClass('active-category');
			});
			
			$('.container').css('height', $(window).innerHeight());

			//스와이퍼 초기화
 			bookSwiper = new Swiper('.book-swiper-container', {
				speed: 600,
				autoplay: {
					delay: 5000,
				},
				pagination:{
					el: '.swiper-pagination',
					type: 'bullets',
					clickable: true,
				},
				slidesPerView: bookSlideUnit,
				slidesPerColumn: 2,
				slidesPerGroup: bookSlideUnit,
				on: {
					slideChange: function(){
						var index = bookSwiper.activeIndex;
						if($('.swiper-slide').length == 8){
							if(index == 0 || index == 1){
								$('.recommend-type').html('베스트셀러');
							}else{
								$('.recommend-type').html('이달의 추천도서');
							}
						}else{
							if(index == 0 || index == 1){
								$('.recommend-type').html('${sessionScope.user.nickname} 님께 추천하는 도서입니다.');
							}else if(index == 2 || index == 3){
								$('.recommend-type').html('베스트셀러');
							}else{
								$('.recommend-type').html('이달의 추천도서');
							}
						}
					},
				},
			});
			
			
			//추천도서 rest
			$.ajax({
				url: "./unifiedsearch/rest/recommendBook",
				success: function(data){
					for(var i=0; i<4; i++){
						var bestSellerContainer = $('.book-content-box')[i+4];
						var bestSellerThumbnail = data.bestsellerList[i].thumbnail;
						var newBookContainer = $('.book-content-box')[i+8];
						var newBookThumbnail = data.newBookList[i].thumbnail;
						
						$(bestSellerContainer).find('input[name="isbn"]').val(data.bestsellerList[i].isbn);
						$(bestSellerContainer).find('.book-img').attr('src', 'http://t1.daumcdn.net/book/KOR' + data.bestsellerList[i].isbn)
																.attr('onerror', 'this.src="' + bestSellerThumbnail + '"');
						$(bestSellerContainer).find('.book-title').html(data.bestsellerList[i].title);
						$(bestSellerContainer).find('.book-author').html(function(){
																		var author = '';
																   		for(x in data.bestsellerList[i].authors){
																   			author += data.bestsellerList[i].authors[x] + ', ';
																   		}
																   		author = author.substring(0, author.lastIndexOf(','));
																   		return author;
																	});

						$(newBookContainer).find('input[name="isbn"]').val(data.newBookList[i].isbn);
						$(newBookContainer).find('.book-img').attr('src', 'http://t1.daumcdn.net/book/KOR' + data.newBookList[i].isbn)
																.attr('onerror', 'this.src="' + newBookThumbnail + '"');
						$(newBookContainer).find('.book-title').html(data.newBookList[i].title);
						$(newBookContainer).find('.book-author').html(function(){
																		var author = '';
																   		for(x in data.newBookList[i].authors){
																   			author += data.newBookList[i].authors[x] + ', ';
																   		}
																   		author = author.substring(0, author.lastIndexOf(','));
																   		return author;
																	});
						
						if(data.userRecommendList != null){
							var userRecommendContainer = $('.book-content-box')[i];
							var userRecommendThumbnail = data.userRecommendList[i].thumbnail;
							$(userRecommendContainer).find('input[name="isbn"]').val(data.userRecommendList[i].isbn);
							$(userRecommendContainer).find('.book-img').attr('src', 'http://t1.daumcdn.net/book/KOR' + data.userRecommendList[i].isbn)
																	.attr('onerror', 'this.src="' + userRecommendThumbnail + '"');
							$(userRecommendContainer).find('.book-title').html(data.userRecommendList[i].title);
							$(userRecommendContainer).find('.book-author').html(function(){
																			var author = '';
																	   		for(x in data.userRecommendList[i].authors){
																	   			author += data.userRecommendList[i].authors[x] + ', ';
																	   		}
																	   		author = author.substring(0, author.lastIndexOf(','));
																	   		return author;
																		});
						}
					}
					$('.recommend-type').html('${sessionScope.user.nickname} 님께 추천하는 도서입니다.');
					if(data.userRecommendList == null || data.userRecommendList.length == 0){
						$($('.book-content-box')[0]).remove();
						$($('.book-content-box')[0]).remove();
						$($('.book-content-box')[0]).remove();
						$($('.book-content-box')[0]).remove();
						bookSwiper.update();
						$('.recommend-type').html('베스트셀러');
					};
					
					$('.book-content-box').on('click', function(){
						var isbn = $(this).find('input[name="isbn"]').val();
						if(isbn != 0){
							$(self.location).attr("href","./unifiedsearch/getBook?isbn="+isbn);
						}
					}).css('cursor', function(){
						var isbn = $(this).find('input[name="isbn"]').val();
						if(isbn != 0){
							return 'pointer';
						}else{
							return 'not-allowed';
						}
					});
				}
			});
			
			
		});
		
		//검색처리
		function fncSearch(){
			var keyword = $('#main-search input').val().trim();
			
			if(keyword == '') {  
				alert('검색어를 입력하세요');
			} else {
				var option_value = $('button.selected-menu').attr('aria-expanded');
				 
				switch (option_value){	  
					case "unifiedsearch" : $(self.location).attr("href","${param.uri}unifiedsearch/getUnifiedsearchList?category=10&keyword="+keyword); break; 
					case "book" : $(self.location).attr("href","${param.uri}unifiedsearch/getBookList?keyword="+keyword); break;
					case "creation" : $(self.location).attr("href","${param.uri}unifiedsearch/getUnifiedsearchList?category=1&keyword="+keyword); break;
					case "community" : $(self.location).attr("href","${param.uri}unifiedsearch/getUnifiedsearchList?category=6&keyword="+keyword); break;
					case "posting" : $(self.location).attr("href","${param.uri}unifiedsearch/getUnifiedsearchList?category=5&keyword="+keyword); break; 
					case "tag" : $(self.location).attr("href","${param.uri}unifiedsearch/getUnifiedsearchList?category=11&keyword="+keyword); break; 
				}
			}
		}
		
		function fncCommunityMoveLeft(){
			$('#community-intro').css('left', '10%').removeClass('active-category');
		}
		function fncCommunityMoveRight(){
			$('#community-intro').css('left', '70%').removeClass('active-category');
		}
		function fncBooklogMoveLeft(){
			$('#booklog-intro').css('left', '20%').removeClass('active-category');
		}
		function fncBooklogMoveRight(){
			$('#booklog-intro').css('left', '80%').removeClass('active-category');
		}
		function fncRecommendMoveLeft(){
			$('#recommend-book').css('left', '30%').removeClass('active-category');
		}
		function fncRecommendMoveRight(){
			$('#recommend-book').css('left', '90%').removeClass('active-category');
		}
		function fncRemoveActiveClass(){
			$('#creation-intro').removeClass('active-category');
			$('#community-intro').removeClass('active-category');
			$('#booklog-intro').removeClass('active-category');
			$('#recommend-book').removeClass('active-category');
		}
		
	</script>
</head>
<body>

	<jsp:include page="./layout/toolbar.jsp"/>
	<header class="parallax">
		<div class="backg"></div>
		<div id="main-bookbox" class="display-middle" style="cursor: pointer; white-space: nowrap; display:block;">
			<span class="font-large theme-black padding-large wide"><strong>BOOKBOX</strong><small class="hidden-xs hidden-sm narrow"> Book Community</small></span><br/>
			<p class="font-large theme-black narrow text-center"><small class="hidden-xs hidden-sm"><em class="text-muted font-small">- 책으로 소통하는 공간</em></small></p>
		</div>
		<div id="main-search">
			<input type="text" name="keyword">
			<div class="search-menu">
				<button type="button" class="selected-menu" aria-expanded="unifiedsearch"><i class="glyphicon glyphicon-search"></i></button>
				<button type="button" class="dropdown-toggle" data-toggle="dropdown" aria-expanded="unifiedsearch"></button>
				<ul class="dropdown-menu" role="menu">
					<li><a href="javascript:void(0);" class="unifiedsearch" style="background: rgb(173, 216, 230);"><i class="glyphicon glyphicon-search"></i></a>
					<li><a href="javascript:void(0);" class="book" style="background: rgb(250, 250, 210);"><i class="glyphicon glyphicon-book"></i></a>
					<li><a href="javascript:void(0);" class="creation" style="background: rgb(240, 128, 128);"><i class="glyphicon glyphicon-pencil"></i></a>
					<li><a href="javascript:void(0);" class="community" style="background: rgb(144, 238, 144);"><i class="glyphicon glyphicon-phone"></i></a>
					<li><a href="javascript:void(0);" class="posting" style="background: rgb(135, 206, 250);"><i class="glyphicon glyphicon-grain"></i></a>
					<li><a href="javascript:void(0);" class="tag" style="background: rgb(119, 136, 153);"><i class="glyphicon glyphicon-tags"></i></a>
				</ul>
			</div>
		</div>
	</header>
	
	<div id="main-box" class="container">
			
		<div class="row">
			<div class="xs-col-12">
				<div class="intro-box">
					<div id="creation-intro" class="category-intro">
						<div class="intro-cover"></div>
						<div class="intro-icon">
							<i class="glyphicon glyphicon-pencil"></i>
						</div>
						<div class="intro-content">
							<h1>CREATION<small class="hidden-xs"> <small> 창작공간</small></small></h1>
							<h1 class="hidden-sm hidden-md hidden-lg"><small> 창작공간</small></h1>
							<div class="content-part">
								<p style="font-size: large;font-style: italic;font-weight: bold;">누구나 작가가 될 수 있는 공간, </p>
								<p>내가 쓴  글이 작품이 됩니다.</p>
								<p>자유롭게 표현하고, 다양한 사람들과 공유해 보세요.</p><br/>
								<p style="font-size: large;font-style: italic;font-weight: bold;">원하는 작품을 소유할 수 있는 공간, </p>
								<p>작품의 좋아요 수가 50개 이상 달성되면 작가는 작품 펀딩을 진행할 수 있고,</p>
								<p>작품이 출판되지 않아도 독자는 펀딩 참여를 통해 원하는 작품을 직접 소장할 수 있습니다.</p><br/>
								<p>원하는 작품을 직접 만들고 간직해 보세요.</p>
							</div>
						</div>
					</div>
					<div id="community-intro" class="category-intro">
						<div class="intro-cover"></div>
						<div class="intro-icon">
							<i class="glyphicon glyphicon-phone"></i>
						</div>
						<div class="intro-content">
							<h1>COMMUNITY<small class="hidden-xs"> <small> 소모임</small></small></h1>
							<h1 class="hidden-sm hidden-md hidden-lg"><small> 소모임</small></h1>
							<div class="content-part">
								<p style="font-size: large;font-style: italic;font-weight: bold;">글에 대한 이야기를 자유롭게 소통할 수 있는 공간,</p>
								<p>영상 및 화상채팅 등 컨텐츠를 통해 다양한 방법으로</p>
								<p>여러 사람들과 글에 대한 이야기를 나눠보세요.</p>
							</div>
						</div>
					</div>
					<div id="booklog-intro" class="category-intro">
						<div class="intro-cover"></div>
						<div class="intro-icon">
							<i class="glyphicon glyphicon-grain"></i>
						</div>
						<div class="intro-content">
							<h1>BOOKLOG<small class="hidden-xs"> <small> 북로그</small></small></h1>
							<h1 class="hidden-sm hidden-md hidden-lg"><small> 북로그</small></h1>
							<div class="content-part">
								<p style="font-size: large;font-style: italic;font-weight: bold;">개인적인 감성을 간직 할 수 있는 공간,</p>
								<p>개인적으로 간직하거나 남기고 싶은 이야기, 컨텐츠를 나만의 공간에 마음껏 남겨보세요.</p>
								<p>내가 관심있는 장르와 분야를 그래프를 통해 확인 할 수 있습니다.</p>
								<p>나의 활동내역을 통해 나의 취향을 알아가고 공유해 보세요.</p>
							</div>
						</div>
					</div>
					<div id="recommend-book" class="category-intro active-category">
						<div class="intro-cover"></div>
						<div class="intro-icon">
							<i class="glyphicon glyphicon-book"></i>
						</div>
						<div class="intro-content">
							<h1>BOOK<small class="hidden-xs"> <small class="recommend-type"> 추천도서</small></small></h1>
							<h1 class="hidden-sm hidden-md hidden-lg"><small class="recommend-type"> 추천도서</small></h1>
	
							<div id="main-recommend-book" class="swiper-container book-swiper-container">
								<div class="swiper-wrapper">

									<c:forEach var="i" begin="0" end="11">
										<div class="swiper-slide book-content-box">
											<input type="hidden" name="isbn" value="0">
											<div class="book-pos-abs">
												<img class="book-img" src="./resources/images/noimage.png" alt="No Image Available">
											</div>
											<div class="book-pos-abs book-preview">
												<div class="book-preview-content">
													<p class="book-title" style="margin-top: 20%;">제목 가져오는 중..</p>
													<p class="book-author">작가 가져오는 중..</p>
												</div>
											</div>
										</div>
									</c:forEach>

								</div>
								<div class="swiper-pagination"></div>
							</div>


						</div>
					</div>
				</div>
			</div>
		</div>
		
	</div>
	
	


	<footer class="container-fluid">
		<jsp:include page="./layout/tailbar.jsp"/>
	</footer>
	
</body>
</html>