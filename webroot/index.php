<?php
require_once($_SERVER['DOCUMENT_ROOT'] . '/../init.inc.php');
Template::SetTitle('首页');
$params =  array(
	'condition' => array(
		array('typeid',6)
	),
	//按修改时间排序
	'order'	=> array(
		array('itemtime','desc')
	)
);
$usernames = Array(
	'a' => 'zhaolujie',
	'b' => 'wanghan',
	'c' => 'likunming',
	'd' => 'yezi'
);
$indexType = ContentList::getList($params);
Template::assign('indexType',$indexType['list']);
Template::assign('usernames',$usernames);
Template::display('index.tpl');
