<?php
/**
 * Smarty plugin
 * @package Smarty
 * @subpackage plugins
 * @author peter@jiwai.com
 */


/**
 * 权限控制判断
 *
 * Type:     modifier<br>
 * Input:    access_ids
 * Example:  {$access_ids|$access}
 * @version 1.0
 * @param 	(String)	$access_id	| 权限id
 * @return  String true or false
 */
function smarty_modifier_highlight($s)
{
    $q = isset($_GET['q']) ?
        $_GET['q'] : null;

    $q = JWUtility::BigToGb( $q );
    $q = preg_replace( '/[\(\)\+\s\/]+/', ' ', $q );
    $q = trim($q);
    $q = preg_replace( '/\s+/', '|', $q );

    return preg_replace("/($q)/i", "<font color='#FF0000'>\\1</font>", $s);
}

?>
