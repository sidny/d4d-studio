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
 * Name:     rand<br>
 * Date:     2009-09-01
 * Purpose:  生成随机数
 * Input:    longip int 
 * Example:  {$type|rand}
 * @version 1.0
 * @return 	(String)	带"."的ip
 */
function smarty_modifier_rand( $to=2, $from=1, $type=0)
{
	$ret = rand($from, $to);
	if(0==$type)
		$ret = intval($rand);
	return $ret;
}
