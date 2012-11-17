<?php
/**
 * Smarty plugin
 * @package Smarty
 * @subpackage plugins
 * @author Rejoy.li
 */


/**
 * Smarty date modifier plugin
 *
 * Type:     modifier<br>
 * Name:     ymd<br>
 * Date:     JUNE 14, 2008
 * Purpose:  format time as human readable
 * Input:    time
 * Example:  {$time|htime:"name"}
 * @version 1.0
 * @param 	(String|int)	$time	| 时间
 * @return  String 显示年月日，例如：2008-06-30 
 */
function smarty_modifier_ymdtime( $time)
{
	$time = is_numeric($time) ? $time : strtotime($time);
	return date("Y-m-d",$time);
}
?>
