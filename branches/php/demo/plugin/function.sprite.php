<?php
/**
 * Smarty plugin
 * @package Smarty
 * @subpackage plugins
 */


/**
 * Smarty {sprite} function plugin
 *
 * Type:     		function<br>
 * Name:     		sprite<br>
 * Purpose:  		将"中间页"显示在on-the-fly的dynamic div中, 
 						包含用于显示/隐藏的脚本过程, 
 						在保持原"大页面“原状的情况下, 加载需要操作的用户界面(由link的href指定),
 						实现及流程类似于Smarty plugin: Confirm
 * @link 
 * @author 		XU Jian <jessexu@gmail.com>
 * @param 		array
 * @param 		Smarty
 
 * 
 */
function smarty_function_sprite($params, &$smarty)
{
	$link = $params['link'];
	if(!isset($link)){
		$smarty->trigger_error('Smarty plugin sprite error: parameter "link" expected.'); 
	}
	
	$width = $params['width'];
	if(!isset($width) || $width == '') {
		$width = '400';
	}
	
	$height = $params['height'];
	if(!isset($height) || $height == '') {
		$height = '300';
	}
	
	$oncomplete = $params['oncomplete'];
	if(!isset($oncomplete) || $oncomplete == '') {
		$oncomplete = 'function(){ return;}';
	}else{
		if(strchr($oncomplete, '(') || strchr($oncomplete, 'return')) $oncomplete = 'function(){'.$oncomplete.'}';
	}
	
	$onload = $params['onload'];	
	$onunload = $params['onunload'];	
	$onabort = $params['onabort'];	
	$onerror = $params['onerror'];
	$onrequirevalidate = $params['onrequirevalidate'];

	$title = $params['title'];
	$mask = $params['mask'];
	
	$script = Template::RequireJs('/lib/jquery/jquery.form.js');
	$script .= "\n";
	$script .= '<script type="text/javascript">';
	$script .= '$(\''.$link.'\').sprite(';
	$script .= '{title: "'.$title.'" ';
	$script .= ', oncomplete: '.$oncomplete;
	if(isset($mask)) $script .= ', mask: '.$mask;
	if(isset($onload)) $script .= ', onload: '.$onload;
	if(isset($onunload)) $script .= ', onunload: '.$onunload;
	if(isset($onrequirevalidate)) $script .= ', onrequirevalidate: '.$onrequirevalidate;

	if(isset($onabort)) $script .= ', onabort: function(r){'.$onabort.'}';
	if(isset($onerror)) $script .= ', onerror: function(r){'.$onerror.'}';
	$script .= '});';
	$script .= '</script>';
	$script .= "\n";
	
	Template::ScriptHolder('', $script);
	return '';
}


?>
