<?php
/**
 * Smarty plugin
 * @package Smarty
 * @subpackage plugins
 */


/**
 * Smarty {quikedit} function plugin
 *
 * Type:		function<br>
 * Name:		quikedit<br>
 * Date:		Mon. Sep 15, 2008<br>
 * Purpose:	 eidt-in-place效果, 直接编辑页内的文本内容(类似flickr.com的直接编辑照片标题、照片说明并保存)
 * Examples:	<{quikedit target="#phototitle"}>
 * Output:		<div id='phototitle-quickedit'>
 						<script .....>
 * @link
 * @author		许健
 * @version		1.0
 * @param		array
 * @param		Smarty
 * @return		HTML to render the quikedit front-end component
 * 
 */


function smarty_block_quickedit($params, $content, &$smarty, &$repeat)
{
	if(!$repeat)
	{
		$target = $params['target'];
		
		if(!isset($target)){
			$smarty->trigger_error('Smarty plugin "quickedit" error: parameter "target" expected.'); 
		}
		
		if(strpos($target, '#') == 0) $target = substr($target, 1);
	
		$action = $params['action'];
		if(!isset($action)){
			$smarty->trigger_error('Smarty plugin "quickedit" error: parameter "action" expected.'); 
		}
	
		$name = $params['name'];
		if(!isset($name)){
			$name = 'content';
		}
	
		$maxlength = $params['maxlength'];
	
		$scale = $params['scale'];  // may be: input, single, multiple, textarea
		if(!isset($scale)) $scale = 'text';
	
		$oncomplete = $params['oncomplete'];
		
		$html .= '<div id="'.$target.'-quickedit" class="quickedit" style="display:none;">';
		$html .= '<form id="'.$target.'-quickedit-form" name="'.$target.'-form" method="POST" action="'.$action.'">';
		$html .= '<input type="hidden" name="ajax" value="1" /> ';
		$html .= $content; // 写入需要追加的input type=hidden
		if(in_array($scale, array('multiple', 'textarea')))	$html .= '<textarea id="'.$target.'-quickedit-content" name="'.$name.'" class="edit" maxlength="'.$maxlength.'"></textarea>';
		else $html .= '<input id="'.$target.'-quickedit-content" name="'.$name.'" class="edit" maxlength="'.$maxlength.'" value="" autocomplete="off" />';
		$html .= '<div class="buttons">';
		$html .= '<div class="floatright error" id="'.$target.'-quickedit-error"></div> ';
		$html .= '<input type="submit" id="'.$target.'-quickedit-submit" value="确定" class="default" /> ';
		$html .= '<a id="'.$target.'-quickedit-cancel" href="cancel" />取消</a>';
		$html .= '</div>';
		$html .= '</form>';
		$html .= '</div>';
		$script .= '<script type="text/javascript" src="'.JWAsset::GetAssetUrl('/lib/jquery/jquery.form.js').'"></script>';
		$script .= '<script type="text/javascript" src="'.JWAsset::GetAssetUrl('/scripts/jquery.quickedit.js').'"></script>';
		$script .= '<script type="text/javascript">';
		$script .= '$(\'#'.$target.'\').quickedit({action:\''.$action.'\'';
		if(isset($oncomplete)) $script .= ', oncomplete: function(){eval(\''. $oncomplete .'\');}';
		$script .= '});';
		$script .= '</script>';
		
		JWTemplate::ScriptHolder('', $script);

		return $html;
	}
}
?>
