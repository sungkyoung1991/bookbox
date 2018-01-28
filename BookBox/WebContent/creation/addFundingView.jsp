<%@ page language="java" contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

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

	<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
	<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>

	<script src="../resources/javascript/custom.js"></script>
	
		<style>
		#imgPreview, #imgPreview > img{
			height: 300px;
		}
		 body{
    		padding-top:0px;
    	}
    	header{
    		background:url(../resources/images/creationTest7.jpg) no-repeat center;
    	}
		    .creation-toolbar{
		clear: both;
	    height: 40px;
	    _height: 40px;
	    padding: 0 0 2px;
	    background: #3d3d3d
	}
	

	</style>
	
	<script type="text/javascript">
	
	ToolbarOpacHeight(500);
	
		$( function() {
		    $("#fundingEndDate").datepicker({ 
		    	dateFormat:"yy-mm-dd",
		    	showOn: "button",
		    	buttonImageOnly : true,
		    	buttonImage: "https://icongr.am/octicons/calendar.svg?size=25",
		    	minDate: 0,
		    	maxDate: 120
		    });
		    
		    var date = new Date();
		    $('#fundingRegDate').val(date.getFullYear()+"-"+fncGetDate(0));
		} );	
	
		//============== 펀딩등록 Event===========
		$(function(){
			$('a.funding-add').on('click', function(){
			//	alert($('form').val());
				$('form.funding-add').attr('method', 'post').attr('enctype' ,'multipart/form-data').attr('action', '../creation/addFunding').submit();
				});
		})
		
				//============== 이전화면 Event===========
		$(function(){
			$('.menu').on('click', function(){
				history.back();
			})
		})
		
		//============== 커버이미지 미리보기 설정===========
		var upload;
		var preview;
		
		if(typeof window.FileReader === 'undefined'){
			alert('커버이미지 미리보기를 지원하지 않는 브라우저 입니다..');
		}
		
		$(function(){
			upload = document.getElementById('file');
			holder = document.getElementById('imgPreview'),
			
			upload.onchange = function(e){
				e.preventDefault();
				
				var file = upload.files[0],
					reader = new FileReader();
				reader.onload = function(event){
					var img = new Image();
					img.src = event.target.result;
					holder.innerHTML = '';
				    holder.appendChild(img);
				}
				reader.readAsDataURL(file);
				
				return false;
			};
		});

	</script>
</head>

<body>
	<jsp:include page="../layout/toolbar.jsp" >
		<jsp:param value="../" name="uri"/>
	</jsp:include>
	<header class="parallax"></header>
	<!-- 여기부터 코딩 -->
	
    <div class="container">
		    	<jsp:include page="creationToolbar.jsp"/>
    
        <form class="form-horizontal funding-add">
            
            
            <div class="text-left" style="font-size:-webkit-xxx-large;font-weight: 600;">펀딩 등록</div>
            <div style="width: 100%;border: #bbbbbb 2px solid;display: inline-block;margin-bottom:50px"></div>
            
            <div class="form-group">
                <div class="col-sm-2 col-sm-offset-2">
                    <label class="control-label" for="fundingTitle">펀딩명</label>
                </div>
                <div class="col-sm-7">
                    <input class="form-control inputValue" type="text" name="fundingTitle" placeholder="펀딩명" autofocus id="fundingTitle">
                </div>
             <div class="col-sm-1"></div>
            </div>
            <div class="form-group">
                <div class="col-sm-2 col-sm-offset-2">
                    <label class="control-label " for="creationTitle">작품 제목</label>
                </div>
                <div class="col-sm-7">
                    <select class="form-control" name="creation.creationNo">
                    	<c:forEach items="${creationList}" var="creation">
	                        <option value="${creation.creationNo}" >${creation.creationTitle}</option>
	                   	</c:forEach>
                    </select>
                </div>
                <div class="col-sm-1"></div>
            </div>
            <div class="form-group">
                <div class="col-sm-2 col-sm-offset-2">
                    <label class="control-label" for="fundingTarget">목표 금액</label>
                </div>
                <div class="col-sm-7">
                    <input class="form-control" type="text" name="fundingTarget" placeholder="목표금액"   id="fundingTarget">
                </div>
               <div class="col-sm-1"></div>
            </div>
            <div class="form-group">
                <div class="col-sm-2 col-sm-offset-2">
                    <label class="control-label" for="fundingTitle">진행기간</label>
                </div>
                <div class="col-sm-3 col-xs-10">
                    <input class="form-control" type="text" name="fundingRegDate" readonly placeholder="시작일" id="fundingRegDate">
                </div>
                <div class="col-sm-1 col-xs-2">
                    <label class="control-label" for="fundingTitle"> ~ </label>
                </div>
                <div class="col-sm-3">
                    <input class="form-control" type="text" name="fundingEndDate" readonly placeholder="종료일" id="fundingEndDate">
                </div>
            </div>
            <div class="form-group">
                <div class="col-sm-2 col-sm-offset-2">
                    <label class="control-label" for="fundingImage">파일첨부</label>
                </div>
                <div class="col-sm-8">
					<div id="imgPreview">
						<img class="img img-responsive" src="../resources/images/noImg_2.jpg"/>
					</div>
                    <input type="file" name="file" id="file">
                </div>
            </div>
            <div class="form-group">
                <div class="col-sm-2 col-sm-offset-2">
                    <label class="control-label" for="perFunding">1인당 금액</label>
                </div>
                <div class="col-sm-7">
                    <input class="form-control" type="text" name="perFunding" placeholder="1인당금액"  id="perFunding">
                </div>
               <div class="col-sm-1"></div>
            </div>
            <div class="form-group">
                <div class="col-sm-2 col-sm-offset-2">
                    <label class="control-label" for="fundingIntro">글소개</label>
                </div>
                <div class="col-sm-7">
                    <textarea class="form-control" rows="5" name="fundingIntro" placeholder="글소개" id="fundingIntro"></textarea>
                </div>
               <div class="col-sm-1"></div>
            </div>
               <div class="form-group">
                <div class="col-sm-7 col-sm-offset-4 text-right">
                    <a class="btn btn-primary funding-add" >등록</a>
                    <a class="btn btn-defalt menu" >menu</a>
                </div>
                <div class="col-sm-1"></div>
            </div>
        </form>
    </div>
		
	
</body>
</html>