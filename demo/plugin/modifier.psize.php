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
 * Name:     psize<br>
 * Date:     Oct 14, 2008
 * Purpose:  get size of picture
 * Example:  {$url|psize:0}
 * @version 1.0
 * @param 	(string)	$url| 图片的url地址
 * @param 	(int)	$type| 需要返回的类型：0表示宽，1表示高
 * @return 	(int)	返回指定类型的大小
 */
function smarty_modifier_psize($url, $type=0 )
{
	$size = JWPicture::GetSize($url, $type);
	if(0==$type)
		return $size['width'];
	else
		return $size['height'];
}
