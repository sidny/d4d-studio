<?php
require_once($_SERVER['DOCUMENT_ROOT'] . '/../init.inc.php');
Template::SetTitle('首页');
$params =  array(
	'condition' => array(
		
	),
	//按修改时间排序
	'order'	=> array(
	)
);
define('PAGE_SIZE' , 1);
$p = intval($_GET["p"]) ? intval($_GET["p"]) : "1";
$offset = PAGE_SIZE * ($p - 1);
$indexType = ContentList::getList($params,$offset,PAGE_SIZE);
$totalcount = $indexType['count'];
$pager = new Pager(array('pageSize' => PAGE_SIZE, 'rowCount' => (int)$totalcount));
Template::assign('indexType',$indexType['list']);
Template::assign('pager',$pager->genYuan());
Template::assign('usernames',$usernames);
Template::display('pager.tpl');
