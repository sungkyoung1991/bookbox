<%@ page language="java" contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<style>
		
	.creation-toolbar{
		clear: both;
	    height: 40px;
	    _height: 40px;
	    padding: 0 0 2px;
	    background: #3d3d3d;
        margin-bottom: 50px;
	}
	
	ul.menu li {
       float: left;
   	 	position: relative;
}
	
	.li-form{
		    list-style: none;
	        margin: 0;
    		padding: 0;
    		text-align: -webkit-match-parent;
	}
	
	.creation-menu-each{
	    padding-left: 15px;
    	padding-right: 15px;
	    font-size: initial;
	}

	.creation-menu{
	    display: inline-block;
	    height: 100%;
	    margin-top: 5px;
	 	color: beige;
 	    font-style: normal;
   		 font-weight: bold;
	}
  
    .add-btn{
    	padding-left: 15px;
	    padding-right: 15px;
	    padding: 7px 15px 7px 15px;
	    font-weight: bold;
	    font-size: small;
        border-right-width: thin;
    	border-right-color: rgba(0,0,0,0.4);
  		border-right-style: double;
    }
    .button-form{
    	cursor:pointer;
    }
    ul.dropdown-menu{
   	    min-width: 0px;
	    padding: 5px 10px;
	    top: 0;
	    width: 100px;
	    height: 140px;
	    left: 100%;
	    border-radius: 0;
	    transform: translate(5px, 0);
    }
	.dropdown-menu-li{
		    margin: 5px;
		    cursor:pointer;
		    transition: 0.1s;
	}
    	
    	
    </style>

    <script>

    $(function() {
	//============= 창작글쓰기 Navigation Event  처리 =============	
		$(".addWriting").on("click" , function() {
			if (${sessionScope.user == null}) {
				alert("로그인 후 이용이 가능합니다.");
			}else{
			$(self.location).attr("href","../creation/addWriting?condition=4");
			}
		}); 
	//============= 펀딩등록하기 Navigation Event  처리 =============	
	 	$(".addfunding").on("click" , function() {
	 		
	 		$.ajax ({
	   	   		url : "rest/addFunding?condition=3",
	   	   		method : "GET",
	   	   		dataType: "json",
		   	   	success:function(JSONData, status){
	   	   		//	alert(status); 
	   	   		//	alert(JSON.stringify(JSONData));
	   	   			var creationList = JSONData;
	   	   		//	alert(creationList);
	   	   			if (creationList.length == 0) {
						alert("등록가능한 작품이 없습니다.");
					}else{
						$(self.location).attr("href","../creation/addFunding?condition=3");
					}
	   	   		} 
	 		});
		
   	}); 
   //============= 창작홈 Navigation Event  처리 =============	
		$(".creation-home").on("click" , function() {
		  $(self.location).attr("href","../creation/getCreationMain");
   	}); 
   //============= 창작리스트 Navigation Event  처리 =============	
		$(".creation-writing-home").on("click" , function() {
			$(self.location).attr("href","../creation/getCreationList");
   	}); 
   //============= 펀딩리스트 Navigation Event  처리 =============	
		$(".funding-home").on("click" , function() {
			$(self.location).attr("href","../creation/getFundingList");
	});  
 //============= 창작 내 공간 드롭다운 Event  처리 =============
   		$('.my-creation').on('click' ,function(){
   			$('.dropdown').dropdown();
	})
 
 //============= 내가 작성한 글 Event  처리 =============
	$('.create-writing').on('click' ,function(){
		$(self.location).attr("href","../creation/getCreationList?condition=5&keyword=${sessionScrope.user.email}");
	})
 //============= 내가 구독한 글 Event  처리 =============
	$('li.subscribe-writing-test').on('click' ,function(){
		alert("dfadfa");
		$(self.location).attr("href","../creation/getCreationList?condition=6");
	})	
 //============= 내가 등록한 펀딩 Event  처리 =============
	$('.added-funding').on('click' ,function(){
		$(self.location).attr("href","../creation/getFundingList?condition=2");
	})	
	 //============= 내가 참여한 펀딩 Event  처리 =============
	$('.joined-funding').on('click' ,function(){
		$(self.location).attr("href","../creation/getFundingList?condition=3");
	})	
	
});		
	
   		
   
    $(function(){
    //============각 메뉴 hover EVENT================= 
    	$( ".li-form" ).hover(
    			  function() {
    			    $( this ).css("opacity","0.7").css("background-color","rgba(187, 187, 187, 0.48)");
    			   },
    			 function(){
    				   $( this ).css("opacity","").css("background-color","");   
    			   }		  
    	);
    	
    	$( ".dropdown-menu-li" ).hover(
  			  function() {
  			    $( this ).css("transform","translate(5%, 0) scale(1.2)");
  			   },
  			 function(){
  				   $( this ).css("transform","initial");   
  			   }
  			  
  		);
    })  
    
  
    </script>
		

	
	<div class="row">
		<div class="col-md-9 creation-toolbar">
			<div class ="creation-toolbar-main" style="display:inline-block; height:100%;">
				<ul class="creation-menu" style="display:inline-block; height:100%;">
					<li class="li-form creation-home" style="display:inline-block;"><div class="creation-menu-each button-form" ><!-- <img src="https://icongr.am/clarity/home.svg?size=20px&color=ffffff"> -->창작공간</div></li>
					<li class="li-form creation-writing-home" style="display:inline-block;"><div class="creation-menu-each button-form">창작작품</div></li>
					<li  class="li-form funding-home" style="display:inline-block;"><div class="creation-menu-each button-form">펀딩</div></li>
				</ul>
			</div>
		</div>
		<div class="col-md-3" style="padding:0px;background-color: rgba(187, 187, 187, 0.62);border: 2px groove;height: 40px;border-left-width: medium;color: #3d3d3d;">
			
			<c:if test="${!empty sessionScope.user and !empty sessionScope.user.email}">
			
				<div class="col-md-5 add-btn addfunding text-center" style="display:inline-block;">
					<div class="addfnding-inner button-form">펀딩등록하기</div>
				</div>
				<div class="col-md-4 add-btn addWriting text-center" style="display:inline-block;">
					<div class="addWriting-inner button-form">글쓰기</div>
				</div>
				<div class="col-md-3 add-btn my-creation text-center" style="display:inline-block;background-color:#f59292;font-size: 12px;">
					<div class="my-creation-inner button-form data-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false"  role="menu">MY</div>
					<ul class="dropdown-menu" role="menu" >
						<li class="dropdown-menu-li create-writing">작성글</li>
						<li class="dropdown-menu-li subscribe-writing-test">구독글</li>
						<hr style="margin: 3px;">
						<li class="dropdown-menu-li added-funding">등록펀딩</li>
						<li class="dropdown-menu-li joined-funding">참여펀딩</li>
					</ul>
				</div>
			
		</c:if>
		
		</div>
	</div>



 