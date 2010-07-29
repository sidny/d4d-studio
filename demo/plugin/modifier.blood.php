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
 * Name:     blood<br>
 * Date:     2008-11-16
 * Purpose:  get blood name by blood
 * Input:    blood type id
 * Example:  {$blood|blood}
 * @version 1.0
 * @param 	(int)	$blood	| 血型
 * @return 	(int)	血型名称
 */
function smarty_modifier_blood( $blood )
{
	$blood_array = array('O型', 'A型', 'B型', 'AB型', '其他');
	return $blood_array[$blood ];
}

?>
