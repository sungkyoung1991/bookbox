<%@page import="java.util.Random"%>
<%@page import="com.bookbox.service.domain.User"%>
<%@page import="com.bookbox.service.domain.ChatRoom"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<% if(request.getAttribute("chatRoom")==null){
	ChatRoom chatRoom=new ChatRoom();
	chatRoom.setRoomId("test0001");
	request.setAttribute("chatRoom", chatRoom);
	Random rand=new Random();
	User user=new User();
	user.setNickname("user"+rand.nextInt(1000));
	request.setAttribute("user", user);
}
%>




<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en" dir="ltr">
<head>
  <meta charset="utf-8">
  <title>WebRTC Scalable Broadcast using RTCMultiConnection</title>
  <meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0">
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
 	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" ></script>
 	
 	<script src="../resources/javascript/toolbar_opac.js"></script>
	<script src="../resources/javascript/custom.js"></script>
 	<!-- RTC -->
 	<script src="../resources/javascript/community/RTCMultiConnection.min.js"></script>
	<script src="../resources/javascript/community/socket.io.js"></script>
 	
 	
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" >
  	<link rel="stylesheet" href="../resources/bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" href="../resources/css/custom.css">
    
    <style type="text/css">
    	.container{
    		height: 100%;
    	}
    	
    	.total-container{
    		border-top: 20px solid #62bfad;
    		padding-top: 20px;
    	}
    	.cast-container{
    		margin: 20px 0 0 0;
    		overflow: hidden;
    		
    	}
    	
    	
    	.video-container{
    		margin-top:20px;
    	}
    	
    	video{
    		width: 100%;
    		/*
    		width: 400px;
    		height: 300px;
    		*/
    	}
    	
   		.chat-container{
   			margin-top:20px;
   			border: solid 2px #62BFAD; 
   			overflow: hidden;
   			transition: height 1s;
   		/*	background-color: #62bfad38;*/
   		}
   		
   		.chat-output{
   			height: 80%;
   			overflow: auto;
   		}
   		
   		.chat-output-item{
   			margin: 10px 0 0 0;
   		}
   		.chat-output-item div{
   			display: inline-block;
   		}
   		.chat-output-item img{
   			height: 30px;
   			width: 30px;
   			border-radius: 50%;
   			object-fit:cover;
   		}
   		.chat-output-message{
   			margin-left: 10px;
   			font-size: 15px;
   		}
   		
   		.chat-input{
   			height: 10%;
   			background-color: #eee !important;
   			height: 25px !important;
   			padding-top: 0px !important;
   		}
   		.container-roominfo{
   			padding: 15px;
   		}
    	.room-info{
    		margin: 20px 0 0 0;
    		background-color: #62bfad38;
    		padding: 15px;
    		border-top: 10px solid  #62bfad;
    	}
    	.room-info .title{
    		font-weight: bold;
    		font-size: 25px;
    	}
    	.room-info .host-img,.host-nickname,.regdate{
    		display: inline-block;
    	}
    	.room-info .host-img img{
    		height: 60px;
    		width: 60px;
    		border-radius: 50%;
    		object-fit:cover;
    	}
    	.room-info .host-nickname{
    		margin: 10px;
    		font-size: 25px;
    	}
    	.room-info .regdate{
    		float: right;
    	}
    	.room-info .current-user{
    		margin: 10px 0 0 0; 
    	}
    	
    	.room-info .content{
    		/*word-spacing: normal;*/
    		/*word-break:break-all;*/
    	}
    	
    	.chat-option{
    		margin-top: 20px;
    	}
    
    
    	hr{
    		margin: 10px 0 10px 0;
    		color: #62BFAD;
    		background-color: #62BFAD;
    		border-color:  #62BFAD;
    	}
    	.btn-custom{
		cursor: pointer;
		border: 1px #888 solid;
		border-radius:5px;
		color: #888;
		padding: 5px;
	}
    </style>
    
    <script type="text/javascript">
    var enableReceiveFlag=true;
    
	//페이지 나갈지 여부 확인
	$(window).on("beforeunload", function(){
        return "페이지를 나가겠습니까";
    });

    
    $(function(){
    	//방장이 나갔을때 삭제
    	var room_id='${chatRoom.roomId}';
    	//alert(room_id);
    	/*
    	$(window).on("beforeunload", function (){
   
    			$.ajax({
    				url:"rest/deleteChatRoom",
    				method:"POST",
    				data:{type:"camchat",roomId:room_id},
    				success:function(){
    				}
    			});
    	});
    	*/
    	function resizeWindow(){
    		var height=$("#video-preview").height();
  			//alert(width);
  			if(!enableReceiveFlag){
  				return
  			}
  			$(".chat-container").height(height);	
    	}
    	
    	resizeWindow();
    	
    	$(window).resize(resizeWindow);
    	
    	$("#video-preview").resize(resizeWindow);
    	
    	$('.chat-output').bind('DOMNodeInserted DOMNodeRemoved', function() {
			$(this).scrollTop($(this)[0].scrollHeight);
    	});
    	
    	
    	$("#enableReceiveChat").on("change",function(){
    		
    		var isEnableReceiveChat=$(this).is(":checked");
    		if(isEnableReceiveChat){
    			enableReceiveFlag=false;
    			$(".chat-container").height(0);
    		//	$('.chat-output').css("background-color","#bbbbbb");
    		}
    		else{
    			enableReceiveFlag=true;
    			resizeWindow();
    		//	$('.chat-output').css("background-color","");
    		}
    		
    	});
    	
    	$("#exit").on("click",function(){
    		self.location="getCommunityMain";
    	});
    	
    }); //onload End
    </script>
</head>

<body>
 	<jsp:include page="../layout/toolbar.jsp" >
		<jsp:param value="../" name="uri"/>
	</jsp:include>
 <!--  비출력 정보 -->
 	<div class="container">
	 <input type="hidden" id="roomId" value="${chatRoom.roomId}">
	 <input type="hidden" id="nickname" value="${user.nickname }">
 	 <input type="hidden" id="userImg" value="${user.booklogImage }">
	 <c:if test="${ user.email == chatRoom.host.email }">
		 <input type="hidden" id="role" value="host">
	 </c:if>
	 <c:if test="${ user.email != chatRoom.host.email }">
	 	<input type="hidden" id="role" value="guest">
	 </c:if>
	 
	 <br>
	<div class="total-container"> 
		<div class="text-right">
			<a class="btn-custom" id="exit">나가기</a>
		</div>	
		<div class="cast-container row">
			<div class="col-sm-7 video-container">
		      <video id="video-preview" controls loop></video>
			</div>
			<div class="col-sm-5 chat-container">
				<div class="chat-output">
				</div>
				<hr/>
				<div class="input-group">
					<input type="text" class="chat-input form-control">
					<span class="input-group-addon addon-custom" id="addTagBtn">
						<a class="btn-custom">전송</a>
					</span>
				</div>
			</div>
			<div class="col-sm-7 container-roominfo">
				<div class="room-info">
					<div class="title">${chatRoom.title}</div>
					
					<hr/>
					<div class="host-img"><img src="../resources/upload_files/images/${chatRoom.host.booklogImage}" onerror="this.src='../resources/images/no_booklog_image.png'"></div>
					<div class="host-nickname">${chatRoom.host.nickname}</div>
					<div class="regdate">${chatRoom.regDate}</div>
					<div class="current-user"><span>시청자</span><span id="currentUser">0</span></div>
					<div class="content"><br/><br/>${chatRoom.content}</div>
					<div class="tag-list">
						<c:forEach items="${chatRoom.tagList}" var="tag">
							<span class="tag">#${tag.tagName}</span>
						</c:forEach>
					</div>
				</div>
			</div>
			<div class="col-sm-5 chat-option text-right">
				<c:if test="${ user.email == chatRoom.host.email }">
					<a class="btn-custom " id="chatMute">채팅금지</a>
					<br>
					<label><input type="checkbox" id="enableReceiveChat">채팅숨기기</label>
				</c:if>
			</div>
				
		</div>
	</div>
	<h1 style="display: none;"></h1>
</div>
<!-- <script src="https://cdn.webrtc-experiment.com/RecordRTC.js"></script> -->
<script>

   
// recording is disabled because it is resulting for browser-crash
// if you enable below line, please also uncomment above "RecordRTC.js"
var enableRecordings = false;

var connection = new RTCMultiConnection();

// its mandatory in v3
connection.enableScalableBroadcast = true;

// each relaying-user should serve only 1 users
connection.maxRelayLimitPerUser = 1;

// we don't need to keep room-opened
// scalable-broadcast.js will handle stuff itself.
connection.autoCloseEntireSession = true;


//집에서 테스트
//connection.socketURL = 'https://192.168.219.167:433/';
//학원테스트
connection.socketURL = 'https://192.168.0.21:433/';
//할리스 테스트
//connection.socketURL = 'https://192.168.1.52:433/';

connection.socketMessageEvent = 'scalable-media-broadcast-demo';


//채팅 서버연결


connection.connectSocket(function(socket) {
    socket.on('logs', function(log) {
        document.querySelector('h1').innerHTML = log.replace(/</g, '----').replace(/>/g, '___').replace(/----/g, '(<span style="color:red;">').replace(/___/g, '</span>)');
    });

    // this event is emitted when a broadcast is already created.
    socket.on('join-broadcaster', function(hintsToJoinBroadcast) {
        console.log('join-broadcaster', hintsToJoinBroadcast);

        connection.session = hintsToJoinBroadcast.typeOfStreams;
        connection.sdpConstraints.mandatory = {
            OfferToReceiveVideo: !!connection.session.video,
            OfferToReceiveAudio: !!connection.session.audio
        };
        connection.broadcastId = hintsToJoinBroadcast.broadcastId;
        connection.join(hintsToJoinBroadcast.userid);
    });

    socket.on('rejoin-broadcast', function(broadcastId) {
        console.log('rejoin-broadcast', broadcastId);

        connection.attachStreams = [];
        socket.emit('check-broadcast-presence', broadcastId, function(isBroadcastExists) {
            if (!isBroadcastExists) {
                // the first person (i.e. real-broadcaster) MUST set his user-id
                connection.userid = broadcastId;
            }

            socket.emit('join-broadcast', {
                broadcastId: broadcastId,
                userid: connection.userid,
                typeOfStreams: connection.session
            });
        });
    });

    socket.on('broadcast-stopped', function(broadcastId) {
        // alert('Broadcast has been stopped.');
        // location.reload();
        console.error('broadcast-stopped', broadcastId);
        alert('방송이 중지.');
    });

    // this event is emitted when a broadcast is absent.
    socket.on('start-broadcasting', function(typeOfStreams) {
        console.log('start-broadcasting', typeOfStreams);

        // host i.e. sender should always use this!
        connection.sdpConstraints.mandatory = {
            OfferToReceiveVideo: false,
            OfferToReceiveAudio: false
        };
        connection.session = typeOfStreams;

        // "open" method here will capture media-stream
        // we can skip this function always; it is totally optional here.
        // we can use "connection.getUserMediaHandler" instead
        connection.open(connection.userid, function() {
           //showRoomURL(connection.sessionid);
        });
        
    });
});

window.onbeforeunload = function() {
    // Firefox is ugly.
    //document.getElementById('open-or-join').disabled = false;
};

var videoPreview = document.getElementById('video-preview');

connection.onstream = function(event) {
    if (connection.isInitiator && event.type !== 'local') {
        return;
    }

    connection.isUpperUserLeft = false;
    videoPreview.srcObject = event.stream;
    videoPreview.play();

    videoPreview.userid = event.userid;

    if (event.type === 'local') {
        videoPreview.muted = true;
    }

    if (connection.isInitiator == false && event.type === 'remote') {
        // he is merely relaying the media
        connection.dontCaptureUserMedia = true;
        connection.attachStreams = [event.stream];
        connection.sdpConstraints.mandatory = {
            OfferToReceiveAudio: false,
            OfferToReceiveVideo: false
        };

        var socket = connection.getSocket();
        socket.emit('can-relay-broadcast');

        if (connection.DetectRTC.browser.name === 'Chrome') {
            connection.getAllParticipants().forEach(function(p) {
                if (p + '' != event.userid + '') {
                    var peer = connection.peers[p].peer;
                    peer.getLocalStreams().forEach(function(localStream) {
                        peer.removeStream(localStream);
                    });
                    event.stream.getTracks().forEach(function(track) {
                        peer.addTrack(track, event.stream);
                    });
                    connection.dontAttachStream = true;
                    connection.renegotiate(p);
                    connection.dontAttachStream = false;
                }
            });
        }

        if (connection.DetectRTC.browser.name === 'Firefox') {
            // Firefox is NOT supporting removeStream method
            // that's why using alternative hack.
            // NOTE: Firefox seems unable to replace-tracks of the remote-media-stream
            // need to ask all deeper nodes to rejoin
            connection.getAllParticipants().forEach(function(p) {
                if (p + '' != event.userid + '') {
                    connection.replaceTrack(event.stream, p);
                }
            });
        }

        // Firefox seems UN_ABLE to record remote MediaStream
        // WebAudio solution merely records audio
        // so recording is skipped for Firefox.
        if (connection.DetectRTC.browser.name === 'Chrome') {
            repeatedlyRecordStream(event.stream);
        }
    }
    
};

// ask node.js server to look for a broadcast
// if broadcast is available, simply join it. i.e. "join-broadcaster" event should be emitted.
// if broadcast is absent, simply create it. i.e. "start-broadcasting" event should be fired.
/*
document.getElementById('open-or-join').onclick = function() {
    var broadcastId = document.getElementById('broadcast-id').value;
    if (broadcastId.replace(/^\s+|\s+$/g, '').length <= 0) {
        alert('Please enter broadcast-id');
        document.getElementById('broadcast-id').focus();
        return;
    }

    document.getElementById('open-or-join').disabled = true;

    connection.session = {
        audio: true,
        video: true,
        oneway: true
    };

    var socket = connection.getSocket();

    socket.emit('check-broadcast-presence', broadcastId, function(isBroadcastExists) {
        if (!isBroadcastExists) {
            // the first person (i.e. real-broadcaster) MUST set his user-id
            connection.userid = broadcastId;
        }

        console.log('check-broadcast-presence', broadcastId, isBroadcastExists);

        socket.emit('join-broadcast', {
            broadcastId: broadcastId,
            userid: connection.userid,
            typeOfStreams: connection.session
        });
    });
};
*/
connection.onstreamended = function() {};

connection.onleave = function(event) {
    if (event.userid !== videoPreview.userid) return;

    var socket = connection.getSocket();
    socket.emit('can-not-relay-broadcast');

    connection.isUpperUserLeft = true;

    if (allRecordedBlobs.length) {
        // playing lats recorded blob
        var lastBlob = allRecordedBlobs[allRecordedBlobs.length - 1];
        videoPreview.src = URL.createObjectURL(lastBlob);
        videoPreview.play();
        allRecordedBlobs = [];
    } else if (connection.currentRecorder) {
        var recorder = connection.currentRecorder;
        connection.currentRecorder = null;
        recorder.stopRecording(function() {
            if (!connection.isUpperUserLeft) return;

            videoPreview.src = URL.createObjectURL(recorder.getBlob());
            videoPreview.play();
        });
    }

    if (connection.currentRecorder) {
        connection.currentRecorder.stopRecording();
        connection.currentRecorder = null;
    }
};

var allRecordedBlobs = [];

function repeatedlyRecordStream(stream) {
    if (!enableRecordings) {
        return;
    }

    connection.currentRecorder = RecordRTC(stream, {
        type: 'video'
    });

    connection.currentRecorder.startRecording();

    setTimeout(function() {
        if (connection.isUpperUserLeft || !connection.currentRecorder) {
            return;
        }

        connection.currentRecorder.stopRecording(function() {
            allRecordedBlobs.push(connection.currentRecorder.getBlob());

            if (connection.isUpperUserLeft) {
                return;
            }

            connection.currentRecorder = null;
            repeatedlyRecordStream(stream);
        });
    }, 30 * 1000); // 30-seconds
};

function disableInputButtons() {
    document.getElementById('open-or-join').disabled = true;
    document.getElementById('broadcast-id').disabled = true;
}

//시청자수 변경시 이벤트 방장만 발생
connection.onNumberOfBroadcastViewersUpdated = function(event) {
    if (!connection.isInitiator) return;

    $.ajax({
    	url:"rest/updateChatRoomCurrentUser",
    	method: "POST",
    	data:{
    		currentUser: event.numberOfBroadcastViewers,
    		roomType:"cast",
    		roomId:$("#roomId").val()
    	},
    	success:function(){
    		//alert("success");
    	}
    });
    
    sendCurrentUser(event.numberOfBroadcastViewers);
    //ui 쪽 변경
    $("#currentUser").html(event.numberOfBroadcastViewers);
    
};


//자동연결
setTimeout(function(){           
	//	console.log("join Room");
	  var broadcastId = $("#roomId").val();

	    connection.session = {
	        audio: true,
	        video: true,
	       // screen:true,
	        oneway: true
	    };

	    var socket = connection.getSocket();
		console.log(socket);
		
		try{
			
	    socket.emit('check-broadcast-presence', broadcastId, function(isBroadcastExists) {
	        if (!isBroadcastExists) {
	            // the first person (i.e. real-broadcaster) MUST set his user-id
	            connection.userid = broadcastId;
	        }

	        console.log('check-broadcast-presence', broadcastId, isBroadcastExists);

	        socket.emit('join-broadcast', {
	            broadcastId: broadcastId,
	            userid: connection.userid,
	            typeOfStreams: connection.session
	        });
	    });
	
		}catch (e) {
			console.log(e);
		}
	
},2000);

//=================================채팅========================================================
var chatSocket=io.connect('https://192.168.0.21:433/chat');
//var chatSocket=io.connect('https://192.168.219.167:433/chat');
//var chatSocket=io.connect('https://192.168.1.52:433/chat');

	chatSocket.on("success-connect",function(data){
		console.log(data)
		chatSocket.emit("initUserInfo",{nickname:$("#nickname").val(),
											roomId:$("#roomId").val(),
											userImg:$("#userImg").val()});
		chatSocket.emit("infoTest");
	});
	//채팅내용 리시브
	chatSocket.on("receiveChatMessage",function(data){
		//alert(data.nickname+":"+data.message);
		writeChatOutput(data.nickname+":"+data.message,data.fontColor,data.userImg);	
	});
	
	chatSocket.on("joinUser",function(data){
		//alert(data.nickname+":"+data.message);
		writeChatOutput(data.nickname +" 님이 입장하였습니다.",null);	
	});
	
	//채팅금지처리
	chatSocket.on("chatMute",function(data){
		if(data==false){
			//alert("chatMute ON!");
			writeChatOutput("채팅사용이 금지 되었습니다.","#ff5555",null);
			$(".chat-input").attr("disabled","");
		}
		else{
			//alert("chatMute OFF");
			writeChatOutput("채팅사용이 허가 되었습니다.","#ff5555",null);
			$(".chat-input").removeAttr("disabled","");
		}
		
	});
	
	//시청자수 변경 보내기
	function sendCurrentUser(currentUser){
		chatSocket.emit("changCurrentUser",currentUser);
		console.log("현재 시청자: "+currentUser);
	};
	
	//시청자수 받기
	chatSocket.on("changCurrentUser",function(data){
		console.log("현재 시청자: "+data);
		$("#currentUser").html(data);
		
	});

	//채팅입력이벤트
	$(".chat-input").on("keyup",function(event){
		if(event.keyCode!=13){
			return;
		}
		var message=$(this).val();
		if(message==""){
			return;
		}
		chatSocket.emit("sendChatMessage",message);
		writeChatOutput("자신:"+message,"#b8b8b8",$("#userImg").val());
		$(this).val("");
	});
	
	var chatMuteFlag=false;
	//채팅금지버튼 이벤트
	$("#chatMute").on("click",function(){
		chatSocket.emit("chatMute",chatMuteFlag);
		if(chatMuteFlag==false){
			$(this).html("채팅허가");
			chatMuteFlag=true;			
		}
		else{
			$(this).html("채팅금지");
			chatMuteFlag=false;
		}
	});
	

	
	//채팅 출력쪽에 채팅 내용 삽입
	function writeChatOutput(message,fontColor,userImg){
		//채팅금지일때 채팅출력 거부
		if(!enableReceiveFlag){
			return;
		}
		if(userImg==null){
			var outObj=$("<p>"+message+"</p>").css("color",fontColor);
			$(".chat-output").append(outObj);			
		}
		else{
			var outObj=$("<div class='chat-output-item'><div class='chat-output-img'>"+
							"<img src=\"../resources/upload_files/images/"+userImg+"\" onerror=\"this.src='../resources/images/no_booklog_image.png'\">"+
							"</div>"+
							"<div class='chat-output-message'>"+message+"</div></div>").css("color",fontColor);
			$(".chat-output").append(outObj);	
		}
	}
	
	

 


</script>

		<div style="height: 200px"></div>
		<footer class="container-fluid">
		<jsp:include page="../layout/tailbar.jsp"/>
		</footer>
</body>
</html>
