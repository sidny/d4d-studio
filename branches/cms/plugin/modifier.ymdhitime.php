<?php
/**
 * Smarty plugin
 * @package Smarty
 * @subpackage plugins
 * @author Rejoy.li
 */


/**
 * Smarty datetime modifier plugin
 *
 * Type:     modifier<br>
 * Name:     ymdhi<br>
 * Date:     JUNE 14, 2008
 * Purpose:  format time as human readable
 * Input:    time
 * Example:  {$time|htime:"name"}
 * @version 1.0
 * @param 	(String|int)	$time	| 时间
 * @return  String 显示年月日时分，例如：2008-06-30 17:45 
 */
function smarty_modifier_ymdhitime( $time)
{
	$time = is_numeric($time) ? $time : strtotime($time);
	return date("Y-m-d H:i",$time);
}
?>
