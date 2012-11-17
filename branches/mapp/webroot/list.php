<?php
require_once($_SERVER['DOCUMENT_ROOT'] . '/../init.inc.php');
Template::SetTitle('首页');
$options  = array(
	'type_id' => (int)$_REQUEST['type'],	
);
$itemType  = ItemType::getList();
$itemList = Item::getList($options);
Template::assign('itemType',$itemType);
Template::assign('itemList',$itemList);
Template::display('list.tpl');
