<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="top.ascx.cs" Inherits="D4D.Web.Control.top" %>
<div class="header">
    <a href="/">
        <img src="/static/images/logo.png" alt="少城时代" /></a>
    <div class="login">
        欢迎光临少城时代，请[<a href="#">登录</a>]或[<a href="#">注册</a>]</div>
</div>
<div class="nav">
    <div class="search">
        <form action="/search/" method="get">
        <input type="image" src="/static/images/search_go.gif" align="absmiddle" style="float: right" />
        <input type="text" class="text" /></form>
    </div>
    <div><a href="/"><img src="/static/images/nav_<%=GetMenu("/") %>03.png" alt="" /></a><a href="/news.html"><img src="/static/images/nav_<%=GetMenu("news") %>04.png" alt="" /></a><a href="/calender.html"><img src="/static/images/nav_<%=GetMenu("calender") %>05.png" alt="" /></a><a href="/singer.html"><img src="/static/images/nav_<%=GetMenu("singer") %>06.png" alt="" /></a><a href="/music.html"><img src="/static/images/nav_<%=GetMenu("music") %>07.png"  alt="" /></a><a href="/video.html"><img src="/static/images/nav_<%=GetMenu("video") %>08.png" alt="" /></a><a href="/photo.html"><img src="/static/images/nav_<%=GetMenu("photo") %>09.png" alt="" /></a></div>
</div>

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