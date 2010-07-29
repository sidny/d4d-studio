<?php
/**
 * Smarty plugin
 * 
 * Purpose:  根据歌曲列表返回歌曲数目
 * @package Smarty
 * @subpackage plugins
 * @author guina
 */


function smarty_modifier_mcount($songs_list)
{
	$music_array = explode('#',$songs_list);
	array_shift($music_array);
	$songs_count = count($music_array);
	return $songs_count;
}