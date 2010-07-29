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
 * Name:     age<br>
 * Date:     2008-11-16
 * Purpose:  get age by birthday
 * Input:    birthday date 
 * Example:  {$birthday|age}
 * @version 1.0
 * @param 	(int)	$birthday	| 出生日期
 * @return 	(int)	年龄
 */
function smarty_modifier_age( $birthday )
{
	$b = explode('-' , $birthday);
	$age = date('Y') - $b[0];
	return intval($age);
}

?>
