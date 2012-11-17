<{include file="ht/htmheader.tpl"}>
<style>
body{background-image:none;background-color:#fff}
</style>
<h2 class="contentTitle">荣誉奖项内容管理</h2>
<div class="pdbody">
	<div class="writeList">
		<form id="imgForm" action="/ajax/image.php" enctype="multipart/form-data" method="post">
			<dl class="clearfix">
				<dt>选择图片：</dt>
				<dd><input type="file" /></dd>
			</dl>
			<input type="hidden" name="typeid" value="4" />
			<dl class="clearfix">
				<dt></dt>
				<dd><input type="submit" class="b-green" value="上传" /></dd>
			</dl>
		</form>
	</div>
</div>
<{scriptholder}>
<script type="text/javascript">
$('#imgForm').ajaxForm({
	success:function(){
		alert('操作成功！');
		window.location.href = '/ht/module/honor.php';
	}
});
</script>
<{/scriptholder}>
<{include file="ht/footer.tpl"}>