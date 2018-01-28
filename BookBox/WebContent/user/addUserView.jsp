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
		}

</style>
<script type="text/javascript">
	var condition;
	ToolbarOpacHeight(250);

	var emailJSONData;
	var nicknameJSONData;

//============= "가입"  Event 연결 =============
$(function() {
	//==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
	$( "a:contains('가입하기')" ).bind("click" , function() {
		
		fncAddUser();
	});
});

//=============fncAddUser()=================
	function fncAddUser() {
			
			
			var email=$("input[name='email']").val();
			var nickname=$("input[name='nickname']").val();
			var password=$("input[name='password']").val();
			var checkPassword=$("input[name='checkPassword']").val();
			var name=$("input[name='gender']").val();
			var name=$("input[name='birth']").val();
			
			var name=$("input[name='outerAccount']").val(0);
			var name=$("input[name='active']").val(0);
						
			if(email == "" || email.length <1){
				alert("아이디는 반드시 입력하셔야 합니다.");
				return;
			}
			if(nickname == "" || nickname.length <1){
				alert("닉네임은 반드시 입력하셔야 합니다.");
				return;
			}
			if(password == "" || password.length <1){
				alert("패스워드는  반드시 입력하셔야 합니다.");
				return;
			}
			if(checkPassword == "" || checkPassword.length <1){
				alert("패스워드 확인은  반드시 입력하셔야 합니다.");
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
			
			if( password != checkPassword ) {				
				alert("비밀번호 확인이 일치하지 않습니다.");
				$("input:[name='checkPassword']").focus();
				return;
			}
			
			if( emailJSONData == false ) {				
				alert("사용불가능한 이메일입니다.");
				return;
			}

			if( nicknameJSONData == false ) {				
				alert("사용불가능한 닉네임입니다.");
				return;
			}
			
			alert("전송된 메일에서 링크를 클릭하시면 회원가입이 완료됩니다.");
			
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
	  
//============emailID 중복체크================
			$(function() {

				$('#email').keyup(
						function() {
							var email=$("input[name='email']").val().trim();
							//alert("입력된 값은 "+email);

							/////////ajax 적용/////////
							$.ajax({
								url : "rest/checkEmailValidation/",
								method : "post",
		 						data : JSON.stringify({
									email : email
								}),
								dataType : "json",
								headers : {
								"Accept" : "application/json",
								"Content-Type" : "application/json"
								},
								success : function(JSONData, status) {

									//Debug...
									//alert(status);
									//Debug...
									//alert("JSONData : \n"+JSONData);
									//alert( "JSON.stringify(JSONData) : \n"+JSONData );
									
										emailJSONData =JSONData;
																			
										if (JSONData == true) {
										
											var displayValue = "<p>'" +email+ "'은 사용가능한 아이디입니다.<br/></p>";
										} else {
											var displayValue = "<p>'"+email+ "'은 사용불가능한 아이디입니다. <br/></p>";
										}
										
										if(email == "") {	
												var displayValue ="";
									}

									//Debug...									
									//alert(displayValue);
									$("p").remove();
									$("#checkEmail").html(displayValue);
								}
							})
						})
				})

//============nickname 중복체크================
				$(function() {

				$('#nickname').keyup(
						function() {
							var nickname=$("input[name='nickname']").val().trim();
							//alert("입력된 값은 "+email);

							/////////ajax 적용/////////
							$.ajax({
								url : "rest/checkNicknameValidation/",
								method : "post",
		 						data : JSON.stringify({
									nickname : nickname
								}),
								dataType : "json",
								headers : {
								"Accept" : "application/json",
								"Content-Type" : "application/json"
								},
								success : function(JSONData, status) {

									//Debug...
									//alert(status);
									//Debug...
									//alert("JSONData : \n"+JSONData);
									//alert( "JSON.stringify(JSONData) : \n"+JSONData );
									
									nicknameJSONData = JSONData;
									
										if (JSONData == true) {
										
											var displayValue = "<p>'"+nickname+ "'은 사용가능한 닉네임입니다.<br/></p>";
										} else {
											var displayValue = "<p>'"
																				+nickname+ "'은 사용불가능한 닉네임입니다. <br/></p>";
										}
										
										if(nickname == "") {	
												var displayValue ="";
									}

									//Debug...									
									//alert(displayValue);
									$("p").remove();
									$("#checkNickname").html(displayValue);
								}
							})
						})
				})


</script>

</head>

<body>
	<jsp:include page="../layout/toolbar.jsp" >
		<jsp:param value="../" name="uri"/>
	</jsp:include>
	<header class="parallax"></header>
	
	<div class="container signup">
		

		<div class="">
			<div class="signup-title" style="text-align: left;padding-left: 20px;">회원가입</div>
		
			<div class="row">
				<div class="col-md-8 col-md-offset-2" style="border:1px groove;padding:20px;margin-top: 30px;">
					<form class="form-horizontal">
						<div class="form-group">
							<label for="email" class="col-sm-5 col-xs-3 control-label">
								Email
							</label>
							<div class="">
								<input id="email" name="email" type="text">
							</div>
						</div>
						<div class="text-center">
							<span id="checkEmail"></span>
						</div>
						<div class="form-group">
							<label for="nickname" class="col-sm-5 col-xs-3 control-label">
								NickName
							</label>
							<div class="">
								<input id="nickname" name="nickname" class="long" type="text">
							</div>
						</div>	
						<div class="text-center">
							<span id="checkNickname"></span>
						</div>
						<div class="form-group">
							<label for="password" class="col-sm-5 col-xs-3 control-label">
								Password
							</label>
							<div class="">
								<input id="password" name="password" class="long" type="password" style="font-family: initial;">
							</div>
						</div>
			
						<div class="form-group">
							<label for="checkPassword" class="col-sm-5 col-xs-3 control-label">
								Repeat password
							</label>
							<div class="">
								<input id="chekPassword" name="checkPassword" class="long" type="password" style="font-family: initial;">
							</div>
						</div>
						
						<div class="form-group">
							<label for="gender" class="col-sm-5 col-xs-3 control-label" >
								Gender
							</label>
							<div class="">
								<input class="long" type="radio" id="gender" name="gender" value="남"> 남
								<input class="long" type="radio" id="gender" name="gender" value="여"> 여		
							</div>
						</div>
						
						<div class="form-group">
							<label for="birth" class="col-sm-5 col-xs-3 control-label">
								Birthday
							</label>
							<div class="">
								<input class="long" type="text" id="birth" name="birth" readonly>
							</div>
						</div>
						
						<input class="long" type="hidden" id="outerAccount" name="outerAccount">
						<input class="long" type="hidden" id="active" name="active">
						<div class="row text-center">
						</div>
			
					</form>
				</div>
			</div>
				<div class="row text-center" style="margin-top: 30px;font-size: larger;">
					<a class="btn-custom" style="cursor:pointer;">가입하기</a>
				</div>
			<br/>
			<br/>
			<br/>
			
		</div>
		
	</div>	
		<footer class="container-fluid">
		<jsp:include page="../layout/tailbar.jsp"/>
		</footer>
</body>
</html>