<?php
/**
 * Smarty plugin
 * @package Smarty
 * @subpackage plugins
 */


/**
 * Smarty {editor} block plugin
 *
 * Type:		block<br>
 * Name:		editor<br>
 * Date:		Wed. July 2, 2008<br>
 * Purpose:	provide a common web text editor in web page
 * 
 * Examples:	<{editor name=content}>Content goes here.<{/editor}>
 * Output:		<script src=..... />
 * 					<textarea name="content">Content goes here.</textarea>
 * 					<iframe src=".....".... />
 * 					<script ....></script>
 * @link
 * @author		XU Jian
 * @version		1.0
 * @param		array
 * @param		Smarty
 * @return		HTML to render a editor box(iframe)
 * 
 */


function smarty_block_editor($params, $content, &$smarty, &$repeat)
{
	if(!$repeat)
	{
		$name = $params['name'];
		$width = $params['width'];
		$height = $params['height'];
		
		if (!isset($name) || empty($name)) {
			$smarty->trigger_error('Smarty plugin editor error: parameter "name" expected.'); 
		}
		
		if (!isset($width) || empty($width)) {
			$width = '';
		}
		
		if (!isset($height) || empty($height)) {
			$height = '300';
		}
		
		$url 		= 'http://' . $_SERVER['HTTP_HOST'];
		preg_match_all("(\w{1,}\.\w{2,3}$)", $_SERVER[HTTP_HOST], $result);
		$domain 	= $result[0];
		$configJs 	= Asset::GetAssetUrl('/lib/fckeditor/myconfig.js');
		
		if (strpos($_SERVER['HTTP_USER_AGENT'], 'MSIE')) {
			$js = Asset::GetAssetUrl('/lib/fckeditor/fckeditor.js');
			$script = '<script type="text/javascript">(function(){var s=document.createElement("script"); s.setAttribute("src", "'.$js.'");document.write(s.outerHTML);})();</script>';
		}else{
			$script = '<script type="text/javascript" src="'.Asset::GetAssetUrl('/lib/fckeditor/fckeditor.js').'"></script>';
		}
		$html .= '<textarea name="'.$name.'" rows="10" cols="80" style="width: 100%; height: 200px">';
		$html .= htmlspecialchars($content);
		$html .= '</textarea>';
		$script .= '<script type="text/javascript">';
		$script .= '(function(){';
		// $script .= 'document.domain = "'.$domain[0].'";';
		$script .= 'var sBasePath = "'.$url.'/fckeditor/";';
		$script .= 'var oFCKeditor = new FCKeditor("'.$name.'");';
		$script .= 'oFCKeditor.BasePath = sBasePath;';
		$script .= 'oFCKeditor.Config["CustomConfigurationsPath"] = "' . $configJs . '";';
		$script .= 'oFCKeditor.ToolbarSet = "139";';
		if($width != '') $script .= 'oFCKeditor.Width = '.$width.';';
		$script .= 'oFCKeditor.Height = '.$height.';';
		$script .= 'oFCKeditor.Debug = true;';
		$script .= 'oFCKeditor.ReplaceTextarea();';
		$script .= '})();';
		$script .= '</script>';
		$script .= "\n";
		Template::ScriptHolder('', $script);

		return $html;
	}
}
?>
