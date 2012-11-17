<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
	"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">

<head>
<meta name="Generator" content="CMS Made Simple - Copyright (C) 2004-9 Ted Kulp. All rights reserved." />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="robots" content="noindex, nofollow" />
<title>一三九CMS - CMSHome</title>
</head>
<body>
<div>
<{foreach from=$result item=item key=key name=list}>
<{if $smarty.foreach.list.index % 10 == 0}>
</div>
<{$smarty.foreach.list.index}>
==================================
<div class="checkstream">
<{/if}>
	<div class="item">
	<p><{assign var="i" value=$smarty.foreach.list.index%10}><{$i+1}> <{$item.title}></p>
	<div class="operate clearfix">
		<input name="no<{$i+1}>" value="<{$item.id}>" type="hidden" />
		<span><input type="radio" name="q<{$i+1}>" value="a" /> <{$item.a}></span>
		<span><input type="radio" name="q<{$i+1}>" value="b" /> <{$item.b}></span>
		<span><input type="radio" name="q<{$i+1}>" value="c" /> <{$item.c}></span>
<{if $item.d}>		<span><input type="radio" name="q<{$i+1}>" value="d" /> <{$item.d}></span><{/if}>

<{if $item.e}>		<span><input type="radio" name="q<{$i+1}>" value="e" /> <{$item.e}></span><{/if}>
	
	</div>
	</div>
<{/foreach}>
</div>


$result = array(
<{foreach from=$result item=item key=key name=list}>
	"<{$item.id}>" => "<{$item.answer}>",
<{/foreach}>
);
</body>
</html>
