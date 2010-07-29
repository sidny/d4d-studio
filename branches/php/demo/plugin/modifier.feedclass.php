<?php
/**
 * Smarty plugin
 * @package Smarty
 * @subpackage plugins
 * @author yancan@aspire-tech.com
 */


/**
 * Smarty feed claass modifier plugin
 *
 * Type:     modifier<br>
 * Name:     feedclass<br>
 * Date:     JUNE 28, 2008
 * Purpose:  get feed classname by feedType
 * Input:    feedType
 * Example:  {$feedType|feedclass}
 * @version 1.0
 * @param 	(int)	$feedType 
 * @return 	(String) classname	
 */
function smarty_modifier_feedclass($feedType)
{
	$classIndex = array();
	$classIndex[LMFeed::FEEDTYPE_BLOG] 		= "type-article";	//博客显示的div类型
	$classIndex[LMFeed::FEEDTYPE_STATE] 	= "type-state";		//修改状态的div类型
	$classIndex[LMFeed::FEEDTYPE_ALBUM] 	= "type-photo";		//相册显示的div类型
	$classIndex[LMFeed::FEEDTYPE_FRIENDS] 	= "type-friend";	//好友显示的div类型
	$classIndex[LMFeed::FEEDTYPE_DATA] 		= "type-state";		//更新显示的div类型
	$classIndex[LMFeed::FEEDTYPE_GROUGS] 	= "type-group";		//圈子显示的div类型
	$classIndex[LMFeed::FEEDTYPE_COMMENT] 	= "type-comment";	//评论显示的div类型
	//如果有其他样式请在这里添加

	return isset($classIndex[$feedType]) ? $classIndex[$feedType] : 'type-comment';
}

