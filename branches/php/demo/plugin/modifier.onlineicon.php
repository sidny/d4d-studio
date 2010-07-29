<?php
/**
 * Smarty plugin
 * @package Smarty
 * @subpackage plugins
 * @author liqingfeng
 */


/**
 * Smarty online icon modifier plugin
 *
 * Type:     modifier<br>
 * Name:     onlineicon<br>
 * Date:     2009-3-12
 * Purpose:  format user online icon
 * Input:    time
 * Example:  {$online_type|onlineicon:"$type"}
 * @version 1.0
 * $param   int $online_type 在线状态类型
 * @param 	$type	类型:1：用户名字添加在线状态icon；2：空间页个人信息添加在线状态
 * @return  String class的名字
 */
function smarty_modifier_onlineicon( $online_type, $type='1')
{
	switch($online_type)
	{
		case LMUserOnline::WWW:
			$class_name = $type==1?'icon i-webonline web':'icon i-webonline web';
		break;
		case LMUserOnline::WAP:
			$class_name = $type==1?'icon i-mobileonline wap':'icon i-mobileonline wap';
		break;
		case LMUserOnline::PCCLIENT:
			$class_name= $type==1?'icon i-online':'icon i-online';
		default:
			
	}
	return $class_name;
}
?>
