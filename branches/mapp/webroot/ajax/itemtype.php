<?php
require($_SERVER['DOCUMENT_ROOT'] . '/ajax.inc.php');
$act = $_GET['act'];
$code = 0;
$msg = '操作成功';
global $currentUserInfo;
//$data = array();
$id = (int) $_REQUEST['id'];
switch ($act) {
    case 'update'://验证登录
    	$item = array(
    		'id' => $id,
    		'cnname' => $_REQUEST['cnname'],
    		'enname' => $_REQUEST['enname'],
    		'path' =>$_REQUEST['path'],
    		'adminpath' => $_REQUEST['adminpath'],
    		'showmenu' => (int)$_REQUEST['showmenu'],
    		'parentid' => (int)$_REQUEST['parentid'],
			'typelevel' => (int)$_REQUEST['typelevel'],
    	);
	
    	if($id)
			$result = ItemType::updateItem($item);
    	else{
    		$result = ItemType::createItem($item);
    	}
    	if($result){
    		$data = $result;
    	}
    break;
	case 'delete':
		if($id) 
		{
			$result = ItemType::deleteItem($id);
			$code = $result['code'];
    		$msg = $result['msg'];
    		$data = $result['data'];
		}else{
			$code = 1;
			$msg ="无效的id";
		}
    break;
    case 'get' :
    	$result = ItemType::getItemByID($id);
    	$code = $result['code'];
    	$msg = $result['msg'];
    	$data = $result['data'][0];
    	break;
    case 'list':
    	break;
	case 'reload':
		$count = ItemType :: count();
		$list = ItemType :: getAllItem();
		Template :: assign(array (
			'p' => $p,
			'total' => $count,
			'items' => $list['data'],
		));
		$data = Template::Render('op/typegrid.tpl');
    	break;
    default:
    	$code = 1;
    	$msg = '没有这个操作';
}
