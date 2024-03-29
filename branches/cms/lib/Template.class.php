<?php
if(false==defined('TPL_COMPILED_DIR')) define('TPL_COMPILED_DIR','/tmp');
if(false==defined('TPL_PLUGINS_DIR')) define('TPL_PLUGINS_DIR','/tmp');
if(false==defined('TPL_TEMPLATE_DIR')) define('TPL_TEMPLATE_DIR','/tmp');
require_once(dirname(__FILE__).'/Smarty/Smarty.class.php');

class Template{

	static private $mTemplate 	= null;
	static private $_instance	= null;

	static public $scirptholder = array();
	static public $cssholder 	= array();

	static private $_csses		= array();
	static private $_jses		= array();
	static private $_jsCodes	= array();	
	static private $_jsVars		= array();

	static function Instance() {
		if(!is_object(self::$_instance)){
			self::$_instance = new Template;
		}
		return self::$_instance;
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
			$smarty->load_filter('output', 'cssholder');
            
            
     
			if(!isset($current_header_type))
				$current_header_type = Utility::GetHeaderTypeByUrl();
       
			if(isset($_REQUEST['ajax']))
				$smarty->assign('ajax', $_REQUEST['ajax']);

			self::$mTemplate = $smarty;
		}
		return self::$mTemplate;
	}

	static private function CloseTemplate(){
		self::$mTemplate = null;
	}

	static public function fetch( $templateFile, $v=array(), $cache_id=null ){
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
		
        $smarty->assign('envobj', json_encode(self::$_jsVars));

//		Msg::RevertPost(1);
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
        echo preg_replace('/(<\\s*script\\s+[^>]*\\s*>)|(<\\s*\/\\s*script\\s*>)/i', '', $str);

		return '';
	}

	static public function CssHolder($cssUrl = "") {
		if(empty($cssUrl)) 
			return empty(self::$cssholder) ? '' : self::CssToString(array_keys(self::$cssholder));

		self::$cssholder[$cssUrl] = 1;
	}

	static public function Clear(){
		self::CloseTemplate();
	}



	/**
	 * 向头部添加 css 文件
	 *
	 * Example:
	 * <code>
	 * Template::AddCss('/css/main.css');
	 * Template::AddCss(array('/css/Mypage.css', '/css/style.css'));
	 * </code>
	 * 
	 * @param string|array $css			文件路径
	 * @param boolean $mtime			是否带时间戳
	 * @return void
	 * @see Template::CssToString()		
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
	 * Template::AddJs('/js/prototype.js');
	 * Template::AddJs(array('/js/jQuery.js', '/js/jQuery.calc.js'));
	 * </code>
	 *
	 * @param string|array $js			文件路径
	 * @param boolean $mtime			是否带时间戳
	 * @return void
	 * @see Template::JsToString()
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
	 * Template::AddJsVars("target", 6);
	 * Template::AddJsVars(array("target" => 7, "next" => true, "list" => array( 1, 2, 3, 4)));
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
	 * @see Asset::GetAssetUrl()
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
	 * Template::AddJsCode('var a = 111;');
	 * Template::AddJsCode(array('var data = {"json": 1};', 'alert('Hello World!')'));
	 * </code>
	 * 
	 * @param string|array $code
	 * @return void
	 */
	static public function AddJsCode($code)
	{
		$str = "";
		DB::CheckArray($code);
		
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
	 * Template::AddMeta($meta, true);
	 * Template::AddMeta(array('name' => 'stencil', 'content'=> 'PGLS000022'));
	 * </code>
	 * 
	 * @param array $metas			键值对
	 * @param boolean $multi		是否是二维数组
	 * @return void
	 * @see Template::MetaToString()
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
	 * Template::SetTitle('139');
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
	 * Template::AddMoreString('139');
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
