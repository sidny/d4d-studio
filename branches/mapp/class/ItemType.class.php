<?php

class ItemType {

	static private $tablename = "itemtype";

	
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
	static public  function getAllItem($parentid = null) {
		$condition = array(
			'1' => '1'
		);
		if(isset($parentid)){
			$condition['parentid'] = $parentid;
		}
		$param = array(
			'condition' => $condition,
			'order'		=> 'id asc',
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
		
		return tdb::delete(self::$tablename,array('condition' => $condition));
	}


	/**
	 * Returns the number of rows in the table.
	 *
	 * Add authorization or any logical checks for secure access to your data 
	 *
	 * 
	 */
	public function count($typeId = null) {
		$condition = array(
			'1' => '1'
		);
		if($typeId){
			$condition['typeId'] = $typeId;
		}
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
	public function getItem_paged($startIndex, $numItems,$typeId= null) {
		$condition = array(
				'1' => '1'
		);
		if($typeId){
			$condition['typeId'] = $typeId;
		}
		$param = array(
			'condition' => $condition,
			'order' => 'id asc', 
			'limit' => $numItems,
			'offset' => $startIndex,
		);
		$result = tdb::select(self::$tablename,$param);

		return $result;
	}
	
	
}
