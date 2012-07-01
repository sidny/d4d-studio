<{include file="section/htmheader.tpl"}>
<form action="" target="_blank" method="get">
表名:<input name="table" />
生成代码:<select name="type">
<option value="ibatis">ibatis</option>
<option value="dao">dao</option>
<option value="service">service</option>
<option value="domain">domain</option>
<input type="submit" />
</form>
<{include file="section/footer.tpl"}>
