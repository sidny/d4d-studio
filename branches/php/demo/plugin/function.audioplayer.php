<?php
/**
 * Smarty plugin
 * @package Smarty
 * @subpackage plugins
 */


/**
 * Smarty {audioplayer} function plugin
 *
 * Type:		function<br>
 * Name:		audioplayer<br>
 * Date:		Sat. Nov 12, 2008<br>
 * Purpose:	 外观一致的音乐播放器, 使用WordPress plugin: audio player
 * Examples:	<{audioplayer url="http://...."}>
 * @link
 * @author		许健
 * @version		1.0
 * @param		array
 * @param		Smarty
 * @return		HTML to render the audio player front-end component
 * 
 */


function smarty_function_audioplayer($params, &$smarty)
{
	$name = $params['name'];
	if(!isset($name)){
		$smarty->trigger_error('Smarty plugin audioplayer error: parameter "name" expected.'); 
	}
	
	$url = $params['url'];
	if(!isset($url)){
		$smarty->trigger_error('Smarty plugin audioplayer error: parameter "url" expected.'); 
	}
	
	$titles = $params['titles'];
	$artists = $params['artists'];
	$autostart = $params['autostart'];
	if(in_array($autostart, array('yes', 'true', '1'))){
		$autostart = 'yes';
	}else{
		$autostart = 'no';
	}
	$loop = $params['loop'];
	if(in_array($loop, array('false', 'no', '0'))){
		$loop = 'no';
	}else{
		$loop = 'yes';
	}
	
	$width = $params['width'];
	if(!isset($width)){
		$width = 200;
	}
	
	$html = JWTemplate::RequireJs('/lib/audioplayer.js');
	$html .= '<script type="text/javascript">AudioPlayer.setup("'.JWAsset::GetAssetUrl('/lib/audioplayer.swf').'", { width: '.$width.' }); </script>';
	$html .= '<script type="text/javascript">';
	$html .= "AudioPlayer.embed('audioplayer-$name', {soundFile: '$url', titles: '$titles', artists: '$artists', autostart: '$autostart', loop: '$loop'}); ";
	$html .= '</script>';
	JWTemplate::ScriptHolder('', $html);
	
	return '<div id="audioplayer-'.$name.'"></div>'; //$html;
}
?>
