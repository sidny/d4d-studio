<?php
require_once($_SERVER['DOCUMENT_ROOT'] . '/../config/config.web.php');
session_start();
$currentUserId = Auth::isLogined();
Template::assign(array(
		'currentUserId' => $currentUserId,
	)
);
if (!$currentUserId) {
	if (@in_array(Utility::getPhpUrl(), $LOGIN_URLS)) {
		Utility::Redirect("/ht/login.php");
		die;
	}
} else {
	$currentUserInfo = Auth::getCurrentUser();

	Template::assign(array(
		'currentUser'	=> $currentUserInfo,
	));
}
Template::addJsVars(array(
	'uid'	=> $currentUserId,
	'user'	=> $currentUserInfo,
));
