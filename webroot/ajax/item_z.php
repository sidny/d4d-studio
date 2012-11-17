<?php
require($_SERVER['DOCUMENT_ROOT'] . '/../ajax.inc.php');
$act = (string) $_REQUEST['act'];
$code = 0;
$msg = '操作成功';
global $currentUserInfo;
$typeid = (int) $_REQUEST['typeid'];
$id = (int) $_REQUEST['id'];
switch ($act){
case 'update':
	$item = array(
		'id' => $id,
		'typeid' => $typeid,
		'content' => stripslashes($_REQUEST['text']),
		'title' => stripslashes($_REQUEST['title']),
		'lang' => 'ch',
		'itemtime' => time(),
		'minimg' => stripslashes($_REQUEST['minimg']),
		'maximg' => stripslashes($_REQUEST['maximg'])
	);
	if($id){
		ContentList::update($item);
	}else{
		ContentList::add($item);	
	}
	break;

	case 'delete':
	if($id) 
	{
		$result = ContentList::del(array('id' =>$id));
		if($result>0){
			$code = 0;
			$msg = "删除成功";
		}else{
			$code = 1 ;
			$msg = "删除失败";
		}
		
	}else{
		$code = 1;
		$msg ="无效的id";
	}
	break;

	default:
	$code = 1;
	$msg = '没有这个操作';
}
