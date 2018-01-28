<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!--  ///////////////////////// JSTL  ////////////////////////// -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<script>
 	$(function(){
		if($(window).height() == $(document).height()){
			fncFooterPositioning();
		}
	});
 	
 	$(window).resize(function(){
		fncFooterPositioning();
		console.log("resize log");
 	});
 	$(window).bind('DOMNodeInserted DOMNodeRemoved', function() {
 		fncFooterPositioning();
	});
 	
 	function fncFooterPositioning(){
		$('footer').css('position', 'absolute')
		.css('top', document.body.scrollHeight-85);
 	}
	
</script>
	<h5>BOOKBOX <span class="hidden-xs">COMMUNITY </span>© 2017</h5>