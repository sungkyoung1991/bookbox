<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"  %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta charset="utf-8">

    <link rel="stylesheet" href="https://cdn.webrtc-experiment.com/style.css">

    <title>WebRTC Scalable Screen Broadcast using RTCMultiConnection</title>

    <meta name="description" content="This module simply initializes socket.io and configures it in a way that single audio/video/screen stream can be shared/relayed over unlimited users without any bandwidth/CPU usage issues. Everything happens peer-to-peer!" />
    <meta name="keywords" content="WebRTC,RTCMultiConnection,Demos,Experiments,Samples,Examples" />

    <style>
        video {
            object-fit: fill;
            width: 100%;
            max-width: 100%;
        }
        button,
        input,
        select {
            font-weight: normal;
            padding: 2px 4px;
            text-decoration: none;
            display: inline-block;
            text-shadow: none;
            font-size: 16px;
            outline: none;
        }

        .make-center {
            text-align: center;
            padding: 5px 10px;
        }

        button, input, select {
            font-family: Myriad, Arial, Verdana;
            font-weight: normal;
            border-top-left-radius: 3px;
            border-top-right-radius: 3px;
            border-bottom-right-radius: 3px;
            border-bottom-left-radius: 3px;
            padding: 4px 12px;
            text-decoration: none;
            color: rgb(27, 26, 26);
            display: inline-block;
            box-shadow: rgb(255, 255, 255) 1px 1px 0px 0px inset;
            text-shadow: none;
            background: -webkit-gradient(linear, 0% 0%, 0% 100%, color-stop(0.05, rgb(241, 241, 241)), to(rgb(230, 230, 230)));
            font-size: 20px;
            border: 1px solid red;
            outline:none;
            vertical-align: middle;
        }
        button, select {
            height: 35px;
            margin: 0 5px;
        }

        button:hover, input:hover, select:hover {
            background: -webkit-gradient(linear, 0% 0%, 0% 100%, color-stop(5%, rgb(221, 221, 221)), to(rgb(250, 250, 250)));
            border: 1px solid rgb(142, 142, 142);
        }

        button:active, input:active, select:active, button:focus, input:focus, select:focus {
            background: -webkit-gradient(linear, 0% 0%, 0% 100%, color-stop(5%, rgb(183, 183, 183)), to(rgb(255, 255, 255)));
            border: 1px solid rgb(142, 142, 142);
        }
        button[disabled], iput[disabled], select[disabled] {
            background: rgb(249, 249, 249);
            border: 1px solid rgb(218, 207, 207);
            color: rgb(197, 189, 189);
        }
        input, input:focus, input:active {
            background: white;
        }
    </style>
</head>

<body>
    <article>

        <header style="text-align: center;">
            <h1><a href="https://github.com/muaz-khan/WebRTC-Scalable-Broadcast">WebRTC Scalable Screen Broadcast</a> using <a href="https://github.com/muaz-khan/RTCMultiConnection">RTCMultiConnection</a></h1>
            <p>
                <a href="https://rtcmulticonnection.herokuapp.com/">HOME</a>
                <span> &copy; </span>
                <a href="http://www.MuazKhan.com/" target="_blank">Muaz Khan</a> .
                <a href="http://twitter.com/WebRTCWeb" target="_blank" title="Twitter profile for WebRTC Experiments">@WebRTCWeb</a> .
                <a href="https://github.com/muaz-khan?tab=repositories" target="_blank" title="Github Profile">Github</a> .
                <a href="https://github.com/muaz-khan/RTCMultiConnection/issues?state=open" target="_blank">Latest issues</a> .
                <a href="https://github.com/muaz-khan/RTCMultiConnection/commits/master" target="_blank">What's New?</a>
            </p>
        </header>

        <div class="github-stargazers"></div>

        <section class="experiment">
            <div class="make-center">
                <input type="text" id="broadcast-id" placeholder="broadcast-id" value="room-xyz">
                <button id="open-or-join">Open or Join Broadcast</button>

                <div id="room-urls" style="text-align: center;display: none;background: #F1EDED;margin: 15px -10px;border: 1px solid rgb(189, 189, 189);border-left: 0;border-right: 0;"></div>
            </div>

            <video id="video-preview" controls loop></video>
        </section>

        <blockquote>
            This module simply initializes socket.io and configures it in a way that single audio/video/screen stream can be shared/relayed over unlimited users without any <a href="https://www.webrtc-experiment.com/docs/RTP-usage.html">bandwidth/CPU usage issues</a>. Everything happens peer-to-peer!

            <br><br>
            You can try <a href="/demos/Scalable-Broadcast.html">Scalable Video Broadcast</a>!

            <br><br>
            Requirements: <a href="https://chrome.google.com/webstore/detail/screen-capturing/ajhifddimkapgcifgcodmmfdlknahffk">install this Chrome extension</a> or <a href="https://addons.mozilla.org/en-US/firefox/addon/enable-screen-capturing/">this Firefox extension</a>.
        </blockquote>

   	<script src="../resources/javascript/community/RTCMultiConnection.min.js"></script>
	<script src="../resources/javascript/community/socket.io.js"></script>

        <!-- capture screen from any HTTPs domain! -->
        <script src="https://cdn.webrtc-experiment.com:443/getScreenId.js"></script>

        <!-- <script src="https://cdn.webrtc-experiment.com/RecordRTC.js"></script> -->
        <script>
            // recording is disabled because it is resulting for browser-crash
            // if you enable below line, please also uncomment above "RecordRTC.js"
            var enableRecordings = false;

            var connection = new RTCMultiConnection(null, {
                useDefaultDevices: true // if we don't need to force selection of specific devices
            });

            // its mandatory in v3
            connection.enableScalableBroadcast = true;

            // each relaying-user should serve only 1 users
            connection.maxRelayLimitPerUser = 1;

            // we don't need to keep room-opened
            // scalable-broadcast.js will handle stuff itself.
            connection.autoCloseEntireSession = true;

            // by default, socket.io server is assumed to be deployed on your own URL
            connection.socketURL = 'https://192.168.0.21:433/';

            // comment-out below line if you do not have your own socket.io server
            // connection.socketURL = 'https://rtcmulticonnection.herokuapp.com:443/';

            connection.socketMessageEvent = 'scalable-screen-broadcast-demo';

            // user need to connect server, so that others can reach him.
            connection.connectSocket(function(socket) {
                socket.on('logs', function(log) {
                    document.querySelector('h1').innerHTML = log.replace(/</g, '----').replace(/>/g, '___').replace(/----/g, '(<span style="color:red;">').replace(/___/g, '</span>)');
                });

                // this event is emitted when a broadcast is already created.
                socket.on('join-broadcaster', function(hintsToJoinBroadcast) {
                    console.log('join-broadcaster', hintsToJoinBroadcast);

                    connection.session = hintsToJoinBroadcast.typeOfStreams;
                    connection.sdpConstraints.mandatory = {
                        OfferToReceiveVideo: true,
                        OfferToReceiveAudio: false
                    };
                    connection.join(hintsToJoinBroadcast.userid);
                });

                socket.on('rejoin-broadcast', function(broadcastId) {
                    console.log('rejoin-broadcast', broadcastId);

                    connection.attachStreams = [];
                    socket.emit('check-broadcast-presence', broadcastId, function(isBroadcastExists) {
                        if(!isBroadcastExists) {
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
                    alert('This broadcast has been stopped.');
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
                        showRoomURL(connection.sessionid);
                    });
                });
            });

            window.onbeforeunload = function() {
                // Firefox is ugly.
                document.getElementById('open-or-join').disabled = false;
            };

            var videoPreview = document.getElementById('video-preview');

            connection.onstream = function(event) {
                if(connection.isInitiator && event.type !== 'local') {
                    return;
                }

                if(event.mediaElement) {
                    event.mediaElement.pause();
                    delete event.mediaElement;
                }

                connection.isUpperUserLeft = false;
                videoPreview.src = URL.createObjectURL(event.stream);
                videoPreview.play();

                videoPreview.userid = event.userid;

                if(event.type === 'local') {
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

                    if(connection.DetectRTC.browser.name === 'Chrome') {
                        connection.getAllParticipants().forEach(function(p) {
                            if(p + '' != event.userid + '') {
                                var peer = connection.peers[p].peer;
                                peer.getLocalStreams().forEach(function(localStream) {
                                    peer.removeStream(localStream);
                                });
                                peer.addStream(event.stream);
                                connection.dontAttachStream = true;
                                connection.renegotiate(p);
                                connection.dontAttachStream = false;
                            }
                        });
                    }

                    if(connection.DetectRTC.browser.name === 'Firefox') {
                        // Firefox is NOT supporting removeStream method
                        // that's why using alternative hack.
                        // NOTE: Firefox seems unable to replace-tracks of the remote-media-stream
                        // need to ask all deeper nodes to rejoin
                        connection.getAllParticipants().forEach(function(p) {
                            if(p + '' != event.userid + '') {
                                connection.replaceTrack(event.stream, p);
                            }
                        });
                    }

                    // Firefox seems UN_ABLE to record remote MediaStream
                    // WebAudio solution merely records audio
                    // so recording is skipped for Firefox.
                    if(connection.DetectRTC.browser.name === 'Chrome') {
                        repeatedlyRecordStream(event.stream);
                    }
                }
            };

            // ask node.js server to look for a broadcast
            // if broadcast is available, simply join it. i.e. "join-broadcaster" event should be emitted.
            // if broadcast is absent, simply create it. i.e. "start-broadcasting" event should be fired.
            document.getElementById('open-or-join').onclick = function() {
                var broadcastId = document.getElementById('broadcast-id').value;
                if (broadcastId.replace(/^\s+|\s+$/g, '').length <= 0) {
                    alert('Please enter broadcast-id');
                    document.getElementById('broadcast-id').focus();
                    return;
                }

                document.getElementById('open-or-join').disabled = true;

                connection.session = {
                    screen: true,
                    oneway: true
                };

                var socket = connection.getSocket();

                socket.emit('check-broadcast-presence', broadcastId, function(isBroadcastExists) {
                    if(!isBroadcastExists) {
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

            connection.onstreamended = function() {};

            connection.onleave = function(event) {
                if(event.userid !== videoPreview.userid) return;

                var socket = connection.getSocket();
                socket.emit('can-not-relay-broadcast');

                connection.isUpperUserLeft = true;

                if(allRecordedBlobs.length) {
                    // playing lats recorded blob
                    var lastBlob = allRecordedBlobs[allRecordedBlobs.length - 1];
                    videoPreview.src = URL.createObjectURL(lastBlob);
                    videoPreview.play();
                    allRecordedBlobs = [];
                }
                else if(connection.currentRecorder) {
                    var recorder = connection.currentRecorder;
                    connection.currentRecorder = null;
                    recorder.stopRecording(function() {
                        if(!connection.isUpperUserLeft) return;

                        videoPreview.src = URL.createObjectURL(recorder.blob);
                        videoPreview.play();
                    });
                }

                if(connection.currentRecorder) {
                    connection.currentRecorder.stopRecording();
                    connection.currentRecorder = null;
                }
            };

            var allRecordedBlobs = [];

            function repeatedlyRecordStream(stream) {
                if(!enableRecordings) {
                    return;
                }

                connection.currentRecorder = RecordRTC(stream, {
                    type: 'video'
                });

                connection.currentRecorder.startRecording();

                setTimeout(function() {
                    if(connection.isUpperUserLeft || !connection.currentRecorder) {
                        return;
                    }

                    connection.currentRecorder.stopRecording(function() {
                        allRecordedBlobs.push(connection.currentRecorder.blob);

                        if(connection.isUpperUserLeft) {
                            return;
                        }

                        connection.currentRecorder = null;
                        repeatedlyRecordStream(stream);
                    });
                }, 30 * 1000); // 30-seconds
            };

            // Using getScreenId.js to capture screen from any domain
            // You do NOT need to deploy Chrome Extension YOUR-Self!!
          /*   connection.getScreenConstraints = function(callback) {
                getScreenConstraints(function(error, screen_constraints) {
                    if (!error) {
                        screen_constraints = connection.modifyScreenConstraints(screen_constraints);
                        callback(error, screen_constraints);
                        return;
                    }
                    throw error;
                });
            }; */

            function disableInputButtons() {
                document.getElementById('open-or-join').disabled = true;
                document.getElementById('broadcast-id').disabled = true;
            }

            // ......................................................
            // ......................Handling broadcast-id................
            // ......................................................

            function showRoomURL(broadcastId) {
                var roomHashURL = '#' + broadcastId;
                var roomQueryStringURL = '?broadcastId=' + broadcastId;

                var html = '<h2>Unique URL for your room:</h2><br>';

                html += 'Hash URL: <a href="' + roomHashURL + '" target="_blank">' + roomHashURL + '</a>';
                html += '<br>';
                html += 'QueryString URL: <a href="' + roomQueryStringURL + '" target="_blank">' + roomQueryStringURL + '</a>';

                var roomURLsDiv = document.getElementById('room-urls');
                roomURLsDiv.innerHTML = html;

                roomURLsDiv.style.display = 'block';
            }

            (function() {
                var params = {},
                    r = /([^&=]+)=?([^&]*)/g;

                function d(s) {
                    return decodeURIComponent(s.replace(/\+/g, ' '));
                }
                var match, search = window.location.search;
                while (match = r.exec(search.substring(1)))
                    params[d(match[1])] = d(match[2]);
                window.params = params;
            })();

            var broadcastId = '';
            if (localStorage.getItem(connection.socketMessageEvent)) {
                broadcastId = localStorage.getItem(connection.socketMessageEvent);
            } else {
                broadcastId = connection.token();
            }
            document.getElementById('broadcast-id').value = broadcastId;
            document.getElementById('broadcast-id').onkeyup = function() {
                localStorage.setItem(connection.socketMessageEvent, this.value);
            };

            var hashString = location.hash.replace('#', '');
            if(hashString.length && hashString.indexOf('comment-') == 0) {
              hashString = '';
            }

            var broadcastId = params.broadcastId;
            if(!broadcastId && hashString.length) {
                broadcastId = hashString;
            }

            if(broadcastId && broadcastId.length) {
                document.getElementById('broadcast-id').value = broadcastId;
                localStorage.setItem(connection.socketMessageEvent, broadcastId);

                // auto-join-room
                (function reCheckRoomPresence() {
                    connection.checkPresence(broadcastId, function(isRoomExists) {
                        if(isRoomExists) {
                            document.getElementById('open-or-join').onclick();
                            return;
                        }

                        setTimeout(reCheckRoomPresence, 5000);
                    });
                })();

                disableInputButtons();
            }

        </script>

        <section class="experiment own-widgets latest-commits">
            <h2 class="header" id="updates" style="color: red;padding-bottom: .1em;"><a href="https://github.com/muaz-khan/RTCMultiConnection/commits/master">Latest Updates</a></h2>
            <div id="github-commits"></div>
        </section>

        <section class="experiment own-widgets">
            <h2 class="header" id="updates" style="color: red;padding-bottom: .1em;"><a href="https://github.com/muaz-khan/RTCMultiConnection/issues">Latest Issues</a></h2>
            <div id="github-issues"></div>
        </section>

        <section class="experiment">
            <h2 class="header" id="feedback">Feedback</h2>
            <div>
                <textarea id="message" style="height: 8em; margin: .2em; width: 98%; border: 1px solid rgb(189, 189, 189); outline: none; resize: vertical;" placeholder="Have any message? Suggestions or something went wrong?"></textarea>
            </div>
            <button id="send-message" style="font-size: 1em;">Send Message</button><small style="margin-left:1em;">Enter your email too; if you want "direct" reply!</small>
        </section>

        <a href="https://github.com/muaz-khan/RTCMultiConnection" class="fork-left"></a>

        <script>
            window.useThisGithubPath = 'muaz-khan/RTCMultiConnection';
        </script>

        <script src="https://cdn.webrtc-experiment.com/commits.js" async></script>

    </article>

    <footer>
        <p>
            <a href="https://www.webrtc-experiment.com">WebRTC Experiments</a> Â© <a href="https://plus.google.com/+MuazKhan" rel="author" target="_blank">Muaz Khan</a>
            <a href="mailto:muazkh@gmail.com" target="_blank">muazkh@gmail.com</a>
            <a href="https://github.com/muaz-khan" target="_blank">Github</a>
        </p>
    </footer>

</body>

</html>
