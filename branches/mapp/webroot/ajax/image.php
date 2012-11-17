<?php
require($_SERVER['DOCUMENT_ROOT'] . '/../ajax.inc.php');
$act = $_REQUEST['act'];
$code = 0;
$msg = '操作成功';
global $currentUserInfo;
switch ($act) {
    case 'upload'://验证登录
    	$file = Photo::uploadFile('pic');
    	if($file){
    		$msg=$file;
    	}else{
    		$code = 1;
    		$msg = Photo::getError();
    	}
    break;
    default:
    	$code = 1;
    	$msg = '没有这个操作';
}
