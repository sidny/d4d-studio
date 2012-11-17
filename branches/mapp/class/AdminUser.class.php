<?php
class AdminUser extends Base {
	protected static $table = "admin_user";
	public static function getItemByUsername($username){
		$condition[] = array('username', $username);
		return self::getList(array('condition' => $condition));
	}
	public static function getList($params,$offset, $count){
		return Base::getList(self::$table, $params,$offset, $count) ;
	}
	public static function add($params){
		return Base::add(self::$table,$params);
	}
	public static function del($params){
		return  Base::del(self::$table,$params);
	}
	public static function update($item){
		return  Base::update(self::$table,$item);
	}
}
