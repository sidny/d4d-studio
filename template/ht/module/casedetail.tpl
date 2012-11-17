<{include file="ht/htmheader.tpl"}>
<style>
body{background-image:none;background-color:#fff}
</style>
<h2 class="contentTitle">经典案例内容管理</h2>
<div class="pdbody">
	<h3>修改内容</h3>
	<div class="writeList">
		<form id="casedetailForm" action="/ajax/item_z.php" method="post">
		<dl class="clearfix">
			<dt>视频标题</dt>
			<dd><input type="text" name="title" class="txt-normal" value="<{$caseDetail[0].title}>" /></dd>
		</dl>
		<dl class="clearfix">
			<dt>文字描述</dt>
			<dd>
				<textarea name="text" id="id_description" class="rte-zone" height="150"><{$caseDetail[0].content}></textarea>
			</dd>
		</dl>
		<dl class="clearfix">
			<dt>缩略图</dt>
			<dd><textarea name="minimg" id="id_description2" class="rte-zone" height="150"><{$caseDetail[0].minimg}></textarea></dd>
		</dl>
		<dl class="clearfix">
			<dt>视频地址</dt>
			<dd><input type="maximg" class="txt-normal" value="<{$caseDetail[0].maximg}>" /></dd>
		</dl>
		<input type="hidden" name="id" value="<{$caseDetail[0].id}>" />
		<input type="hidden" name="act" value="update" />
		<input type="hidden" name="typeid" value="6" />
		<dl><dt></dt><dd><input type="submit" class="b-green" value="提交" /></dd></dl>
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
		<div style="padding-top:20px;" id="imgAddr"></div>
	</div>
</div>
<{include file="ht/module/rte.tpl"}>
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