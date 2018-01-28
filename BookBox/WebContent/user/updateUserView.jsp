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
	    
	    .list-header{
	    	margin:  20px 0 10px 0;
	    	font-weight: bold;
	    	border-bottom: 1px solid #444;  
	    }
	    .userupdate-title{
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

</style>
<script type="text/javascript">
	var condition;
	ToolbarOpacHeight(250);


	var nicknameJSONData;

//============= "가입"  Event 연결 =============
$(function() {
	//==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
	$( "a:contains('수정')" ).bind("click" , function() {
		
		fncUpdateUser();
	});
});


//============= "회원탈퇴" Event 연결 ============
$(function(){
	$('a.user-shut-out').bind('click', function(){
		if( confirm("정말 탈퇴 하시겠습니까?") ){
			$(self.location).attr('href', '../user/deleteUser');
		}
	});
});

//=============fncAddUser()=================
	function fncUpdateUser() {
			
			
			var email=$("input[name='email']").val();
			var nickname=$("input[name='nickname']").val();
			var password=$("input[name='password']").val();
			var checkPassword=$("input[name='checkPassword']").val();
			var name=$("input[name='gender']").val();
			var name=$("input[name='birth']").val();
			
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
			
			if( nicknameJSONData == false ) {				
				alert("사용불가능한 닉네임입니다.");
				return;
			}			
			
			$("form").attr("method" , "POST").attr("action" , "updateUser").submit();
			
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
		<div class="userupdate-title" style="text-align: left;padding-left: 20px;">회원정보 수정</div>

		<div class="row">
			<div class="col-md-offset-3 col-md-6" style="margin-top: 30px;">		
			<form class="form-horizontal" style="border: 1px solid;padding-bottom: 20px;padding-top: 30px;">
				
				<div class="form-group">
					<label class="col-sm-5 col-xs-3 control-label">
						Email
					</label>
					<input id="email" name="email"  class="long" type="text" value="${user.email }" readonly>
				</div>
				<div class="text-center">
					<span id="checkEmail"></span>
				</div>
				
						
				<div class="form-group">
					<label class="col-sm-5 col-xs-3 control-label">
						NickName
					</label>
					<input id="nickname" name="nickname" class="long" type="text" value="${user.nickname }">
				</div>
				<span id="checkNickname">
				
				</span>
	
				<div class="form-group">
					<label class="col-sm-5 col-xs-3 control-label">
					Password
					</label>
					<input id="password" name="password" class="long" type="password" style="font-family: initial;">
				</div>
				
				<div class="form-group">
					<label class="col-sm-5 col-xs-3 control-label">
					Repeat Password
					</label>
					<input id="chekPassword" name="checkPassword" class="long" type="password" style="font-family: initial;">
				</div>
				
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
					<input class="long" type="text" id="birth" name="birth" readonly value="${user.birth}">
				</div>
					<input class="long" type="hidden" id="outerAccount" name="outerAccount" value="${user.outerAccount }">
					<input class="long" type="hidden" id="active" name="active" value="${user.active }">
			
			</form>
			<div class="row" style="padding-right: 20px; padding-top: 20px;">
				<div class="text-right user-shut-out" style="display:inline-block;float:right;">
					<a class="btn ">회원탈퇴</a>
				</div>
				<div class="text-center" style="display:inline-block;float:right;">
					<a class="btn btn-primary">수정</a>
				</div>
	
			</div>
		</div>
		</div>
	</div>	
	
	<footer class="container-fluid">
		<jsp:include page="../layout/tailbar.jsp"/>
	</footer>
</body>
</html>