<?php
require_once($_SERVER['DOCUMENT_ROOT'] . '/../init.inc.php');
$params =  array(
	'condition' => array(
		array('typeid',1)
	)
);
//echo json_encode(ContentList::getList($params));
$indextype = ContentList::getList($params);
ContentList::del($params);
Template::assign('indextype',$indextype);
Template::display('ht/module/index.tpl');