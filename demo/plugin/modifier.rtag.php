<?php
/**
 * Smarty plugin
 * @package Smarty
 * @subpackage plugins
 * @author seek@jiwai.com
 */


/**
 * Smarty page modifier plugin
 *
 * Type:     modifier<br>
 * Name:     page<br>
 * Date:     JUNE 28, 2008
 * Example:  {$count|page:20}
 * @version 1.0
 * @param 	(int)	$count	| 分页的总数
 * @param 	(int)	$page_size		| 每页多少条记录
 * @return 	(String)	分页字符串
 */
function smarty_modifier_rtag( $string )
{
    return strip_tags($string);
}

?>
