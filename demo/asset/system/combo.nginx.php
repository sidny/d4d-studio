<?php
$assetPath  = dirname(__FILE__) . '/../';
require_once($assetPath.'../config/config.web.php');
$files      = $_SERVER['QUERY_STRING'];
$split      = '__';
$str        = '';
$len        = 7; // len for '/combo/'
$file       = md5($files);
$real       = ROOT."/tmp/$file";
$alias      = "combine/$file";

list($files) = explode('?', $files);
//$tmp        = substr($files, $len);
$tmp = $files;
//$tmp        = ltrim(strstr($tmp, '/'), '/');
$files      = explode($split, $tmp);
header('Content-Type: '.getMimeType($assetPath . $files[0]));
if(file_exists($real)) {
    $mtime  = filemtime($real);
    $old    = false;
    foreach($files as $k=>$v) {
        if(is_numeric($v) or empty($v))
        {
            unset($files[$k]);
            continue;
        }

        $filepath = $assetPath . $v;
        if(!is_file($filepath)) die;

        if(filemtime($filepath) > $mtime) {
            $old = true;
            break;
        }
    }
if (file_exists($real)) {;
    if(!$old) {
  //      header("X-Accel-Redirect: $alias");
        header("X-SendFile: $real");
        die;
    }
}else{
    var_dump($alias);
    die;
}
} 

$tmp = tempnam('/tmp', 'combo');
foreach($files as $k => $v) 
    $files[$k] = escapeshellcmd($assetPath . $v);
system("cat " . join(' ', $files) . " > $tmp 2>/dev/null");
rename($tmp, $real);

//header("X-Accel-Redirect: $alias");
var_dump($alias);
die;
//header("X-SendFile: $alias");

function getMimeType($filename, $ext=null) {
       if(empty($ext))
    {
        preg_match('/\.([^\.]*?)$/', $filename, $m);    # Get File extension for a better match
        $ext = $m[1];
    }
    switch($ext){
    case 'js': return 'application/javascript';
    case 'json': return 'application/json';
    case 'jpg': case 'jpeg': case 'jpe': return 'image/jpg';
    case 'png': case 'gif': case 'bmp': return 'image/'.strtolower($m[1]);
    case 'css': return 'text/css';
    case 'xml': return 'application/xml';
    case 'html': case 'htm': case 'php': return 'text/html';
    default: 
        if(function_exists('mime_content_type')){ # if mime_content_type exists use it.
            $m = mime_content_type($filename);
        }else if(function_exists('')){    # if Pecl installed use it
            $finfo = finfo_open(FILEINFO_MIME);
            $m = finfo_file($finfo, $filename);
            finfo_close($finfo);
        }else{    # if nothing left try shell
            if(strstr($_SERVER['HTTP_USER_AGENT'], 'Windows')){ # Nothing to do on windows
                return ''; # Blank mime display most files correctly especially images.
            }
            if(strstr($_SERVER['HTTP_USER_AGENT'], 'Macintosh')){ # Correct output on macs
                $m = trim(exec('file -b --mime '.escapeshellarg($filename)));
            }else{    # Regular unix systems
                $m = trim(exec('file -bi '.escapeshellarg($filename)));
            }
        }
        $m = explode(';', $m);
        return trim($m[0]);
    }
}
