<?php
require_once($_SERVER['DOCUMENT_ROOT'] . '/../init.inc.php');
$params =  array(
	'condition' => array(
		array('typeid',7)
	)
);
$worksType = ContentList::getList($params);
Template::assign('worksType',$worksType);
Template::display('ht/module/works.tpl');