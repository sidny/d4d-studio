<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="top.ascx.cs" Inherits="D4D.Web.Control.top" %>
<div class="header">
    <a href="/">
        <img src="/static/images/logo.png" alt="少城时代" /></a>
    <div class="login">
        欢迎光临少城时代，
        <%if (D4D.Web.Helper.AdminHelper.CurrentUser == null)
          { %>
        <label>请[<a href="#" id="btnLogin" onclick="return false">登录</a>]或[<a href="/regist.html">注册</a>]</label>
        <a id="logout" style="display:none" href="/regist.html">注销</a>
        <%}
          else
          { %>
         <label><%=D4D.Web.Helper.AdminHelper.CurrentUser.UserName %></label>
         <a id="logout" href="/regist.html">注销</a>
        <%} %></div>
     <div id="loginForm" style="display:none"><form action="/svc/user.svc/Login">
            <p><label>用户名:</label><input type="text" name="username" /></p>
            <p><label>密　码:</label><input type="password" name="password" /></p>
            <p><input type="submit" value="登录" /></p>
</form></div>
</div>
<div class="nav">
    <div class="search">
        <form action="/search.html" method="get">
        <input type="image" src="/static/images/search_go.gif" align="absmiddle" style="float: right" />
        <input name="s" type="text" class="text" /></form>
    </div>
    <div><a href="/"><img src="/static/images/nav_<%=GetMenu("/") %>03.png" alt="" /></a><a href="/news.html"><img src="/static/images/nav_<%=GetMenu("news") %>04.png" alt="" /></a><a href="/calender.html"><img src="/static/images/nav_<%=GetMenu("calender") %>05.png" alt="" /></a><a href="/singer.html"><img src="/static/images/nav_<%=GetMenu("singer") %>06.png" alt="" /></a><a href="/music.html"><img src="/static/images/nav_<%=GetMenu("music") %>07.png"  alt="" /></a><a href="/video.html"><img src="/static/images/nav_<%=GetMenu("video") %>08.png" alt="" /></a><a href="/photo.html"><img src="/static/images/nav_<%=GetMenu("photo") %>09.png" alt="" /></a></div>
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
            $.blockUI({ message: $('#loginForm') });
            $('.blockOverlay').attr('title', 'Click to unblock').click($.unblockUI);

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