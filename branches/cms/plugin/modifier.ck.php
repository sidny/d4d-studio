<?php
/**
 * Smarty plugin
 * @package Smarty
 * @subpackage plugins
 */


/**
 * Smarty {combo} block plugin
 *
 * Type:     block<br>
 * Name:     combo<br>
 * Purpose:  combo css/js url

 * @author yancan <yancan at aspire-tech dot com>
 * @param array
 * @param Smarty
 */
 require_once (CKPATH . '/./ckeditor_php5.php');

function smarty_modifier_ck($id, $name='',$defaultValue ='') {
	if(!$id) return;
	$CKEditor = new CKEditor();

	$CKEditor->basePath = CKBASEPATH;
	$config['toolbar'] = array(
	array( 'Source', '-', 'Bold', 'Italic', 'Underline', 'Strike' ),
	array( 'Image', 'Link', 'Unlink', 'Anchor' )
);
	$config['name'] = $name;
	
	//$CKEditor->returnOutput = true;
	// Create a textarea element and attach CKEditor to it.
	$CKEditor->editor($id, $defaultValue,$config);
	return ''; 
}
?>
