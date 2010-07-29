<?php
/**
 * Smarty plugin
 * @package Smarty
 * @subpackage plugins
 */


/**
 * Smarty {privacee} function plugin
 *
 * Type:     		function<br>
 * Name:     		privacee<br>
 * Purpose:  	
 * @link 
 * @author 		许健 (xujianmac@gmail.com)
 * @param 		array
 * @param 		Smarty
 
 * 
 */
function smarty_function_privacee($params, &$smarty)
{
	$link = $params['link'];
	if(!isset($link)){
		$smarty->trigger_error('Smarty plugin privacee error: parameter "link" expected.'); 
	}
	
	$origin = $params['origin'];
	if(!isset($origin)){
		$origin = 'null';
	}
	
	$oncomplete = $params['oncomplete'];
	if(!isset($oncomplete) || $oncomplete == '') {
		$oncomplete = 'function(){ return;}';
	}else{
		if(strchr($oncomplete, '(') || strchr($oncomplete, 'return')) $oncomplete = 'function(){'.$oncomplete.'}';
	}
	
	$onengage = $params['onengage'];
	if(strchr($onengage, '(') || strchr($onengage, 'return')) $onengage = 'function(){'.$onengage.'}';
	$ondismiss = $params['ondismiss'];
	if(strchr($ondismiss, '(') || strchr($ondismiss, 'return')) $ondismiss = 'function(){'.$ondismiss.'}';
	
	
	//var_dump($origin);
	$onload = $params['onload'];	
	$onabort = $params['onabort'];	
	$onerror = $params['onerror'];
	$origin = explode(';',$origin); //var_dump($origin);
	$html = '<link href="'.JWAsset::GetAssetUrl('/css/components/privacy.css').'" rel="stylesheet" type="text/css" />';
	$html .= "\n";
	JWTemplate::Assign('oringin', $origin);
	JWTemplate::Assign('oringin_type', $origin[0]);
	JWTemplate::Assign('oringin_data', $origin[1]);
	$html .= JWTemplate::Render( 'section/privacy_setting.tpl');
	$html = JWTemplate::RequireJsCode($html);
	JWTemplate::ScriptHolder('', $html);
	
	
	$script = JWTemplate::RequireJs('/lib/jquery/jquery.form.js');
	$script .= "\n";
	$script .= <<<EOF
<script type="text/javascript">
EOF;

if(isset($onengage)) $script .= "\n__privacee__onengage = $onengage;";
if(isset($ondismiss)) $script .= "\n__privacee__ondismiss = $ondismiss;";

$script .= <<<EOF

$('$link').click(function(){
	$(this).blur();
	var p = $(this).position();
  $('#privacy-spring').show().css('left', p.left + 44).css('top', p.top - 3);
  __privacee__onengage.call();
	__privacee__oncomplete = $oncomplete;
	window.setTimeout(function(){
		$(window).resize(function(){
			$('#privacy-spring').hide();
		});
	}, 500);
	return false;
});
</script>

EOF;
	
	JWTemplate::ScriptHolder('', $script);
	return '';
}


?>