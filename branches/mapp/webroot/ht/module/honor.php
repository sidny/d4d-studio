<?php
require_once($_SERVER['DOCUMENT_ROOT'] . '/../init.inc.php');
$params =  array(
	'condition' => array(
		array('typeid',4)
	)
);
$honorType = ContentList::getList($params);
Template::assign('honorType',$honorType);
Template::display('ht/module/honor.tpl');