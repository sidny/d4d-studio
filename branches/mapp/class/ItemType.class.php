<?php
class ItemType extends Base {
	protected static $table = "item_type";

	public static function search($keyword){
		$condition[] = array('title', '%' . $keyword .'%', 'like');
		return self::getList(array('condition' => $condition));
	}
	public static function getList($params,$offset = null, $count = null ){
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
