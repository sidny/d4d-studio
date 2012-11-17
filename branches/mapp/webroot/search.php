<?php
//ini_set("display_errors" ,1 );
require_once($_SERVER['DOCUMENT_ROOT'] . '/../init.inc.php');
$params = 'zhao';//搜索关键词
$indexSearch = ContentList::search($params);
Template::assign('indexType',$indexSearch);
Template::display('search.tpl');