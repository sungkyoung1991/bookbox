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
	
	<script src="../resources/javascript/toolbar_opac.js"></script>
	<script src="../resources/javascript/custom.js"></script>
	
	<style type="text/css">
		body{
	    	padding-top:0px;
	    }
	    
	    header{
	    	background:url(../resources/images/user_title.jpg) no-repeat center;
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
	ToolbarOpacHeight(500);
</script>


</head>
<body>
	<jsp:include page="../layout/toolbar.jsp" >
		<jsp:param value="../" name="uri"/>
	</jsp:include>
		<header class="parallax"></header>
	<div class="container login">
		<form class="form-horizontal">
			<div class="userupdate-title">
				Update User Check
			</div>
			<hr>
			<div class="form-group">
				<label  class="col-sm-6 col-xs-3 control-label">
					Passward
				</label>
					<input class="long" type="text">
			</div>
			
			<div class="text-center">
			<a class="button-submit btn-custom">확인</a>
			</div>
		</form>
	</div>	
	
		<footer class="container-fluid">
		<jsp:include page="../layout/tailbar.jsp"/>
		</footer>
</body>
</html>