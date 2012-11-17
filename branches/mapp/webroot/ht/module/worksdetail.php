<?php
require_once($_SERVER['DOCUMENT_ROOT'] . '/../init.inc.php');
$worksid = $_REQUEST['id'];
$params =  array(
	'condition' => array(
		array('id',$worksid)
	)
);
$worksDetail = ContentList::getList($params);
Template::assign('worksDetail',$worksDetail);
Template::display('ht/module/worksdetail.tpl');