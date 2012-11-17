<?php
require_once($_SERVER['DOCUMENT_ROOT'] . '/../init.inc.php');
$params =  array(
	'condition' => array(
		array('typeid',8)
	)
);
$contactType = ContentList::getList($params);
Template::assign('contactType',$contactType);
Template::display('ht/module/contact.tpl');