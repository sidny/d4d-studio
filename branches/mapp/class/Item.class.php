<?php

class Item {

	static private $tablename = "yashion_content";

	
	public function __construct() {
	  
	}
	private static function Instance()
	{
		if (!isset(self::$msInstance)) {
			self::$msInstance = new self;
		}
	}

	/**
	 * Returns all the rows from the table.
	 *
	 * Add authroization or any logical checks for secure access to your data 
	 *
	 * @return array
	 */
	static public  function getAllItem($lang = 'cn',$typeId = null,$club= null) {
		if(is_string($lang))
		$condition['lang'] = $lang;
		if($typeId){
			$condition['typeId'] = $typeId;
		}
		$condition['club'] = $club;
		
		$param = array(
			'condition' => $condition,
			'order' => 'id desc', 
		);
		$result = tdb::select(self::$tablename,$param);
		
		return $result;
	}

	/**
	 * Returns the item corresponding to the value specified for the primary key.
	 *
	 * Add authorization or any logical checks for secure access to your data 
	 *
	 * 
	 * @return stdClass
	 */
	public function getItemByID($itemID) {
		$params = array(
		 	'condition' =>array(
				'id' => $itemID,
			),
		);
		return tdb::select(self::$tablename,$params);
	}

	/**
	 * Returns the item corresponding to the value specified for the primary key.
	 *
	 * Add authorization or any logical checks for secure access to your data 
	 *
	 * 
	 * @return stdClass
	 */
	public function createItem($item) {
		return tdb::insert(self::$tablename,$item);
	}

	/**
	 * Updates the passed item in the table.
	 *
	 * Add authorization or any logical checks for secure access to your data 
	 *
	 * @param stdClass $item
	 * @return void
	 */
	public function updateItem($item) {
		if(isset($item['id'])){
			$id = $item['id'];
			unset($item['id']);
			
			$params['set'] =$item;
			$params['condition'] = array('id' => $id); 
			return tdb::update(self::$tablename,$params);
		}
		return false;
	}

	/**
	 * Deletes the item corresponding to the passed primary key value from 
	 * the table.
	 *
	 * Add authorization or any logical checks for secure access to your data 
	 *
	 * 
	 * @return void
	 */
	public function deleteItem($itemID) {
		$condition = array(
			'id' => $itemID
		);
		
		$result =  tdb::delete(self::$tablename,array('condition' => $condition));
		
		if($result)
			return array('code'=>0,'msg'=>'操作成功','data'=>$result);
		else
			return array('code'=>1,'msg'=>'操作失败','data'=>$result);
	}


	/**
	 * Returns the number of rows in the table.
	 *
	 * Add authorization or any logical checks for secure access to your data 
	 *<em></em>
	 * 
	 */
	public function count($lang='cn',$typeId,$club=null) {
		if(is_string($lang))
		$condition['lang'] = $lang;
		if($typeId){
			$condition['typeId'] = $typeId;
		}
		$condition['club'] = $club;
		
		return tdb::count(self::$tablename,array('condition' => $condition));
	}


	/**
	 * Returns $numItems rows starting from the $startIndex row from the 
	 * table.
	 *
	 * Add authorization or any logical checks for secure access to your data 
	 *
	 * 
	 * 
	 * @return array
	 */
	public function getItem_paged($lang = 'cn',$startIndex, $numItems,$typeId,$club = null) {
		if(is_string($lang))
		$condition['lang'] = $lang;
		if($typeId){
			$condition['typeId'] = $typeId;
		}
		
		$condition['club'] = $club;
		
	//	var_dump($club);
		$param = array(
			'condition' => $condition,
			'order' => 'id desc', 
			'limit' => $numItems,
			'offset' => $startIndex,
		);
		$result = tdb::select(self::$tablename,$param);

		return $result;
	}
	
	
}
