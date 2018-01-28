<%@ page language="java" contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<jsp:include page="fundingData.jsp"/>
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

	<script src="../resources/javascript/custom.js"></script>
	
	<script type="text/javascript">
		$( function() {
		    $("#fundingEndDate").datepicker({ 
		    	dateFormat:"yy-mm-dd",
		    	showOn: "button",
		    	buttonImageOnly : true,
		    	buttonImage: "https://icongr.am/octicons/calendar.svg?size=25",
		    	minDate: 0,
		    	maxDate: 120
		    });
		    
		} );	
		
		$(function(){
			$('a.funding-update').on('click', function(){
//				$('form.funding-update').attr('method', 'post').attr('enctype' ,'multipart/form-data').attr('target', '../creation/updateFunding').submit();
			});
		})


	</script>
</head>

<body>
	<jsp:include page="../layout/toolbar.jsp" >
		<jsp:param value="../" name="uri"/>
	</jsp:include>
	<!-- 여기부터 코딩 -->
	
    <div class="container">
        <form class="form-horizontal funding-update">
            <h2 class="text-center">펀딩 등록</h2>
            <div class="form-group">
                <div class="col-sm-2 col-sm-offset-2">
                    <label class="control-label" for="fundingTitle">펀딩명</label>
                </div>
                <div class="col-sm-8">
                    <input class="form-control" type="text" name="fundingTitle" placeholder="펀딩명" autofocus id="fundingTitle" value="${funding.fundingTitle}">
                </div>
            </div>
            <div class="form-group">
                <div class="col-sm-2 col-sm-offset-2">
                    <label class="control-label" for="creationTitle">작품 제목</label>
                </div>
                <div class="col-sm-8">
                    <input class="form-control" type="text" name="creationTitle" placeholder="작품제목" id="creationTitle" value="${funding.creation.creationTitle}" readonly>
                </div>
            </div>
            <div class="form-group">
                <div class="col-sm-2 col-sm-offset-2">
                    <label class="control-label" for="fundingTarget">목표 금액</label>
                </div>
                <div class="col-sm-8">
                    <input class="form-control" type="text" name="fundingTarget" placeholder="목표금액" id="fundingTarget" value="${funding.fundingTarget}">
                </div>
            </div>
            <div class="form-group">
                <div class="col-sm-2 col-sm-offset-2">
                    <label class="control-label" for="fundingTitle">진행기간</label>
                </div>
                <div class="col-sm-3 col-xs-10">
                    <input class="form-control" type="text" name="fundingRegDate" readonly placeholder="시작일" id="fundingRegDate" value="${funding.fundingRegDate}">
                </div>
                <div class="col-sm-1 col-xs-2">
                    <label class="control-label" for="fundingTitle"> ~ </label>
                </div>
                <div class="col-sm-4">
                    <input class="form-control" type="text" name="fundingEndDate" readonly placeholder="종료일" id="fundingEndDate" value="${funding.fundingEndDate}">
                </div>
            </div>
            <div class="form-group">
                <div class="col-sm-2 col-sm-offset-2">
                    <label class="control-label" for="fundingImage">파일첨부</label>
                </div>
                <div class="col-sm-8">
                    <input type="file" name="fundingImage" id="fundingImage">
                </div>
            </div>
            <div class="form-group">
                <div class="col-sm-2 col-sm-offset-2">
                    <label class="control-label" for="perFunding">1인당 금액</label>
                </div>
                <div class="col-sm-8">
                    <input class="form-control" type="text" name="perFunding" placeholder="1인당금액" id="perFunding" value="${funding.perFunding}">
                </div>
            </div>
            <div class="form-group">
                <div class="col-sm-2 col-sm-offset-2">
                    <label class="control-label" for="fundingIntro">글소개</label>
                </div>
                <div class="col-sm-8">
                    <textarea class="form-control" rows="5" name="fundingIntro" placeholder="글소개" id="fundingIntro">${funding.fundingIntro}</textarea>
                </div>
            </div>
            <div class="form-group">
                <div class="col-sm-2 col-sm-offset-2">
                    <label class="control-label">Static Control</label>
                </div>
                <div class="col-sm-8">
                    <p class="form-static-control">A basic template showing the proper way to create bootstrap forms using form group components, labels and input fields.</p>
                </div>
            </div>
            <div class="form-group">
                <div class="col-sm-8 col-sm-offset-4">
                    <a class="btn btn-primary funding-update" href="#">수정</a>
                </div>
            </div>
        </form>
    </div>
		
	
</body>
</html>