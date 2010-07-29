<?php
/**
 * Smarty plugin
 * @package Smarty
 * @subpackage plugins
 */


/**
 * Smarty {footer} block plugin
 *
 * Name:     		footer<br>
 * Purpose:  		提供统一页头
 * @link 
 * @author 		Yancan <yancan@staff.139.com>
 * @param 		array
 * @param 		Smarty
 * 
 */

function smarty_block_footer($params, $content, &$smarty, &$repeat) {
	if($repeat)
		return;

	$conf	= MI::get('config');
	$tpl	= TPL_COMPILED_DIR . "/footer.tpl";

	$key 	= 'ui:ver';
	$ver 	= apc_fetch($key);
	$cache	= MI_Cache::instance($conf->config_server);
	$newVersion = $cache->get($key);
	$hited	= 0;
	if(((false === $newVersion /*cache down*/) or ($newVersion == $ver)) and 
		is_file($tpl) and empty($conf->ui_debug)) {
		$res 	= file_get_contents($tpl);
		$hited	= 1;
	} else {
		$api	= $conf->global['api:ui_url'];
		$vip	= new MI_For("$api?method=ui.footer&v=1&prop=standard", array('vipconf' => $conf->global));
		$res	= $vip->request('GET');
		if(!empty($res)) {
			$res = $res->getBody();
			file_put_contents($tpl, $res);
		}
		apc_store($key, $newVersion);
	}

	return "$res\n<!--cache-$hited-->\n";
}
