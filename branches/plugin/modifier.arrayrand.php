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
 * Name:     arrayrand<br>
 * Date:     2009-09-01
 * Purpose:  生成随机数
 * Input:    longip int 
 * Example:  {$type|rand}
 * @version 1.0
 * @return 	(String)	带"."的ip
 */
function smarty_modifier_arrayrand( $to=3, $from=1, $num=2)
{
	$arr = range($from, $to);
	shuffle($arr);
	$ret = array_slice($arr, 0, $num);
	return implode(',', $ret);
}
