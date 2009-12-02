<%@ Control Language="C#" AutoEventWireup="true" %>
<script type="text/javascript">
    var menuData = {
        "home": { text: "首页", url: "/" },
        "news": { text: "资讯", url: "/news.html" },
        "calender": { text: "行程", url: "/calender.html" },
        "singer": { text: "档案", url: "/singer.html" },
        "music": { text: "唱片", url: "/music.html" },
        "video": { text: "视频", url: "/video.html" },
        "photo": { text: "图片", url: "/photo.html" },
        "bbs": { text: "论坛", url: "http://bbs.janezhang.com", target: "_blank" },
        "shop": { text: "商城", url: "/shop.html" }
    };
    var channel = "<%=channel %>" ;
    menuData[channel].isCurrent = true;
    function menuReady(func) {
        var flash = window["menu"] || document["menu"];
        setTimeout(function() {
            flash.setMenu(menuData);
        }, 500);
    }
</script>
<div class="head">
  <div class="head_login">
   <%if (D4D.Web.Helper.AdminHelper.CurrentUser == null)
          { %>
  <a href="#" id="btnLogin">登录</a> | <a href="http://bbs.janezhang.com/register.aspx?agree=yes">注册</a>
  <div style="display:none"><div class="login" id="loginForm">
    <iframe style="width:398px; height:240px; position:absolute;z-index:-1; top:0; left:0; border:0;"></iframe>
    <form action="/svc/user.svc/Login">
	  <div class="login_title">
		<h1 class="font14">登录张靓颖官方网站</h1>
		<span onclick="$.unblockUI()"><img src="/static/images/ico_close_01.gif" /></span>
	  </div>
	  <div class="spacer" style="height:30px"></div>
	  <div class="login_row">
		<div class="login_row_name font14 floatleft">
		  用户名字：
		</div>
		<div class="login_row_con floatright">
			<input type="text" name="username" style="width:180px; height:16px;line-height:16px;" class="input_02 font14" />
		</div>
		<div class="clear"></div>
	  </div>
	  <div class="spacer"></div>
	  <div class="spacer"></div>
	  <div class="login_row">
		<div class="login_row_name font14 floatleft">
		  密&nbsp;&nbsp;&nbsp;&nbsp;码：
		</div>
		<div class="login_row_con floatright">
			<input type="password" name="password" style="width:180px; height:16px;line-height:16px;" class="input_02 font14" />
		</div>
		<div class="clear"></div>
	  </div>
	  
	  <div class="spacer"></div>
	  <div class="spacer"></div>
	  <div class="login_row">
		<div class="login_row_name font14 floatleft">
		 &nbsp;
		</div>
		<div class="login_row_con floatright">
			<input type="submit" value="登录" />
			<div class="vspacer"></div>
			<div class="floatleft" style="line-height:20px"><a href="http://bbs.janezhang.com/register.aspx?agree=yes">立即注册</a> | <a href="http://bbs.janezhang.com/getpassword.aspx">忘记密码</a></div>	
		</div>
		<div class="clear"></div>
	  </div>
	  
	  <div class="spacer"></div>
	  <div class="spacer"></div>
	  
	  
	  <div class="login_foot">登录张靓颖官方网站，获得更多精彩资讯</div>
	  <div class="spacer"></div>
	</div></div>
   <%}
          else
          { %>
          <label><%=D4D.Web.Helper.AdminHelper.CurrentUser.UserName %></label> | <a href="#" id="logout">退出登录</a>
        <%} %>
| <a href="#">语言选择</a><img src="/static/images/ico_arrow.gif" align="absmiddle" />
  </div>
  <div>
  <script type="text/javascript">
          AC_FL_RunContent(
		"src", "/static/images/menu",
		"width", "1300",
		"height", "40",
		"align", "middle",
		"id", "menu",
		"quality", "high",
		"name", "menu",
		"allowScriptAccess", "always",
		"wmode","transparent",
		"type", "application/x-shockwave-flash",
		"pluginspage", "http://www.adobe.com/go/getflashplayer"
	);
</script>  
  
  </div>
</div>
<script type="text/javascript">
    $(document).ready(function() {
        $("#loginForm form").ajaxForm(
        { success: function(response) {
            if (response.d && response.d.UserId > 0) {
                $.unblockUI();
                alert("登录成功");
                location.reload();
            } else {
                alert("您输入的用户名密码有误，请重试");
            }
        }, dataType: "json"
        })
        .find("a:eq(0)").click(function() {
            $("#loginForm form").submit();
        });

        $('#btnLogin').click(function() {
            $.blockUI({ message: $('#loginForm'),
                css: {
                    width: 396,
                    left: ($(window).width() - 396) / 2,
                    top: ($(window).height() - 300) / 2,
                    border: "none"                    
                }
            });
            $('.blockOverlay').attr('title', '点击取消登陆').click($.unblockUI);

        });
        $("#logout").click(function() {
            $.getJSON("/svc/user.svc/LoginOut");
            window.location.reload();
            return false;
        });
    }); 
</script>
<script runat="server">
    protected void Page_Load(object sender, EventArgs e)
    {
        string[] path = Request.AppRelativeCurrentExecutionFilePath.Split('/');
        if (path.Length >= 3)
        {
            channel = path[2];
        }
    }
    private string channel = "home";
    protected string GetMenu( string str)
    {

        if (str == channel) return "";
        else return "off_";
        
    }
    
</script>