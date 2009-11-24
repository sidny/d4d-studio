<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="top.ascx.cs" Inherits="D4D.Web.Control.top" %>
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
    <object classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000" codebase="http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=7,0,19,0" width="1300" height="40">
      <param name="movie" value="/static/images/menu.swf" />
      <param name="quality" value="high" />
<param name="wmode" value="transparent" />
      <embed src="/static/images/menu.swf" quality="high" pluginspage="http://www.macromedia.com/go/getflashplayer" type="application/x-shockwave-flash" width="1300" height="40"></embed>
    </object>
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