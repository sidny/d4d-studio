<?php

/**
 * Database 
 * 
 * 数据库控制类
 *
 * 提供基础的数据库功能，并封装了常用的获取列表等功能
 *
 * @uses MDB2
 * @package demo
 * @copyright weibo.10086.cn Inc
 * @author matao_a <matao_a@aspirecn.com> 
 */

class Database extends MDB2{
	static $_debug = true;
	static private $msInstance = array();
	private $_mConnection;

	private $_logFile;
	
	/**
	 * instance 
	 *
	 * 创建数据库实例
	 * 
	 * @param string	$host	
	 * @param string	$port	
	 * @param string	$user	
	 * @param string	$passwd	
	 * @param string	$dbName	
	 * @param string	$logFile	
	 * @static
	 * @access public
	 * @return array
	 */
	public static function instance($host, $port, $user, $passwd, $dbName, $logFile=null)
	{
		$instName = self::_getInstName($host, $port, $user, $passwd, $dbName);
		if (!array_key_exists($instName, self::$msInstance)) {
			self::$msInstance[$instName] = new self($host, $port, $user, $passwd, $dbName, $logFile);
		}
		self::$msInstance[$instName]->excute("use $dbName");
		return self::$msInstance[$instName];
	}
	public static function instanceMultiDb($conf,$logFile=null)
	{
		$instName = self::_getInstName($conf['ip'], $conf['port'], $conf['user'], $conf['passwd'], $conf['dbname']);
		if (!array_key_exists($instName, self::$msInstance)) {
			self::$msInstance[$instName] = new self($conf['ip'], $conf['port'], $conf['user'], $conf['passwd'], $conf['dbname'], $logFile);
		}
		return self::$msInstance[$instName];
	}
	
	/**
	 * @description 构造函数，创建一个连接
	 *
	 */
	public function __construct($host, $port, $user, $passwd, $dbName, $logFile=null) {
		$dsn = "mysql://$user:$passwd@$host:$port/$dbName?charset=utf8&new_link=true";
		$options = array(
			'debug'       => 2,
			'portability' => MDB2_PORTABILITY_ALL,
		);
		$this->_mConnection = &MDB2::connect($dsn, $options);
		if (MDB2::isError($this->_mConnection)) {
			die(MDB2::errorMessage($this->_mConnection));
		}
		$this->_logFile = str_replace('.date.', date('.Ymd.'), $logFile);
		$this->_logFile = str_replace('dbname', $dbName, $this->_logFile);
	}

	//{{{ selectRow($table, $condition, $order = array(), $cols = '*')
	/**
	 * selectRow
	 *
	 * 查询单条数据
	 * 
	 * @param string	$table			表名
	 * @param array		$condition		条件数组	
	 * @param array		$order			排序数组	
	 * @param string	$cols			读取的列，默认为全部
	 * @access public
	 * @return array	返回一条数据。
	 */
	public function selectRow($table, $condition, $order=array(), $cols = '*') {
		$conditions = self::buildCondition($condition);
		$conditions = $conditions ? (' WHERE ' . $conditions) : '';
		$orders = self::buildOrder($order);
		$orders = $orders ? ($orders = ' ORDER BY ' . $orders) : '';
		$cols = strlen($cols) ? $cols : '*';
		$sql = "SELECT $cols FROM " . $table . "$conditions$orders LIMIT 1";
		$res = $this->_mConnection->query($sql);
		if (MDB2::isError($res)) {
			$this->_log("QUERY_ROW\t$sql\t" . $res->getMessage());
			return false;
		}
		if (self::$_debug) {
			$this->_log("QUERY_ROW_SUC:\t$sql");
		}
		return $res->fetchRow(MDB2_FETCHMODE_ASSOC);
	}//}}}

	//{{{ selectList($table, $condition, $order, $offset = 0, $rowCount = 20, $cols = '*', $needCount = false)
	/**
	 * selectList 
	 *
	 * 查询一个翻页列表
	 * 
	 * @param string	$table			表名
	 * @param array		$condition		条件数组	
	 * @param array		$order			排序数组	
	 * @param int		$offset			偏移量，默认为0
	 * @param int		$rowCount		单页获取数量，默认为20
	 * @param string	$cols			读取的列，默认为全部
	 * @param boolean	$needCount		是否需要获取总数，默认不获取
	 * @access public
	 * @return array	返回数组中list为列表数据，count为总数。
	 */
	public function selectList($table, $condition, $order, $offset = 0, $rowCount = 20, $cols = '*', $needCount = false) {
		$conditions = self::buildCondition($condition);
		$conditions = $conditions ? (' WHERE ' . $conditions) : '';
		$orders = self::buildOrder($order);
		$orders = $orders ? ($orders = ' ORDER BY ' . $orders) : '';
		$offset = $offset ? intval($offset) : 0;
		$rowCount = $rowCount ? intval($rowCount) : 20;
		$cols = strlen($cols) ? $cols : '*';
		if ($needCount) {
			$sqlList = "SELECT SQL_CALC_FOUND_ROWS $cols FROM " . $table . "$conditions$orders LIMIT $offset, $rowCount";
			$res = $this->_mConnection->query($sqlList);
			if (MDB2::isError($res)) {
				$this->_log("QUERY_LIST\t$sqlList\t" . $res->getMessage());
				return false;
			}
			if (self::$_debug) {
				$this->_log("QUERY_LIST_SUC:\t$sqlList");
			}
			$list = $res->fetchAll(MDB2_FETCHMODE_ASSOC);
			$sqlCount = 'SELECT FOUND_ROWS()';
			$res = $this->_mConnection->query($sqlCount);
			if (MDB2::isError($res)) {
				$this->_log("QUERY_COUNT\t$sqlCount\t" . $res->getMessage());
				return false;
			}
			$count = $res->fetchOne();
			return array(
				'list'	=> $list,
				'count'	=> $count,
			);
		} else {
			$sqlList = "SELECT $cols FROM " . $table . "$conditions$orders LIMIT $offset, $rowCount";
			$res = $this->_mConnection->query($sqlList);
			if (MDB2::isError($res)) {
				$this->_log("QUERY_LIST\t$sqlList\t" . $res->getMessage());
				return false;
			}
			if (self::$_debug) {
				$this->_log("QUERY_LIST_SUC:\t$sqlList");
			}
			$list = $res->fetchAll(MDB2_FETCHMODE_ASSOC);
			return array(
				'list'	=> $list,
			);
		}
	}//}}}

	//{{{ selectAll($table, $condition, $order, $cols = '*', $needCount = false)
	/**
	 * selectAll
	 *
	 * 查询一个翻页列表
	 * 
	 * @param string	$table			表名
	 * @param array		$condition		条件数组	
	 * @param array		$order			排序数组	
	 * @param string	$cols			读取的列，默认为全部
	 * @param boolean	$needCount		是否需要获取总数，默认不获取
	 * @access public
	 * @return array	返回数组中list为列表数据，count为总数。
	 */
	public function selectAll($table, $condition, $order, $cols = '*', $needCount = false) {
		$conditions = self::buildCondition($condition);
		$conditions = $conditions ? (' WHERE ' . $conditions) : '';
		$orders = self::buildOrder($order);
		$orders = $orders ? ($orders = ' ORDER BY ' . $orders) : '';
		$offset = $offset ? intval($offset) : 0;
		$rowCount = $rowCount ? intval($rowCount) : 20;
		$cols = strlen($cols) ? $cols : '*';
		if ($needCount) {
			$sqlList = "SELECT SQL_CALC_FOUND_ROWS $cols FROM " . $table . "$conditions$orders";
			$res = $this->_mConnection->query($sqlList);
			if (MDB2::isError($res)) {
				$this->_log("QUERY_LIST\t$sqlList\t" . $res->getMessage());
				return false;
			}
			$list = $res->fetchAll(MDB2_FETCHMODE_ASSOC);
			$sqlCount = 'SELECT FOUND_ROWS()';
			$res = $this->_mConnection->query($sqlCount);
			if (MDB2::isError($res)) {
				$this->_log("QUERY_COUNT\t$sqlCount\t" . $res->getMessage());
				return false;
			}
			$count = $res->fetchOne();
			return array(
				'list'	=> $list,
				'count'	=> $count,
			);
		} else {
			$sqlList = "SELECT $cols FROM " . $table . "$conditions$orders";
			$res = $this->_mConnection->query($sqlList);
			if (MDB2::isError($res)) {
				$this->_log("QUERY_LIST\t$sqlList\t" . $res->getMessage());
				return false;
			}
			if (self::$_debug) {
				$this->_log("QUERY_ALL_SUC:\t$sqlList");
			}
			$list = $res->fetchAll(MDB2_FETCHMODE_ASSOC);
			return array(
				'list'	=> $list,
			);
		}
	}//}}}

	//{{{ selectCol($table, $condition, $order, $col, $needCount = false)
	/**
	 * selectCol 
	 *
	 * 查询一列
	 * 
	 * @param string	$table			表名
	 * @param array		$condition		条件数组	
	 * @param array		$order			排序数组	
	 * @param string	$col			读取的列
	 * @param boolean	$needCount		是否需要获取总数，默认不获取
	 * @access public
	 * @return array	返回数组中list为列表数据，count为总数。
	 */
	public function selectCol($table, $condition, $order, $col, $needCount = false) {
		$conditions = self::buildCondition($condition);
		$conditions = $conditions ? (' WHERE ' . $conditions) : '';
		$orders = self::buildOrder($order);
		$orders = $orders ? ($orders = ' ORDER BY ' . $orders) : '';
		$offset = $offset ? intval($offset) : 0;
		$rowCount = $rowCount ? intval($rowCount) : 20;
		if ($needCount) {
			$sqlList = "SELECT SQL_CALC_FOUND_ROWS $col FROM " . $table . "$conditions$orders";
			$res = $this->_mConnection->query($sqlList);
			if (MDB2::isError($res)) {
				$this->_log("QUERY_LIST\t$sqlList\t" . $res->getMessage());
				return false;
			}
			$list = $res->fetchCol();
			$sqlCount = 'SELECT FOUND_ROWS()';
			$res = $this->_mConnection->query($sqlCount);
			if (MDB2::isError($res)) {
				$this->_log("QUERY_COUNT\t$sqlCount\t" . $res->getMessage());
				return false;
			}
			$count = $res->fetchOne();
			return array(
				'list'	=> $list,
				'count'	=> $count,
			);
		} else {
			$sqlList = "SELECT $col FROM " . $table . "$conditions$orders";
			$res = $this->_mConnection->query($sqlList);
			if (MDB2::isError($res)) {
				$this->_log("QUERY_LIST\t$sqlList\t" . $res->getMessage());
				return false;
			}
			if (self::$_debug) {
				$this->_log("QUERY_COL_SUC:\t$sql");
			}
			$list = $res->fetchCol();
			return array(
				'list'	=> $list,
			);
		}
	}//}}}

	//{{{ selectCount($table, $condition)
	/**
	 * selectCount
	 *
	 * 查询总数
	 * 
	 * @param string	$table			表名
	 * @param array		$condition		条件数组	
	 * @access public
	 * @return int	返回总数。
	 */
	public function selectCount($table, $condition) {
		$conditions = self::buildCondition($condition);
		$conditions = $conditions ? (' WHERE ' . $conditions) : '';
		$sql = "SELECT count(1) FROM " . $table . "$conditions";
		$res = $this->_mConnection->query($sql);
		if (MDB2::isError($res)) {
			$this->_log("QUERY_ROW\t$sql\t" . $res->getMessage());
			return false;
		}
		if (self::$_debug) {
			$this->_log("QUERY_COUNT_SUC:\t$sql");
		}
		$row = $res->fetchRow(MDB2_FETCHMODE_ASSOC);
		return intval($row['count(1)']);
	}//}}}

	//{{{ insert($table, $condition, $needIncId = true)
	/**
	 * insert 
	 *
	 * 插入一条数据
	 * 
	 * @param string	$table		表名	
	 * @param array		$condition	插入的数据map
	 * @param boolean	$needIncId	是否需要返回自增id
	 * @access public
	 * @return int/boolean		当needIncId == true时返回自增id，否则返回成功状态
	 */
	public function insert($table, $condition, $needIncId = true) {
		foreach ($condition as $key => $value) {
			$keys[] = "`$key`";
			$values[] = "'" . self::escapeString($value) . "'";
		}
		$sql = "INSERT INTO $table (" .implode(',', $keys). ") VALUES (" .implode(',', $values). ")";
		$res = $this->_mConnection->exec($sql);
		if (MDB2::isError($res)) {
			$this->_log("INSERT\t$sql\t" . $res->getMessage());
			return false;
		}
		if (self::$_debug) {
			$this->_log("INSERT_SUC:\t$sql");
		}
		if (!$needIncId) {
			return $res;
		}
		$res = $this->_mConnection->lastInsertID($table);
		if (MDB2::isError($res)) {
			$this->_log("LAST_ID\t$table\t" . $res->getMessage());
			return false;
		}
		return $res;
	}//}}}

	//{{{ insertOrUpdate($table, $params, $uniqKey)
	/**
	 * insert 
	 *
	 * 插入一条数据
	 * 
	 * @param string	$table		表名	
	 * @param array		$params 插入的数据map
	 * @param array		$uniqKey 唯一索引
	 * @access public
	 * @return boolean	返回成功状态
	 */
	public function insertOrUpdate($table, $params, $uniqKey) {
		foreach ($params as $key => $value) {
			$keys[] = "`$key`";
			$values[] = "'" . self::escapeString($value) . "'";
			if (!in_array($key, $uniqKey)) {
				$updates[] = "`$key`='".self::escapeString($value)."'";
			}
		}
		$sql = "INSERT INTO $table (" .implode(',', $keys). ") VALUES (" .implode(',', $values). ") ON DUPLICATE KEY UPDATE ".implode(',', $updates);
		$res = $this->_mConnection->exec($sql);
		if (MDB2::isError($res)) {
			$this->_log("INSERT\t$sql\t" . $res->getMessage());
			return false;
		}
		if (self::$_debug) {
			$this->_log("INSERTORUPDATE_SUC:\t$sql");
		}
		return $res;
	}//}}}

	//{{{ replace($table, $condition, $needIncId = true)
	/**
	 * insert 
	 *
	 * 覆盖一条数据
	 * 
	 * @param string	$table		表名	
	 * @param array		$condition	插入的数据map
	 * @param boolean	$needIncId	是否需要返回自增id
	 * @access public
	 * @return int/boolean		当needIncId == true时返回自增id，否则返回成功状态
	 */
	public function replace($table, $condition, $needIncId = true) {
		foreach ($condition as $key => $value) {
			$keys[] = "`$key`";
			$values[] = "'" . self::escapeString($value) . "'";
		}
		$sql = "REPLACE INTO $table (" .implode(',', $keys). ") VALUES (" .implode(',', $values). ")";
		$res = $this->_mConnection->exec($sql);
		if (MDB2::isError($res)) {
			$this->_log("INSERT\t$sql\t" . $res->getMessage());
			return false;
		}
		if (self::$_debug) {
			$this->_log("REPLACE_SUC:\t$sql");
		}
		if (!$needIncId) {
			return $res;
		}
		$res = $this->_mConnection->lastInsertID($table);
		if (MDB2::isError($res)) {
			$this->_log("LAST_ID\t$table\t" . $res->getMessage());
			return false;
		}
		return $res;
	}//}}}

	//{{{ update($table, $condition, $param)
	/**
	 * update 
	 *
	 * 修改数据
	 * 
	 * @param string	$table	
	 * @param array		$condition	
	 * @param array		$param
	 * @access public
	 * @return boolean
	 */
	public function update($table, $condition, $param) {
		$conditions = self::buildCondition($condition);
		if (!$conditions) {
			$this->_log("UPDATE_NO_CONDITION\t$table\t".http_build_query($param));
			return false;
		}
		$params = array();
		foreach ($param as $key => $value) {
			$params[] = "`$key` = '" . self::escapeString($value) . "'";
		}
		if (!$params) {
			$this->_log("UPDATE_NO_PARAMS\t$table\t".http_build_query($condition));
			return false;
		}
		$sql = "UPDATE $table SET " . implode(',', $params). " WHERE $conditions";
		$res = $this->_mConnection->exec($sql);
		if (MDB2::isError($res)) {
			$this->_log("UPDATE\t$sql\t" . $res->getMessage());
			return false;
		}
		if (self::$_debug) {
			$this->_log("UPDATE_SUC:\t$sql");
		}
		return $res;
	}//}}}

	//{{{ delete($table, $condition)
	/**
	 * delete 
	 *
	 * 删除数据
	 * 
	 * @param string	$table	
	 * @param array		$condition	
	 * @access public
	 * @return boolean
	 */
	public function delete($table, $condition) {
		$conditions = self::buildCondition($condition);
		if (!$conditions) {
			$this->_log("DELETE_NO_CONDITION\t".http_build_query($param));
			return false;
		}
		$sql = "DELETE FROM $table WHERE $conditions";
		$res = $this->_mConnection->exec($sql);
		if (MDB2::isError($res)) {
			$this->_log("DELETE\t$sql\t" . $res->getMessage());
			return false;
		}
		if (self::$_debug) {
			$this->_log("DELETE_SUC:\t$sql");
		}
		return $res;
	}//}}}

	//{{{ excute($sql)
	/**
	 * @description 数据库查询语句，主要用于复杂查询,如果用于非select查询，返回结果表示成功与否
	 *
	 * @param unknown_type $sql，sql语句
	 * @return unknown
	 */
	public function excute($sql)
	{
		$startTime = microtime(true);
		$ret = $this->_mConnection->query($sql);
		$costTime = sprintf('%01.4f', microtime(true) - $startTime);
		if (MDB2::isError($ret)) {
			$msg = $ret->getMessage();
			$this->_log($sql.", ".$costTime.", ".$msg);
			return null;
		}
		if (self::$_debug) {
			$this->_log("EXCUTE_SUC:\t$sql");
		}
		if ($costTime > 1) {
			$this->_log("SLOW QUERY:\t$sql");
		}
		
		//循环数据
		$result = array();
		if (is_object($ret)) {
			while ($row = $ret->fetchRow(MDB2_FETCHMODE_ASSOC)) {
				$result['list'][] = $row; 
			}
			$result['count'] = count($result['list']);
			$ret->free();
			return $result;
		}
		
		return $result;
	}//}}}

	public function query($sql) {
		$startTime = microtime(true);
		$ret = parent::query($sql);
		$costTime = sprintf('%01.4f', microtime(true) - $startTime);
		if ($costTime > 1) {
			$this->_log("SLOW QUERY:\t$sql");
		}
		return $ret;
	}

	//{{{ private functions
	/**
	 * _getInstName 
	 *
	 * 生成数据库连接索引id的方法
	 * 
	 * @param string	$host	
	 * @param string	$port	
	 * @param string	$user	
	 * @param string	$passwd	
	 * @param string	$dbName	
	 * @static
	 * @access private
	 * @return array
	 */
	private static function _getInstName($host, $port, $user, $passwd, $dbName) {
		return "$host:$port:$user$passwd:$dbName";
	}
	
	/**
   * @description写日志
   *
   * @param string $message，日志内容
   */
	private function _log ($message) {
		//设置日志文件名
		$msg = date("Y-m-d H:i:s")." ".$message."\n";
		if(defined("DB_LOG_ENABLE") && DB_LOG_ENABLE == false) {
			return;
		}
		else{
			error_log($msg, 3, $this->_logFile);
		}
	}
	
	/**
   * @description Escape string, deny injection
   * @param string $string
   * @return string
   */
	static public function escapeString($string) {
		return addslashes($string);
	}
	
	//{{{ selectGroupList($table, $condition, $groupby, $order, $offset = 0, $rowCount = 20, $cols = '*', $needCount = false)
	/**
	 * selectList 
	 *
	 * 查询一个翻页列表
	 * 
	 * @param string	$table			表名
	 * @param array		$condition		条件数组	
	 * @param array		$groupby		聚合字段
	 * @param array		$order			排序数组	
	 * @param int		$offset			偏移量，默认为0
	 * @param int		$rowCount		单页获取数量，默认为20
	 * @param string	$cols			读取的列，默认为全部
	 * @param boolean	$needCount		是否需要获取总数，默认不获取
	 * @access public
	 * @return array	返回数组中list为列表数据，count为总数。
	 */
	public function selectGroupList($table, $condition, $groupby, $order, $offset = 0, $rowCount = 20, $cols = '*', $needCount = false) {
		$conditions = self::buildCondition($condition);
		$conditions = $conditions ? (' WHERE ' . $conditions) : '';
		$groupstr = ' GROUP BY '.$groupby;
		$orders = self::buildOrder($order);
		$orders = $orders ? ($orders = ' ORDER BY ' . $orders) : '';
		$offset = $offset ? intval($offset) : 0;
		$rowCount = $rowCount ? intval($rowCount) : 20;
		$cols = strlen($cols) ? $cols : '*';
		if ($needCount) {
			$sqlList = "SELECT SQL_CALC_FOUND_ROWS $cols,count(1) AS count FROM " . $table . "$conditions$groupstr$orders LIMIT $offset, $rowCount";
			$res = $this->_mConnection->query($sqlList);
			if (MDB2::isError($res)) {
				$this->_log("QUERY_GROUP_LIST\t$sqlList\t" . $res->getMessage());
				return false;
			}
			if (self::$_debug) {
				$this->_log("QUERY_GROUP_LIST_SUC:\t$sqlList");
			}
			$list = $res->fetchAll(MDB2_FETCHMODE_ASSOC);
			$sqlCount = 'SELECT FOUND_ROWS()';
			$res = $this->_mConnection->query($sqlCount);
			if (MDB2::isError($res)) {
				$this->_log("QUERY_COUNT\t$sqlCount\t" . $res->getMessage());
				return false;
			}
			$count = $res->fetchOne();
			return array(
				'list'	=> $list,
				'count'	=> $count,
			);
		} else {
			$sqlList = "SELECT $cols,count(1) AS `count` FROM " . $table . "$conditions$groupstr$orders LIMIT $offset, $rowCount";
			$res = $this->_mConnection->query($sqlList);
			if (MDB2::isError($res)) {
				$this->_log("QUERY_LIST\t$sqlList\t" . $res->getMessage());
				return false;
			}
			if (self::$_debug) {
				$this->_log("QUERY_LIST_SUC:\t$sqlList");
			}
			$list = $res->fetchAll(MDB2_FETCHMODE_ASSOC);
			return array(
				'list'	=> $list,
			);
		}
	}//}}}
	/**
	 * @description 构造查询条件
	 *
	 * @param unknown_type $params
	 * @return unknown
	 */
	private static function buildCondition($params)
	{
		if (!is_array($params) || !$params) {
			return "";
		}
		
		$condition = " ";
		$logic = isset($params['logic'])?trim(strtoupper($params['logic'])):"AND";
		if ($logic != "AND" && $logic != "OR") {
			$this->_log("buildCondition, ".json_encode($params).", 连接符logic：$logic 参数错误");
			return "";
		}

		$conditions = array();
		foreach ($params as $one) {
			$one[2] = isset($one[2]) ? $one[2] : '=';
			$one[2] = strtoupper($one[2]);
			switch($one[2]) {
				case 'IN':
					$conditions[] = "`{$one[0]}` IN ({$one[1]})";
					break;
				default:	
					$one[1] = self::escapeString($one[1]);
					$conditions[] = "`{$one[0]}` {$one[2]} '{$one[1]}'";
					break;
			}
		}
		
		$con = implode(" $logic ", $conditions);
		return $con;
	}

	/**
	 * buildOrder 
	 *
	 * 生成order语句
	 * 
	 * @param array $params	
	 * @static
	 * @access private
	 * @return string
	 */
	private static function buildOrder($params) {
		if (!is_array($params) || !$params) {
			return "";
		}
		$orders = array();
		foreach ($params as $one) {
			$logic = isset($one[1]) ? $one[1] : "DESC";
			$logic = strtoupper($logic);
			if ($logic != "DESC" && $logic != "ASC") {
				$this->_log("buildOrder, ".json_encode($params).", 连接符logic：$logic 参数错误");
				return "";
			}
			$orders[] = "$one[0] $one[1]";
		}
		return implode(',', $orders);
	}
	//}}}
}
