<?php
/**
 * Smarty plugin
 * @package Smarty
 * @subpackage plugins
 */


/**
 * Smarty {js} block plugin
 *
 * Name:     		js<br>
 * Purpose:  		提供js合并去重功能
 * @link 
 * @author 		Yancan <yancan@staff.139.com>
 * @param 		array
 * @param 		Smarty
 * 
 */

function smarty_block_jsholder($params, $content, &$smarty, &$repeat) {
	if($repeat)
		return;

	static $cont = array();

	$output	= (isset($params['output']) and $params['output']);
	if($output) {
		if(empty($cont))
			return '';

		if(ASSET_COMBO) {
			$url = "'" . Asset::GetComboUrl(array_keys($cont)) . "'";
		}
		else {
			$js = array();
			foreach ($cont as $key => $value) {
				$js[] = Asset::GetAssetUrl($key);
			}
			$url = json_encode($js);
		}

		return $url;
	}

	if(empty($content))
		return '';

	foreach(explode("\n", $content) as $v) {
		if(empty($v))
			continue;

		$v = trim($v);
		$v = ltrim($v, '/');
		$cont[$v] = 1;
	}
}
