<?php
require_once($_SERVER['DOCUMENT_ROOT'] . '/../init.inc.php');
$params =  array(
	'condition' => array(
		array('typeid',2)
	)
);
$aboutType = ContentList::getList($params);
Template::assign('aboutType',$aboutType);
Template::display('ht/module/about.tpl');