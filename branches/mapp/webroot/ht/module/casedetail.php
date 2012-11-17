<?php
require_once($_SERVER['DOCUMENT_ROOT'] . '/../init.inc.php');
$caseid = $_REQUEST['id'];
$params =  array(
	'condition' => array(
		array('id',$caseid)
	)
);
$caseDetail = ContentList::getList($params);
Template::assign('caseDetail',$caseDetail);
Template::display('ht/module/casedetail.tpl');