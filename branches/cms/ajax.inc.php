<?php
require_once($_SERVER['DOCUMENT_ROOT'] . '/../config/config.web.php');
//ini_set('display_errors','1');
//{{{统一输出函数
function ajaxOutput() {
	global $code, $msg, $data, $respType, $newCrumb, $callback;
	$code = intval($code);
	$msg = (string) $msg;
	Output::out($respType, $code, $msg, $data, $callback, $newCrumb);
	return true;
}
register_shutdown_function('ajaxOutput');
//}}}

//公共参数处理及校验
$respType= isset($_GET['resp_type']) ? $_GET['resp_type'] : Output::TYPE_JSON;
$callback = (Output::TYPE_JSON == $respType && isset($_GET['callback'])) ? $_GET['callback'] : '';

session_start();
$currentUserId = Auth::isLogined();
if (!$currentUserId) {
	if (!@in_array(str_replace($_SERVER['DOCUMENT_ROOT'], '', $_SERVER['SCRIPT_FILENAME']), $NO_LOGIN_AJAX_URLS)) {
		$code = 2;
		$msg = '需要重新登录';
		die;
	}
} else {
	$currentUserInfo = Auth::getCurrentUser();
	Template::assign(array(
		'currentUser'	=> $currentUserInfo,
	));
}

