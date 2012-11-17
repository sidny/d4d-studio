<{cssholder}>
/static/css/list.css
<{/cssholder}>
<div class="pageList clearfix">
	<{foreach from=$itemType.list key=key item=item}>
	<dl>
		<dt><a href="/list_<{$item.id}>.html"><img src="<{$item.image|default:'/static/images/categorys.png'|formaturl}>" /></a></dt>
		<dd><{$item.title}></dd>
	</dl>
	<{/foreach}>
</div>
