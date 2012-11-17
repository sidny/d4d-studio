<?php
require_once($_SERVER['DOCUMENT_ROOT'] . '/../init.inc.php');
$userList = AdminUser::getList();
Template::assign('userlist',$userList);
Template::display('ht/module/admins.tpl');