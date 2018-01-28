<%@ page language="java" contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

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
	
	<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
	<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>

	<!-- CKEditor 추가 -->
	<script src="../resources/ckeditor/ckeditor.js"></script>
		<!-- CDN Version -->
	<!-- <script src="https://cdn.ckeditor.com/4.7.3/standard/ckeditor.js"></script> -->
	<!-- CKEditor -->
	
	<style>
		body{
			height: 1600px;
			padding-top: 0;
		}
		.form-group{
			margin: 16px 0;
		}
		.form-group > *{
			display: inline-block;
		}
		.form-group input[type="text"]{
			background: inherit;
		}
		header{
			background: url(../resources/images/posting.jpeg) no-repeat center;
		}
	</style>
	
	
	<script type="text/javascript">
		var tagHtml;
		var num;
		var editor;
		
		$(function(){
			num = 0;
			fncTagAutocomplete();

			$('div.posting-add:contains("등록")').on('click',function(){
				var postingTitle = $('input[name="postingTitle"]').val(); 
				var data = CKEDITOR.instances.postingContent.getData();
				if(upload.files[0] == null){
					alert('커버이미지는 필수로 등록하여야 합니다.');
					return;
				}
				if(postingTitle.trim() == ''){
					alert('제목을 입력해주세요.');
					return;
				}
				if(data.trim() == ''){
					alert('내용을 입력해주세요.');
					return;
				}
				$('textarea').val(data);
				$('form.posting').attr('method','post').attr('action','../booklog/addPosting').attr('enctype','multipart/form-data').submit();
			});
			
			$('div.tag-add:contains("추가")').on('click',function(){
				fncTagAddForm();
			});
			$('#tag').on('keydown', function(event){
				if(event.which == 13){
					event.preventDefault();
					fncTagAddForm();
				}
			});

		});
	
		$(function(){
			editor = CKEDITOR.replace('postingContent', { customConfig : 'config_posting.js'});
			fncFooterPositioning();
		});


		function fncTagAutocomplete(){
			$( "input[name='tag']" ).autocomplete({
				source: function( request, response ) {
				    $.ajax( {
				    	url: "rest/tag",
				        method: "post",
				        dataType: "json",
				        data: "tagName="+request.term,
				        success: function( data ) {
			        	  	response(data);
			        	}
					} );
			    }
			});
		}

		function fncRemoveTag(num){
			$('#tag'+num).remove();
		}
		
		function fncTagAddForm(){
			num = num + 1;
			tagHtml = '<span id="tag'+num+'">, # <input type="text" name="tag"><span class="glyphicon glyphicon-remove" aria-hidden="true" onClick="javascript:fncRemoveTag('+num+')"></span></span>';
			$('.tag-list').append(tagHtml);
			fncTagAutocomplete();
			$('#tag'+num).on('keydown', function(event){
				if(event.which == 13){
					event.preventDefault();
					fncTagAddForm();
				}
			}).find('input').focus();
		}
		
		// 커버이미지 미리보기 설정
		var upload;
		var preview;
		
		if(typeof window.FileReader === 'undefined'){
			alert('커버이미지 미리보기를 지원하지 않는 브라우저 입니다..');
		}
		
		$(function(){
			upload = document.getElementById('mainFile');
			preview = $('header.preview');

			upload.onchange = function(e){
				e.preventDefault();
				
				var file = upload.files[0],
					reader = new FileReader();
				reader.onload = function(event){
					var img = new Image();
					img.src = event.target.result;
					$(preview).css('background','url('+img.src+') no-repeat center').css('background-size','cover');
				}
				reader.readAsDataURL(file);
				$('html').animate({
					scrollTop: 0
				}, 500);
				return false;
			};
		})
		
	</script>
</head>
<body>
	<jsp:include page="../layout/toolbar.jsp" >
		<jsp:param value="../" name="uri"/>
	</jsp:include>
	<!-- 여기부터 코딩 -->
	
	<header class="preview parallax booklog-background"></header>
	
	<div class="container booklog-background" style="padding: 30px;">
	
		<div class="text-left" style="font-size:-webkit-xxx-large;font-weight: 600;">포스팅 등록</div>
		<div style="width: 100%;border: #bbbbbb 2px solid;display: inline-block;margin-bottom:50px"></div>
	
		<form class="posting">
			<div class="row">
				<div class="col-md-6">
					<div class="form-group">
						<div class="col-xs-3">
							<label>제목</label>
						</div>
						<div class="col-xs-9">
							<input type="text" name="postingTitle" style="width: 100%;">
						</div>
					</div>
				</div>
				<div class="col-md-6">
					<div class="form-group">
						<div class="col-xs-3">
							<label>커버사진</label>
						</div>
						<div class="col-xs-9">
							<input type="file" id="mainFile" name="mainFile" style="display: inline-block;">
						</div>
					</div>
				</div>
			</div>

			<div class="form-group">
				<textarea name="postingContent" id="postingContent" rows="10" cols="80"></textarea>
			</div>
			
			<div class="form-group tag-list">
				<label>태그</label>
				<div class="btn-form tag-add">추가</div>
				<span># <input type="text" name="tag" id="tag"></span>
			</div>
			<div class="form-group" style="float: right">
				<div class="btn-form posting-add">등록</div>
			</div>
		</form>
	</div>
	
	<div style="height: 300px;"></div>
	
	<footer class="container-fluid">
		<jsp:include page="../layout/tailbar.jsp"/>
	</footer>
	
</body>
</html>