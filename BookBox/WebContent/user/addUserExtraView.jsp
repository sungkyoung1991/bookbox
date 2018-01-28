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
	    
	    .signup-title{
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

//============= "가입"  Event 연결 =============
$(function() {
	var condition;
	ToolbarOpacHeight(250);

	//==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
	$( "a:contains('Sign Up')" ).bind("click" , function() {
		
		fncAddUser();
	});
});

//=============fncAddUser()=================
	function fncAddUser() {

			var nickname=$("input[name='nickname']").val();
			var name=$("input[name='gender']").val();
			var name=$("input[name='birth']").val();
			var name=$("input[name='active']").val(1);
			
						
			if(nickname == "" || nickname.length <1){
				alert("닉네임은 반드시 입력하셔야 합니다.");
				return;
			}
			if(gender == ""){
				alert("성별은  반드시 체크하셔야 합니다.");
				return;
			}
			if(birth == ""){
				alert("생일은 반드시 입력하셔야 합니다.");
				return;
			}
						
			$("form").attr("method" , "POST").attr("action" , "addUser").submit();
			
		}

	//=============생일 날짜입력==================
	$( function() {
	    $("#birth").datepicker({ 
	    	dateFormat:"yy-mm-dd",
	    	showOn: "button",
	    	changeMonth: true,
	    	changeYear: true,
	    	defaultDate: '-20y',
	    	buttonImageOnly : true,
	    	buttonImage: "https://icongr.am/octicons/calendar.svg?size=25",
	    	buttonText : "Select date"});
	  } );	

</script>

</head>

<body>
	<jsp:include page="../layout/toolbar.jsp" >
		<jsp:param value="../" name="uri"/>
	</jsp:include>
	<header class="parallax"></header>
		<div class="container signup">
			<div class="signup-title" style="text-align: left;padding-left: 20px;">부가정보 입력</div>
		<div class="row">
			<div class="col-md-offset-3 col-md-6" style="margin-top: 30px;border: 1px solid;padding-bottom: 20px;padding-top: 30px;">
			<form class="form-horizontal">
				
				<div class="form-group">
					<label for="email" class="col-sm-4 col-md-4 control-label">
						Email
					</label>
					<div class="col-sm-8 col-md-8">
						<input id="email" name="email"  class="long" type="text" value="${user.email}" readonly>
					</div>
				</div>
				<div class="form-group">
					<label for="email" class="col-sm-4 col-md-4 control-label">
						NickName
					</label>
					<div class="col-sm-8 col-md-8">
						<input id="nickname" name="nickname" class="long" type="text">
					</div>
				</div>
				<div class="form-group">
					<label for="email" class="col-sm-4 col-md-4 control-label">
						Gender
					</label>
					<div class="col-sm-8 col-md-8">
						<input class="long" type="radio" id="gender" name="gender" value="남"> 남
						<input class="long" type="radio" id="gender" name="gender" value="여"> 여		
					</div>
				</div>
				<div class="form-group">
					<label for="email" class="col-sm-4 col-md-4 control-label">
						Birthday
					</label>
					<div class="col-sm-8 col-md-8">
						<input class="long" type="text" id="birth" name="birth" >
					</div>
				</div>			
				<input type ="hidden" id="outerAccount" name="outerAccount" value="${user.outerAccount }">
				<input type ="hidden" id="outerToken" name="outerToken" value="${user.outerToken }">
				<input type ="hidden" id="active" name="active" >
				
				<br/>
	
			</form>
			</div>
		</div>
			<div class="row text-center" style="margin-top: 30px;font-size: larger;">
				<a type="button" class="btn-custom">가입하기</a>
			</div>
	</div>	
	<footer class="container-fluid">
		<jsp:include page="../layout/tailbar.jsp"/>
	</footer>
</body>
</html>