/**
 * 
 */
function fncGetDate(day){
	var nowDate = new Date();
	var date = nowDate.getTime() - (day * 24 * 60 * 60 * 1000);
	nowDate.setTime(date);
	var year = nowDate.getFullYear();
	var month = nowDate.getMonth() + 1;
	var day = nowDate.getDate();
	
	if(month < 10){
		month = '0' + month;
	}
	if(day < 10){
		day = '0' + day;
	}
	
	return month + '-' + day;
};

$(function(){
	$('span.tag').on('click', function(){
		var keyword = $(this).html();
		keyword = keyword.substring(1);
		$(self.location).attr("href","../unifiedsearch/getUnifiedsearchList?category=11&keyword="+keyword);
	});
});

