<?php
require_once($_SERVER['DOCUMENT_ROOT'] . '/../init.inc.php');
$params =  array(
	'condition' => array(
		array('typeid',5)
	)
);
$brandType = ContentList::getList($params);
Template::assign('brandType',$brandType);
Template::display('ht/module/brand.tpl');