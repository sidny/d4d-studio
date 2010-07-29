<?php
/**
 * Smarty plugin
 * @package Smarty
 * @subpackage plugins
 * @author wqsemc@gmail.com
 */


/**
 * Smarty ulogo modifier plugin
 *
 * Type:     modifier<br>
 * Name:     ulogo<br>
 * Date:     Nov 5th, 2008
 * Purpose:  get user avatar full path by id
 * Input:    string file info 
 * Input:	 string size need
 * Example:  {$var|ulogo:'48x48'}
 * @version 1.0
 * @param 	(String)	$file_info | 头像info, 格式(用户id_logo名称), 例如1_2.jpg
 * @param 	(String)	$size		| 可选,格式(长,宽)
 * @return 	(String)	full path
 */
function smarty_modifier_ulogo($file_info = '', $size='48x48' , $reg=1)
{
	return Asset::GetUrlByName($file_info, $size, 'avatar', $reg);
}
