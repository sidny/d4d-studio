<?php

require($_SERVER['DOCUMENT_ROOT'] . '/../ajax.inc.php');
$act = $_REQUEST['act'];
$code = 0;
$msg = '操作成功';
$data = array();
switch ($act) {
    case 'login'://验证登录
    	$username = $_REQUEST['username'];
    	$password = $_REQUEST['password'];
    	$result = Auth::checkLogin($username,$password);
    	$code = $result['code'];
    	$msg = $result['msg'];
    break;
	case 'logout':
		session_destroy();
    break;
    default:
    	$code = 1;
    	$msg = '没有这个操作';
}
