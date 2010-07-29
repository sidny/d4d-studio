<?php
/**
 * Smarty plugin
 * @package Smarty
 * @subpackage plugins
 * @author yancan@aspire-tech.com
 */


/**
 * Smarty ad modifier plugin
 *
 * Type:     modifier<br>
 * Name:     ad<br>
 * Date:     JUNE 28, 2008
 * Purpose:  display ad
 * Example:  {'2'|ad}
 * @version 1.0
 * @param 	(int)	$sid spaceid
 * @return 	(String) ad code
 */
function smarty_modifier_ad($sid)
{
	//$js 	= smarty_modifier_formaturl('/scripts/bd.js');

	$advstr = JWTemplate::Render("wptpl/advertiseposition/{$sid}.tpl");
	//$content = preg_replace("/\n/","",$advstr);
	$content =  $advstr;

	return $content;
}

