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
 * Name:     page<br>
 * Date:     JUNE 19, 2008
 * Purpose:  get page list by count
 * Input:    count int 
 * Input:    page_size int 
 * Example:  {$count|page:20}
 * @version 1.0
 * @param 	(int)	$count	| 分页的总数
 * @param 	(int)	$page_size		| 每页多少条记录
 * @return 	(String)	分页字符串
 */
function smarty_modifier_page( $count, $page_size=20)
{
	$count = intval($count);
	$page_size = intval($page_size);
    $pager = new Pager(array(
		'rowCount' => $count,
		'pageSize' => $page_size,
		));
	return $pager->genYuan();
}

?>
