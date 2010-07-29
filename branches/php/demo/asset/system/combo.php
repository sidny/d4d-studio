<?php
require(dirname(__FILE__) . "/../asset.inc.php");

$assetPath 	= PUB_ROOT . 'domain/asset/';
$files 		= $_SERVER['REQUEST_URI'];

$split		= '__';
$str		= '';
$len		= 7; // len for '/combo/'
$file		= md5($files);
$real		= "/Data/webapps/storage/combine/$file";
$alias		= "/combine/$file";

list($files) = explode('?', $files);
$tmp		= substr($files, $len);
$tmp		= ltrim(strstr($tmp, '/'), '/');
$files		= explode($split, $tmp);

header('Content-Type: '.JWUtility::GetMimeType($assetPath . $files[0]));

if(file_exists($real)) {
	$mtime 	= filemtime($real);
	$old	= false;
	foreach($files as $k=>$v) {
		if(is_numeric($v) or empty($v))
		{
			unset($files[$k]);
			continue;
		}

		$filepath = $assetPath . $v;
		if(!is_file($filepath))
			die;

		if(filemtime($filepath) > $mtime) {
			$old = true;
			break;
		}
	}

	if(!$old) {
		header("X-Accel-Redirect: $alias");
		die;
	}
} 

$tmp = tempnam('/tmp', 'combo');
foreach($files as $k => $v) 
	$files[$k] = escapeshellcmd($assetPath . $v);

system("cat " . join(' ', $files) . " > $tmp 2>/dev/null");
rename($tmp, $real);

header("X-Accel-Redirect: $alias");
