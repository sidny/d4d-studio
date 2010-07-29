<?php
/**
 * Smarty plugin
 * @package Smarty
 * @subpackage plugins
 */


/**
 * Smarty {vaidate} function plugin
 *
 * Type:     		function<br>
 * Name:     		validate<br>
 * Purpose:  	validate a form input field with pattern, includes
 						required, range, regex, custom
 * @link 
 * @author 		许健 <jessexu@gmail.com>
 * @param 		array
 * @param 		Smarty
 
 * history:
 		2008-11-3 许健 created
 		2008-11-3 许健 实现required
 		2008-11-5 许健 实现regex
 		
 */
function smarty_function_validate($params, &$smarty)
{

	$js_data = $params;
	$field = $params['field'];
	if(!isset($field)) {
		$smarty->trigger_error('Smarty plugin validte error: parameter "field" expected.'); 
	}
	
	$type = $params['type'];
	if(!isset($type) || $type == '') {
		$js_data['type'] = 'required';
	}
	
	$version = $params['version'];
	if(!isset($version) || $version == '') {
		$version = '0';
	}
	unset($js_data['version']);
	if($type == 'regexp') $js_data['type'] = 'regex';
	
	if(!in_array($type, array('required', 'regex', 'custom'))) {
		$smarty->trigger_error('Smarty plugin validte error: parameter "type" invalid or not supported.'); 
	}
	
	// data表示多种意义, 正则表达式内容, 比较字符串, 范围表达式
	
	$method = $params['method'];
	if(!isset($method) || $method == '') {
		$js_data['method'] = 'default';
	}
	
	$onfail = $params['onfail'];
	
	// attribute : lazy, 表示是否等到form开始submit才检查
	$lazy = $params['lazy'];
	if(!isset($lazy) || $lazy == '') {
		$lazy = 'true';
	}
	if(in_array($lazy, array('no', '0'))) $lazy = 'false';
	else $lazy = 'true'; 
	$js_data['lazy'] = $lazy;
		
	// 处理field, 用于给定field是form element name的情况
	if(substr($field, 0, 1) != '.' && substr($field, 0, 1) != '#') $field = ":input[name='$field']";

	// 实现了经Script Holder处理的优化方案
	if($version == '1'){
		$script =	Template::RequireJs('/core/js/jquery/validate/jquery.validate.js').
			Template::RequireJs('/core/js/jquery/bt/jquery.bt.js');
	}else{
		$script  = Template::RequireJs('/scripts/jquery.validate.js');
	}
	$html .= '$(function(){';
	$html .= '$("'.$field.'").validate(';
	$html .= json_encode($js_data);
	
	$html .= ');});';
	Template::AddJsCode( $html);
	Template::ScriptHolder('',$script);
	
	return ''; //$html;
}


?>
