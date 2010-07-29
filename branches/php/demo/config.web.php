<?php
if(defined('ROOT')) return;
require('config.inc.php');
if(!function_exists('autoload'))
{
    function autoload($classname)
    {   
        $filename = str_replace('_', '/',$classname) . '.class.php';

        $filepath = CLS . $filename;
        print_r($filepath);
        if(file_exists($filepath))
            return require($filepath);

        $filepath = LIB . $filename;
        if(file_exists($filepath))
            return require($filepath);

        $filepath = PEAR_LIB.$classname.'/'.$classname.'.class.php';  
        if(file_exists($filepath))
            return require($filepath);

        print_r($filepath);
        throw new Exception( $filepath . ' NOT FOUND IN PRJ_CLS');
    }   
}


spl_autoload_register('autoload');
