<{include file="ht/htmheader.tpl"}>
<style>
body{background-image:none;background-color:#fff}
</style>
<h2 class="contentTitle">荣誉奖项内容管理</h2>
<div class="pdbody">
	<form id="honorForm" action="/ajax/item_z.php" method="POST">
		<h3>荣誉奖项内容</h3>
		<div class="clearfix">
			<textarea name="text" id="id_description2" class="rte-zone" height="150"><{$honorType[0].content}></textarea>
		</div>
		<br />

		<{if $honorType[0].id}>
		<input type="hidden" name="id" value="<{$honorType[0].id}>" />
		<{/if}>
		<input type="hidden" name="typeid" value="4" />
		<input type="hidden" name="act" value="update" />

		<p><input type="submit" class="b-green" value="提交" /></p>
	</form><br /><br />
	<form id="uploadForm" action="/ajax/image.php" enctype="multipart/form-data" method="post">
		<div class="writeList">
			<dl class="clearfix">
				<dt>选择图片：</dt>
				<dd><input type="file" name="pic" /></dd>
			</dl>
			<input type="hidden" name="act" value="upload" />
			<input type="hidden" name="resp_type" value="html" />
			<dl class="clearfix">
				<dt>选择图片：</dt>
				<dd><input type="submit" class="b-green" value="上传" /></dd>
			</dl>
		</div>
	</form>
	<div style="padding-top:20px;" id="imgAddr"></div>
	<{include file="ht/module/rte.tpl"}>
</div>
<{scriptholder}>
<script type="text/javascript">
$(document).ready(function(){
	$('#uploadForm').ajaxForm({
		success:function(r){
			if(r.substr(0,1) == "<") r = $(r).text();
			r = {code:parseInt(r),msg:r.substr(2)};
			if(r.code)alert(r.msg);
			else{
				$('#imgAddr').append(
				'<p><lable>'+r.msg+'</label> <a href="'+r.msg+'" target="_blank">查看</a></p>');
			}
		}
	});
});
</script>
<{/scriptholder}>
<{include file="ht/footer.tpl"}>