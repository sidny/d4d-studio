<?php
require( dirname(__FILE__).'/Smarty-2.6.19/libs/Smarty.class.php' );

if(false==defined('TPL_COMPILED_DIR')) define('TPL_COMPILED_DIR','/tmp');
if(false==defined('TPL_PLUGINS_DIR')) define('TPL_PLUGINS_DIR','/tmp');
if(false==defined('TPL_TEMPLATE_DIR')) define('TPL_TEMPLATE_DIR','/tmp');

class Template{

	static private $mTemplate 	= null;
	static private $_instance	= null;
    static private $_showNotice = true;

	static public $scirptholder = array();

	static private $_csses		= array();
	static private $_jses		= array();
	static private $_jsCodes	= array();	
	static private $_jsVars		= array();

	static function Instance() {
		if(!is_object(self::$_instance))
			self::$_instance = new Template;
		return self::$_instance;
	}

    static function DisableNotice() {
        self::$_showNotice = false;
    }

	static private function GetTemplate(){
		if ( null==self::$mTemplate )
		{
			$smarty = new Smarty();
			$smarty->template_dir = TPL_TEMPLATE_DIR;
			$smarty->use_sub_dirs = defined('TPL_SUB_DIRS') ? TPL_SUB_DIRS : false;
			$smarty->compile_dir = TPL_COMPILED_DIR;
			$smarty->plugins_dir = isset( $GLOBALS['CONFIG_TPLPLUGINS_DIRS'] )?$GLOBALS['CONFIG_TPLPLUGINS_DIRS']:array('plugins' ,TPL_PLUGINS_DIR);
			$smarty->left_delimiter = '<{'; 
			$smarty->right_delimiter = '}>';
            
            /* for convenience */
            /*
			global $current_user_id, $current_user_mobile, $current_user_active, $current_user_province, $current_user_city, $carrytime_beginning, $current_user_info, $current_header_type, $https_to_http;
			$current_error = $current_alert = '';
            if (self::$_showNotice) {
                if(!isset($https_to_http) || 0>=$https_to_http)
                {
                    $current_error = JWSession::GetInfo('error');
                    $current_alert= JWSession::GetInfo('alert');
                }
            }
			//$system_notice = array('type'=>'', 'message'=>'');
			$system_notice = 'null';
			if(!empty($current_alert))
			{
				$system_notice = '{type:\'notice\',message:"'.$current_alert.'"}';

				//$system_notice = array('type'=>'info', 'message'=>$current_alert);
			}
			elseif(!empty($current_error))
			{
				$system_notice = '{type:\'error\',message:"'.$current_error.'"}';

				//$system_notice = array('type'=>'error', 'message'=>$current_error);
			}

	    $smarty->assign('current_header_type', $current_header_type);
            $smarty->assign('current_user_id', $current_user_id);
            $smarty->assign('current_user_info', $current_user_info);
            $smarty->assign('current_user_mobile', $current_user_mobile);
            $smarty->assign('current_user_active', $current_user_active);
            $smarty->assign('current_user_province', $current_user_province);
            $smarty->assign('current_user_city', $current_user_city);
            $smarty->assign('system_notice', $system_notice); 
			$smarty->assign('carrytime_beginning', $carrytime_beginning);
            */
    		if(!isset($current_header_type))
				$current_header_type = Utility::GetHeaderTypeByUrl();
        
			if(isset($_REQUEST['ajax']))
				$smarty->assign('ajax', $_REQUEST['ajax']);

            //$smarty->assign( 'system_notice', json_encode($system_notice)); 
            /* end */

			self::$mTemplate = $smarty;
		}
		return self::$mTemplate;
	}

	static private function CloseTemplate(){
		self::$mTemplate = null;
        self::$_showNotice= true;
	}

	static public function Render( $templateFile, $v=array(), $cache_id=null ){
		if ( is_array($v) ) self::Assign($v);
		else $cache_id = $v;
		$smarty = self::GetTemplate();
		$content = $smarty->fetch( $templateFile, $cache_id );
		self::CloseTemplate();
		return $content;
	}

	static public function Display( $templateFile,$v=array(), $cache_id=null ){
		if ( is_array($v) ) self::Assign($v);
		else $cache_id = $v;
		$smarty = self::GetTemplate();

		if(!empty(self::$_jses))
			$smarty->assign('javascripts', self::JsToString(array_keys(self::$_jses)));
		if(!empty(self::$_csses))
			$smarty->assign('csses', self::CssToString(array_keys(self::$_csses)));
		if(!empty(self::$_jsVars))
			$smarty->assign('envobj', json_encode(self::$_jsVars));

		$smarty->display( $templateFile, $cache_id );
		self::CloseTemplate();
	}

	static public function Assign($k=null, $v=null){
		$smarty = self::GetTemplate();
		if ( is_array($k) ) {
			foreach( $k AS $key=>$value )
				$smarty->assign($key, $value);
			return self::Instance();
		}
		$smarty->assign($k, $v);
		return self::Instance();
	}


	/**
	 * require once js
	 *
	 * @param string $js js url
	 * @return string
	 */
	static public function RequireJs($js){
		static $required = array();
		if(isset($required[$js]))
			return '';

		$required[$js] = 1;
		$js = '<script type="text/javascript" src="'.Asset::GetAssetUrl($js).'"></script>';
		return $js;
	}


	/**
	 * require once js code
	 *
	 * @param string $code js code
	 * @return string
	 */
	static public function RequireJsCode($code){
		static $required = array();
		if(isset($required[$code]))
			return '';

		$required[$code] = 1;
		return $code;
	}


	/**
	 * scriptholder
	 *
	 * @param array $params
	 * @param string $content
	 * @return string
	 */
	static public function ScriptHolder($params, $content) {
		if(empty($content))
			return;

		if(empty($params))
			$params = array('place' => 'scriptassembly');

		$assign = $params['place'];
		if(!isset(self::$scirptholder[$assign]) or empty(self::$scirptholder[$assign]))
			self::$scirptholder[$assign] = $content;
		else
			self::$scirptholder[$assign].= $content;
	}


	/**
	 * get scriptholder output
	 *
	 * @param array $params
	 * @param string $content
	 * @return string
	 */
	static public function GetScriptHolder($params) {
		if(!isset($params['place']))
			$params = array('place' => 'scriptassembly');
		$assign = $params['place'];

		$str = isset(self::$scirptholder[$assign]) ? self::$scirptholder[$assign] : '';
        foreach(str_split($str, 512) as $v)
            echo $v;


		return '';
	}


	static public function Clear(){
		self::CloseTemplate();
	}

	/**
	 * 向头部添加 css 文件
	 *
	 * Example:
	 * <code>
	 * JWTemplate::AddCss('/css/main.css');
	 * JWTemplate::AddCss(array('/css/Mypage.css', '/css/style.css'));
	 * </code>
	 * 
	 * @param string|array $css			文件路径
	 * @param boolean $mtime			是否带时间戳
	 * @return void
	 * @see JWTemplate::CssToString()		
	 */
	static public function AddCss($css = array(), $mtime = true)
	{
		if (!is_array($css)) 
			$css = array($css);
		
		foreach ($css as $v) {
			if (isset(self::$_csses[$v])) 
				continue;
			self::$_csses[$v] = 1;
		}
		return self::Instance();
	}
	
	/**
	 * 向头部添加 js 文件
	 * 
	 * Example:
	 * <code>
	 * JWTemplate::AddJs('/js/prototype.js');
	 * JWTemplate::AddJs(array('/js/jQuery.js', '/js/jQuery.calc.js'));
	 * </code>
	 *
	 * @param string|array $js			文件路径
	 * @param boolean $mtime			是否带时间戳
	 * @return void
	 * @see JWTemplate::JsToString()
	 */
	static public function AddJs($js = array())
	{
		if (!is_array($js)) 
			$js = array($js);

		foreach ($js as $v) {
			if (isset(self::$_jses[$v])) 
				continue;
			self::$_jses[$v] = 1;
		}

		return self::Instance();
	}

	/**
	 * 向页面添加 js 输出变量
	 * 
	 * Example:
	 * <code>
	 * JWTemplate::AddJsVars("target", 6);
	 * JWTemplate::AddJsVars(array("target" => 7, "next" => true, "list" => array( 1, 2, 3, 4)));
	 * </code>
	 *
	 * @param string|array $js			变量名或变量数组
	 * @param boolean $value			变量值
	 * @return void
	 */
	static public function AddJsVars($vars = array(), $value)
	{
		if (is_array($vars)) {
			foreach ($vars as $key => $value) {
				self::$_jsVars[$key] = $value;
			}
		}
		else {
			self::$_jsVars[$vars] = $value;
		}

		return self::Instance();
	}

	/**
	 * 生成 <link .. />
	 *
	 * @param array $css
	 * @param boolean $mtime
	 * @return string
	 * @see Asset::GetAssetUrl()
	 */
	static public function CssToString(array $css, $mtime = true)
	{
		if(empty($css))
			return '';

		$cnt = count($css);
		if(ASSET_COMBO) {
			$str = '<link href="'. 
				(count($css) > 1 ? Asset::GetComboUrl($css, $mtime) : 
				Asset::GetAssetUrl($css[0], $mtime)) .  '" rel="stylesheet" type="text/css" />';
		} else {
			$str = '';
			for($i = 0; $i < $cnt; ++$i) 
				$str.= '<link href="' . Asset::GetAssetUrl($css[$i], $mtime) .  "\" rel=\"stylesheet\" type=\"text/css\" />\n";
		}

		return $str;
	}
	
	/**
	 * 生成 <script ...></script>
	 *
	 * @param array $js
	 * @param boolean $mtime
	 * @return string
	 * @see JWAsset::GetAssetUrl()
	 */
	static public function JsToString(array $js, $mtime = true)
	{
		if(empty($js))
			return '';

		$cnt = count($js);
		if(ASSET_COMBO) {
			$str = '<script type="text/javascript" src="' . 
				($cnt > 1 ? Asset::GetComboUrl($js, $mtime) : 
				Asset::GetAssetUrl($js[0], $mtime)) .
				'"></script>';
		} else {
			$str = '';
			for($i = 0; $i < $cnt; ++$i) 
				$str.= '<script type="text/javascript" src="' . Asset::GetAssetUrl($js[$i], $mtime) .  "\"></script>\n";
		}
		
		return $str;
	}
	
	/**
	 * 向头部添加 JS 片断
	 * 
	 * Example:
	 * <code>
	 * JWTemplate::AddJsCode('var a = 111;');
	 * JWTemplate::AddJsCode(array('var data = {"json": 1};', 'alert('Hello World!')'));
	 * </code>
	 * 
	 * @param string|array $code
	 * @return void
	 */
	static public function AddJsCode($code)
	{
		$str = "";
		JWDB::CheckArray($code);
		
		self::$_jsCodes = array_merge(self::$_jsCodes, $code);
		
		$str .= '<script language="javascript" type="text/javascript">' . "\r\n";
		$str .= implode("\r\n", self::$_jsCodes);
		$str .= "\r\n</script>";
		self::Assign('js_codes', $str);
		return self::Instance();
	}
	

	/**
	 * 向头部添加 meta 标签
	 *
	 * Example:
	 * <code>
	 * $meta = array(
	 *     array('name' => "publishid",'content' => "30,59,1"),
	 *     array('name' => 'stencil', 'content'=> 'PGLS000022')
	 * );
	 * JWTemplate::AddMeta($meta, true);
	 * JWTemplate::AddMeta(array('name' => 'stencil', 'content'=> 'PGLS000022'));
	 * </code>
	 * 
	 * @param array $metas			键值对
	 * @param boolean $multi		是否是二维数组
	 * @return void
	 * @see JWTemplate::MetaToString()
	 */
	static public function AddMeta($metas, $multi = false)
	{
		static $str = '';
		
		if($multi) {
			foreach ($metas as $meta) {
				$str .= self::MetaToString($meta);
			}
		} else {
			$str .= self::MetaToString($metas);
		}
		
		self::Assign('metas', rtrim($str, "\r\n"));
		return self::Instance();
	}
	
	/**
	 * 设置页面 <title></title>
	 *
	 * Example:
	 * <code>
	 * JWTemplate::SetTitle('139');
	 * </code>
	 * 
	 * @param string $title
	 * @return void
	 */
	static public function SetTitle($title)
	{
		self::Assign('head_title', $title);
		return self::Instance();
	}	
	
	
	/**
	 * 生成 <meta ... />
	 *
	 * @param array $meta
	 * @return string
	 */
	static protected function MetaToString(array $meta)
	{
		$str = '<meta ';
		$tmp = array();
		
		foreach ($meta as $k => $v) {
			$tmp[] = $k . '="' . addslashes($v) . '"';
		}
		
		$str .= implode(' ', $tmp);
		$str .= " />\r\n";
		
		return $str;
	}
	
	/**
	 * 设置页面 <title></title>
	 *
	 * Example:
	 * <code>
	 * JWTemplate::AddMoreString('139');
	 * </code>
	 * 
	 * @param string $title
	 * @return void
	 */
	static public function AddMoreString($str)
	{
		self::Assign('more_string', $str);
		return self::Instance();
	}	

}
