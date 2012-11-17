<?php
class Photo {	
	const ERROR_PHOTO_TOO_LARGE = '上传文件过大';
	const ERROR_PHOTO_NOT_EXISTS = "文件不存在";
	const ERROR_PHOTO_UPLOAD_ERROR ="文件上传失败";
    public static function uploadFile($name) {
        self::clearError();
        if (!self::isLocalUploadSuc($name)) {
            return false;
        }
        $file = $_FILES[$name]['tmp_name'];
        $path = UPLOADPATH.date('y/m/');
        $httppath = UPLOAD.date('y/m/');
       // var_dump($path);
        if(!is_dir($path))  mkdir($path,0777,true);
        preg_match('/\.([^\.]*?)$/', $_FILES[$name]['name'], $m);    # Get File extension for a better match
 	    $ext = $m[1];
        $newfile = md5(file_get_contents($_FILES[$name]['tmp_name'])).'.'.$ext;
       	if(move_uploaded_file($file,$path.$newfile)){
       		return "http://".HOSTNAME.$httppath.$newfile;
       	}
        self::setError(self::ERROR_PHOTO_UPLOAD_ERROR);
        return false;
    }
	public static function isLocalUploadSuc($name) {
		if (!isset ($_FILES[$name])) {
			self :: setError(self::ERROR_PHOTO_NOT_EXISTS);
			return false;
		}
		elseif (0 == $_FILES[$name]['error']) {
			return true;
		}
		elseif (in_array($_FILES[$name]['error'], array (
			1,
			2
		))) {
			self :: setError(self::ERROR_PHOTO_TOO_LARGE);
			return false;
		} else {
			self :: setError(self::ERROR_PHOTO_NOT_EXISTS);
			return false;
		}

	}
	    private static $_errNo = null;
    const DEFAULT_ERRNO = 1;
    public static function clearError() {
        self::$_errNo = null;
    }
    public static function setError ($errNo) {
        self::$_errNo = $errNo;
    }
    public static function getError () {
        if (self::$_errNo) {
            return self::$_errNo;
        }
        return self::DEFAULT_ERRNO;
    }
}