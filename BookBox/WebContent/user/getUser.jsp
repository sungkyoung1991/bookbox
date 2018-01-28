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
	    	height: 250px;
	    }
	    .getuser-title{
			background-color: #444;
			color: floralwhite;		
			font-size: 35px;
			text-align: center;
		}
		
		.btn-custom{
			border-radius: 5px;
			border: 1px solid #444;
			padding: 10px;
			color: #444;
		}
		
		a.btn-custom:hover{
			text-decoration: none;
			cursor:pointer;
		}
</style>	
<script type="text/javascript">
	var condition;
	ToolbarOpacHeight(250);
//============= "가입"  Event 연결 =============
$(function() {
	//==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
	$( "a:contains('정보수정')" ).bind("click" , function() {
		//$(self.location).attr("href","updateUser");
		self.location = "updateUser"
		
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
			<div class="getuser-title" style="text-align: left;padding-left: 20px;">회원정보조회</div>
			<div class="row">
			<div class="col-md-offset-3 col-md-6" style="margin-top: 30px;border: 1px solid;padding-bottom: 20px;padding-top: 30px;">
				<form class="form-horizontal">
					
					<div class="form-group">
						<label  for="email" class="col-sm-5 col-xs-3 control-label">
							Email
						</label>
							<input id="email" name="email"  class="long" type="text" value="${user.email }" readonly>
					</div>
						<span id="checkEmail">
						</span>
					<div class="form-group">					
						<label class="col-sm-5 col-xs-3 control-label">
							Nickname
						</label>
							<input id="nickname" name="nickname" class="long" type="text" value="${user.nickname }" readonly>
					</div>
					<span id="checkNickname">
					</span>
					<div class="form-group">
						<label class="col-sm-5 col-xs-3 control-label">
							Gender
						</label>
							<input class="long" type="radio" id="gender" name="gender" value="남" 
							${user.gender == '남' ? 'checked' : '' }> 남
							<input class="long" type="radio" id="gender" name="gender" value="여"
							${user.gender == '여' ? 'checked' : '' }> 여		
					</div>
					<div class="form-group">
						<label class="col-sm-5 col-xs-3 control-label">
							Birthday
						</label>
						<input class="long" type="text" id="birth" name="birth" value="${user.birth }" readonly>
					</div>
					
						<input class="long" type="hidden" id="outerAccount" name="outerAccount" value=${user.outerAccount }>
						<input class="long" type="hidden" id="active" name="active" value=${user.active }>
		
				</form>
			</div>
		</div>
				<div class="row text-center" style="margin-top: 30px;font-size: larger;">
					<a type="button" class="btn-custom">정보수정</a>
				</div>
	</div>	
	<footer class="container-fluid">
		<jsp:include page="../layout/tailbar.jsp"/>
	</footer>
</body>
</html>