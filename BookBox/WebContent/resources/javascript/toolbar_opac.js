//Toolbar Animation Script
var winHeight = $(window).height();
var isToolbarOpac = true;

function ToolbarOpacHeight(opacHeight){
	winHeight = opacHeight;
}

function setToolbarOpac(opac){
	isToolbarOpac = opac;
}

$(window).scroll(function(){
	if($(window).scrollTop() <= winHeight - 50){
		$('header').css('opacity', (winHeight - $(window).scrollTop()) / winHeight * 0.75);
		if(isToolbarOpac){
			$('.bookbox-navigation').css('background-color', 'rgba(255, 255, 255, ' + (1 - ((winHeight - $(window).scrollTop()) / winHeight)) + ')')
											.css('-webkit-box-shadow', '0px ' + (2 * ($(window).scrollTop() / winHeight)) + 'px ' + (5 * ($(window).scrollTop() / winHeight)) + 'px 0px')
											.css('-moz-box-shadow', '0px ' + (2 * ($(window).scrollTop() / winHeight)) + 'px ' + (5 * ($(window).scrollTop() / winHeight)) + 'px 0px')
											.css('box-shadow', '0px ' + (2 * ($(window).scrollTop() / winHeight)) + 'px ' + (5 * ($(window).scrollTop() / winHeight)) + 'px 0px');
		}
	}else{
		if(isToolbarOpac){
			$('.bookbox-navigation').css('background-color', 'rgba(255, 255, 255, 1)')
											.css('-webkit-box-shadow', '0px 2px 5px 0px')
											.css('-moz-box-shadow', '0px 2px 5px 0px')
											.css('box-shadow', '0px 2px 5px 0px');
		}
	}
});

$(function(){
	if($(window).scrollTop() < winHeight){
		if(isToolbarOpac){
			$('.bookbox-navigation').css('background-color', 'rgba(255, 255, 255, ' + (1 - ((winHeight - $(window).scrollTop()) / winHeight)) + ')')
											.css('-webkit-box-shadow', '0px ' + (2 * ($(window).scrollTop() / winHeight)) + 'px ' + (5 * ($(window).scrollTop() / winHeight)) + 'px 0px')
											.css('-moz-box-shadow', '0px ' + (2 * ($(window).scrollTop() / winHeight)) + 'px ' + (5 * ($(window).scrollTop() / winHeight)) + 'px 0px')
											.css('box-shadow', '0px ' + (2 * ($(window).scrollTop() / winHeight)) + 'px ' + (5 * ($(window).scrollTop() / winHeight)) + 'px 0px');
		}
	}
});

