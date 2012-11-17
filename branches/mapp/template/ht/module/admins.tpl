<{include file="ht/htmheader.tpl"}>
<style>
body{background-image:none;background-color:#fff}
</style>
<h2 class="contentTitle">管理员管理</h2>
<div class="pdbody">
	<div class="tablebox">
		<div class="tableheader">
			<span class="name">用户列表</span>
			<a href="#" class="openUp"></a>
		</div>
		<div class="tablecontent">
			<table>
				<tr>
					<th width="50%">账号 ---- <a href="#" class="mainOperate" srv="addForm">增加账号</a></th>
					<th width="50%">操作</th>
				</tr>
				<{ foreach from=$userlist item=useritem}>
				<tr>
					<td><{$useritem.username}></td>
					<td><a href="#" class="mainOperate" srv="editorForm">修改</a></td>
				</tr>
				<{/foreach }>
			</table>
		</div>
	</div>
</div>

<{*修改账号*}>
<div id="editorForm" class="mainOperateCount" style="width:400px; height:200px; background-color:#eee;">
	<a href="#" class="uiClose"></a>
	修改账号
</div>

<{*添加账号*}>
<div id="addForm" class="mainOperateCount" style="width:400px; height:200px; background-color:#eee;">
	<a href="#" class="uiClose"></a>
	添加账号
</div>
<{include file="ht/footer.tpl"}>