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
	<script src="../resources/javascript/custom.js"></script>
	
	<script type="text/javascript">
		var isListLoading = false;
		var condition, keyword, currentPage;
		
		$(function(){
			condition = $('input[name="condition"]').val();
			keyword = $('input[name="keyword"]').val();
			currentPage = 1;
			$('div.btn-form.posting-add:contains("포스팅 등록")').on('click',function(){
				$(self.location).attr('href','../booklog/addPosting');
			});
			fncPostingEventOn();

			if( $(window).height() >= $(document).height() ){
				if(!isListLoading){
					fncGetPostingList();
				}
			}
			
		});
		
		$(window).scroll(function(){
			if($(window).scrollTop() >= $(document).height() - $(window).height() - 40){
				if(!isListLoading){
					fncGetPostingList();
				}
			}
		});
		
		function fncGetPostingList(){
			$('.img-loading').show();
			isListLoading = true;
			currentPage = currentPage + 1;
			$.ajax({
				url: 'rest/getPostingList/'+currentPage,
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
					if(data.postingList.length == 0){
						$('.img-loading').hide();
						return;
					}
					for(var i=0; i<data.postingList.length; i++){
						var divHtml = '<div class="row div-posting booklog-background"><div class="row hidden-xs"><div class="col-sm-4 text-center posting-img" style="padding-right: 0;">';
						divHtml += '<input type="hidden" name="postingNo" value="' + data.postingList[i].postingNo + '"/>';
						divHtml += '<img class="img-object-fit posting-img" src="../resources/upload_files/images/' + data.postingList[i].postingFileList[0].fileName + '" alt="Image Not Found" height="200px"></div>';
						divHtml += '<div class="col-sm-8" style="height: 200px; padding: 0 50px 10px 20px;"><h3><input type="hidden" name="postingNo" value="' + data.postingList[i].postingNo + '"/><strong>' + data.postingList[i].postingTitle + '</strong></h3>';
						divHtml += '<a class="posting-user" href="javascript:void(0);"><input type="hidden" name="user.email" value="' + data.postingList[i].user.email + '">by.' + data.postingList[i].user.nickname + '</a>';
						divHtml += '<span class="posting-content">' + data.postingList[i].postingContent + '</span><div class="row" style="position: absolute; bottom: 0; margin: 10px 0;">';
						for(x in data.postingList[i].postingTagList){
							divHtml += '<span class="tag">#' + data.postingList[i].postingTagList[x].tagName + '</span>';
						}
						divHtml += '</div></div></div>';
						divHtml += '<div class="row hidden-sm hidden-md hidden-lg"><div class="col-xs-12 posting-img"><div class="col-xs-10 col-xs-offset-1" style="position: absolute; top: 0; left: 0; height: 200px;">';
						divHtml += '<h4><strong>' + data.postingList[i].postingTitle + '</strong></h4><a class="posting-user" href="javascript:void(0);">';
						divHtml += '<input type="hidden" name="user.email" value="' + data.postingList[i].user.email + '">by.' + data.postingList[i].user.nickname + '</a>';
						divHtml += '<span class="posting-content">' + data.postingList[i].postingContent + '</span><div class="row" style="position: absolute; bottom: 0; margin: 10px 0;">';
						for(x in data.postingList[i].postingTagList){
							divHtml += '<span class="tag">#' + data.postingList[i].postingTagList[x].tagName + '</span>';
						}
						divHtml += '</div></div><input type="hidden" name="postingNo" value="' + data.postingList[i].postingNo + '"/>';
						divHtml += '<img class="img-object-fit posting-img" src="../resources/upload_files/images/' + data.postingList[i].postingFileList[0].fileName + '" alt="Image Not Found"></div></div></div>';
						$('.posting-list-box').append(divHtml);
					}
					fncFooterPositioning();
					fncPostingEventOn();
					isListLoading = false;
					$('.img-loading').hide();
				}
			});
			
		};
		
		function fncPostingEventOn(){
			$('div.div-posting .posting-img, div.div-posting h3').off('click').on('click', function(){
				var postingNo = $(this).find('input[name="postingNo"]').val();
				$(self.location).attr("href","../booklog/getPosting?postingNo="+postingNo+"&condition="+condition+"&keyword="+keyword);
			});
			$('a.posting-user').off('click').on('click', function(){
				var user = $(this).find('input[name="user.email"]').val();
				$(self.location).attr("href","../booklog/getBooklog?user.email="+user);
			});
			
			//이미지 불러오기 실패시 기본 이미지 출력
			$('img.posting-img').off('error').on('error', function(){
				$(this).attr('src', '../resources/images/posting_noimage.jpeg');
			});
			
		}
	</script>

</head>
<body>
	<jsp:include page="../layout/toolbar.jsp" >
		<jsp:param value="../" name="uri"/>
	</jsp:include>
	<!-- 여기부터 코딩 -->

	<div class="container posting-list-box">
		<input type="hidden" name="condition" value="${search.condition}">
		<input type="hidden" name="keyword" value="${search.keyword}">
		<br/>
		<c:if test="${!empty sessionScope.user}">
			<div class="btn-form posting-add">포스팅 등록</div><br/>
		</c:if>
		<div class="row">
			<p>전체 ${totalCount}건수</p>
		</div>

		<c:forEach items="${postingList}" var="posting">
		<div class="row div-posting booklog-background">
			<div class="row hidden-xs">
				<div class="col-sm-4 text-center posting-img" style="padding-right: 0;">
					<input type="hidden" name="postingNo" value="${posting.postingNo}"/>
					<img class="img-object-fit posting-img" src="../resources/upload_files/images/${posting.postingFileList[0].fileName}" alt="Image Not Found" height="200px">
				</div>
				<div class="col-sm-8" style="height: 200px; padding: 0 50px 10px 20px;">
					<h3><input type="hidden" name="postingNo" value="${posting.postingNo}"/><strong>${posting.postingTitle}</strong></h3>
					<a class="posting-user" href="javascript:void(0);">
						<input type="hidden" name="user.email" value="${posting.user.email}">
						by.${posting.user.nickname}
					</a>
					<span class="posting-content">${posting.postingContent}</span>
					<div class="row" style="position: absolute; bottom: 0; margin: 10px 0;">
						<c:forEach items="${posting.postingTagList}" var="tag">
							<span class="tag">#${tag.tagName}</span>
						</c:forEach>
					</div>
				</div>
			</div>
			<div class="row hidden-sm hidden-md hidden-lg">
				<div class="col-xs-12 posting-img">
					<div class="col-xs-10 col-xs-offset-1" style="position: absolute; top: 0; left: 0; height: 200px;">
						<h4><strong>${posting.postingTitle}</strong></h4>
						<a class="posting-user" href="javascript:void(0);">
							<input type="hidden" name="user.email" value="${posting.user.email}">
							by.${posting.user.nickname}
						</a>
						<span class="posting-content">${posting.postingContent}</span>
						<div class="row" style="position: absolute; bottom: 0; margin: 10px 0;">
							<c:forEach items="${posting.postingTagList}" var="tag">
								<span class="tag">#${tag.tagName}</span>
							</c:forEach>
						</div>
					</div>
					<input type="hidden" name="postingNo" value="${posting.postingNo}"/>
					<img class="img-object-fit posting-img" src="../resources/upload_files/images/${posting.postingFileList[0].fileName}" alt="Image Not Found">
				</div>
			</div>
		</div>
		</c:forEach>
	</div>
	<div class="container">
		<img class="img-loading" src="../resources/images/loading.gif" style="display: none;">
	</div>
	
	<div style="height: 300px;"></div>

	<footer class="container-fluid">
		<jsp:include page="../layout/tailbar.jsp"/>
	</footer>
	
</body>
</html>