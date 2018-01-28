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
	
	<link rel="stylesheet" href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" >
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" >
    <link rel="stylesheet" href="../resources/css/custom.css">

<style type="text/css">
	.tag{
		margin-left: 10px;
		margin-top: 10px;
	}

	.addon-custom{
		background-color: #ffffffff !important; 
		border: 0px !important;
	}
	.label-custom{
		font-size: 15px;
		font-weight: lighter;
		padding: 5px;
		cursor: pointer;
		border: 1px solid;
		border-radius: 7px;
	}
	
	.input-hidden{
		display: none !important;
	}
	
	.input-group-custom{
		margin-bottom: 10px;	
	}
	
	.btn-custom{
	    padding: 5px;
		border: 1px solid;
	    border-radius: 7px;
	    padding-left: 15px;
	    padding-right: 15px;
	    cursor: pointer;
	    color: #777;
	}
	
	.readonly-custom{
		background-color: #ffffff00 !important;
	}
</style>

<script type="text/javascript">
	$(function(){
		//fileinput 이벤트
		$("#inputFile").on("change",function(){
			var filename;
			if(window.FileReader){ // modern browser 
				filename = $(this)[0].files[0].name; } 
			else { // old IE var 
				filename = $(this).val().split('/').pop().split('\\').pop(); 
			}
			
			$("#fileText").val(filename);
			
		});

		
		//태그 자동완성
		$( "#chatroom-tagInput" ).autocomplete({
		      source: function( request, response ) {
		        $.ajax( {
		          url: "rest/getTagNameList",
		          method: "post",
		          dataType: "json",
		          data: "tagName="+request.term,
		          success: function( data ) {
		            //	alert(JSON.stringify(data));
		        	  	response(data);
		          }
		        } );
		      }
		    }
		);
		//태그 자동완성 끝
		
		$( "#chatroom-tagInput" ).on("keyup",function(e){
				if(e.keyCode!=13 || $(this).val()==''){
					return;
				}
				addTag();
		});
		
		//태그 추가 
		$("#chatroom-addTagBtn").on("click",function(){
		//	alert(	$("#tagInput").val());
			addTag();
		});
		
		//submit 버튼 이벤트 등록
		$(".submit.addChatRoom").on("click",function(){
		//	alert("submit");
			$(".chatRoom-form").submit();
		});
		
		
	}); //온로드 끝
	//
	function addTag(){
		
		var tag = $("#chatroom-tagInput").val();
		
		var tagName=$("<span><span class='tag'>"+tag+
						"<input type='hidden' name='tagNames' value='"+tag+"' readonly>"+
						"</span><a class='removeBtn'>x</a></span>");
		tagName.find("a.removeBtn").on("click",function(){
			//alert("test");
			tagName.remove();
		});
		
		 $("#chatroom-tagInput").val("");
		//alert(tagName.val());
		$("#tagNames").append(tagName);
		
	}
	
</script>
<style type="text/css">
	.ui-autocomplete { z-index:2147483647; }
</style>
</head>


<body>

	<div class="container-fluid">
	
		<form class="chatRoom-form" action="addChatRoom" method="post" enctype="multipart/form-data">
			<div class="input-group">
	 		 <span class="input-group-addon addon-custom" id="title-addon">방 제목</span>
			 <input type="text" name="title" class="form-control"  aria-describedby="title-addon"/>
			</div>
			
			<div class="input-group input-group-custom">
	 			<span class="input-group-addon addon-custom" id="content-addon">방 내용</span>
				<textarea  name="content" class="form-control" aria-describedby="content-addon"></textarea>
			</div>
			<div class="input-group input-group-custom">
	 		 <span class="input-group-addon addon-custom" id="title-addon">최대인원</span>
			 <input type="text" name="maxUser" class="form-control"  aria-describedby="title-addon"/>
			</div>
			<div class="input-group input-group-custom">
	 		 <span class="input-group-addon addon-custom" id="title-addon">이미지</span>
			 <input type="file" id="inputFile" name="file" class="form-control input-hidden"  aria-describedby="title-addon"/><!-- 숨김 -->
			 <input type="text" id="fileText" class="form-control readonly-custom"  readonly/>
			 <span class="input-group-addon addon-custom" id="title-addon">
			 	<label for="inputFile" class="label-custom">이미지 선택</label>
			 </span>
			</div>
			<div class="input-group input-group-custom">
	 		 <span class="input-group-addon addon-custom" id="type">방종류</span>
			 <select name="type"  class="form-control">
			 	<option value="0">그룹채팅</option>
			 	<option value="1">방송</option>
			 </select>
			</div>
			<div id="tagNames">
				<div class="input-group input-group-custom">
				<span class="input-group-addon addon-custom" id="type">태그</span>
				<input type="text"id="chatroom-tagInput"><a class="btn-custom" id="chatroom-addTagBtn">추가</a><br/>
				</div>
			</div>
			
		</form>
		
			<br/><br/><br/>
	
	</div>
	
</body>
</html>