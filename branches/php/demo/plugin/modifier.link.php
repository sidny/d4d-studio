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
 * Name:     link<br>
 * Date:     Nov 15th, 2008
 * Purpose:  get link by string
 * Example:  {$id|link:'888'}
 * @version 1.0
 * @param 	(string)	$str | url参数对应的值
 * @param 	(string)	$val | url参数对应的值
 * @return 	(String)	生成的url
 */
function smarty_modifier_link( $str, $val, $ignore='')
{
    $pager = new JWPager(array());
	return $pager->genLink($str, $val, $ignore);
}

?>
