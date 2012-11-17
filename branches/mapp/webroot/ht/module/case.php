<?php
require_once($_SERVER['DOCUMENT_ROOT'] . '/../init.inc.php');
$params =  array(
	'condition' => array(
		array('typeid',6)
	)
);
$caseType = ContentList::getList($params);
Template::assign('caseType',$caseType);
Template::display('ht/module/case.tpl');