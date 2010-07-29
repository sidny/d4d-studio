<?php
/**
 * Smarty insert plugin
 * @package Smarty
 * @subpackage plugins
 */


/**
 * Function: smarty_crumb<br>
 *
 * Purpose:  used to make a crumb
 * @author   volcano <volcas at gmail dot com>
 * @return string
 */
function smarty_insert_crumb()
{
        return JWCrumb::GetCrumb();
}

/* vim: set expandtab: */

?>
