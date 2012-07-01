<?php
/**
 * Smarty plugin
 * @package Smarty
 * @subpackage plugins
 */


/**
 * Smarty truncate modifier plugin
 *
 * Type:     modifier<br>
 * Name:     truncateuhtmltf8<br>
 * Purpose:  Truncate a string to a certain length if necessary,
 *           optionally splitting in the middle of a word, and
 *           appending the $etc string or inserting $etc into the middle.
 * @link http://smarty.php.net/manual/en/language.modifier.truncateutf8.php
 *          truncate (Smarty online manual)
 * @param string
 * @param integer
 * @param string
 * @param boolean
 * @param boolean
 * @return string
 */
function smarty_modifier_truncatehtmlutf8($string, $length = 80, $etc = '...',
                                                $break_words = false, $middle = false)
{
    if ($length == 0)
        return '';
    
    $string = html_entity_decode($string,ENT_QUOTES,'utf-8');
    $string = strip_tags($string);
    
    mb_internal_encoding("UTF-8");
    if (mb_strlen($string) > $length) {
        //$length -= min($length, mb_strlen($etc));
        if (!$break_words && !$middle) {
            $string = preg_replace('/\s+?(\S+)?$/', '', mb_substr($string, 0, $length+1));
        }
        if(!$middle) {
            return mb_substr($string, 0, $length-1) . $etc;
        } else {
            return mb_substr($string, 0, $length/2) . $etc . mb_substr($string, -$length/2);
        }
    } else {
        return $string;
    }
}

/* vim: set expandtab: */

?>
