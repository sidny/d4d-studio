<{include file="ht/htmheader.tpl"}>
<style>
body{background-image:none;background-color:#fff}
</style>
<h2 class="contentTitle">此页标题</h2>
<form>

<{include file="ht/module/rte.tpl"}>
</form>
<div class="pdbody">
	<div class="topbar">
		<ul class="clearfix">
			<li class="current"><a href="#">模块1</a></li>
			<li><a href="#">模块2</a></li>
			<li><a href="#">模块3</a></li>
			<li><a href="#">模块4</a></li>
		</ul>
	</div>
	
	<h3>表格示例</h3>
	<div class="tablebox">
		<div class="tableheader">
			<span class="name">表名称</span>
			<a href="#" class="openUp"></a>
			<ul class="clearfix">
				<li class="current"><a href="#">第一部分</a></li>
				<li><a href="#">第二部分</a></li>
				<li><a href="#">三部分</a></li>
			</ul>
		</div>
		<div class="tablecontent">
			<table>
				<tr>
					<th width="20%">姓名</th>
					<th width="20%">星座</th>
					<th width="20%">爱好</th>
					<th width="20%">性别</th>
					<th width="20%">感言</th>
				</tr>
				<tr>
					<td width="20%">随便随便</td>
					<td width="20%">天驴座</td>
					<td width="20%">哈哈嘎嘎</td>
					<td width="20%">依依呀呀</td>
					<td width="20%">密友啥的</td>
				</tr>
				<tr>
					<td width="20%">随便随便</td>
					<td width="20%">天驴座</td>
					<td width="20%">哈哈嘎嘎</td>
					<td width="20%">依依呀呀</td>
					<td width="20%">密友啥的</td>
				</tr>
			</table>
		</div>
	</div>

	<h3>表格示例（左右两栏）</h3>
	<div class="tablebox clearfix">
		<div class="leftitem">
			<div class="tableheader">
				<span class="name">左边栏</span>
			</div>
			<div class="tablecontent">
				<p class="title">可以写个小标题</p>
				<p>可以写点内容进来，这个是必须的可以写点内容进来，这个是必须的可以写点内容进来，这个是必须的可以写点内容进来，这个是必须的</p>
			</div>
		</div>
		<div class="rightitem">
			<div class="tableheader">
				<span class="name">右边栏</span>
				<a href="#" class="openUp"></a>
			</div>
			<div class="tablecontent">
				<table>
					<tr>
						<th width="25%">可以</th>
						<th width="25%">插个</th>
						<th width="25%">表格</th>
						<th width="25%">进来</th>
					</tr>
					<tr>
						<td width="20%">随便随便</td>
						<td width="20%">天驴座</td>
						<td width="20%">哈哈嘎嘎</td>
						<td width="20%">依依呀呀</td>
					</tr>
				</table>
			</div>
		</div>
	</div>

	<h3>输入样式</h3>
	<div class="writeList">
		<dl class="clearfix">
			<dt>用户名</dt>
			<dd><input type="text" class="txt-normal" /></dd>
		</dl>
		<dl class="clearfix">
			<dt>手机号</dt>
			<dd><input type="text" class="txt-normal" /></dd>
		</dl>
		<dl class="clearfix">
			<dt>备注</dt>
			<dd><textarea class="txt-normal"></textarea></dd>
		</dl>
		<dl class="clearfix">
			<dd>
				<input type="button" class="b-green" value="提交" />
				<input type="button" class="b-gray" value="取消" />
			</dd>
		</dl>
	</div>

	<h3>相关信息样式</h3>
	<div class="writeList">
		<dl class="clearfix">
			<dt>用户名：</dt>
			<dd>赵路杰：</dd>
		</dl>
		<dl class="clearfix">
			<dt>手机号：</dt>
			<dd>135XXXXXXXX</dd>
		</dl>
		<dl class="clearfix">
			<dt>邮箱：</dt>
			<dd>zhaolujie@aspirecn.com</dd>
		</dl>
		<dl class="clearfix">
			<dt>备注：</dt>
			<dd>这个那个啥啥啊这个那个的</dd>
		</dl>
	</div>

	<h3>提醒样式</h3>
	<div class="remindbox orangeRemind">黄色的</div>
	<div class="remindbox blueRemind">蓝色的</div>
	<div class="remindbox greenRemind">绿色的</div>
	<div class="remindbox redRemind">红色的</div>

	<h3>按钮样式</h3>
	<div class="clearfix mainitem">
		<input class="b-green" type="button" value="确定按钮" />
		<input class="b-gray" type="button" value="灰色取消按钮" />
	</div>
	
	<h3>链接伪类</h3>
	<div class="mainitem">
		<a href="#" class="b-green">确定</a>
		<a href="#" class="b-gray">取消</a>
	</div>

	<h3>下拉菜单及输入框</h3>
	<div class="mainitem">
		<select>
			<option>choose an action</option>
			<option>fadfadf</option>
			<option>dddaadf</option>
			<option>dfadfadfa</option>
		</select>
		<input type="text" class="txt-normal" />
	</div>
	
	<h3>分页器样式</h3>
	<div class="pagenation clearfix">
		<ul class="clearfix">
			<li class="prev"><a href="#">&lt;&lt;上一页</a></li>
			<li><a href="#">1</a></li>
			<li><a href="#">2</a></li>
			<li><a href="#">3</a></li>
			<li class="current"><a href="#">4</a></li>
			<li><a href="#">5</a></li>
			<li><a href="#">6</a></li>
			<li class="next"><a href="#">下一页&gt;&gt;</a></li>
		</ul>
	</div>
</div>
<{include file="ht/footer.tpl"}>