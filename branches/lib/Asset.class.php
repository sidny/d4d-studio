<?php
/**
 * @package	JiWai.de
 * @copyright	AKA Inc.
 * @author  	glinus@jiwai.com
 */

/**
 * JiWai.de Asset Class
 */
class Asset {

	/**
	 * path_config
	 *
	 * @var
	 */
	static private $msAssetRoot;

	static private $msAssetCounter 	= 0;
    static private $msAssetMax = ASSET_RANDOM;
	/*
	 * Get asset url with timestamp
	 *	@param	path		the path of asset.jiwai.de/$path
	 *	@return	URL			the url ( domain name & path )
	 */
	static public function GetAssetUrl($absUrlPath, $mtime=true, $type=1)
	{
		if ( preg_match( '#^https?://#', $absUrlPath ) )
			return $absUrlPath;

		if ( empty($absUrlPath) )
		{
			return '';
			//throw new JWException('must have path');
		}

		$asset_path	= ASSET_PATH;
		if($absUrlPath{0} != '/')
			$absUrlPath = '/' . $absUrlPath;

		// 同一个文件，总会被分配到同一个 n 上。
		if(1==$type)
			$asset_name = self::GetAssetServer($absUrlPath);
		else
			$asset_name = 'http://'.$asset_path;

		if ( !$mtime )
			return $asset_name . $absUrlPath;

		$extLen		= 3;
		$abs_file 	= $asset_path . $absUrlPath;
		$tmp		= explode('.', $absUrlPath);
		$ext		= array_pop($tmp);
       // var_dump($abs_file);
		$timestamp 	= file_exists($abs_file) ? filemtime($abs_file) : 0;
		if($extLen > strlen($ext))
			$timestamp.= '0';

		//we use more then one domain name to down load asset in parallel
		return "$asset_name{$absUrlPath}__$timestamp.$ext";
	}

	static public function GetUploadUrl($absUrl) {
		return 'http://' . UPLOAD_HOSTNAME . $absUrl;
	}

	/**
	 * Get combo asset url 
	 *
	 *	@param	path		array of the path, asset.jiwai.de/$path
	 *	@return	URL			the url ( domain name & path )
	 */
	static public function GetComboUrl($absUrlPaths, $mtime=true)
	{
		$split 		= '__';
		$prefix 	= '/combo/';
		$absUrlPath = join($split, $absUrlPaths);
		$asset_name = self::GetAssetServer($absUrlPath);

		if ( !$mtime )
			return $asset_name . $prefix . $absUrlPath;

		$timestamp 	= 0;
		foreach((array)$absUrlPaths as $v) 
        {
			$timestamp = max(self::_getTimestamp($v), $timestamp);
        }
		return "$asset_name$prefix$split$timestamp/$absUrlPath";
	}


	/**
	 * Get asset server number 
	 *
	 *	@param	path		path of the asset, asset.jiwai.de/$path
	 *	@return	int 		the number
	 */
    static public function GetAssetServer($absUrlPath, $is_http = true)
    {
        $n = sprintf('%u',crc32($absUrlPath));
        if(self::$msAssetMax > 0 ){
            $n %= self::$msAssetMax;
            if($is_http)
                return 'http://asset' . $n . '.' . ASSET_HOSTNAME;
            else
                return 'asset' . $n . '.' . ASSET_HOSTNAME;
        }else{
            if($is_http)
                return 'http://'.ASSET_HOSTNAME;
            else
                return ASSET_HOSTNAME ;

        }
	}

	/**
	 * Get file timestamp
	 *
	 *	@param	path		path of the asset, asset.jiwai.de/$path
	 *	@return	int 		the timestamp 
	 */
	static private function _getTimestamp($absUrlPath)
    {   
        $asset_name = 'http://'.$asset_path;
		$abs_file 	= ASSET_PATH."/$absUrlPath";
		$timestamp 	= file_exists($abs_file) ? filemtime($abs_file) : 0;
		return $timestamp;
	}

	static public function DefaultUrl($id, $size='48x48', $r=array(), $reg=1)
	{
		if(1==$reg)
		$default_url = Asset::GetUploadUrl( '/images/no_'.$size.'.jpg');
		else
		$default_url = Asset::GetUploadUrl( '/images/noreg_'.$size.'.jpg');
		if (!is_array($id) )
			return $default_url;

		foreach ( $id AS $one )
		{
			if ( !isset($r[$one]) )
				$r[$one] = $default_url;
		}
		return $r;

	}

	/**
	 * 根据 file_id ，获取一个/一组文件的访问地址
	 * @param int/array $id file
	 * @param string $thumb 
	 */
	static public function GetUrlByName($file_info, $thumb='48x48', $type='avatar', $reg=1)
	{
		if(is_numeric($file_info)) return Asset::GetAssetUrl('/images/red.jpg');
		list($user_id, $file_name) = explode('_', $file_info, 2);
		if(empty($user_id) || empty($file_name))
			return Asset::DefaultUrl(0, $thumb, '', $reg);
		if(0==strncmp($file_name, 'http://', 7))
		{
			return $file_name;
			/*$size = getimagesize($file_name);
			if(false===$size || !is_array($size) || empty($size))
				return JWAsset::DefaultUrl(0, $thumb);*/
			/*if(file_get_contents($file_name))
				return $file_name;
			else*/
		}
		$file_path = join('/', array( '/system', $type, $user_id , $thumb, $file_name));
		return Asset::GetUploadUrl($file_path);
	}

}
