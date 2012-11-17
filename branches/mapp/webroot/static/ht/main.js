$(document).ready(function(){
	$('.tablebox .tableheader a.openUp').click(function(){
		var $this = $(this);
		$this.toggleClass('openDown');
		$this.closest('.tablebox').find('.tablecontent').toggle();
		return false;
	});
	$('.mainOperate').click(function(){
		$.blockUI({
			message:$('#' + $(this).attr('srv')),
			css:{
				width:'auto',
				left:'50%',
				top:'50%'
			}
		});
		centerUI();
		$('.uiClose').click(function(){
			$.unblockUI();
		});
	});
	//ajax form
	$('#indexForm, #aboutForm, #directorForm, #honorForm, #brandForm, #caseForm, #worksForm, #contactForm, #casedetailForm').ajaxForm({
		dataType:'JSON',
		success:function(msg){
			alert(msg.msg);
			window.location.reload();
		}
	});
});