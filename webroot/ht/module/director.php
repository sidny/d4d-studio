<?php
require_once($_SERVER['DOCUMENT_ROOT'] . '/../init.inc.php');
$params =  array(
	'condition' => array(
		array('typeid',3)
	)
);
$directorType = ContentList::getList($params);
Template::assign('directorType',$directorType);
Template::display('ht/module/director.tpl');