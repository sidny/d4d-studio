<{include file="ht/htmheader.tpl"}>
<style>
body{background-image:none;background-color:#fff}
</style>
<h2 class="contentTitle">公司简介内容管理</h2>
<div class="pdbody">
	<form id="aboutForm" action="/ajax/item_z.php" method="POST">
		<h3>公司简介内容</h3>
		<div class="clearfix">
			<textarea name="text" id="id_description" class="rte-zone" height="150"><{$aboutType[0].content}></textarea>
		</div>
		<br />
		<{if $aboutType[0].id}>
		<input type="hidden" name="id" value="<{$aboutType[0].id}>" />
		<{/if}>
		<input type="hidden" name="typeid" value="2" />
		<input type="hidden" name="act" value="update" />

		<p><input type="submit" class="b-green" value="提交" /></p>
	</form>
	<{include file="ht/module/rte.tpl"}>
</div>
<{include file="ht/footer.tpl"}>