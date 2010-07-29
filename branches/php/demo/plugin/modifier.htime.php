<?php
/**
 * Smarty plugin
 * @package Smarty
 * @subpackage plugins
 * @author Rejoy.li
 */


/**
 * Smarty humantime modifier plugin
 *
 * Type:     modifier<br>
 * Name:     htime<br>
 * Date:     JUNE 14, 2008
 * Purpose:  format time as human readable
 * Input:    time
 * Example:  {$time|htime:"name"}
 * @version 1.0
 * @param 	(String)	$time	| 时间
 * @return  String humantime
 */
function smarty_modifier_htime( $time  )
{
	return JWUtility::GetHumanTime($time);
}
