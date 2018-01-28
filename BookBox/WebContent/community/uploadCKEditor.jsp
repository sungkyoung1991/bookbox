<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<script src="../resources/ckeditor/ckeditor.js"></script>
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	
	<script type="text/javascript">
		window.parent.CKEDITOR.tools.callFunction(${CKEditorFuncNum},"${url}","이미지업로드성공");
		var imgObj=$("<div class='img-item'>"+
						"<input type='hidden' name='image' value='${fileName}' readonly>"+ //hidden 처리
						//"<label>"+
						//	"<input type='radio' name='primeImg' value='${fileName}'/>대표이미지지정"+
						//"</label>"+
						"<img src='${url}'>"+
						"<spen>${originFileName}</spen>"+
						"<a class='btn removeImg'>x</a>"+
					"</div>");		
			
				imgObj.find(".removeImg").on("click",function(){
					
					//alert($("textarea[name='boardContent']",parent.document).val());
					var content=window.parent.CKEDITOR.instances.boardContent.getData();
					//alert(content);
					var contentObj=$("<div>"+content+"</div>");
					var src=imgObj.find("input[name='image']").val();
				//	alert(temp.html());
					contentObj.find("img[src*='"+src+"']").remove();
				//	alert($("textarea[name='boardContent']",parent.document).find("img[src='resources']").attr("src"));
				//	$("textarea[name='boardContent']",parent.document).find("img[src*='"+src+"']").remove();
					
					//다른곳에서 쓸때는 에디터 접근 이름변경
					window.parent.CKEDITOR.instances.boardContent.setData(contentObj.html());
					imgObj.remove();
			});
			//alert(imgObj.html());
			//alert(imgObj.find(".removeImg").html());
			
		//	var content=window.parent.CKEDITOR.instances.boardContent.getData();
		//alert(content);
		//$("textarea[name='boardContent']",parent.document).val(content);
	
		$(".imgList",parent.document).append(imgObj);
	</script>
<title>Insert title here</title>
</head>
<body>
</body>
</html>