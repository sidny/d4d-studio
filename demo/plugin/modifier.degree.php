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
 * @param 	(int)	$count	| 分页的总数
 * @return 	(String)	分页字符串
 */
function smarty_modifier_degree( $degree )
{
	$degree_array = array('其他','博士', '研究生', '大学', '大专', '中专', '技校', '高中', '初中', '小学');//来源于webroot/p/story_deit.php
	
	return $degree_array[$degree];
}

?>
