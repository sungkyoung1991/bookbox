<%@ page language="java" contentType="text/html" pageEncoding="UTF-8"%>
<!--  ///////////////////////// JSTL  ////////////////////////// -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
	<!-- 기본설정 -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="../resources/bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" href="../resources/css/custom.css">
    <link rel="stylesheet" href="../resources/css/star.css">
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" ></script>
	<!-- 기본설정 끝 -->
	<!-- CKEditor 추가 -->
	<script src="../resources/ckeditor/ckeditor.js"></script>
		<!-- CDN Version -->
	<!-- <script src="https://cdn.ckeditor.com/4.7.3/standard/ckeditor.js"></script> -->
	<!-- CKEditor -->

<script type="text/javascript">

		var tagHtml;
		var num;
		var editor;
//=====================창작글 수정하기 EVENT=================
	$(function(){
			editor = CKEDITOR.replace('writingContent', { customConfig : 'config_writing.js'});
			num = 0;
		
			$('.update-writing').on('click',function(){
				var data = CKEDITOR.instances.writingContent.getData();
				$('form[name="updateForm"] textarea').val(data);
				alert($('form[name="updateForm"] textarea').val());
				$("form[name='updateForm']").attr('method','post').attr('action','../creation/updateWriting').submit();
			});
		});	
				
		$(function(){	
			$(".removeImg").on("click",function(){
			
					var content=CKEDITOR.instances.writingContent.getData();
					//alert(content);
					var contentObj=$("<div>"+content+"</div>");
					var src=$(this).attr("id");
				//	alert(temp.html());
					contentObj.find("img[src*='"+src+"']").remove();
					alert(src);
				//	alert($("textarea[name='boardContent']",parent.document).find("img[src='resources']").attr("src"));
				//	$("textarea[name='boardContent']",parent.document).find("img[src*='"+src+"']").remove();
					
					//다른곳에서 쓸때는 에디터 접근 이름변경
					CKEDITOR.instances.writingContent.setData(contentObj.html());
					$(this).parent("div").remove();	
					
			});
		});
		
	//=========================이전화면 Navigation=================================
    $(function(){
		$(".before").on("click" , function() {
	   		history.back();
	   	});
    });
		

</script>

</head>

<body>
	<jsp:include page="../layout/toolbar.jsp" >
		<jsp:param value="../" name="uri"/>
	</jsp:include>

	<!-- 말머리 -->
<div class="container">
			<jsp:include page="creationToolbar.jsp"/>

   
        <div class="row" style="height:325px;margin-top: 30px;overflow:hidden;">
				<input type ="hidden" name="creationNo" value="${creation.creationNo }"/>
            <div class="col-md-5">
            	<img class="img-rounded img-responsive  img-object-fit" src="../resources/upload_files/images/${creation.creationFileName }">
            	<c:if test="${creation.doFunding}">
            		펀딩 진행 중!
            	</c:if>
            </div>
            <div class="col-md-7" style="height: 100%;">
            	<div class="row">
	            	<strong style="font-size: xx-large;padding-left:15px">${creation.creationTitle}  </strong>
	           		<span style="font-size: small;">  ${creation.creationAuthor.nickname}</span>
	          </div>
	          <div>
           			<div id="starWrap" class="gradeAvg star${creation.grade.average}" >
						<ul style="padding-left:0">
							<li class="s1"></li>
							<li class="s2"></li>
							<li class="s3"></li>
							<li class="s4"></li>
							<li class="s5"></li>
						</ul>
				</div>
	          </div>
   			 <div class="row">
                	<div class="col-sm-12" style="padding-left: 10%;padding-right: 3%;">
	                	${creation.creationIntro}
	                </div>
                </div>
                
		        <div class="row">
		            <div class="col-xs-12 " style="padding-left: 10%;padding-top: 4px;bottom: 6%;position: absolute;">
			           	<c:forEach items="${creation.tagList}" var="tag">
			           		<span style="border: 1px solid;border-color: #bbbbbb;border-radius: 15px;padding: 4px;" class="tag">
			           		<strong>#${tag.tagName}</strong></span>
			           	</c:forEach>
		            </div>
		        </div>
            </div>
        </div>
        <div class="row">
        	<%-- <div class="col-md-6" >
        		<div class="row">
				<c:if test="${sessionScope.user.email == creation.creationAuthor.email}">
                	<div class="btn-form control-btn updateCreation" style="display:inline-block;">수정</div>
                	<div class="btn-form control-btn deleteCreation" style="display:inline-block;">삭제</div>
	             </c:if>
	             </div>
			</div> --%>
        
            <div class="col-md-12">
            	<div class="row" role="group" style="float:right">
                	
            <c:if test="${creation.doFunding}">
                <div class="go-funding btn-form" style="margin-right: 20px;"><strong>펀딩보러가기</strong></div>
            </c:if>
                
	                <c:if test="${creation.doSubscription}">
	                	<div class="subscription deleteSubscription btn-form" style="background-color:rgba(255, 20, 44, 0.21);"><i class="glyphicon glyphicon-tags"></i><strong>  구독중</strong></div>
	                    
	                </c:if>
	                <c:if test="${!creation.doSubscription}">
	                	<div class="subscription doSubscription btn-form"><strong>구독하기</strong></div>
	                </c:if>
	                <c:if test="${creation.like.doLike}">
	                    <div class="like deleteCreationLike btn-form">	
	                    	<img class="creationLike-link" src="https://icongr.am/entypo/heart.svg?size=25&color=ff0000"> <span  id="likeSum">${creation.like.totalLike}</span>
	                    </div>
	                   
	                </c:if>
	                <c:if test="${!creation.like.doLike}">
	                    <div class="like addCreationLike btn-form" >
	                    	<img class="creationLike-link" src="https://icongr.am/entypo/heart-outlined.svg?size=25&color=ff0000"> <span  id="likeSum">${creation.like.totalLike}</span>
	                    </div>
	               </c:if>
                </div>
            </div>
        </div><!--창작부분 버튼 끝  -->
   </div><!--창작 container 끝  -->
	
	<div class="container">
		<div class="inWriting" id="inWriting">
			
			<form id="updateForm" name="updateForm">
		<hr>
		<div class="form-group">
					<strong style="font-size: large;">글제목</strong> <input type="text" class="form-control" name="writingTitle" value="${writing.writingTitle }">
					<input type = "hidden" name="creationNo" value="${creation.creationNo }">
					<input type = "hidden" name="writingNo" value="${writing.writingNo }">
					<input type = "hidden" name="active" value="${writing.active }">
				</div>
				<div class="form-group" >
					<textarea name="writingContent" id="writingContent" rows="20" cols="80">
						${writing.writingContent }</textarea>
				</div>
				
				<div class="panel imgList">
				이미지리스트
					<c:forEach var ="uploadFile" items="${writing.writingFileList }">
					<div id="${uploadFile.fileName}">
						<input type="hidden" name="writingFileName"   value="${uploadFile.fileName}" readonly>
						<input type="hidden" name="writingOriginName"    value="${uploadFile.originName}" readonly>
						<span>${uploadFile.originName}</span>
						<a class='btn removeImg' id="${uploadFile.fileName}">x</a>
					</div>		
					</c:forEach>
				</div>
		
				 <div class="form-group" style="margin-bottom:80px;">
			           <div style="float:right;">
			               <a class="btn delete-writing" id="delete-writing">삭제</a>
							<a class= "btn btn-primary update-writing" id="update-writing" >수정</a>
			           </div>
			           <div>
							<a class="btn before">이전</a>
			           </div>
			   </div>	
			   
			  
	</form>
		
		
		</div>
	</div>

		
		

		
	
	</div>
</body>
</html>