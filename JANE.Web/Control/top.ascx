<%@ Control Language="C#" AutoEventWireup="true" %>
<script type="text/javascript">
    function menuReady(func) {
        var flash = window["menu"] || document["menu"];
        setTimeout(function() {
            flash.setMenu([
            { text: "首页", url: "/" },
	        { text: "资讯", url: "/news.html" },
	        { text: "行程", url: "/calender.html" },
	        { text: "档案", url: "/singer.html" },
	        { text: "唱片", url: "/music.html" },
	        { text: "视频", url: "/video.html" },
	        { text: "图片", url: "/photo.html" },
	        { text: "论坛", url: "http://bbs.janezhang.com",target:"_blank" },
	        { text: "商城", url: "/shop.html" }
        ]);
        }, 500);
    }
</script>
<div class="head">
  <div class="head_login">
   <%if (D4D.Web.Helper.AdminHelper.CurrentUser == null)
          { %>
  <a href="#" id="btnLogin">登录</a> | <a href="#">注册</a> <%}
          else
          { %>
          <label><%=D4D.Web.Helper.AdminHelper.CurrentUser.UserName %></label> 
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
                $("div.login label").html(response.d.UserName);
                $("#logout").show();
            } else {
                alert("您输入的用户名密码有误，请重试");
            }
        }, dataType: "json"
        });
        $('#btnLogin').click(function() {
            $.blockUI({ message: $('#loginForm'),
								   css: { 
								   		width:500,
								   		left:($(window).width()-500)/2,
										top: ($(window).height()-$('#loginForm').height())/2,
										border:"2px solid black" } });
            $('.blockOverlay').attr('title', '点击取消登陆').click($.unblockUI);

        });
        $("#logout").click(function() {
            $.getJSON("/svc/user.svc/LoginOut");
            location.refresh();
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
    private string channel = "/";
    protected string GetMenu( string str)
    {

        if (str == channel) return "";
        else return "off_";
        
    }
    
</script>