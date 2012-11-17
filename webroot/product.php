<?php
require_once($_SERVER['DOCUMENT_ROOT'] . '/../init.inc.php');
Template::SetTitle('首页');
$options  = array(
	'id' => (int)$_REQUEST['id'],	
);
$item  = Item::getOne($options);
Template::assign('item',$item);
Template::display('product.tpl');
