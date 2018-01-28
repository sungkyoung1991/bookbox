<%@ page language="java" contentType="text/html" pageEncoding="UTF-8"%>
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

	<script src="../resources/javascript/toolbar_opac.js"></script>
	<script src="../resources/javascript/custom.js"></script>


<style type="text/css">
		body{
	    	padding-top:0px;
	    }
	    
	    header{
	    	background:url(../resources/images/user_title.jpg) no-repeat center;
	    }
	    
	     .btn-custom{
			border-radius: 5px;
			border: 1px solid #444;
			padding: 10px;
			color: #444;
		}
</style>
<script type="text/javascript">
	var condition;
	ToolbarOpacHeight(500);
//============= "가입"  Event 연결 =============
$(function() {
	
	//==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
	$( "a:contains('로그인 하러 가기')" ).bind("click" , function() {
		self.location = "login"
		
	});
});


</script>

</head>

<body>
	<jsp:include page="../layout/toolbar.jsp" >
		<jsp:param value="../" name="uri"/>
	</jsp:include>
		<header class="parallax"></header>
		<div class="container signup">
		
		<form>
			<div class="text-center">
				<h1>인증이 완료되었습니다</h1>
				<br/><br/>
				<a type="button" class="btn-custom">로그인 하러 가기</a>
			</div>
		

		</form>
	</div>	
	<footer class="container-fluid">
		<jsp:include page="../layout/tailbar.jsp"/>
	</footer>
</body>
</html>