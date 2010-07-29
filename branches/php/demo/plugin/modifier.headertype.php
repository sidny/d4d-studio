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
 * Name:     headertype<br>
 * Date:     Sep 27th, 2009
 * Purpose:  is show simple header
 * Input:    string uid
 * Example:  {''|headertype}
 * @version 1.0
 * @param 	(String)	$url=''
 */
function smarty_modifier_headertype($url='')
{
	return Utility::GetHeaderTypeByUrl($url);
}

