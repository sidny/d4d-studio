<?php
require_once($_SERVER['DOCUMENT_ROOT'] . '../init.inc.php');
$table = $_REQUEST['table'];
$result = array();
if($table){
	$db = DataBase::instance(DB_GLOBAL_IP, DB_GLOBAL_PORT, DB_GLOBAL_USER, DB_GLOBAL_PASSWD, DB_GLOBAL_NAME, DB_GLOBAL_LOG);
	$result = $db->excute("select * from yangfan_cmcc");
}

function javaClassName($str='',$type=0){
	$arr = split('_',$str);
	$tmp = "";
	foreach($arr as $i) $tmp .= ucwords($i);
	if($type==1) $tmp[0] = strtolower($tmp[0]);
	return $tmp;
}

function jdbcType($str='',$type=0){
	if(substr($str,0,3) == 'int') return "INTEGER"	;
	if(substr($str,0,7) == 'varchar') return "VARCHAR";
	if(substr($str,0,4) == 'text') return "LONGVARCHAR";
	if(substr($str,0,9) == 'timestamp') return "TIMESTAMP";

	if(substr($str,0,10) == 'tinyint(1)') return "BIT";
	elseif(substr($str,0,7) == 'tinyint') return "TINYINT";
	
	return $str;	
}
function javaType($str='',$type=0){
	if(substr($str,0,3) == 'int') return "Integer"	;
	if(substr($str,0,7) == 'varchar') return "String";
	if(substr($str,0,4) == 'text') return "String";
	if(substr($str,0,9) == 'timestamp') return "Timestamp";

	if(substr($str,0,10) == 'tinyint(1)') return "Boolean";
	elseif(substr($str,0,7) == 'tinyint') return "Short";
	
	return $str;	
}
$tpl = "code/index.tpl";
$type = $_REQUEST['type'];
if ($type){
	$tpl = "code/$type.tpl";
}
$assign = array(
	'table' => $table,
	'result' => $result['data'],
);
header('content-type: text/html');
MI_Template::assign($assign);
if($type){
$code = (MI_Template::fetch($tpl));
//$code = ereg_replace("\n",'<br/>',$code);
//$code = ereg_replace(' ','&nbsp;',$code);
//$code = ereg_replace("\t",'&nbsp;&nbsp;&nbsp;&nbsp;',$code);
echo $code;
}else{
	MI_Template::display($tpl);
}
