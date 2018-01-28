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

	<!-- CKEditor 추가 -->
	<script src="../resources/ckeditor/ckeditor.js"></script>
		<!-- CDN Version -->
	<!-- <script src="https://cdn.ckeditor.com/4.7.3/standard/ckeditor.js"></script> -->
	<!-- CKEditor -->
	
	
	<script type="text/javascript">
	
	//=============태그추가====================
	var tagHtml;
	var num;
	
	function fncRemoveTag(num){
		$('#tag'+num).remove();
	}
	
	$(function(){
		num = 0;
					
		$('a.tag-add:contains("추가하기")').on('click',function(){
			num = num + 1;
			tagHtml = '<span id="tag'+num+'">, # <input class="inputValue" type="text" name="tag"><span class="glyphicon glyphicon-remove" aria-hidden="true" onClick="javascript:fncRemoveTag('+num+')"></span></span>';
			$('.tag-list').append(tagHtml);
		});
	});

	
	//==============창작작품 수정=================
	
	$(function() {
		$('a.update-creation:contains("수정하기")').on('click', function(){
			$('form[name="creationForm"]').attr('method','post').attr('action','../creation/updateCreation').submit();
		});
	});

	//=============말머리 선택시 태그에 추가=========
	
	$(function() {
	
		$('input:radio[name="creationHead"]').on('click', function() {
				$('input.headTag').val( $('input:radio[name="creationHead"]:checked').val().trim() );
				alert( $('input:radio[name="creationHead"]:checked').val() );
				alert("hiddenTag = "+$('input.headTag').val());
		})		
	})
	
	//============== 커버이미지 미리보기 설정===========
		var upload;
		var preview;
		
		if(typeof window.FileReader === 'undefined'){
			alert('커버이미지 미리보기를 지원하지 않는 브라우저 입니다..');
		}
		
		$(function(){
			upload = document.getElementById('creationOriginName');
			holder = document.getElementById('imgPreview');
			
			upload.onchange = function(e){
				console.log('???');
				e.preventDefault();
				console.log('???');
				var file = upload.files[0],
					reader = new FileReader();
				reader.onload = function(event){
					var img = new Image();
					img.src = event.target.result;
					holder.innerHTML = '';
				    holder.appendChild(img);
				}
				reader.readAsDataURL(file);
				
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
	
	<div class="container">
	
		<!--창작작품 등록란  -->
	<div class="panel panel-default">
  		<div class="panel-heading">
	     <h3>창작작품 수정</h3>
	  </div>
  		<div class="panel-body" >
		<form id="creationForm" name="creationForm" enctype="multipart/form-data">
			<div class="form-group">
				말머리 선택
				<input class="inputValue" type="radio" name ="creationHead"  value ="픽션" ${creation.creationHead =='픽션' ? 'checked' : '' } >픽션
				<input class="inputValue" type="radio" name ="creationHead"  value ="논픽션" ${creation.creationHead =='논픽션' ? 'checked' : '' } >논픽션
				<p></p>
				<p>작품명</p>
				<input class="inputValue" type="text" name="creationTitle" id ="creationTitle" value="${creation.creationTitle }">
				<input class="hidden" type="text" name="creationNo" id ="creationNo" value="${creation.creationNo }">
				<input class="hidden" type="text" name="active" id ="active" value="${creation.active }">
				
				<p></p>
				<p>작품소개</p>
				<textarea class="inputValue" name="creationIntro" rows="5" cols="100">${creation.creationIntro }</textarea>
			</div>
			<p>대표이미지</p>
				<input type="hidden" name="creationFileName" value="${creation.creationFileName }">
				<input type="hidden" name="creationOriginName" value="${creation.creationOriginName }">
			<div id="imgPreview">
				<img src="../resources/upload_files/images/${creation.creationFileName }"/>
			</div>
			<input class="inputValue" type="file"   id="creationOriginName" name="file">
		
			<div class="form-group tag-list">
				<label>태그</label>
				<input type="hidden" class="headTag" name="tag" id="tag">
				<a href="#" class="btn tag-add ">추가하기</a>
				<span class="hidden"># <input type="text" name="tag" id="tag" value="${creation.tagList[0].tagName}"></span>
				<c:set var="num" value="0"/>
				<c:forEach items="${creation.tagList}" var="tag" begin="1">
					<c:set var="num" value="${num+1}"/>
						<span id="tag${num}">, # <input type="text" name="tag" value="${tag.tagName}"><span class="glyphicon glyphicon-remove" aria-hidden="true" onClick="javascript:fncRemoveTag('${num}')"></span></span>
				</c:forEach>
				
		
			</div>
			<div class="text-right">
				<a href="#" class="btn btn-default update-creation"  id="update-creation">수정하기</a>
				<a href="#" class="btn btn-default delete-creation"  id="delete-creation">삭제하기</a>
			</div>
		</form>
		</div>
	</div>
	

	
</div>
	
	
</body>
</html>