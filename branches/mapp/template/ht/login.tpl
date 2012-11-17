<{include file="ht/header.tpl"}>
<div class="loginbox">
	<h2>用户登录</h2>
	<form id="login" action="/ajax/auth.php" method="get">
		<dl class="clearfix">
			<dt>用户名：</dt>
			<dd><input type="text" name="username" class="txt-normal" /></dd>
		</dl>
		<dl class="clearfix">
			<dt>密码：</dt>
			<dd><input type="password" name="password" class="txt-normal" /></dd>
		</dl>
		<input type="hidden" value="login" name="act" />
		<dl class="clearfix btnbox">
			<dd class="alignright"><input type="checkbox" class="checkbox" />记住密码<input type="submit" class="b-green" value="登录" /></dd>
		</dl>
	</form>
</div>
<{scriptholder}>
<script type="text/javascript">
$(document).ready(function(){
	$('#login').ajaxForm({
		dataType:'json',
		success:function(s){
			alert(s.msg);
			window.open('/ht/index.php','_self')
		}
	});
});
</script>
<{/scriptholder}>
<{include file="ht/footer.tpl"}>