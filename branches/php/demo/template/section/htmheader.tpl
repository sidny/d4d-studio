<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<{$metas}>
<title><{$head_title}><{if $head_title}> - <{/if}><{$smarty.const.TOP_TITLE}></title>
<!--tpl:cssholder-->
<{$more_string}>
<{if !$iapi}>
<script type="text/javascript">
var _bi_uid="<{$current_user_id}>";
var carrytime = {};
(function(){
	 var a = document.cookie.split('; ');
	 for(i = 0; i< a.length; i ++){
		 var s = a[i].split('=');
		 if(s[0] == 'c.carrytime.leave'){
			carrytime.leave = parseInt(s[1]);
		 }
	 }
 })();
if(carrytime.leave && !isNaN(carrytime.leave)){
	carrytime.back = (new Date()).getTime();
}
</script>
<{/if}>
</head>
<body>
