<?php
class <{$table|javaClassName}> extends Base {

	const TABLE_<{$table|strtoupper}>	= '<{$table}>';
<{foreach from=$column item=item}>
	const COL_<{$item.field|strtoupper}> = '<{$item.field}>';
<{/foreach}>	

	public static function getList() {
		self::clearError();
		$db = self::_getDb();
		$condition = array();
		$connList = $db->selectAll(self::TABLE_<{$table|strtoupper}>, $condition, array());
		if (!$connList) {
			self::setError('');
			return false;
		}
		$items = array();
		foreach ($connList['list'] as $one) {
			$items[] = array(
<{foreach from=$column item=item}>
			 '<{$item.field}>' => $one[self::COL_<{$item.field|strtoupper}>],
<{/foreach}>
			);
		}
		if (count($items) == 0) {
			return array();
		}
		return $items;
	}
	private static function _getDb() {
		return DataBase::instance(DB_GLOBAL_IP, DB_GLOBAL_PORT, DB_GLOBAL_USER, DB_GLOBAL_PASSWD, DB_GLOBAL_NAME, DB_GLOBAL_LOG);
	}

	public static function delCache($connectId) {
		$key = "observer_UserConnectAccount_$connectId";
		$memcache = new Memcached;
		foreach($GLOBALS['MEMCACHE_SERVER'] as $v) {
			$memcache->addServer($v['host'], $v['port'], $v['weight']);
		}
		$memcache->setOption(Memcached::OPT_HASH, Memcached::HASH_CRC);
		$memcache->setOption(Memcached::OPT_DISTRIBUTION, Memcached::DISTRIBUTION_CONSISTENT);
		$memcache->delete($key);
	}
}
class <{$table|strtoupper}> implements ArrayAccess {
<{foreach from=$column item=item}>
	var $<{$item.field}>;
<{/foreach}>	
	public function __construct($info) {
<{foreach from=$column item=item}>
		$this-><{$item.field}>		= $info['<{$item.field}>']; //<{$item|@var_dump}>
<{/foreach}>	
	}
}
