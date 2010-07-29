<?php
/**
 * Smarty plugin
 * @package Smarty
 * @subpackage plugins
 * @author wqsemc@gmail.com
 */


/**
 * Smarty page modifier plugin
 *
 * Type:     modifier<br>
 * Name:     ta<br>
 * Date:     Nov 7th, 2008
 * Purpose:  get size of picture
 * Example:  {$url|psize:0}
 * @version 1.0
 * @param 	(string)	$type | 性别
 * @return 	(string)	返回指定称谓
 */
function smarty_modifier_ta($type)
{
	return LMUser::GetTaNameByType($type);
}
