<?php
class Auth {

	static public function isLogined() {
		return isset($_SESSION['info']) && is_array($_SESSION['info']);
	}
	static public function getCurrentUser() {
		if(isset($_SESSION['info']))
		return $_SESSION['info'];
		else return null;
	}
	static public function checkLogin($username = '', $password = '') {
		$res = AdminUser::getItemByUsername($username);
		if (count($res)) {
			$res = $res[0];
			if (md5($password) == $res['passwd']) {
				$_SESSION['info'] = $res;
				return array (
					'code' => 0,
					'msg' => '成功',
				);
			}else{
				return array (
					'code' => 1,
					'msg' => '密码错误',
				); 
			}

		} else {
			return array (
				'code' => 0,
				'msg' => '没有这个用户',
			);
		}

	}
}
