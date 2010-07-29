<?php
/**
 * @package JiWai.de
 * @copyright AKA Inc.
 * @author shwdai@gmail.com
 */
class Memcache
{

	private $mCache = null;
	static private $mInstance = array();

	static public function Instance($cluster='default')
	{
		if ( isset( self::$mInstance[ $cluster ] ) )
			return self::$mInstance[ $cluster ];

		return self::$mInstance[ $cluster ] = new Memcache($cluster);
	}

	static private function _CreateCacheInstance($cluster='default')
	{
		$cache_instance = new MemCache();
		foreach( $GLOBALS['CONFIG_MEMCACHE'][$cluster]  AS $one )
		{
			list($ip, $port, $weight) = explode(':', $one);
			$a=$cache_instance->addServer( $ip
					,$port
					,true
					,$weight
					,1
					,15
					,true
					,array('Memcache','FailureCallback')
					);
		}
		$cache_instance->setCompressThreshold(5000); // > 5k then zlib
		return $cache_instance;
	}

	private function __construct($cluster='default')
	{
		$this->mCache = self::_CreateCacheInstance( $cluster );
	}

	static public function FailureCallback($ip, $port)
	{
		error_log( 'connect memcache fail: '.$ip.':'.$port );
	}

	function Get($key) 
	{
		return $this->mCache->get($key);	
	}


	function Add($key, $var, $flag=0, $expire=0) {
		return $this->mCache->add($key,$var,$flag,$expire);
	}


	function Dec($key, $value=1)
	{
		return $this->mCache->decrement($key, $value);
	}


	function Inc($key, $value=1)
	{
		return $this->mCache->increment($key, $value);
	}

	function Replace($key, $var, $flag=0, $expire=0)
	{
		return $this->mCache->replace($key, $var, $flag, $expire);
	}


	function Set($key, $var, $flag=0, $expire=0) {
		return $this->mCache->set($key, $var, $flag, $expire);
	}

	function Del($key, $timeout=0) {
		if (is_array($key)) {
			foreach ($key as $k) $this->mCache->delete($k, $timeout);
		} else {
			if($this->mCache->get($key)) {
			$result =	$this->mCache->delete($key, $timeout);
			}
		}
	}

	function Flush()
	{
		return $this->mCache->flush();
	}
	
	function GetFunctionValue($callback, $args=array(), $expire=1, $fresh_time=0)
	{
		$k = self::GetFunctionKey($callback, $args);
        $v = $this->Get($k);

        if ( $v && $v['t'] > $fresh_time )
        {
            return $v['v'];
        }

        $r = call_user_func_array($callback, $args);
        $v = array(
                'v' => $r,
                't' => time(),
                );
        $this->Set($k, $v, 0, $expire);

		return $r;
	}
	
	function GetObjectValue($tablename, $id, $reload=false, $expire=0)
	{
		$k = self::GetFunctionKey($tablename, $id);
		if ( $reload || false===($v = $this->Get($k)) ) 
		{
			$v = Table::Fetch( $tablename, $id );
			$this->Set($k, $v, 0, $expire);
		}
		return $v;
	}

	static public function GetFunctionKey($callback='', $args=array())
	{
		ksort($args);
		$v_str = var_export($args,true);
		$v_str = preg_replace('/(=>)\s*\'(\d+)\'/', '\\1\\2', $v_str);

		if ( is_array($callback) ) 
			$callback = $callback[0].'::'.$callback[1];

		return 'LM[FUNC]:'.$callback.'('.$v_str.')';
	}

	static public function GetObjectKey($tablename, $id, $k='id')
	{
        if ( is_array( $id ) )
        {
            $id = array_values(array_unique($id));
            $key = array();
            foreach( $id AS $one )
            {
                $key[$one] = 'LM[OBJ]:'.$tablename.'('.$k.':'.$one.')';
            }
            return $key;
        }

		return 'LM[OBJ]:'.$tablename.'('.$k.':'.$id.')';
	}
}
