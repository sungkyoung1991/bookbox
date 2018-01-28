<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="initial-scale=1.0; maximum-scale=1.0; width=device-width;">
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
	
	<link rel="stylesheet" href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" ></script>
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" >
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" >
	
	<link rel="stylesheet" href="../resources/css/custom.css">

	<script src="../resources/javascript/toolbar_opac.js"></script>
	<script src="../resources/ckeditor/ckeditor.js"></script>
<title>Insert title here</title>
<!-- 나중에 뽑아갈것들 -->
<style type="text/css">

	body{
    		padding-top:0px;
    	}
    header{
    		background:url(../resources/images/community.jpeg) no-repeat center;
    	}

	input[type="text"]{
		margin: 0 0 0 0;
		padding: 0 0 0 0;
	}
	
	input-group-custom{
		/*background-color: 0;*/
	}
	.addon-custom{
		background-color: #ffffff00;
	}
	
	.removeBtn{
	 padding-left:2px; 
	}
	#submit{
		border: solid 1px;
		border-radius: 5px;
	}
	#submit img{
		width: 15px;
	 	vertical-align: center;
	}
	.img-item img{
		width: 90px;
		height: 90px;
		object-fit:contain;
	}
	
</style>
<script type="text/javascript">
	var condition;
	ToolbarOpacHeight(500);
	
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
		$("#tagInput").on("keyup",function(e){
			if(e.keyCode!=13){
				return;
			}
			addTag();
		});
		$("#addTagBtn").on("click",function(){
			addTag();
		
		});
			
		//
		
		var editor=CKEDITOR.replace( 'boardContent',{ customConfig :'config_board.js'} );
		
		//에디터 내용 변환 이벤트
		editor.on( 'change', function( evt ) {
			var content = CKEDITOR.instances.boardContent.getData();
			$("textarea[name='boardContent']").val(content);
		   // console.log( 'Total bytes: ' + evt.editor.getData().length );
		});
	
		
		
		$("#submit").on("click",function(){
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
	
	//태그 추가 함수
	
	function addTag(){
		var tag = $("#tagInput").val();
		
		var tagName=$("<span><span class='tag'>"+tag+
						"<input type='hidden' name='tagNames' value='"+tag+"' readonly>"+
						"</span><a class='btn removeBtn'>x</a></span>");
		
		tagName.find("a.removeBtn").on("click",function(){
			//alert("test");
			tagName.remove();
		});
		
		$("#tagNames").append(tagName);
		$("#tagInput").val("");
	}
	
</script>
<!-- 뽑아갈거 끝 -->
</head>
<body>
	<jsp:include page="../layout/toolbar.jsp" >
		<jsp:param value="../" name="uri"/>
	</jsp:include>	
	<header class="parallax"></header>

<div class="container">
	<h2 >게시판 생성</h2>
	<hr/>

	<form name="tx_editor_form" id="tx_editor_form" action="addBoard" method="post" accept-charset="utf-8">
	
		<div class="form-group">
			<div class="input-group input-group-custom">
				<!--  <label for="boardTitle">제목</label> -->
				<span class="input-group-addon addon-custom" id="title-addon">제목</span>
				<input type="text" name="boardTitle" class="input-title form-control">
			</div> 
		</div>	
		<input type="hidden" name="thumbnailUrl"><!-- 썸네일주소 -->
		
		<textarea rows="10" cols="80" name="boardContent"></textarea>
		<br/>
		<div class="form-group ">
			<div class="row">
				<div class="col-md-6 col-sm-6 col-xs-6">
					<div class="input-group input-group-custom">
						 <span class="input-group-addon addon-custom" id="tag-addon">태그</span>
						 <input type="text" id="tagInput" class="form-control" aria-describedby="tag-addon">
						 <span class="input-group-addon addon-custom" id="addTagBtn"><a>추가</a></span>
					</div>
				</div>
				<div class="col-md-6 col-sm-6 col-xs-6 text-right">
					<a id="submit" class="btn">등록 <img src="../resources/images/community/btn_submit.png"></a>
				</div>
			</div>
			
		</div>
		<div id="tagNames"></div>
		<br/>
		<div class="imgList">
			이미지 목록
		</div>
		<br/>
		<br/>
	</form>
	
</div>

	<footer class="container-fluid">
			<jsp:include page="../layout/tailbar.jsp"/>
	</footer>
</body>
</html>