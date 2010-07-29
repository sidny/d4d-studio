<?php
/**
 * Smarty plugin
 * @package Smarty
 * @subpackage plugins
 * @author wqsemc@gmail.com
 */


/**
 * Smarty ulogo modifier plugin
 *
 * Type:     modifier<br>
 * Name:     cardencrypt<br>
 * Date:     Sep 6th, 2009
 * Purpose:  get user avatar full path by id
 * Input:    string uid
 * Example:  {$var|cardencrypt:'1000007'}
 * @version 1.0
 * @param 	(String)	$uid 用户uid
 */
function smarty_modifier_cardencrypt($uid='')
{
	return JWUtility::CardEncrypt($uid);
}
