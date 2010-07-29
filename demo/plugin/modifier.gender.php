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
 * Name:     gender<br>
 * Date:     Nov 7th, 2008
 * Purpose:  get size of picture
 * Example:  {$url|psize:0}
 * @version 1.0
 * @param 	(string)	$gender| 性别
 * @return 	(string)	返回指定性别
 */
function smarty_modifier_gender($type )
{
	return LMUser::GetGenderNameByType($type);
}
