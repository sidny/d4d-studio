<?php
require($_SERVER['DOCUMENT_ROOT'] . '/ajax.inc.php');
$act = $_REQUEST['act'];
$code = 0;
$msg = '操作成功';
global $currentUserInfo;
//$data = array();
$typeid = (int) $_REQUEST['typeid'];
$id = (int) $_REQUEST['id'];
$club = $_REQUEST['club'];
switch ($act) {
    case 'update'://验证登录
    	$item = array(
    		'id' => $id,
    		'typeid' => $typeid,
    		'lang' => $_REQUEST['lang'],
    		'content' => stripslashes($_REQUEST['text']),
    		'title' => $_REQUEST['title'],
    		'itemtime' => $_REQUEST['itemtime'],
    		'itemcreatetime' => date('Y-m-j G:i:s'),
			'operator' => $currentUserInfo['idoperator'],
			'club'	=> $_REQUEST['club'],
    	);
    	//var_dump($item['content'],$_REQUEST['text']);
   // die();
    	if($id)
			$result = Item::updateItem($item);
    	else{
    		$result = Item::createItem($item);
    	}
    	if($result){
    		$data = $result;
    	}
    break;
	case 'delete':
		if($id) 
		{
			$result = Item::deleteItem($id);
			$code = $result['code'];
    		$msg = $result['msg'];
    		$data = $result['data'];
		}else{
			$code = 1;
			$msg ="无效的id";
		}
    break;
    case 'get' :
    	$result = Item::getItemByID($id);
    	$code = $result['code'];
    	$msg = $result['msg'];
    	$data = $result['data'][0];
    	break;
    case 'list':
    	break;
	case 'reload':
		$p = (int) $_REQUEST['p'];
		$size = 10;
		$count = Item :: count(null,$typeid);
		$list = Item :: getItem_paged(null,$p * $size, $size, $typeid,$club);
		Template :: assign(array (
			'p' => $p,
			'total' => $count,
			'items' => $list['data'],
		));
		$data = Template::Render('op/grid.tpl');
    	break;
    default:
    	$code = 1;
    	$msg = '没有这个操作';
}
