<?php
/**
 * Smarty plugin
 * @package Smarty
 * @subpackage plugins
 * @author Rejoy.li
 */


/**
 * Smarty date modifier plugin
 *
 * Type:     modifier<br>
 * Name:     rank<br>
 * Date:     JUNE 14, 2008
 * Purpose:  format time as human readable
 * Input:    time
 * Example:  {$time|htime:"name"}
 * @version 1.0
 * $param   int $rank_id 等级值
 * @param 	$type	类型:1：小图；2：大图
 * @return  String 取小图的相对地址
 */
function smarty_modifier_rank( $rank_id, $type='1')
{
	$path = Utility::RankImgurl($rank_id,$type);
	return $path;
}
?>
