<?php
class Base{
	private static $_err = null;
	const DEFAULT_ERR = '系统未知异常';
	public static function clearError() {
		self::$_err = null;
	}   
	public static function setError($err) {
		self::$_err = $err;
	}   
	public static function getError() {
		if (self::$_err) {
			return self::$_err;
		}   
		return self::DEFAULT_ERR;
	}   
	public static function getList($table, $params = array(),$offset = 0 , $count = 20) {
		self::clearError();
		$db = self::_getDb();
		$condition = isset($params['condition']) ? $params['condition']: array();
		$order = isset($params['order']) ? $params['order']: array();
		$connList = $db->selectList($table, $condition, $order, $offset, $count, '*', true); 
		if (!$connList) {
			self::setError('');
			return false;
		}

		return $connList;
	}
	public static function update($table,$item){
		self::clearError();
		$db = self::_getDb();
		if(empty($item)){
			self::setError('数据异常');
			return false;
		}
		if(isset($item['id'])){
			$id = $item['id'];
			unset($item['id']);
			
			$params = $item;
			$condition[] = array('id' ,$id); 
			return $db->update($table,$condition,$params);
		}
		return false;
	}
	public static function add($table,$params = array()) {
		$db = self::_getDb();
		if (!$db) {
			self::setError('数据库连接异常');
			return false;
		}   
		$id = $db->insert($table, $params);
		if (false === $id) {
			self::setError('添加任务失败');
		}   
		return $id;

	}
	public static function del($table,$params) {
		$db = self::_getDb();
		if (!$db) {
			self::setError('数据库连接失败');
			return false;
		} 
		
		foreach($params as $key => $one){
			$conditions[] = array($key,$one);
		}
		return $db->delete($table, $conditions, false);
	}   

	private static function _getDb() {
		return DataBase::instance(DB_GLOBAL_IP, DB_GLOBAL_PORT, DB_GLOBAL_USER, DB_GLOBAL_PASSWD, DB_GLOBAL_NAME, DB_GLOBAL_LOG);
	}

}
