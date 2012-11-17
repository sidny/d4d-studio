$(document).ready(function(){
	//blockUI 提示弹层
	function tipsUI(msg){
		$.blockUI({
			message:'<div style="padding:30px; position:relative;"><a href="#" id="uiClose"></a>' + msg + '</div>',
			css:{
				width:'auto',
				left:'50%',
				top:'50%'
			}
		});
		//alert($('#blockContent').width() + ' -- ' + $('#blockContent').height() + 'window:' + $(window).width() + ' -- ' + $(window).height());
		centerUI();
		$('#uiClose').click(function(){
			$.unblockUI();
			return false;
		});
	}
	window.tipsUI = tipsUI;

	//blockUI 成功提示
	function successUI(msg){
		$.blockUI({
			message:'<div style="padding:10px 15px; position:relative;">' + msg + '</div>',
			css:{
				width:'auto',
				left:'50%',
				top:'50%'
			}
		});
		centerUI();
		setTimeout($.unblockUI,1600);
	}
	window.successUI = successUI;

	//blockUI 上下左右居中
	function centerUI(){
		$('#blockContent').css({
			'margin-left':- $('#blockContent').width()/2,
			'margin-top':- $('#blockContent').height()/2
		});
	}
	window.centerUI = centerUI;
});