<{include file="ht/htmheader.tpl"}>
<style>
body{background-image:none;background-color:#fff}
</style>
<h2 class="contentTitle">经典案例内容管理</h2>
<div class="pdbody">
	<form id="caseForm" action="/ajax/item_z.php" method="POST">
		<h3>经典案例内容</h3>
		<div class="writeList">
			<dl>
				<dt>标题：</dt>
				<dd><input type="text" name="title" class="txt-normal" style="width:200px;" /></dd>
			</dl>
			<dl class="clearfix">
				<dt>缩略图地址：</dt>
				<dd><textarea name="minimg" id="id_description" class="rte-zone" height="150"></textarea></dd>
			</dl>
			<dl class="clearfix">
				<dt>视频地址：</dt>
				<dd><input type="text" class="txt-normal" name="maximg" value="" /></dd>
			</dl>
			<dl class="clearfix">
				<dt>文字描述：</dt>
				<dd><textarea name="text" id="id_description2" class="rte-zone" height="150"></textarea></dd>
			</dl>
			<input type="hidden" name="typeid" value="6" />
			<input type="hidden" name="act" value="update" />
			<dl class="clearfix">
				<dt></dt>
				<dd><input type="submit" class="b-green" value="提交" /></dd>
			</dl>
		</div>
		<br />
	</form><br /><br />
	<form id="uploadForm" action="/ajax/image.php" enctype="multipart/form-data" method="post">
		<div class="writeList">
			<dl class="clearfix">
				<dt>上传缩略图：</dt>
				<dd><input type="file" name="pic" /></dd>
			</dl>
			<input type="hidden" name="act" value="upload" />
			<input type="hidden" name="resp_type" value="html" />
			<dl class="clearfix">
				<dt></dt>
				<dd><input type="submit" class="b-green" value="上传" /></dd>
			</dl>
		</div>
	</form>
	<{include file="ht/module/rte.tpl"}>
	<div style="padding-top:20px;" id="imgAddr"></div>
	<{*table*}>
	<div class="tablebox">
		<div class="tableheader">
			<span class="name">经典案例列表</span>
		</div>
		<div class="tablecontent">
			<table>
				<tr>
					<th width="20%">标题</th>
					<th width="20%">文字描述</th>
					<th width="20%">缩略图</th>
					<th width="20%">视频地址</th>
					<th width="20%">操作</th>
				</tr>
				<{foreach from=$caseType item=item}>
				<tr>
					<td><{$item.title}></td>
					<td><{$item.content|truncate:100:"...":true}></td>
					<td><{$item.minimg}></td>
					<td><{$item.maximg}></td>
					<td>
						<form method="POST" action="/ajax/item_z.php">
						<input type="hidden" name="act" value="delete" />
						<input type="hidden" name="id" value="<{$item.id}>" />
						<a href="#" class="del" srv="<{$item.id}>">删除</a> | 
						<a href="/ht/module/casedetail.php?id=<{$item.id}>">修改</a>
						</form>
					</td>
				</tr>
				<{/foreach}>
			</table>
		</div>
	</div>
	<{*table over*}>
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
	$('.del').click(function(){
		var $this = $(this);
		$this.closest('form').ajaxSubmit({
			success:function(r){
				alert(r.msg);
				window.location.reload();
			},dataType:"json"
		});
		return false;
	});
});
</script>
<{/scriptholder}>
<{include file="ht/footer.tpl"}>