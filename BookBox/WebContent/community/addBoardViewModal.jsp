<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="initial-scale=1.0, maximum-scale=1.0, width=device-width">
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
	
	<link rel="stylesheet" href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" ></script>
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" >
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" >
	
	<link rel="stylesheet" href="../resources/css/custom.css">

	<script src="../resources/ckeditor/ckeditor.js"></script>
<title>Insert title here</title>
<!-- 나중에 뽑아갈것들 -->
<style type="text/css">
	input[type="text"]{
		margin: 0 0 0 0;
		padding: 0 0 0 0;
	}
	.ui-autocomplete { z-index:2147483647; }

</style>
<script type="text/javascript">
	$(function(){
		
		//태그 자동완성
		$( "#tagInput" ).autocomplete({
		      source: function( request, response ) {
		        $.ajax( {
		          url: "rest/getTagNameList",
		          method: "post",
		          dataType: "json",
		          data: "tagName="+request.term,
		          success: function( data ) {
		            	//alert(JSON.stringify(data));
		        	  	response(data);
		          }
		        } );
		      }
		    }
		);
		//태그 자동완성 끝
		//태그 추가 
		$("#addTagBtn").on("click",function(){
		//	alert(	$("#tagInput").val());
			var tag = $("#tagInput").val();
			
			var tagName=$("<span><input type='text' name='tagNames' value='"+tag+"' readonly>"+
							"<a class='btn removeBtn'>x</a></span>");
			tagName.find("a.removeBtn").on("click",function(){
				//alert("test");
				tagName.remove();
			});
			
			
			//alert(tagName.val());
			$("#tagNames").append(tagName);
		});
		//
		
		var editor=CKEDITOR.replace( 'boardContent',{ customConfig :'config_board.js'} );
		
		//에디터 내용 변환 이벤트
		editor.on( 'change', function( evt ) {
			var content = CKEDITOR.instances.boardContent.getData();
			$("textarea[name='boardContent']").val(content);
		   // console.log( 'Total bytes: ' + evt.editor.getData().length );
		});
	
		
		
		$("#submit.addBoard").on("click",function(){
			var content = CKEDITOR.instances.boardContent.getData();
			$("textarea[name='boardContent']").val(content);
			//alert(content);
			//썸네일 설정
			var tempObj=$("<div>"+content+"</div>");
			var url=tempObj.find("img:first").attr("src");
			//alert(url);
			$("input[name='thumbnailUrl']").val(url);
			//alert($("input[name='thumbnailUrl']").val());		
			//
			$("form").submit();
		});
	});
	
	
</script>
<!-- 뽑아갈거 끝 -->
</head>
<body>


<div class="container-fluid">
	<form name="tx_editor_form" id="tx_editor_form" action="addBoard" method="post" accept-charset="utf-8">
		<!-- 에디터 컨테이너 시작 -->
		
		<!--  !!!!!!!제목 추가!!!!!!!!!!!! -->
		제목<input type="text" name="boardTitle" class="input-title"> 
			<input type="hidden" name="thumbnailUrl"><!-- 썸네일주소 -->
		태그<input type="text" id="tagInput"><a class="btn" id="addTagBtn">추가</a>
		<div id="tagNames"></div>
		<textarea rows="10" cols="80" name="boardContent"></textarea>
		
		<!-- 
		<a id="submit" class="btn">등록</a>
		 -->
			
		<div class="imgList">
			이미지 목록
		</div>
	</form>
	
</div>


</body>
</html>