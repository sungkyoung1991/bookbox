<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="initial-scale=1.0, maximum-scale=1.0, width=device-width">
<title>Create chatRoom </title>
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" ></script>
	
	<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" >
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" >
    <link rel="stylesheet" href="../resources/css/custom.css">


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
			
			var tagName=$("<span><input type='text' name='tagNames' value='"+tag+"' readonly><a class='btn removeBtn'>x</a></span>");
			tagName.find("a.removeBtn").on("click",function(){
				//alert("test");
				tagName.remove();
			});
			
			 $("#tagInput").val("");
			//alert(tagName.val());
			$("#tagInput").before(tagName);
		});
		
		//submit 버튼 이벤트 등록
		$(".submit").on("click",function(){
		//	alert("submit");
			$("form").submit();
		});
		
		
	}); //온로드 끝
	//
	
	
</script>

</head>


<body>
	<jsp:include page="../layout/toolbar.jsp">
		<jsp:param value="../" name="uri"/>
	</jsp:include>
	<div class="container">
	
		<form action="addChatRoom" method="post" enctype="multipart/form-data">
			<div class="input-group">
	 		 <span class="input-group-addon" id="title-addon">방 제목</span>
			 <input type="text" name="title" class="form-control" placeholder="Title" aria-describedby="title-addon"/>
			</div>
			
			<div class="input-group">
	 			<span class="input-group-addon" id="content-addon">방 내용</span>
				<textarea  name="content" class="form-control" placeholder="content" aria-describedby="content-addon"></textarea>
			</div>
			<div class="input-group">
	 		 <span class="input-group-addon" id="title-addon">최대인원</span>
			 <input type="text" name="maxUser" class="form-control" placeholder="maxUser" aria-describedby="title-addon"/>
			</div>
			<div class="input-group">
	 		 <span class="input-group-addon" id="title-addon">이미지</span>
			 <input type="file" name="file" class="form-control" placeholder="이미지" aria-describedby="title-addon"/>
			</div>
			<div class="input-group">
	 		 <span class="input-group-addon" id="type">방종류</span>
			 <select name="type"  class="form-control">
			 	<option value="0">그룹채팅</option>
			 	<option value="1">방송</option>
			 </select>
			</div>
			<div id="tagNames">
				<input type="text"id="tagInput"><a class="btn" id="addTagBtn">추가</a>
			</div>
			
			<a class="submit btn prime-btn">등록</a>
		</form>
		
			
	
	</div>
	
</body>
</html>