<?php
require_once($_SERVER['DOCUMENT_ROOT'] . '/../init.inc.php');
Template::SetTitle('首页');
if(isset($_REQUEST['type'])){
	$options  = array(
		'type' => (int)$_REQUEST['type'],	
	);
}
$itemType  = ItemType::getList($options);
Template::assign('itemType',$itemType);
Template::display('index.tpl');
