<%@ Page Language="C#" ContentType="text/html" ResponseEncoding="utf-8" %>
<%@ Import Namespace="System.Collections.Generic" %>
<%@ Import Namespace="D4D.Platform.Domain" %>
<%@ Import Namespace=" D4D.Platform" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>张靓颖官方网站</title>
</head>
<style type="text/css">
	img{border:none;}
	a{ text-decoration:none;}
	body{ background:#d1edd3 url(http://cn.janezhang.com/static/images/intro/bg.jpg) repeat-x top; padding:0; margin:0}
	#wrap{ width:960px; height:593px; margin:0 auto; position:relative}
	.intro1{ background:url(http://cn.janezhang.com/static/images/intro/tif.jpg) no-repeat; background-position:520px;}
	.intro2{ background:url(http://cn.janezhang.com/static/images/intro/intro2.jpg) no-repeat; background-position:420px;}
	.intro3{ background:url(http://cn.janezhang.com/static/images/intro/intro3.jpg) no-repeat; background-position:520px;}
	.copyright{ font-family:Verdana, Geneva, sans-serif; font-size:10px; color:#949e94; position:absolute; bottom:20px;width:470px; text-align:center;margin-left:70px; }
	.center{ background:url(http://cn.janezhang.com/static/images/intro/main.gif) no-repeat top center; width:470px; height:322px; margin-left:70px;}
	.language{ text-align:center; color:#5e719c; font-family:"微软雅黑"; font-size:20px; font-weight:bold; width:470px;  margin-left:70px;}
	.language label { padding:0 15px;}
	.language a{ color:#5e719c; text-decoration:none}
	.language a:hover{ text-decoration:underline}
	.link{width:470px;  margin-left:70px; padding-top:30px; text-align:center;}
	.link a{ margin:0 10px;}
	.link a img{ filter:Gray Alpha(Opacity=15);opacity:0.15;}
	.link a:hover img{ filter:none;opacity:1;}
	.event{right:0; position:absolute; bottom:20px;}
	.event li{ list-style:none; padding:0; margin:0;}
	.event a{font-family:"微软雅黑"; font-size:12px; text-align:center; display:block; color:#899486; line-height:30px; margin:5px auto}
</style>
<script type="text/javascript" src="http://cn.janezhang.com/static/js/jquery-1.3.2.js"></script>
<script type="text/javascript">
	$(function(){
		var  css = Math.round(Math.random() *2);
		$("#wrap").addClass("intro"+ (css+1));
  	});
</script>
<body>
<div id="wrap">
	<div><img src="http://cn.janezhang.com/static/images/intro/xas.gif" /></div>
    <div class="center"></div>
    <div class="language">　<a href="http://cn.janezhang.com">中文</a><label>|</label><a>ENGLISH</a></div>
    <div class="link">
    <a href="http://www.kaixin001.com/zhangliangying" target="_blank"><img src="/static/images/intro/kaixin.gif" /></a>
    <a href="http://www.myspace.cn/zhangliangying " target="_blank"><img src="/static/images/intro/myspace.gif" /></a>
    <a href="http://music.youku.com/JaneZhang" target="_blank"><img src="/static/images/intro/youku.gif" /></a>
    <a href="http://blog.sina.com.cn/zhangliangying" target="_blank"><img src="/static/images/intro/sina.gif" /></a>
    </div> 
    <!--  活动 end -->
    <div class="copyright">Copyright&copy; 2006 - 2009 JANEZHANG.COM, All Rights Reserved</div>
    <!--  活动  -->
    <div class="event">
    	<%=D4D.Platform.D4DGateway.CorpInfoProvider.ReadProfileContent("ad")%>
    </div>
   
</div>
</body>
</html>
