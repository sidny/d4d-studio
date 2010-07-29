<?php
/**
 * Smarty plugin
 * @package Smarty
 * @subpackage plugins
 */


/**
 * Smarty {matchbox} function plugin
 *
 * Type:		function<br>
 * Name:		matchbox<br>
 * Date:		Tue. Sep 9, 2008<br>
 * Purpose:	 显示一个“姓名查询器”, 输入汉字、汉语拼音关键字, 向后端查询好友姓名, 显示下拉菜单并可选择输入
 * Examples:	<{matchbox name="recipients"}>
 * Output:		<script src=..... />
 						<link type=.... />
 * 						<div class="matchbox">
 							<input type="hidden" name="recipients" />
 						</div>
 * 						<script ....></script>
 * @link
 * @author		许健
 * @version		1.0
 * @param		array
 * @param		Smarty
 * @return		HTML to render the matchbox front-end component
 * 
 * history:
 		Thu. 2008-11-13 许健 + People Picker 
 */


function smarty_function_matchbox($params, &$smarty)
{
	$name = $params['name'];
	if(!isset($name)){
		$smarty->trigger_error('Smarty plugin sprite error: parameter "name" expected.'); 
	}
	
	$userid = $params['userid'];
	if(!isset($userid)){
		$smarty->trigger_error('Smarty plugin sprite error: parameter "userid" expected.'); 
	}
	
	if(!isset($params['groupid'])){
		$groupid = 0;
	}
	else
		$groupid = $params['groupid'];
	
	$limit = $params['limit'];
	
	$width = $params['width'];
	if(!isset($width) || $width == '') {
		$width = '400';
	}
	
	$exclude = $params['exclude'];
	
	$height = $params['height'];
	if(!isset($height) || $height == '') {
		$height = '18';
	}
	
	$paging = $params['paging'];
	if(!isset($paging) || $paging == '') {
		$paging = 'true';
	}
	
	$layout = $params['layout'];
	
	$queryurl = $params['queryurl'];
	
	$filter = $params['filter']; // group, online...
	
	
	$html = '<link href="'.JWAsset::GetAssetUrl('/css/components/matchbox.css').'" rel="stylesheet" type="text/css" />';
	$htlm .= "\n";
	$html .= '<div title="请输入好友姓名，支持全拼、中文、首字母模糊输入" class="floatleft" style="width:'.$width.'px"><div id="jquery-matchbox-'.$name.'" class="matchbox"></div></div>';
	
	$script .= '<script type="text/javascript" src="'.JWAsset::GetAssetUrl('/scripts/jquery.matchbox.js').'"></script>';
	$script .= "\n";
	$script .= '<script type="text/javascript" src="'.JWAsset::GetAssetUrl('/scripts/jquery.peoplepicker.js').'"></script>';
	$script .= "\n";
	$script .= '<script type="text/javascript">';
	$script .= '$(\'#jquery-matchbox-'.$name.'\').matchbox({name: "'.$name.'", userid:"'.$userid.'", groupid:"'.$groupid.'"';
	if(isset($limit) && is_numeric($limit)) $script .= ', limit: ' .$limit;
	if(isset($layout) && $layout == 'floating') $script .= ', layout: "floating"';
	if(isset($exclude)) $script .= ', exclude: "' .$exclude .'"';
	if(isset($filter)) $script .= ', filter: "' .$filter .'"';
	if(isset($filter)) $script .= ', paging: "' .$paging .'"';
	if(isset($queryurl)) $script .= ', queryUrl: "' .$queryurl.'"';
	$script .= '});';
	$script .= '</script>';
	$script .= "\n";
	JWTemplate::ScriptHolder('', $script);
	
	
	return $html;
}
?>
