<?php


class DB {

	static private $mConnection = array();
	static private $mInstance	= array();

	/**
	 * see @BuildCondition 
	 */
	static private $_params 	= array();

	static private $_lastConnect= null;
	static private $_config 	= array();

	static public $mDebug 		= false;

	/**
	 * lifetime(seconds) for master/slave switcher
	 * see self::_switch
	 */
	static public $life			= 10;

	/**
	 * 获取唯一实例
	 *
	 * @param array config 	db config param
	 * @return instance of object
	 */
	static function Instance($config = array()) {
		$class = __CLASS__;
		if(!empty($config)) 
			$class 	= 'DB_Multi';
		else
			$config = self::GetDefaultConfig();

		$key 	= serialize($config);
        // edit by zhangqiuming at 2009/12/21 如果默认配置已经直接指定为Multi了，会导致返回$mConnection中为空;
		if(!isset(self::$mInstance[$key]) or empty(self::$mInstance[$key]) or empty(self::$mConnection))  
			self::$mInstance[$key] = new $class($config);

		return self::$mInstance[$key];
	}

	/**
	 * 构造方法
	 */
	function __construct($config = array()) {
		// default config
		self::$_config = empty($config) ? self::GetDefaultConfig() : $config;

		$option = array(
			PDO::ATTR_EMULATE_PREPARES   => true,
			PDO::MYSQL_ATTR_INIT_COMMAND => "SET NAMES 'utf8'",
		);

		foreach(self::$_config as $i => $database) {
			$dsn = isset($database[4]) ?
                "mysql:dbname={$database[3]};host={$database[0]};port={$database[4]}" :
                "mysql:dbname={$database[3]};host={$database[0]}";
			try {
				self::$mConnection[$i] = new PDO($dsn, $database[1], $database[2], $option);
			} catch(Exception $e ) {
				throw new Exception('Connect ' .$i. ' failed: ' . $e->getMessage());
			}
		}
	}

	/**
	 * 析构方法
	 */
	function __destruct() {
		self::Close();
	}

	/**
	 * 关闭
	 */
	static function Close() {
		$config = self::GetDefaultConfig();
		$key 	= serialize($config);
		unset(self::$mInstance[$key]);
		self::$mConnection 	= array();
	}

	/**
	 * 调试用，用于打印数据查询
	 */
	static public function Debug($debug=true) {
		self::$mDebug = true==$debug;
	}

	/**
	 * Escape string, deny injection
	 * @param string $string
	 * @return string
	 */
	static public function EscapeString($string) {
		return addslashes($string);
	}

	/**
	 * 获取最后插入ID
	 */
	static public function GetInsertId() {
		self::Instance();
		$i = isset(self::$_lastConnect) ? self::$_lastConnect : 0;
		return (int)self::$mConnection[$i]->lastInsertId();
	}

	/**
	 * 执行一些Query
	 * @param string $sql
	 * @return mysql_result $query_result
	 */
	static public function Query($sql ,$isSelect=false) {
		$result = self::_getConn($isSelect)->query($sql);
		if($result) 
			return $result;

		self::Close();
		return false;
	}

    /**
     * getConnection 
     * 
     * @param mixed $isSelect 指定db
     * @return void
     */
    static public function getConnection($isSelect = false){
        return self::_getConn($isSelect);
    }

	/**
	 * get db connection
	 *
	 * @param bool $isSelect 指定db
	 * @return object
	 */
	static private function _getConn($isSelect = false) {
		self::Instance();
		$i 						= rand(0, count(self::$_config) - 1);
		self::$_lastConnect 	= ($isSelect && $i) ? $i : 0;
		$conn 					= self::$mConnection[self::$_lastConnect]; 
		return $conn;
	}


	/**
	 * get db config 
	 *
	 * @return array
	 */
	static function GetDefaultConfig() {
		return $GLOBALS['CONFIG_DATABASE'];
	}

	/**
	 * 根据条件获取一条记录
	 * @param string $table 表名
	 * @param mix $condition 条件
	 * @param array $option 查询选项
	 * @return record
	 */
	static public function GetTableRow($table, $condition, $options=array()) {
		return self::LimitQuery($table, array(
			'condition' => $condition,
			'one' 		=> isset($options['one']) ? $options['one'] : true,
			'select' 	=> isset($options['select']) ? $options['select'] : '*',
		));
	}

	/**
	 * 根据条件获取有限条数记录
	 * @param string $table 表名
	 * @param array $options 查询选项
	 $options 可以包含 cache 选单，表示记录cache时间
	 * @return array of record
	 */
	static public function LimitQuery($table, $options=array()) {
		return self::DBLimitQuery($table, $options);
	}

	/**
	 * 根据条件获取有限条数记录，从库中查询，并进行缓存 
	 *
	 * @param string $table 表名
	 * @param array $option 查询选项
	 * @return array of record
	 */
	static function DBLimitQuery($table, $options=array()) {
		$condition 	= isset($options['condition']) ? $options['condition'] : null;
		$one 		= isset($options['one']) ? $options['one'] : false;
		$offset 	= isset($options['offset']) ? abs(intval($options['offset'])) : 0;

		if($one) 
			$size = 1;
		else 
			$size = isset($options['size']) ? abs(intval($options['size'])) : null;

		$order 		= isset($options['order']) ? $options['order'] : null;
		$select 	= isset($options['select']) ? $options['select'] : '*';

		$condition 	= self::BuildCondition( $condition );
		$condition 	= (null==$condition) ? null : "WHERE $condition";

		if($one)
			$limitation = " LIMIT 1 ";
		else
			$limitation = $size ? "LIMIT $offset,$size" : null;

		$sql = "SELECT $select FROM `$table` $condition $order $limitation";
		return self::GetQueryResult($sql, $one, self::$_params);
	}

	/**
	 * 执行真正的数据库查询
	 * @param string $sql
	 * @param bool $one 是否单条记录
	 * @return array of $record
	 */
	static function GetQueryResult($sql, $one=true, array $params = array()) {
		$ret 	= array();
		$stmt 	= self::Execute($sql, $params);
		if(!is_object($stmt)) {
			error_log('Error: bad sql - ' . $sql);
			error_log('Error: bad sql - ' . var_export($params, true));
			return array();
		} else {
			return $one ? $stmt->fetch() : $stmt->fetchAll();
		}
	}

	/**
	 * 插入一条记录 Alias of method: Insert
	 * @param string $table 表名
	 * @param array $condition 记录
	 * @return int $id
	 */
	static function SaveTableRow($table, $condition) {
		return self::Insert($table, $condition);
	}

	/**
	 * 插入一条记录
	 * @param string $table 表名
	 * @param array $condition 记录
	 * @return int $id
	 */
	static function Insert($table, $condition, $type=0) {
		$content 	= null;
		$sql = "INSERT INTO `$table` 
				(`" . join('`,`', array_keys($condition)) . '`) 
				values (' . join(',', array_fill(0, count($condition), '?')) . ')';

		$stmt = self::Execute($sql, array_values($condition));
		if(1==$type) //用于不是自增id时的判断
			return is_object($stmt);
		$insertId = self::GetInsertId();

		return $insertId;
	}

	/**
	 * 删除一条记录 Alias of method: Delete
	 * @param string $table 表名
	 * @param array $condition 条件 
	 * @return int $id
	 */
	static function DelTableRow($table=null, $condition=array()) {
		return self::Delete($table, $condition);
	}

	/**
	 * 删除一条记录
	 * @param string $table 表名
	 * @param array $condition 条件 
	 * @return int $id
	 */
	static function Delete($table=null, $condition = array()) {
		if ( null==$table || empty($condition) )
			return false;

		$condition = self::BuildCondition($condition);
		$condition = (null==$condition) ? null : "WHERE $condition";
		$sql = "DELETE FROM `$table` $condition";

		$flag = self::Execute($sql, self::$_params);
		return $flag;
	}

	static function Execute($sql, array $params = array(), $retry = 0) {
		$t = '';
		$s = explode('?', $sql);
		foreach($params as $k=>$v)
			$t .= $s[$k]."'$v'";

		$t = (is_array($s) && isset($k) ? $t.$s[$k+1] : $sql)."<br/>\n";
		if (self::$mDebug ) 
			echo $t;

		try {
			$conn = self::_switch($sql);
			$sth 	= $conn->prepare($sql);
			if(!is_object($sth)) 
				throw new Exception('Error: bad sql');

			$sth->setFetchMode(PDO::FETCH_ASSOC);
			$result = empty($params) ? $sth->execute() : $sth->execute(array_values($params));
			$error = $sth->errorCode();

			// no more log
			/*
			if(0 != $error) 
				$script_uri = Utility::GetRequestUri(2);
			error_log(date('Y-m-d H:i:s').", $flag, DB::Execute(), $error, $t, ".print_r($sth->errorInfo(), 1).", $script_uri, $sql, ".print_r($params, 1).", \n", 3, '/home/d139/logs/www/jwdb.'.date('Ymd').'.log');
			*/

			if(($error == 2006) and !$retry) {
				self::Close();
				self::Execute($sql, $params, $retry = 1);
			}
		} catch(Exception $e) {
			$result = false;
		}

		self::$_params = array();
		if ( false == $result ) {
			self::Close();
			return false;
		}

		return $sth;
	}

	/**
	 * choose master or slave
	 * 
	 * @param string $sql 
	 */
	static private function _switch($sql) {
		$select = false;

		$uid 		= Login::GetCurrentUserId();
		$callback 	= 'DB::_switch';
		$args		= array($uid);
		$key		= Memcache::GetFunctionKey($callback, $args);

		if(false === stripos($sql, 'SELECT')) {
			if($uid) {
				// master
				$flag		= 0;
				$value		= 1;
				Memcache::Instance()->Set($key, $value, $flag, self::$life);
			}
		} elseif(rand(0, 1)) {
			// %50 to master
		} else {
			$value 	= Memcache::Instance()->Get($key);
			if(!$value) //slave
				$select = 1;
		}

		return self::_getConn($select);
	}

	/**
	 * 更新一条记录
	 * @param string $table 表名
	 * @param mix $id 更新条件 
	 * @param mix $updaterow 修改内容
	 * @param string $pkname 主键 
	 * @return boolean
	 */
	static function Update( $table=null, $id=1, $updaterow=array(), $pkname='id' ) {
		if ( null==$table || empty($updaterow) || null==$id)
			return false;

		if ( is_array($id) ) $condition = self::BuildCondition($id);
		else $condition = "`$pkname`='$id'";

		$sql 		= "UPDATE `$table` SET ";
		$content 	= null;
		$updates 	= array();
		$v_str		= '?';

		foreach ( $updaterow as $k => $v ) {
			if(is_array($v)) {
				$str = $v[0]; //for 'count'=>array('count+1');
				$content .= "`$k`=$str,";
			} else {
				$updates[] 	= $v;
				$content .= "`$k`=$v_str,";
			}
		}

		$content 	= trim($content, ',');
		$sql 		.= $content;
		$sql 		.= " WHERE $condition";
		$result = self::Execute($sql, array_merge($updates, self::$_params));

		return is_object($result) ? $result->rowCount() : false;
	}

	/**
	 * 获取表的字段列表
	 * @param string $table 表名
	 * @param $select_map 对应enum字段的解释
	 * @return array
	 */
	static function GetField($table, $select_map = array()) {
		$fields = array();
		$stmt	= self::Query( "DESC `$table`" );
		$result = $stmt->setFetchMode(PDO::FETCH_ASSOC);

		while ( $r = $stmt->fetch() ) {
			$Field = $r['Field'];
			$Type = $r['Type'];

			$type = 'varchar';
			$cate = 'other';
			$extra = null;

			if ( preg_match( '/^id$/i', $Field ) )
				$cate = 'id';
			else if ( preg_match( '/^time_/i', $Field ) )
				$cate = 'time';
			else if ( preg_match ( '/_id$/i', $Field ) )
				$cate = 'fkey';


			if ( preg_match('/text/i', $Type ) ) {
				$type = 'text';
				$cate = 'text';
			}

			if ( preg_match('/date/i', $Type ) ) {
				$type = 'date';
				$cate = 'time';
			} else if ( preg_match( '/int/i', $Type) ) {
				$type = 'int';
			} else if ( preg_match( '/(enum|set)\((.+)\)/i', $Type, $matches ) ) {
				$type = strtolower($matches[1]);
				eval("\$extra=array($matches[2]);");
				$extra = array_combine($extra, $extra);

				foreach( $extra AS $k=>$v)
					$extra[$k] = isset($select_map[$k]) ? $select_map[$k] : $v;

				$cate = 'select';
			}

			$fields[] = array(
				'name' => $Field,
				'type' => $type,
				'extra' => $extra,
				'cate' => $cate,
			);
		}
		return $fields;
	}

	/**
	 * 是否存在符合条件的记录
	 * @param string $table 表名
	 * @param array $condition
	 * @param boolean $returnid 是否返回记录id
	 * @return mixed (int)id /(array)record
	 */
	static function Exist($table, $condition=array(), $returnid = true, $order='') {
		$row = self::LimitQuery($table, array(
			'condition' => $condition,
			'one' => true,
			'order' => $order
		));

		if($returnid)
			return empty($row) ? false : (isset($row['id']) ? $row['id'] : true);
		else
			return empty($row) ? array() : $row;
	}

	/**
	 * 组建QueryCondition
	 *
	 * @param mix $condition;
	 * @param string $logic, optional
	 * @return string $condition
	 */
	static function BuildCondition($condition=array(), $logic='AND') {
		if ( is_string( $condition ) || is_null($condition) )
			return $condition;

		$logic = strtoupper( $logic );
		$content = null;
		foreach ( $condition as $k => $v ) {
			$v_str = ' ? ';
			$v_connect = '=';

			if ( is_numeric($k) ) {
				$content .= ' '. $logic . ' (' . self::BuildCondition( $v ) . ')';
				continue;
			}

			$maybe_logic = strtoupper($k);
			if ( in_array($maybe_logic, array('AND','OR'))) {
				$content .= $logic . ' (' . self::BuildCondition( $v, $maybe_logic ) . ')';
				continue;
			}

			if ( is_numeric($v) ) {
				self::$_params[] = $v;	
			} else if ( is_null($v) ) {
				$v_connect = ' IS ';
				$v_str = 'NULL';
			} else if ( is_array($v) && ($c = count($v))) {
				if (1<$c) {
					self::$_params = array_merge(self::$_params, $v);
					$v_connect 	= 'IN(' . join(',', array_fill(0, $c, '?')) . ')';
					$v_str		= '';
				} else if ( empty($v) ) {
					$v_str = $k;
					$v_connect = '<>';
				} else {
					$tmp_keys = array_keys($v);
					$v_connect = array_shift($tmp_keys);
					if( is_numeric($v_connect) )
						$v_connect = '=';
					$tmp_values = array_values($v);	
					$v_s = array_shift($tmp_values);

					if(is_array($v_s)) {
						$v_str = 'IN (' . join(',', array_fill(0, count($v_s), '?')) . ')';
						self::$_params = array_merge(self::$_params, $v_s);
					} else {
						self::$_params[] = $v_s;	
					}

				}
			} else {
				self::$_params[] = $v;
			}

			$content .= " $logic `$k` $v_connect $v_str ";

		}

		$content = preg_replace( '/^\s*'.$logic.'\s*/', '', $content );
		$content = preg_replace( '/\s*'.$logic.'\s*$/', '', $content );
		$content = trim($content);

		return $content;
	}

	/**
	 * 检查是否DB用于的Int
	 * @param mix $id
	 * @return int $id
	 */
	static function CheckInt(&$id, $is_abs=false) {
		if ( is_array($id) ) {
			foreach( $id AS $k => $o ) $id[$k] = self::CheckInt($o);
			return $id;
		}

		if(!is_int($id))
			$id = intval($id);

		if(0>$id && $is_abs)
			return abs($id);
		else
			return $id;
	}

    /**
     * 检查是否DB用于的Array
     * @param mix $arr
     * @return int $arr
     */
	static function CheckArray(&$arr) {
        if ( !is_array($arr) ) {
			if(false===$arr)
				$arr = array();
			else
				settype($arr, 'array');
		}
		return $arr;
	}
    

}
