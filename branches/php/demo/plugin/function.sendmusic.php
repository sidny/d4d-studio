<?php
/**
 * Smarty plugin
 * @package Smarty
 * @subpackage plugins
 */


/**
 * Smarty {sendmusic} function plugin
 *
 * Type:     		function<br>
 * Name:     		sendmusic<br>
 * Purpose:  	"送歌"按钮, 连同脚本过程及对话框
 * 
 * @author 		XU Jian <xujianmac@gmail.com>
 * @param 		array
 * @param 		Smarty
 
 * 
 */
function smarty_function_sendmusic($params, &$smarty)
{
	global $current_user_id;
	$number = $params['number'];
	if(!isset($number)){
		$smarty->trigger_error('Smarty plugin confirm error: parameter "number" expected.'); 
	}
	
	$title = $params['title'];
	if(!isset($title)){
		$title = '(未知)';
	}
	
	$artist = $params['artist'];
	if(!isset($artist)){
		$artist = '(未知)';
	}
	
	$method = $params['method'];
	if(!isset($method) || $method == ''){
		$method = 'light';
	}
	//送歌的link文字
	$text = isset($params['text'])?$params['text']:'';
	
	//送歌的css class
	$cssclass = isset($params['class'])?$params['class']:'';
	
	$oncomplete = $params['oncomplete'];
	if(!isset($oncomplete) || $oncomplete == '') {
		$oncomplete = 'void(0);';
	}
	
	$html = Template::RequireJsCode('<link href="'.Asset::GetAssetUrl('/css/components/matchbox.css').'" rel="stylesheet" type="text/css" />');
	$html .= "<a  title=\"送歌\"  href=\"javascript:void(0);\" onclick=\"__openSendMusicDialog('$number', '$title', '$artist')\" class=\"$cssclass\">$text</a>";	
	$script = <<< EOF
<script type="text/javascript">
function __openSendMusicDialog(number, title, artist){
	$('#sendmusic-dialog').dialog({title: '送歌'});
	$('#jquery-interactive-box form input[name="music_id"]').val(number); 
	$('#jquery-interactive-box .song-title').text(title); 
	$('#jquery-interactive-box .song-artist').text(artist); 
	$('#jquery-interactive-box .matchbox').matchbox({name: 'friend_id', userid: $current_user_id});
	$('#jquery-interactive-box form input.default').unbind('click');
	$('#jquery-interactive-box form').ajaxForm({
		befroeSumit: function(){
			if(!$('#jquery-interactive-box form input[name="friend_id"]').val()){
				alert('请选择朋友');
				return false
			}
		},
		success: function(r){
			if(r.substr(0,1)=='0'){
				$('#jquery-interactive-box').hide();
				$.alert('送出了一首歌');
			}else{
				alert(r.substr(2));
				$(this).attr('disabled', false);
			}
		}
	});
}
</script>
EOF;
	$script = Template::RequireJsCode($script);
	Template::ScriptHolder('', $script);

	$html_dialog = '<div id="sendmusic-dialog" style="display:none;">';
	$html_dialog .= Template::Render( 'section/music_send_user.tpl');
	$html_dialog .= '</div>';

	$html_dialog = Template::RequireJsCode($html_dialog);
	Template::ScriptHolder('', $html_dialog);

	$script = Template::RequireJs('/scripts/jquery.matchbox.js');
	$script .= Template::RequireJs('/scripts/jquery.peoplepicker.js');

	Template::ScriptHolder('', $script);
	
	return $html;
}
?>
