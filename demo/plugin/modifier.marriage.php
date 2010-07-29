<?php
/**
 * Smarty plugin
 * @package Smarty
 * @subpackage plugins
 * @author gd0ruyi@gmail.com
 */


/**
 * Smarty page modifier plugin
 *
 * Type:     modifier<br>
 * Name:     marriage<br>
 * Date:     2008-11-16
 * Purpose:  get marriage name by marriage
 * Input:    marriage type id
 * Example:  {$marriage|marriage}
 * @version 1.0
 * @param 	(int)	$marriage	| 血型
 * @return 	(int)	血型名称
 */
function smarty_modifier_marriage( $marriage )
{
	$marriage_array = array('单身', '热恋中', '已婚', '寻求真爱中');
	return $marriage_array[$marriage ];
}

?>
