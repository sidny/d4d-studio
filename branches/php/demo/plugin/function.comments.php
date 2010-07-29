<?php

/**
* Smarty plugin: Comments
* @package Smarty
* @subpackage plugins
*
* 许健 2009-8-4 简化<{comments }>操作, 去掉大部分不必要的属性、参数
* 
* param app：应用类型：见LMComment
* param topic:应用id
* param pagesize :每页大小
* param $pageable：分页形式。1：分页显示；2：只有一页，提供显示剩余链接；其他，只有当前页，不分页
* param  sort：排序方式

@history 许健 2009-9-28, 为使"心情记录"可使用<{comments}>, 增加了可定制查询地址的query attribute
**/
define('COMMENT_DEFAULT_PAGE',1);
define('COMMENT_DEFAULT_PAGESIZE',8);



function smarty_function_comments($params, &$smarty)
{
	$app = $params['app'];
	if(!isset($app)){
		$smarty->trigger_error('Smarty plugin comments error: parameter "app" expected.');
	}

 // 可使用不同于统一的查询地址 // 计划经济时代产物 计划弃用
	$query = $params['query'];
	if(!isset($query)){
		$query = "/ajax/comments.php";
	}

	$topic = $params['topic'];
	if(!isset($topic)){
		$smarty->trigger_error('Smarty plugin comments error: parameter "topic_key" expected.');
	}
	
	$p = isset($params['p'])?$params['p']:1;
			
	$pagesize = $params['pagesize'];
	if(!isset($pagesize))
		$pagesize = COMMENT_DEFAULT_PAGESIZE;
		
	$pageable = $params['pageable'];
	if(!isset($pageable))
		$pageable = 1;

	$sort = isset($params['sort'])?$params['sort']:'asc';
	if($sort != 'desc')
		$sort = 'asc';

	$async = $params['async'];
	if(!isset($async))
		$async = true;

	$useemotions = $params['useemotions'];
	if(!isset($useemotions))
		$useemotions = 'yes';
	if($useemotions != 'no' && $useemotions != '0')
		$useemotions = 'yes';

	$useforward = $params['useforward'];
	if(!isset($useforward))
		$useforward = 'yes';
	if($useforward != 'no' && $useforward != '0')
		$useforward = 'yes';
		
	if(isset($params['showseq']) && $params['showseq'])
		$showseq = true;

    $usearrow = isset($params['usearrow']) ? $params['usearrow'] : 'l';

	$userid = $params['userid'];
	
	$options = array(
			'app'         => $app,
			'topic'       => $topic,
			'query'       => $query,
			'sort'        => $sort,
			'p'           => $p,
			'pagesize'    => $pagesize,
			'pageable'    => $pageable,
			'useemotions' => $useemotions,
			'showseq'     => $showseq,
			'touserid'    => $params['owner'],
			'useforward'  => $useforward,
            'usearrow'    => $usearrow,
			);

	$html = JWTemplate::Render('comments/default.tpl', $options);
	if($params['noscript'] == 1){
		$script .= <<<EOF
			<script type="text/javascript">
			window.ENVOBJ.requireComments = window.ENVOBJ.requireComments || [];
			window.ENVOBJ.requireComments.push({'selector':'#comments-{$app}-$topic','async': $async});
			</script>
EOF;
	}else{
		$script = JWTemplate::RequireJs('/lib/jquery/jquery.form.js');
		$script .= JWTemplate::RequireJs('/core/js/jquery/commentupon/jquery.commentupon.js');
		
		if(!$options['issub']){
	    	$script .= '<script type="text/javascript">';
	    	$script .= '$("#comments-'.$app.'-'.$topic.'").commentupon({async: '.$async.'});';
	    	$script .= '</script>';
		}
	}	
	
		JWTemplate::ScriptHolder('', $script);

	return $html;
}
