<{include file="ht/htmheader.tpl"}>
<style>
body{background-image:none;background-color:#fff}
</style>
<h2 class="contentTitle">首页内容管理</h2>
<div class="pdbody">
	<form id="indexForm" action="/ajax/item_z.php" method="POST">
		<h3>首页口号</h3>
		<div class="clearfix">
			<textarea name="title" id="id_description" class="rte-zone" height="150"><{$indextype[0].title}></textarea>
		</div><br />
		<h3>首页内容</h3>
		<div class="clearfix">
			<textarea name="text" id="id_description2" class="rte-zone" height="150"><{$indextype[0].content}></textarea>
		</div>
		<{if $indextype[0].id}>
		<input type="hidden" name="id" value="<{$indextype[0].id}>" />
		<{/if}>
		<input type="hidden" name="typeid" value="1" />
		<input type="hidden" name="act" value="update" />
		<br />
		<p><input type="submit" class="b-green" value="提交" /></p>
	</form>
	<{include file="ht/module/rte.tpl"}>
</div>
<{include file="ht/footer.tpl"}>