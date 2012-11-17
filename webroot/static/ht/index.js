// JavaScript Document

$(document).ready(function(){
	
	//展开 收起左侧导航
	$('.stretch a').click(function(){
		var $this = $(this);
		$this.toggleClass('current');
		if($this.hasClass('current')){
			$('#leftcolumn').hide();
			$('body').css('background-position','-230px top');
			$('#maincolumn').css('margin-left','30px');
		}else{
			$('#leftcolumn').show();
			$('body').css('background-position','0 top');
			$('#maincolumn').css('margin-left','249px');
		}
	});
	$('#content').height($(window).height()-71);
	$(window).resize(function(){
		$('#content').height($(window).height()-71);
	});
});