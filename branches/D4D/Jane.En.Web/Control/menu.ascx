<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="menu.ascx.cs" Inherits="D4D.Web.Control.menu" %>
<div class="sub-title">
  <p class="title"><%=Channel %></p>
  <p class="nav-link">您的位置：首页 > <%=Channel %></p>
</div>
<div class="sub-nav">
  <ul>
    <li>》<font color="red">全部新闻</font></li>
    <li>》<a href="#">公司新闻</a></li>
    <li>》<a href="#">张靓颖新闻</a></li>
    <li>》<a href="#">王铮亮新闻</a></li>
  </ul>
</div>
<script  runat="server">
    public string Channel;
    private static Hashtable channelList = new Hashtable();
    
    protected void Page_Load(object sender, EventArgs e)
    {
        channelList["news"] =  "星文";
        channelList["anews"] = "星文";
        string[] path = Request.AppRelativeCurrentExecutionFilePath.Split('/');
        if (path.Length >= 3)
        {
            Channel = channelList[path[2]] as string;
        }
    }    
</script>