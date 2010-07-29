<?php
/**
 * Smarty plugin
 * @package Smarty
 * @subpackage plugins
 * @author wqsemc@jiwai.com
 */


/**
 * Smarty page modifier plugin
 *
 * Type:     modifier<br>
 * Name:     page<br>
 * Date:     JUNE 28, 2008
 * Purpose:  get page list by count
 * Input:    count int 
 * Input:    page_size int 
 * Example:  {$count|page:20}
 * @version 1.0
 * @param 	(int)	$count	| 分页的总数
 * @param 	(int)	$page_size		| 每页多少条记录
 * @return 	(String)	分页字符串
 */
function smarty_modifier_birthday( $birthday , $format)
{
	list($birthday_year, $birthday_month, $birthday_day) = split("-", $birthday, 3);
	$birthday_year = intval($birthday_year);
	$birthday_month= intval($birthday_month);
	$birthday_day= intval($birthday_day);
	if(1908>$birthday_year || 1>$birthday_month || 1>$birthday_day)
		return "";
	if(empty($format)){
           $format='m-d';
     }
	$format = in_array($format, array('Y-m-d', 'm-d','n月j日', 'Y年n月j日')) ? $format : 'Y-m-d';
	$ret = date($format, strtotime($birthday));
	return $ret;
}

?>
