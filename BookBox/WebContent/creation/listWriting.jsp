<%@ page language="java" contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<!--  ///////////////////////// JSTL  ////////////////////////// -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

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
    <link rel="stylesheet" href="../resources/css/star.css">
	<script src="../resources/javascript/toolbar_opac.js"></script>
	<script src="../resources/javascript/custom.js"></script>
	
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/Swiper/3.4.2/css/swiper.css">
	 
	<script src="https://cdnjs.cloudflare.com/ajax/libs/Swiper/3.4.2/js/swiper.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/Swiper/3.4.2/js/swiper.jquery.js"></script>
	
	

<style type="text/css">

/* 페이지 css 설정 */
		span.tag{
			margin-right: 2px; 
			border: 1px solid;
			border-color: #bbbbbb;
			border-radius: 15px;
			padding: 4px;
			font-weight: bold;
		}
		div.row.writing-border{
			border-bottom: 1px solid #eeeeee;
			/* margin-top: 1%; */
		}
		  
		 
		body{
			padding-top:0px;
			
		}
		header{
			background:url(../resources/images/newCreationTest1.jpg) no-repeat center;
		}
		
		.btn-form{
	     	border: 2px groove; 
		    padding: 5px;
		    border-radius: 7px; 
		    display:inline-block;
	        padding-left: 15px;
   			padding-right: 15px;
   			cursor:pointer;
		}
		.like{
			padding: 4px 15px; 
		}
	.creation-toolbar{
		clear: both;
	    height: 40px;
	    _height: 40px;
	    padding: 0 0 2px;
	    background: #3d3d3d
	}
	.writing-list-menu{
		font-weight: bold;
		background-color: rgba(165, 163, 159, 0.19);
		margin-top: 3%;
		border-bottom: 1px groove;
	    padding-top: 1%;
   	}	
	.funding-badge{
    	position: absolute;
    	z-index: 3;
   	    transform: translate(-50%,-40%);
   	    background-color: antiquewhite;
    	border-radius: 50%;
    }
	
  
    </style>

	
    <script>
    
	   ToolbarOpacHeight(500);
	   
	   function fncDoSubscription(){
		   $.ajax ({
			   url : "rest/addCreationSubscribe?creationNo="+$("input[name='creationNo']").val(),
	    		method : "get",
	    		dataType : "json",
	    		success: function(JSONData, status){
	    		//	alert(JSONData);
	    			$(".doSubscription").css('background-color','#bbbbbb').css('color','darkslategray').removeClass('doSubscription').addClass('deleteSubscription').html("<i class='glyphicon glyphicon-tags'></i><strong>구독중</strong>").off('click');
	    		//	$("a.doSubscription").replaceWith("<a style='background-color:rgba(106, 98, 230, 0.46);' class='btn btn-default deleteSubscription' type='button'><i class='glyphicon glyphicon-tags'></i>구독중</a>");
	    			 $(".deleteSubscription").on("click" , function() {
			   	    		alert("구독취소");
			   	    		fncDeleteSubscription();
			   	    	}); 
	    		}  
		   });
	   }
	   
	   function fncDeleteSubscription(){
		   $.ajax ({
			   url : "rest/deleteCreationSubscribe?creationNo="+$("input[name='creationNo']").val(),
	    		method : "get",
	    		dataType : "json",
	    		success: function(JSONData, status){
	    			alert(JSONData);
	    			$(".deleteSubscription").css('background-color','#ffffff').css('color','inherit').removeClass('deleteSubscription').addClass('doSubscription').html("<strong>구독하기</strong>").off('click');
	    		//	$("a.deleteSubscription").replaceWith("<a class='btn btn-default doSubscription' type='button'><i class='glyphicon glyphicon-tags'></i>구독</a>");
	    			 $(".doSubscription").on("click" , function() {
			   	    		alert("구독");
			   	    		fncDoSubscription();
			   	    	});  
	    		
	    		}  
		   });
	   }
	   
	   function fncAddCreationLike(){   
		   var total = document.getElementById('likeSum').innerHTML;  	
		   	$.ajax ({
		   		url : "rest/addCreationLike?creationNo="+$("input[name='creationNo']").val(),
		   		method : "GET",
		   		success:function(JSONData, status){
		   		//	alert(status);
		   			alert(JSONData);
		   			
		   			$(".addCreationLike").removeClass('addCreationLike').addClass('deleteCreationLike').off('click');
		   			$('img.creationLike-link').attr('src','https://icongr.am/entypo/heart.svg?size=25&color=ff0000');
		   		
		   			$("#likeSum").replaceWith("<span id='likeSum'>" + (Number(total)+1) + "</span>");
		   	   		 $(".deleteCreationLike").on("click" , function() {
		   	    		alert("좋아요취소");
		   	    		fncDeleteCreationLike();
		   	    	});
		   		 } 
		   	});
		}  
	   
	   function fncDeleteCreationLike(){   
		   var total = document.getElementById('likeSum').innerHTML;	   	   	
	   	   	$.ajax ({
	   	   		url : "rest/deleteCreationLike?creationNo="+$("input[name='creationNo']").val(),
	   	   		method : "GET",
	   	   		success:function(JSONData, status){
	   	   			
	   	   		$(".deleteCreationLike").removeClass('deleteCreationLike').addClass('addCreationLike').off('click');
	   	   		$('img.creationLike-link').attr('src','https://icongr.am/entypo/heart-outlined.svg?size=25&color=ff0000');
	   	   		
	   	   			$("#likeSum").replaceWith("<span id='likeSum'>" + (Number(total)-1) + "</span>");
		   	   		 $(".addCreationLike").on("click" , function() {
		   	    		alert("좋아요");
		   	    		fncAddCreationLike();
		   		    	
		   	    	});
	   	   		} 
	   	   	});
		} 
	   
	$(function(){
		num = 0;
		
			$('a.tag-add:contains("추가하기")').on('click',function(){
				num = num + 1;
				tagHtml = '<span id="tag'+num+'">, # <input class="inputValue" type="text" name="tag"><span class="glyphicon glyphicon-remove" aria-hidden="true" onClick="javascript:fncRemoveTag('+num+')"></span></span>';
				$('.tag-list').append(tagHtml);
			});
		});
	

	   
   $(function() {
		      
       //============= 창작글 조회 Navigation Event  처리 =============	
	   $("a.writingTitle").on("click" , function() {
	   		$(self.location).attr("href","../creation/getWriting?writingNo="+$(this).attr("id"));
   		}); 
	   //============= 창작작품 수정 Navigation Event  처리 =============	
 	   $("#update-creation-action").on("click" , function() {
 		  $('#creationForm').attr('enctype','multipart/form-data').attr('method','post').attr("action","../creation/updateCreation?creationNo="+$("input[name='creationNo']").val()).submit();
   		});  
	 //============= 창작작품 수정 Navigation Event  처리 =============	
	   $(".updateCreation").on("click" , function() {
		   $('#update-creation').modal('show')
   		}); 
		 //============= 창작작품 수정창 취소버튼 Navigation Event  처리 =============	
	   $(".cancle").on("click" , function() {
		   $('#update-creation').modal('hide')
   		}); 
	   //============= 창작작품 삭제 Navigation Event  처리 =============	
	   $(".deleteCreation").on("click" , function() {
		   alert("정말로 삭제하시겠습니까?");
		   $(self.location).attr("href","../creation/deleteCreation?creationNo="+$("input[name='creationNo']").val());
   		});
	//============= 펀딩보러가기 ====================	
	  $(".go-funding").on("click" , function() {
		$(self.location).attr("href","../creation/getFundingList?creationNo="+$("input[name='creationNo']").val()+"&condition=1");
	  });
	//============= 작가 북로그 보러가기 ====================	
	  $(".creation-author").on("click" , function() {
		  $(self.location).attr("href","../booklog/getBooklog?user.email="+$(this).attr('id'));
	  });
		
   }); 
 	   
   $(function() {
 //========================구독신청 =======================
	   $(".doSubscription").on("click" , function() {
		   alert("구독");
		   fncDoSubscription();	
	   });
   //========================구독신청 취소=======================
	   $(".deleteSubscription").on("click" , function() {
		   alert("구독취소");		   
		   fncDeleteSubscription();
		});

    //========================좋아요 추가=======================
     	 $(".addCreationLike").on("click" , function() {
    		alert("좋아요");
    		fncAddCreationLike();
	    	
    	});
    //=========================좋아요 취소=================================
      	 $(".deleteCreationLike").on("click" , function() {
    		alert("좋아요취소");
    		fncDeleteCreationLike();
    	});
    });


    
    </script>
		

</head>
<body>
	<jsp:include page="../layout/toolbar.jsp" >
		<jsp:param value="../" name="uri"/>
	</jsp:include>
	<header class="parallax"></header>
	
    <div class="container" style="margin-bottom:50px;">
			<jsp:include page="creationToolbar.jsp"/>

   
        <div class="row" style="height:325px;margin-top: 30px;">
				<input type ="hidden" name="creationNo" value="${creation.creationNo }"/>
            <div class="col-md-5" style="height: 100%">
            	<c:if test="${creation.doFunding }">
					<div class="funding-badge">
							<img src="https://icongr.am/entypo/credit.svg?size=25px&color=ff9a3c" style="position: absolute; left: 50%;top: 50%;transform: translate(50%, -120%);">
							<img src="https://icongr.am/material/account-multiple.svg?size=65px&color=092a35"></div>	
				</c:if>
            	<img class="img-rounded img-responsive  img-object-fit" src="../resources/upload_files/images/${creation.creationFileName }">
            </div>
            <div class="col-md-7" style="height: 100%;">
            	<div class="row">
	            	<strong style="font-size: xx-large;padding-left:15px">${creation.creationTitle}  </strong>
	           		<span class="creation-author" id="${creation.creationAuthor.email }" style="font-size: small;cursor:pointer;">  ${creation.creationAuthor.nickname}</span>
	          </div>
	          
           			<div id="starWrap" class="gradeAvg star${fn:substring(creation.grade.average, 0, 1)}"  style="display: inline-block; float:left;    padding-top: 0.6%;" >
						<ul style="padding-left:0">
							<li class="s1"></li>
							<li class="s2"></li>
							<li class="s3"></li>
							<li class="s4"></li>
							<li class="s5"></li>
						</ul>
					</div>
					<div  style="display: inline-block; float:left;"><strong>(<fmt:formatNumber value="${creation.grade.average}" pattern="0.00"/>)</strong></div>
	          
   			 <div class="row">
                	<div class="col-sm-12" style="padding-left: 10%;padding-right: 3%;">
	                	${creation.creationIntro}
	                </div>
                </div>
                
		        <div class="row">
		            <div class="col-xs-12 " style="padding-left: 10%;padding-top: 4px;bottom: 6%;position: absolute;">
			           	<c:forEach items="${creation.tagList}" var="tag">
			           		<span  class="tag">#${tag.tagName}</span>
			           	</c:forEach>
		            </div>
		        </div>
            </div>
        </div>
        <div class="row" style="margin-top: 20px;">
        	<div class="col-md-6" >
        		<div class="row">
				<c:if test="${sessionScope.user.email == creation.creationAuthor.email}">
                	<div class="btn-form control-btn updateCreation" style="display:inline-block;">수정</div>
                	<div class="btn-form control-btn deleteCreation" style="display:inline-block;">삭제</div>
	             </c:if>
	             </div>
			</div>
        
            <div class="col-md-6">
            	<div class="row" role="group" style="float:right">
            <c:if test="${!empty sessionScope.user }">    	
           	<c:if test="${creation.doFunding}">
                <div class="go-funding btn-form" style="margin-right: 20px;"><strong>펀딩보러가기</strong></div>
            </c:if>
                
                <c:if test="${!empty sessionScope.user and !empty sessionScope.user.email}">
	                <c:if test="${creation.doSubscription}">
	                	<div class="subscription deleteSubscription btn-form" style="background-color: #bbbbbb;color: darkslategray;"><i class="glyphicon glyphicon-tags"></i><strong>  구독중</strong></div>
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
               </c:if>
               </c:if>
                </div>
            </div>
        </div><!--창작부분 버튼 끝  -->
   </div><!--창작 container 끝  -->
    
    <!-- <hr> -->
    
    <div class="container">
        <div class="row hidden-xs hidden-sm" >
            <div class="col-md-2 text-center writing-list-menu">
                <p>이미지</p>
            </div>
            <div class="col-md-6 text-center writing-list-menu">
                <p>제목</p>
            </div>
            <div class="col-md-2 text-center writing-list-menu">
                <p>평점</p>
            </div>
            <div class="col-md-2 text-center writing-list-menu">
                <p>등록일</p>
            </div>
        </div>
        <div>
        	<c:if test="${empty creation.writingList}">
				<div class="text-center" style="padding: 10%;border-bottom: 1px groove;margin-bottom: 10%;">        		
        		등록된 게시글이 존재하지 않습니다.
        		</div>
        	</c:if>
			    <c:forEach items="${creation.writingList}" var="writing">
			        <div class="row writing-border">
			        	<div class="row writing-each" style="margin:1%;">
				        	<input type ="hidden" class="writingNo" name="writingNo" value="${writing.writingNo }" readonly>
				            <div class="col-md-2 col-xs-3" style="overflow:hidden;height: 130px;">
				            	<img class="img-responsive img-object-fit" src="../resources/upload_files/images/${writing.writingFileList[0].fileName }">
				            </div>
				            <div class="col-md-6 col-xs-9">
				                <div class="row">
				                    <div class="col-md-12">
				                        <p style="font-size: 15px;"><a href="#" class="writingTitle" id="${writing.writingNo}">${writing.writingTitle }</a></p>
				                    </div>
				                </div>
				                <div class="row hidden-md hidden-lg">
				                    <div class="col-xs-7">
										<div id="starWrap" class="star${fn:substring(writing.grade.average, 0, 1)}" style="display: inline-block;float:left;padding-top: 0.6%;">
											<ul>
												<li class="s1"></li>
												<li class="s2"></li>
												<li class="s3"></li>
												<li class="s4"></li>
												<li class="s5"></li>
											</ul>
										</div>
									</div>
				                    <div class="col-xs-5" style="text-align:center"><span >${writing.regDate}</span></div>
				                </div>
				            </div>
				            <div class="col-md-2 hidden-xs hidden-sm">
								<div id="starWrap" class="star${fn:substring(writing.grade.average, 0, 1)}" style="display: inline-block;">
									<ul style="float: left;padding-top: 2%;">
										<li class="s1"></li>
										<li class="s2"></li>
										<li class="s3"></li>
										<li class="s4"></li>
										<li class="s5"></li>
									</ul>
								<div style="display: inline-block; float:left;"><strong>(<fmt:formatNumber value="${writing.grade.average}" pattern="0.00"/>)</strong></div>
								</div>
							</div>
				            <div class="col-md-2 hidden-xs hidden-sm" style="text-align:center"><span>${writing.regDate}</span></div>
				        
			        	</div>
			        </div>
				</c:forEach>
      </div> 
    </div>
    
    <div class="modal fade update-creation" id="update-creation" tabindex="-1" role="dialog" style="z-index:1090;">
    	<div class="modal-dialog modal-lg" role="document">
    		<div class="modal-content">
		      <div class="modal-header" style="border-bottom: 3px groove;margin-left: 20px;margin-bottom: 30px;padding-bottom: 0;">
		        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
		        <h4 class="modal-title" id="insert-payInfo" style="font-weight: bold;">작품정보 수정</h4>
		      </div>
		      
		      <form  class="form-horizontal creation-update" id="creationForm" name="creationForm">
		      	<div class="modal-body">
		      		<!-- creation Form -->
		      		
		
						<div class="row">
							<div class="col-sm-12 col-md-12">
								<div class="row">
									<div class="col-md-5">
										<div id="imgPreview" style="padding-left:20px;">
											<c:if test="${!empty creation }">
												<img class="img img-responsive img-object-fit" src="../resources/upload_files/images/${creation.creationFileName }"/>
											</c:if>
											<c:if test="${empty creation }">
												<img class="img img-responsive img-object-fit" src="../resources/images/noImg_2.jpg"/>
											</c:if>
										</div>
			                    		<input style="padding-left:20px;" type="file"  class="inputValue" id="file" name="file" value="${creation.creationOriginName }">
									</div><!--이미지처장 div END  -->
								
									<div class="col-md-7">
										
										<div class="form-group">
							                <div class="col-sm-2 col-sm-offset-1 ">
							                    <label class="control-label" for="creationHead">말머리</label>
							                </div>
							                <div class="col-sm-9">
							                    <input class="inputValue" type="radio" name ="creationHead"  value ="픽션" ${creation.creationHead =='픽션' ? 'checked' : '' } >픽션
												<input class="inputValue" type="radio" name ="creationHead"  value ="논픽션" ${creation.creationHead =='논픽션' ? 'checked' : '' } >논픽션
							                </div>
			             				</div>
			            
							            <div class="form-group">
							                <div class="col-sm-2 col-sm-offset-1">
							                    <label class="control-label " for="creationTitle">작품명</label>
							                </div>
							                <div class="col-sm-8">
							                    <input class="inputValue form-control" type="text" name="creationTitle" id ="creationTitle" value="${creation.creationTitle }">
											
												<c:if test="${!empty creationList}">
													<select class="form-control" name="creationNo" >
														<option value="0">새작품</option>
														<c:forEach var="creation" items="${creationList }">
												      		<option value="${creation.creationNo }" >${creation.creationTitle }</option>
														</c:forEach>
												     </select>
											     </c:if>
											  </div>
							                <div class="col-sm-1"></div>
							            </div>
			            
							            <div class="form-group">
							                <div class="col-sm-2 col-sm-offset-1">
							                    <label class="control-label" for="creationIntro">작품소개</label>
							                </div>
							                <div class="col-sm-8">
							                    <textarea class="inputValue" name="creationIntro" rows="5" cols="100" style="width: -webkit-fill-available;resize:none;background-color: rgba(0,0,0,0.075)">${creation.creationIntro }</textarea>
							                </div>
							               <div class="col-sm-1"></div>
							            </div>
														
										<div class="form-group">
							                <div class="col-sm-2 col-sm-offset-1">
							                    <label class="control-label" for="fundingIntro">태그</label>
							                </div>
							                <div class="col-sm-8 tag-list">
							                    <input type="hidden" class="headTag" name="tag" id="tag">
													<a class="btn tag-add ">추가하기</a>
													<span class="hidden"># <input type="text" name="tag" id="tag" value="${creation.tagList[0].tagName}"></span>
													<c:set var="num" value="0"/>
													<c:forEach items="${creation.tagList}" var="tag" begin="1">
														<c:set var="num" value="${num+1}"/>
															<span id="tag${num}">, # <input type="text" name="tag" value="${tag.tagName}"><span class="glyphicon glyphicon-remove" aria-hidden="true" onClick="javascript:fncRemoveTag('${num}')"></span></span>
													</c:forEach>
							                </div>
							               <div class="col-sm-1"></div>
							            </div>				
										
									</div>
								</div>
							</div>
						</div>
			
						 <div class="form-group" style="margin-bottom:80px;margin-top:50px;">
			                <div class="col-sm-8 col-sm-offset-4 text-right">
			                    <a class="btn btn-primary update-creation-action" id="update-creation-action" >수정</a>
			                    <a class="btn btn-defalt cancle" >취소</a>
			                </div>
			            </div>	
		
				</div><!--creation div END  -->
			</form>	
		      	
		      </div>
    		</div>
    	</div>
  
    
	
	
		<footer class="container-fluid">
		<jsp:include page="../layout/tailbar.jsp"/>
	</footer>
   
</body>
</html>