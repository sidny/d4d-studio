<%@ Control Language="C#" AutoEventWireup="true" %>
<%@ Import Namespace="D4D.Platform.Domain" %>
<div class="sub-title">
  <p class="title">音乐</p>
  <p class="nav-link">您的位置：首页 > <%=Channel %></p>
</div>
<div class="sub-nav">
    <ul>
  <asp:Repeater runat="server" ID="menuList">
    <HeaderTemplate>
        <li>》<%#GetLink(Container.DataItem) %></li>
        
    </HeaderTemplate>
    <ItemTemplate>
        <li>》<%#GetLink(Container.DataItem) %></li>
        
    </ItemTemplate>
    </asp:Repeater>
  </ul>
  
</div>
<script  runat="server">
    public string Channel;
    private static Hashtable channelList = new Hashtable();
    
    protected void Page_Load(object sender, EventArgs e)
    {
        menuList.DataSource = D4D.Web.Helper.Helper.BandList;
        menuList.DataBind();
    }
    protected String GetLink(Object o)
    {
        BandInfo band = o as BandInfo;
        if (band != null)
        {
            if (Request["id"] == band.BandId.ToString())
            {
                return string.Format("<font color=\"red\">{0}音乐</font>", band.BandName);
            }
            else
            {
                return string.Format("<a href=\"http://localhost/music/b{0}.html\">{1}音乐</a>", band.BandId, band.BandName);
            }
        }
        else
        {
            if (String.IsNullOrEmpty(Request["id"]))
            {
                return string.Format("<font color=\"red\">全部音乐</font>");
            }
            else
            {
                return string.Format("<a href=\"http://localhost/music.html\">全部音乐</a>");
            }
        }

    }
   
</script>