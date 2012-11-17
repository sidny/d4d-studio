<{include file="ht/htmheader.tpl"}>
<style>
body{background-image:none;background-color:#fff}
</style>
<h2 class="contentTitle">联系我们内容管理</h2>
<div class="pdbody">
	<form id="contactForm" action="/ajax/item_z.php" method="POST">
		<h3>联系我们内容</h3>
		<div class="clearfix">
			<textarea name="text" id="id_description" class="rte-zone" height="150"><{$contactType[0].content}></textarea>
		</div>
		<br />
		<{if $contactType[0].id}>
		<input type="hidden" name="id" value="<{$contactType[0].id}>" />
		<{/if}>
		<input type="hidden" name="typeid" value="8" />
		<input type="hidden" name="act" value="update" />

		<p><input type="submit" class="b-green" value="提交" /></p>
	</form>
	<{include file="ht/module/rte.tpl"}>
</div>
<{include file="ht/footer.tpl"}>