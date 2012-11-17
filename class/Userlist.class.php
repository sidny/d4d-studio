<?php
class Userlist extends Base {

    const TABLE_USERLIST    = 'userlist';
    const COL_ID = 'id';
    const COL_XING = 'xing';
    const COL_MING = 'ming';
    const COL_AGE = 'age';
    

    public static function getList() {
        self::clearError();
        $db = self::_getDb();
        $condition = array();
        $connList = $db->selectAll(self::TABLE_USERLIST, $condition, array());
        if (!$connList) {
            self::setError('');
            return false;
        }
        $items = array();
        foreach ($connList['list'] as $one) {
            $items[] = array(
             'id' => $one[self::COL_ID],
             'xing' => $one[self::COL_XING],
             'ming' => $one[self::COL_MING],
             'age' => $one[self::COL_AGE],
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

}
