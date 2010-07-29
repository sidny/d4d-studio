<?php
/**
 * @package JiWai.de
 * @copyright AKA Inc.
 * @author shwdai@gmail.com
 */
class Table
{
    public $table_name = null;
    public $pk_name = 'id';
    public $pk_value = null;
    private $column_values = array();
	static public $mDebug = false;

    public function __get($k=null)
    {
        if ( isset($this->column_values[$k]) )
            return $this->column_values[$k];
        return null;
    }

    public function __set($k=null, $v=null)
    {
        $this->column_values[$k] = $v;
    }

    public function _set_values($vs=array())
    {
        $this->column_values = $vs;
    }

    public function __construct($n=null, $record=array())
    {
        if ( is_array($n) )
        {
            $this->_set_values($n);
            return;
        }

        $this->table_name = $n;
        $this->_set_values( $record );
    }

    public function _set_pk($k=null, $v=null)
    {
        if ( $k && $v )
        {
            $this->pk_name = $k;
            $this->pk_value = $v;
        }
    }

    public function get($k=null)
    {
        if (null==$k)
            return $this->column_values;
        return $this->__get($k);
    }

    public function set($k, $v=null)
    {
        $this->column_values[$k] = $v;
    }

    public function plus($k=null, $v=1)
    {
        if ( array_key_exists($k, $this->column_values) )
        {
            $this->column_values[$k] += $v;
        }
        else throw new Exception( 'Table ' .$this->table_name. ' no column '. $k );
    }

    public function update()
    {
        $fields = func_get_args();
        if ( empty($fields) )
            return true;

        $up_array = array();
        foreach( $fields AS $f )
        {
            if ( array_key_exists($f, $this->column_values) )
            {
                $up_array[$f] = $this->column_values[$f];

            }
        }
        if (empty($up_array) )
            return true;

        return DB::Update($this->table_name, $this->pk_value, $up_array, $this->pk_name);
    }

	/**
	 * fetch db result
	 * 
	 * @param object $db 指定DB Instance
	 * @return array()
	 */
    static public function Fetch($n = null, $ids = array(), $k = 'id', $db = null) {
        if ( empty($ids) ) 
            return array();

        $single = is_array($ids) ? false : true;
        DB::CheckArray($ids);
		$ids = array_values($ids);

        $key = Memcache::GetObjectKey($n, $ids, $k);
		/*
        $memcache = Memcache::Instance();

        $cache_key = array_values($key);
        $values = (!self::$mDebug && 'id'===$k) 
            ? $memcache->Get( $cache_key )
            : array();
		*/

		$values = array();
        $n_fetch_ids = array();
        $y_fetch_record = array();
        foreach( $key AS $id => $c_key ) {
            if ( false == isset($values[$c_key]) ) {
                $n_fetch_ids[] = $id;
            } else {
                $y_fetch_record[ $id ] = $values[$c_key];
            }
        }
    
        $result = $y_fetch_record;
        if ( false==empty($n_fetch_ids) ) {
            $r_fetch_record = self::DBFetch($n, $n_fetch_ids, $k, $db);
            if ( false==empty($r_fetch_record) ) 
                $result = array_merge( $y_fetch_record, $r_fetch_record );
        }

        if ( $single ) 
            return empty($result) ? array() : array_shift($result);

        $result = Utility::AssColumn($result, $k );
        $result = Utility::SortArray($result, $ids);
        return $result;
    }

    static public function DBFetch($n=null,$ids=array(),$k='id',$db=null) {
        if ( empty($ids) ) 
            return array();

        settype($ids, 'array'); $ids = array_values($ids);

        $ids = array_diff($ids, array(NULL));
		if(is_object($db)) {
			$result = $db->LimitQuery($n, array(
				'condition' => array( $k => $ids, ),
			));
		} else {
			$result = DB::LimitQuery($n, array(
				'condition' => array( $k => $ids, ),
			));
		}

        $result = Utility::AssColumn($result, $k);

		/*
        if ( 'id' === $k )
        {
            $key = Memcache::GetObjectKey($n, $ids, $k);
            $memcache = Memcache::Instance();
            foreach( $key AS $id => $c_key )
            {
                if ( isset($result[$id]) )
                    $memcache->Set($c_key, $result[$id]);
            }
        }
		*/

        return $result;
    }

    static public function FetchAll($n=null,$ids=array(),$k='id',$db=null)
    {
        if ( empty($ids) ) 
            return array();

        DB::CheckArray($ids);
		$ids = array_values($ids);
        $ids = array_diff($ids, array(NULL));
		if(is_object($db)) {
			$result = $db->LimitQuery($n, array(
				'condition' => array( $k => $ids, ),
				'one' => false,
			));
		} else {
			$result = DB::LimitQuery($n, array(
				'condition' => array( $k => $ids, ),
				'one' => false,
			));
		}

        return $result;
    }

    static public function Load($n=null, $id=1, $k='id')
    {
        $one = is_array($id) ? false : true;
        $row = self::Fetch($n,$id,$k);

        if ( $one )
        {
            if ( $row )
            {
                $table = new Table($n, $row);
                $table->_set_pk( $k, $id );
                return $table;
            }
            return null;
        }
        else
        {	
            $tables = array();
            if ( $row )
                foreach ( $row AS $r )
                {
                    $table = new Table($n,$r);
                    $table->_set_pk( $k, $r[$k] );
                    $tables[$one[$k]] = $table;
                }
            return $tables;	
        }
    }

    static public function Count($n=null, $condition=null, $db=null) {
		if(is_object($db)) {
			$row = $db->LimitQuery( $n, array(
				'condition' => $condition,
				'select' => 'COUNT(1) AS count',
				'one' => true,
			));
		} else {
			$row = DB::LimitQuery( $n, array(
				'condition' => $condition,
				'select' => 'COUNT(1) AS count',
				'one' => true,
			));
		}
        return intval($row['count']);
    }

    static public function Delete($n=null, $id=null, $k='id')
    {
        $condition = array( $k => $id );
        return DB::Delete( $n, $condition );
    }

    /**
     * 调试用，用于打印数据查询
     */
	static public function Debug($debug=true)
	{
		self::$mDebug = true==$debug ? true: false;
	}
}
?>
