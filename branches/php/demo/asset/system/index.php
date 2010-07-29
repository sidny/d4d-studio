<?php
require($_SERVER['DOCUMENT_ROOT'] . "asset.inc.php");

$pathParam = null;
extract($_REQUEST,EXTR_IF_EXISTS);

$pathParam = rtrim(urldecode($_SERVER['QUERY_STRING']));
$pathParam = substr($pathParam, 10, strlen($pathParam));

if ( preg_match('#^(?P<type>\w+)/(?P<id>\d+)/(?P<thumb>\w+)/(?P<file_name>.*?)\.(?P<file_ext>\w+)(?:.*)$#',$pathParam,$matches) )
{
	$type = $matches['type'];
	$thumb = strtolower($matches['thumb']);
	$file_id = $matches['id'];
	$file_name = $matches['file_name'];
	$file_ext = $matches['file_ext'];

	JWPicture::Show($file_id, $thumb, $type, $file_name, $file_ext);
}
else
{
	JWPicture::Show(1, "48x48");
}

die();

