<?php
/**
 * Smarty plugin
 * @package Smarty
 * @subpackage plugins
 */


/**
 * Smarty {header} block plugin
 *
 * Name:     		header<br>
 * Purpose:  		提供统一页头
 * @link 
 * @author 		Yancan <yancan@staff.139.com>
 * @param 		array
 * @param 		Smarty
 * 
 */

function smarty_block_header($params, $content, &$smarty, &$repeat) {
	if($repeat)
		return;

	$holder = '<!--headHolder-->';
	$prop 	= $params['prop'];
	$conf	= MI::get('config');
	$tpl	= TPL_COMPILED_DIR . "/header.$prop.tpl";

	$key 	= 'ui:ver';
	$ver 	= apc_fetch("$key:$prop");
	$cache	= MI_Cache::instance($conf->config_server);
	$newVersion = $cache->get($key);
	$hited	= 0;
	if(((false === $newVersion /*cache down*/) or ($newVersion == $ver)) and 
		is_file($tpl) and empty($conf->ui_debug)) {
		$res 	= file_get_contents($tpl);
		$hited	= 1;
	} else {
		$api	= $conf->global['api:ui_url'];
		$vip	= new MI_For("$api?method=ui.header&v=1&prop=$prop", array('vipconf' => $conf->global));
		$res	= $vip->request('GET');
		if(!empty($res)) {
			$res = $res->getBody();
			file_put_contents($tpl, $res);
		}
		apc_store("$key:$prop", $newVersion);
	}

	$res	= str_replace($holder, $content, $res);
	if(function_exists('headerFilter'))
		$res = headerFilter($res);
	return "$res\n<!--ui:ver-$ver cache-$hited-->\n";
}
