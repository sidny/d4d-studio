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
 * Name:     		conf<br>
 * Purpose:  	get key  of config
 * @link 
 * @author 		Yancan <yancan@staff.139.com>
 * @param 		array
 * @param 		Smarty
 */
function smarty_function_conf($params, &$smarty)
{
	if(!isset($params['key']) or empty($params['key']))
		return null;

	$key = $params['key'];
	$conf = MI::get('config');
	return $conf->global[$key];
}
