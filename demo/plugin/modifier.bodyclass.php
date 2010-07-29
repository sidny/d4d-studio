<?php
/**

 */
function smarty_modifier_bodyclass($url)
{
	$result = $url;
	if($result == '') $result = 'frontpage';
	if(in_array($url, array('userp', 'blog', 'photo', 'album', 'share', 'magic',  'music', 'friend_list'))) $result = 'space';
	return $result;
}
?>
