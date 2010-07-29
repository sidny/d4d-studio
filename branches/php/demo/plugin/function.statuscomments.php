<?php

/**
* Smarty plugin
* @package Smarty
* @subpackage plugins
*
* Type:            function<br>
* Name:            comments<br>
* Purpose:         To render comments in a unify style or form, also simple etc
*                  
* @author      wangweisen<visen1118@gmail.com>
* @param       array,　其中model表示展现的样式，暂时支持JWComment::MODEL_
* @param       Smarty*
*
*
**/
define('COMMENT_DEFAULT_PAGE',1);
define('COMMENT_DEFAULT_PAGESIZE',15);

function smarty_function_statuscomments($params, &$smarty)
{
	if( isset( $params['options'] ) )
	{
		$params += $params['options'];
	}

	$app = $params['app'];
	if( !isset( $app ) ){
		$smarty->trigger_error('Smarty plugin statuscomments error: parameter "app" expected.');
	}

	$topic = $params['topic_key'];
	if( !isset( $topic ) ){
		$smarty->trigger_error('Smarty plugin statuscomments error: parameter "topic_key" expected.');
	}

	$model = $params['model'];
	if( !isset( $model ) )
		$model = JWComments::MODEL_ASYNC_ONLOAD;

	$pagesize = $params['pagesize'];
	if( !isset( $pagesize ) )
		$pagesize = COMMENT_DEFAULT_PAGESIZE;

	$maxlen = $params['maxlen'];
	if( !isset( $maxlen ) )
		$maxlen = JWComments::DEFAULT_MAX_LEN;

	$orderby = $params['orderby'];
	if( !isset( $orderby ) )
		$orderby = 'asc';

	$postable = $params['postable'];
	if( !isset( $postable ) )
		$postable = true;

	$pageable = $params['pageable'];
	if( !isset( $pageable ) )
		$pageable = true;
	
	$topic_owner_id = $params['topic_owner_id'];
	
	$hintable = $params['hintable'];	
	if( !isset( $hintable ) )
		$hintable = true;

	$abstract= $params['abstract'];
	if( !isset( $abstract) )
		$abstract = '';

	$delable= $params['delable'];
	if( !isset( $delable) )
		$delable= '';
	
	$options = array(
				'app' 		=> $app,
				'topic' 	=> $topic,
				'model' 	=> $model,
				'pagesize'	=> $pagesize,
				'orderby'	=> $orderby,
				'issub'		=> $params['issub'],
				'maxlen'	=> $maxlen,
				'postable'	=> $postable,
				'pageable'	=> $pageable,
				'hintable'	=> $hintable,
				'abstract' => $abstract,
				'delable' => $delable,
				);


	if( isset( $topic_owner_id ) )
		$options['topic_owner_id'] = $topic_owner_id;

	$subapp = JWComments::getSubCommentSetting( $app );
	if( isset( $subapp ) ){
		$subcomment = $subapp;

		if( !isset( $subcomment['pagesize'] ) ){
			$subcomment['pagesize'] = COMMENT_DEFAULT_PAGESIZE;
		}
		if( !isset( $subcomment['orderby'] ) ){
			$subcomment['orderby'] = 'asc';
		}
		if( !isset( $subcomment['maxlen'] ) ){
			$subcomment['maxlen'] = JWComments::DEFAULT_MAX_LEN;
		}

		$subcomment['model'] = JWComments::MODEL_ASYNC;
		$subcomment['issub'] = true;
		$subcomment['userid'] = $userid;
		$subcomment['postable'] = $postable;

		$options['subcomment'] = $subcomment;
	}

	JWTemplate::AddCss( array('/css/pages/comment.css' ) );
	
	$html = '<div id="comments_'.$app.'_'.$topic.'" ';

	// 检查是否为子评论
	if( $params['issub'] )
		$html .= ' style="display:none" class="commentlist replies" ';
	else
		$html .= ' class="commentlist"';
	$html .= '>';
	
	$templatehtml = JWTemplate::Render( 'statuscomment/comments.tpl', $options );
	$html .= $templatehtml;

	$html .= '</div>';

    $has_sub = isset( $subapp );
	
	$script = JWTemplate::RequireJs( '/lib/jquery/jquery.form.js' );
	$script .= JWTemplate::RequireJs( '/scripts/jquery.comments.js' );
    $params_str = '{';
    $params_str .= '"model":'.$model;
    $params_str .= ',"maxlen":'.$options['maxlen'];
    $params_str .= '}';
	
	if( !$options['issub'] ){
    	$script .= '<script type="text/javascript">';
    	$script .= '$("#comments_'.$app.'_'.$topic.'" ).comments( '.$params_str.');';
    	$script .= '</script>';
	}
	JWTemplate::ScriptHolder('', $script);

	return $html;
}
?>
