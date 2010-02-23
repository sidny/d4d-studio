
;(function($){
var __reglib = {
	email			:	/^([\w.-])+\@(([\w-])+\.)[a-zA-Z0-9]{2,}/,
	domain			:	/^(http:\/\/)([\w]+\.){1,}[A-Z]{2,4}\b/gi,
	mobile			:	/^1(3|4|5|8)\d{9}$/,
	chinamobile		:	/^1(3[4-9]|4[7]|5[0-2|7-9]|8[7-8])[0-9]{8}$/,
	numeric			:	/^[0-9]+$/gi,
	chinese			:	/^([\u4e00-\u9fa5]{1,})/gi,
	tel				:	/^\d{3,4}-\d{7,8}$/gi,
	idcard			:	/^\d{14}(\d{1}|\d{4}|(\d{3}[xy]))$/gi,
	zip				:	/^[0-9]{6}$/gi,
	image			:	/[\w]+\.(gif|jpg|bmp|png|jpeg)$/gi,
	ewvt			:	/[\w]+\.(htm|html|php|txt)$/gi,
	media			:	/[\w]+\.(avi|mov|mpeg|wmv)$/gi,
	pdf				:	/[\w]+\.(pdf)$/gi
};
function __createTips(target,message,type,onstatus){
	if(onstatus instanceof Function) onstatus.call(target,message,type);
	$(target).trigger(((type == "error")?type:"normal"));
	if ($.bt){
			$(target).bt(message,$.extend(
						{closeWhenOthersOpen:false,clickAnywhereToClose:false,trigger:'none',positions:'most'},
						$.bt[type]));
			$(target).btOn();
	}
}
function __showTips (options){
	__createTips(options.target,options.tips,'tips',options.onstatus);
}

function __showError (options){
	__createTips(options.target,options.error,'error',options.onstatus);
}

function __showSuccess (options){
	__createTips(options.target,'','valid',options.onstatus);
}

function __report(options, failed){
	/**
	 * true		| 验证失败提示
	 * false	| 验证成功提示
	 */
	if(failed){
		//如果需要自定义出错的UI提示，可自定义错误回调
		if(options.onfail) {
			options.onfail.call(options.target[0], options.error);
		}
		else {
			__showError(options)
		}
		options.target.data('checked', false);
	}
	else{
		__showSuccess(options);
		options.target.data('checked', true);
	}
};

function __validateField (options){
	var $this = $(options.target);
	var $form = $($this[0].form);
	var _value = $this.val();
	var _result = true;
	
	//如果此项是隐藏的，那么就认为验证通过
	if($this.parents().is(':hidden')){
		__report(options, !_result);
		return _result;
	}

	switch(options.type){
		case 'required':
			if(!$.trim(_value))	_result = false;
			break;
		case 'regex' :
			try{
				var re = __reglib[options.data];
				if(!re)	re = new RegExp(options.data);
				if(!re.test(_value))	_result = false;
			}catch(error){
				alert($this.attr('name') + '缺少必须的data属性');
				return false;
			}
			break;
		case 'custom' : 
			try{
				var _result = eval(options.data).call($this[0]);
				/*
				 *为了满足不同的错误提示
				 *如果验证函数返回了字符串，那么作为错误提示文字
				 *如果返回的是非字符串，那么就用options.error的错误提示文字
				 */
				if(typeof(_result) === 'string'){
					options.error = _result;
					_result = false;
				}else if(_result instanceof Object){
					if(_result.type == 'error'){
						options.error = _result.message;
						_result = false;
					}
				}
				else if(!_result) _result = false;

			}catch(error){
				alert($this.attr('name') + '缺少必须的data属性');
				return false;
			}
			break;
	}
	__report(options, !_result);
	return _result;
} 
$.fn.extend({
	validate : function(options){
		var options = $.extend({
			type: 'required',
			tips: '输入提示',
			data: '',
			error: '内容不能为空',
			onstatus:null
		}, options);
		return this.each(function(){
			var $this = $(this);
			var $form = $(this.form);
			options.check = false;
			$this.data('validateOption', options);
			$this.bind('focus', function(){
				var opts = $(this).data("validateOption");
				opts.target = $(this);
				__showTips(opts);
			});
			$this.bind('blur', function(){
				var opts = $(this).data("validateOption");
				opts.target = $(this);
				__validateField(opts);
			});
			//form的自定义检测绑定一次
			if(!$form.data('validate')){
				$form.bind('submit.validate', function(){
					//禁用Submit按钮
					$('input[type=submit],button[type=submit]', this).attr('disabled', true).addClass('disabled');
					//验证每一项
					var _result = true;
					for(var i = 0 ,list = this.elements,j = list.length;i<j;i++){
						var opts = $(list[i]).data('validateOption');
						if(!opts) continue;
						opts.target = $(list[i]);
						_result = __validateField(opts);
						//如果有一项验证失败，那就终止下面的验证
						if(!_result) break;	
					}
					$('input[type=submit],button[type=submit]', this).attr('disabled', false).removeClass('disabled');
					return _result;
				})
				.data('validate', true);
			}
		});
	}
});

$.extend({
	getReg : function(type){
		if(!__reglib[type])	return null;
		return __reglib[type];
	}
});

})(jQuery);
