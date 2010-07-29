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
 * Name:     inarray<br>
 * Date:     2009-09-01
 * Purpose:  生成随机数
 * Input:    longip int 
 * Example:  {$type|rand}
 * @version 1.0
 * @return 	(String)	带"."的ip
 */
function smarty_modifier_inarray( $val, $values='')
{
	JWDB::CheckInt($val, 1);
	$values = explode(',', $values);
	JWDB::CheckArray($values);
	$ret = in_array($val, $values);
	return $ret;
}

