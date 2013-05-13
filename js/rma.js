// written by mueller@cognita.ch
$(document).ready(function() {
	//Navigation Frame
	//group list
	$('.menu > .menuOut').each(function(){
		$(this).add( $(this).nextUntil('.menuOut') ).wrapAll('<div class="ul"/>');
	});
	//mark items with no submenu
	$('.ul div:only-child').parent().addClass('layerone');
	//mark first/last item as last for logout-button
	$('.ul:first').addClass('nothing');
	$('.ul:last-child').addClass('logout');
	//add .hover class
	$('.menu div').hover(function() {
	  $(this).addClass('hover');
		}, function() {
	  $(this).removeClass('hover');
	});
	//add active-class (trail)
	$('.ul .menuOut').click(function() {
		$(this).not('.layerone').toggleClass('active');
		$('.active').next().removeClass('third');
		$('.active').next().addClass('third');
	});
	$('.layerone > a').click(function() {
		$('.active-trail').removeClass('active-trail');
		$(this).parent().addClass('active-trail');
	});
	$('.submenu a').click(function() {
		$('.active-trail').removeClass('active-trail')
		$(this).addClass('active-trail');
	});
	//add +/- indicators
	$('.submenu').prev().append("<span class='visible'>+</span><span>&ndash;</span>");
	$('.submenu').prev().click(function() {
		$(this).children().toggleClass('visible');
	});
	
	//Main Frame
	$('.submit:first, .listrow0 td:first-child, .listrow1 td:first-child, .listsubtotal td:first-child, .listsubtotal th:first-child, .listtotal td:first-child, .listtotal th:first-child').addClass('first')
	$('.submit:last, .listrow0 td:last-child, .listrow1 td:last-child, .listsubtotal td:last-child, .listsubtotal th:last-child, .listtotal td:last-child, .listtotal th:last-child').addClass('last')
	$('.submit').wrapAll('<div class="buttons" />');
	$('body',top.frames['main_window'].document).addClass('main').wrapInner('<div id="wrap"/>');
	$('td[align=right]').addClass('right');
	$('.listheading[colspan=2]').addClass('header');
	$('h1.login').parents('body').addClass('start');
	$('td:empty, th:empty').html('&nbsp;');
});