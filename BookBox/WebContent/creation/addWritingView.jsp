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

	<!-- CKEditor 추가 -->
	<script src="../resources/ckeditor/ckeditor.js"></script>
		<!-- CDN Version -->
	<!-- <script src="https://cdn.ckeditor.com/4.7.3/standard/ckeditor.js"></script> -->
	<!-- CKEditor -->
	
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


		.btn-custom{
			cursor: pointer;
			border: 1px #888 solid;
			border-radius:5px;
			color: #888;
			padding: 5px;
		}
		.btn-custom:hover{
			text-decoration: none;
	}
    	
    	.tag-container{
    		height: 30px !important;
    		
    	}
    	.tag-list{
    		padding-top:10px !important;
    		height: 40px;
    	}
	</style>
	
	<script type="text/javascript">
	
	ToolbarOpacHeight(500);
	
//=============말머리 선택시 태그에 추가=======
	
	$(function() {
	
		$('.menu').on('click', function() {
			 $(self.location).attr("href","../creation/getCreationMain");
				
		})		
	})
	
	//============창작작품 등록하기=============
		function ConvertFormToJSON(form){
			 var array = jQuery(form).serializeArray();
			 var json = {};
			 
			 jQuery.each(array, function(){
				 if(this.name != 'tag'){
					 json[this.name] = this.value || '';
				 }
			 });
			 
			 return json;
			
		}
	
	 $(function() {

				$('#add-creation').on('click', function() {
						
				var creationForm = $("form[name='creationForm']");
				var json = ConvertFormToJSON(creationForm);
										
				 var formData = new FormData();
				 formData.append('creation', JSON.stringify(json));
				 formData.append('file',$('input[name="creationOriginName"]')[0].files[0]);
				 for(i=0; i< $('input[name="tag"]').length; i++){
					 formData.append('tag' , $($('input[name="tag"]')[i]).val());
				 }
				 				
				 /////////ajax 적용/////////
				$.ajax({
					url : "rest/addCreation/",
					method : "post",
					data : formData,
					contentType: false,
					processData: false,
					dataType : "json",
					success : function(JSONData, status) {

						//Debug...
					//	alert(status);
						
						var offset = $(".inWriting").offset();
				        $('html, body').animate({scrollTop : offset.top}, 400);

						$("form:hidden").show("fast");
						$('.inputValue').attr('disabled','true');
						$('span.glyphicon-remove').remove();
						$('a.tag-add:contains("추가하기")').off('click');
						$('input[name="creationNo"]').val(JSONData.creation.creationNo);
						$('html, body').animate({scrollTop : offset.top-80}, 400);
						
					// alert("창작글 creationNo : "+$('.writing-creationNo[name="creationNo"]').val());
					}
				})
			})
	})		
	
	//=============말머리 선택시 태그에 추가=======
	
	$(function() {
	
		$('input:radio[name="creationHead"]').on('click', function() {
				$('input.headTag').val( $('input:radio[name="creationHead"]:checked').val().trim() );
				//alert( $('input:radio[name="creationHead"]:checked').val() );
				//alert("hiddenTag = "+$('input.headTag').val());
		})		
	})
		
	
	
	//==============있는 작품 선택================
		
	$(function() {
			
					$("select[name='creationNo']").on('change', function() {
						var creationNo = $("select[name='creationNo']").find("option:selected").val().trim();
						//alert("creationNo = "+creationNo);
						
						if (creationNo == 0 ) {
							$('.inputValue').attr('disabled', false);
							$('#creationForm')[0].reset();
							
							fncAddTag();
							
							$('.addThing').remove();
							$('#creationNoFile').attr('src','../resources/images/noImg_2.jpg');
							$('.glyphicon-remove').on('click',function(){
								fncRemoveTag(num);
							});
							$('form[name="writingForm"]').attr('class','hidden');
						}
						
					
					 /////////ajax 적용/////////
					$.ajax({
						url : "rest/getCreation?creationNo="+creationNo,
						method : "get",
						dataType : "json",
						success : function(JSONData, status) {
							
							//Debug...
					//	alert(status);
							
							var offset = $(".inWriting").offset();
														
							$('input[name="creationNo"]').val(JSONData.creationNo);
							$("input[name='creationTitle']").val(JSONData.creationTitle);
							$("textarea[name='creationIntro']").val(JSONData.creationIntro);
							$("#creationNoFile").attr("src","../resources/upload_files/images/"+JSONData.creationFileName);
							$("input[name='creationHead']").val(JSONData.creationHead);
							if($("input[name='creationHead']").val()==JSONData.creationHead){
								$("input[name='creationHead']").attr('checked','checked');
							}
							
							$("input[name='tag']").val(JSONData.tagList[0].tagName);
							$(".add-tag").remove();
							for (var i = 1; i < (JSONData.tagList).length; i++) {
								/*
								num = num+1;
								tagHtml = '<span class="add-tag addThing" id="tag'+num+'">, # <input class="inputValue addThing" type="text" name="tag" value='+JSONData.tagList[i].tagName+'>';
								tagHtml +='<span class="glyphicon glyphicon-remove addThing sr-only" aria-hidden="true" onClick="javascript:fncRemoveTag('+num+')"></span></span>';
								$('.tag-list').append(tagHtml);
								*/
								var tagName=JSONData.tagList[i].tagName;
								var tagItem=$("<span>"+"<span class='tag'>#"+tagName+"</span>"+"<input name='tag' value='"+tagName+"' style='display:none;'>"+"<a class='glyphicon glyphicon-remove'></a>"+"</span>");
								initTag(tagItem);
								
								$('.tag-list').append(tagItem);
							}
							
							$('form[name=writingForm]').attr('class','visible').show();
							$('.inputValue').attr('disabled','true');
							$('a.tag-add:contains("추가하기")').off('click');
					        $('html, body').animate({scrollTop : offset.top-80}, 400);
					       
					        
					   //     alert("창작글 creationNo : "+$('.writing-creationNo[name="creationNo"]').val());
						}
					})
				})
		})		
		
		
		function initTag(tagObj){
		 	tagObj.find("a").on("click",function(){
		 		tagObj.remove();
		 	});
	 	}
		
	//============창작작품 수정하러가기 버튼========
		 $(function() {

				$('#add-creation:contains("수정하기")').on('click', function() {
					self.location().attr('href','../creation/getWritingList');
				})
		 })

	//=============창작 글 등록====================
		var tagHtml;
		var num;
		var editor;
	
		$(function(){
			num = 0;
			editor = CKEDITOR.replace('writingContent', { customConfig : 'config_writing.js'});
		
			$('a.add-writing:contains("등록")').on('click',function(){
				var data = CKEDITOR.instances.writingContent.getData();
				
				if($('input[name="writingTitle"]').val() == null || $('input[name="writingTitle"]').val() == ""){
					alert("글제목을 입력해 주세요.");
				}else{
				
				$('form[name="writingForm"] textarea').val(data);
			//	alert($('form[name="writingForm"] textarea').val());
				$('form[name="writingForm"]').attr('method','post').attr('action','../creation/addWriting').submit();
				}
			});
			
			fncAddTag();
		});
	
		//=============태그추가====================
		function fncAddTag(){	
			$('a.tag-add:contains("추가하기")').on('click', function(){
				num = num + 1;
				tagHtml = '<span id="tag'+num+'">, # <input class="inputValue" type="text" name="tag"><span class="glyphicon glyphicon-remove" aria-hidden="true" onClick="javascript:fncRemoveTag('+num+')"></span></span>';
				$('.tag-list').append(tagHtml);
			});
		}
		
		
		//태그추가 수정=======================]
		$(function(){
			$(".tag-add").on("click",addTag);
			$("#inputTag").on("keyup",addTag);
		});
		
		function addTag(e){
			
			var tagName=$("#inputTag").val();
			
			if(e.keyCode!=undefined&&e.keyCode!=13||tagName==""){
				return;
			}
			
			var tagItem=$("<span class='tag-container'>"+"<span class='tag'>#"+tagName+"</span>"+"<input name='tag' value='"+tagName+"' style='display:none;'>"+"<a class='glyphicon glyphicon-remove'></a>"+"</span>");
				tagItem.find('a').on("click",function(){
					tagItem.remove();
				});
			
			$(".tag-list").append(tagItem);
			
			$("#inputTag").val("");
			
		};
			
		//=============태그삭제====================
		function fncRemoveTag(num){
			$('#tag'+num).remove();
		}
	
		//============== 커버이미지 미리보기 설정===========
		var upload;
		var preview;
		
		if(typeof window.FileReader === 'undefined'){
			alert('커버이미지 미리보기를 지원하지 않는 브라우저 입니다..');
		}
		
		$(function(){
			upload = document.getElementById('creationOriginName');
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
		})
		

	</script>
</head>

<body>
	<jsp:include page="../layout/toolbar.jsp" >
		<jsp:param value="../" name="uri"/>
	</jsp:include>
	<!-- 여기부터 코딩 -->
	<header class="parallax"></header>
	
	<div class="container">
		
		<jsp:include page="creationToolbar.jsp"/>
	
	
	       <div class="text-left" style="font-size:-webkit-xxx-large;font-weight: 600;">작품 등록</div>
	       <div style="width: 100%;border: #bbbbbb 2px solid;display: inline-block;margin-bottom:50px"></div>
		
		<div class="creation-div">
		<form class="form-horizontal creation-add" id="creationForm" name="creationForm">
			<div class="row">
				<div class="col-sm-12 col-md-12">
					<div class="row">
						<div class="col-md-5">
							<div id="imgPreview" style="padding-left:20px;overflow:hidden;">
								<c:if test="${!empty creation }">
									<img id="creationFileName" class="img img-responsive img-object-fit" src="../resources/upload_files/images/${creation.creationFileName }"/>
								</c:if>
								<c:if test="${empty creation }">
									<img id="creationNoFile" class="img img-responsive img-object-fit" src="../resources/images/noImg_2.jpg"/>
								</c:if>
							</div>
                    		<input style="padding-left:20px;" type="file"  class="inputValue" id="creationOriginName" name="creationOriginName" value="${creation.creationOriginName }">
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
				                <input type='text' id="inputTag"><a class="btn-custom tag-add">추가</a>
				                 <div class="col-sm-8 tag-list">
				                  <!-- 
				                    <input type="hidden" class="headTag" name="tag" id="tag">
										<a class="btn tag-add ">추가하기</a>
										<span class="hidden"># <input class="inputValue" type="text" name="tag" id="tag"  value="${creation.tagList[0].tagName}"></span>
										<span ># <input class="inputValue" type="text" name="tag" id="tag"  ></span>
				                   -->
				                </div>
				              
				               <div class="col-sm-1"></div>
				            </div>		
				            	<br/>
				             
				            		
							
						</div>
					</div>
				</div>
			</div>
			
			 <div class="form-group" style="margin-bottom:80px;margin-top:50px;">
                <div class="col-sm-8 col-sm-offset-4 text-right">
                    <a class="btn btn-primary" id="add-creation" >등록</a>
                    <a class="btn btn-defalt menu" >이전</a>
                </div>
              </div>	
		
		</form>	
	</div><!--creation div END  -->
			            
			            
			            
			            
			            
           <%--  <div class="form-group">
                <div class="col-sm-2 col-sm-offset-2">
                    <label class="control-label" for="creationHead">말머리</label>
                </div>
                <div class="col-sm-8">
                    <input class="inputValue" type="radio" name ="creationHead"  value ="픽션" ${creation.creationHead =='픽션' ? 'checked' : '' } >픽션
					<input class="inputValue" type="radio" name ="creationHead"  value ="논픽션" ${creation.creationHead =='논픽션' ? 'checked' : '' } >논픽션
                </div>
             </div>
            
            <div class="form-group">
                <div class="col-sm-2 col-sm-offset-2">
                    <label class="control-label " for="creationTitle">작품명</label>
                </div>
                <div class="col-sm-7">
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
                <div class="col-sm-2 col-sm-offset-2">
                    <label class="control-label" for="creationIntro">작품소개</label>
                </div>
                <div class="col-sm-7">
                    <textarea class="inputValue" name="creationIntro" rows="5" cols="100" style="width: -webkit-fill-available;background-color: rgba(0,0,0,0.075)">${creation.creationIntro }</textarea>
                </div>
               <div class="col-sm-1"></div>
            </div>
            
            <div class="form-group">
                <div class="col-sm-2 col-sm-offset-2">
                	<label class="control-label" for="fundingImage">파일첨부</label>
                </div>
                <div class="col-sm-8">
					<div id="imgPreview">
						<c:if test="${!empty creation }">
							<img class="img img-responsive" src="../resources/upload_files/images/${creation.creationFileName }"/>
						</c:if>
						<c:if test="${empty creation }">
							<img class="img img-responsive" src="../resources/images/noImg_2.jpg"/>
						</c:if>
					</div>
                    <input type="file"  class="inputValue" id="creationOriginName" name="creationOriginName" value="${creation.creationOriginName }">
                </div>
            </div>
            
            
            <div class="form-group">
                <div class="col-sm-2 col-sm-offset-2">
                    <label class="control-label" for="fundingIntro">태그</label>
                </div>
                <div class="col-sm-7 tag-list">
                    <input type="hidden" class="headTag" name="tag" id="tag">
						<a href="#" class="btn tag-add ">추가하기</a>
						<span class="hidden"># <input class="inputValue" type="text" name="tag" id="tag"  value="${creation.tagList[0].tagName}"></span>
						<span ># <input class="inputValue" type="text" name="tag" id="tag"  ></span>
                </div>
               <div class="col-sm-1"></div>
            </div>
            
            <div class="form-group">
                <div class="col-sm-7 col-sm-offset-4 text-right">
                    <a class="btn btn-primary" id="add-creation" >등록</a>
                    <a class="btn btn-defalt menu" >menu</a>
                </div>
                <div class="col-sm-1"></div>
            </div>	
		
		</form>	
	</div>	 --%>

<!--////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////  --> 	
		<!--창작작품 등록란  -->
	<%-- <div class="panel panel-default">
  		<div class="panel-heading">
	     <h3>창작작품 등록란</h3>
	  </div>
  		<div class="panel-body" >
		<form id="creationForm" name="creationForm" >
			<div class="form-group">
				말머리 선택
				<input class="inputValue" type="radio" name ="creationHead"  value ="픽션" ${creation.creationHead =='픽션' ? 'checked' : '' } >픽션
				<input class="inputValue" type="radio" name ="creationHead"  value ="논픽션" ${creation.creationHead =='논픽션' ? 'checked' : '' } >논픽션
				<p></p>
				<p>작품명</p>
				<input class="inputValue" type="text" name="creationTitle" id ="creationTitle" value="${creation.creationTitle }">
				
					<c:if test="${!empty creationList}">
						<select class="form-control" name="creationNo" >
							<option value="0">새작품</option>
							<c:forEach var="creation" items="${creationList }">
					      		<option value="${creation.creationNo }" >${creation.creationTitle }</option>
							</c:forEach>
					     </select>
				     </c:if>
				
				<p></p>
				<p>작품소개</p>
				<textarea class="inputValue" name="creationIntro" rows="5" cols="100">${creation.creationIntro }</textarea>
			</div>
			<p>대표이미지</p>
			<div id="imgPreview">
				<c:if test="${!empty creation }">
					<img class="img img-responsive" src="../resources/upload_files/images/${creation.creationFileName }"/>
				</c:if>
				<c:if test="${empty creation }">
					<img class="img img-responsive" src="../resources/upload_files/images/noImg_2.jpg"/>
				</c:if>
			</div>
				<input type="file"  class="inputValue" id="creationOriginName" name="creationOriginName" value="${creation.creationOriginName }">
			<div class="form-group tag-list">
				<label>태그</label>
				<input type="hidden" class="headTag" name="tag" id="tag">
				<a href="#" class="btn tag-add ">추가하기</a>
				<span class="hidden"># <input class="inputValue" type="text" name="tag" id="tag"  value="${creation.tagList[0].tagName}"></span>
				<span ># <input class="inputValue" type="text" name="tag" id="tag"  ></span>			
			</div>
		
		<c:if test="${creationList != null }">	
			<a href="#" class="btn btn-default" id="add-creation" >등록하기</a>
		</c:if>
		
		</form>
		</div>
	</div> --%>
	
	<div  class="inWriting" id="inWriting">
		<!--창작글 등록란  -->
	<form style="display:none;"  id="writingForm" name="writingForm">
		<hr>
		<div class="form-group">
					<strong style="font-size: large;">글제목</strong> <input type="text" class="form-control" name="writingTitle">
					<input type = "hidden" class="writing-creationNo" name="creationNo" value="${creation.creationNo }">
				</div>
				<div class="form-group" >
					<textarea name="writingContent" id="writingContent" rows="20" cols="80"></textarea>
				</div>
				
				<div class="panel imgList">
				이미지리스트
				
				</div>
		
				 <div class="form-group" style="margin-bottom:80px;">
			           <div class="col-sm-8 col-sm-offset-4 text-right">
			               <a class="btn btn-primary add-writing" id="add-writing" >등록</a>
			           </div>
			   </div>	
	</form>

	</div>
	
	
</div>
	

	
</body>
</html>