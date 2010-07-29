<?php
/**
 * Smarty plugin
 * @package Smarty
 * @subpackage plugins
 */


/**
 * Smarty {confirm} function plugin
 *
 * Type:     		function<br>
 * Name:     		confirm<br>
 * Purpose:  		为指向"删除"操作的超链接加上"删除确认"过程, 
 						包含用于confirm的脚本过程, 
 						一致且简化的"删除-确认"用户操作流程
 * @link 
 * @author 		XU Jian <jessexu@gmail.com>
 * @param 		array
 * @param 		Smarty
 
 * 
 */
function smarty_function_confirm($params, &$smarty)
{
	$link = $params['link'];
	if(!isset($link)){
		$smarty->trigger_error('Smarty plugin confirm error: parameter "link" expected.'); 
	}
	
	$title = $params['title'];
	if(!isset($title) || $title == ''){
		$title = '确认';
	}
	
	$message = $params['message'];
	if(!isset($message) || $message == ''){
		$message = '确定要进行该操作吗？';
	}
	
	$method = $params['method'];
	if(!isset($method) || $method == ''){
		$method = 'light';
	}
	
	$oncomplete = $params['oncomplete'];
	if(!isset($oncomplete) || $oncomplete == '') {
		$oncomplete = 'return';
	}else{
		// oncomplete pattern: oncomplete给定值的规则
		// 1. single symbol, 单个标识符, 当做callback function name, 例如, afterXxxxxProcedure 不带括号
		// 2. 带括号表达式, 当做JavaScript statement, 输出为anonymous function
		// 3. 带"="或";", 同2
		if(strchr($oncomplete, '(') || strchr($oncomplete, '=') || strchr($oncomplete, ';')) $oncomplete = 'function(){'.$oncomplete.'}';
	}
	
	$script = '';
	$script .= '<script type="text/javascript">';
	$script .= '$("'.$link.'").confirm("'.$message.'", {title:"'.$title.'",oncomplete : '.$oncomplete.'});';
	$script .= '</script>';
	$script .= "\n";
	JWTemplate::ScriptHolder('', $script);

	return '';
}
?>
