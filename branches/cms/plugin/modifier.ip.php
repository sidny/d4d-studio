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
 * Name:     ip<br>
 * Date:     2008-7-1
 * Purpose:  显示ip
 * Input:    longip int 
 * Example:  {$longip|ip}
 * @version 1.0
 * @return 	(String)	带"."的ip
 */
function smarty_modifier_ip( $longip)
{
	return long2ip($longip);
}

?>
