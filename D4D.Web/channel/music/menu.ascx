<%@ Control Language="C#" AutoEventWireup="true" %>
<%@ Import Namespace="D4D.Platform.Domain" %>
<style title="text/css">
.sub-nav li.sub {
    background:none; height:auto; line-height:21px; font-weight:normal; padding:5px 30px; 
}
.sub-nav li.sub a {
    display:block;
}
</style>
<div class="sub-title">
  <p class="title">音乐</p>
  <p class="nav-link">您的位置：首页 > <%=Channel %></p>
</div>
<div class="sub-nav">
    <ul>
  <asp:Repeater runat="server" ID="menuList" OnItemDataBound="menuList_ItemDataBind">
    <HeaderTemplate>
        <li>》<%#GetLink(Container.DataItem) %></li>
        <asp:PlaceHolder runat="server" ID="Sub">
        <li class="sub">
        <% for (int i = int.Parse(DateTime.Now.ToString("yyyy")); i >= 2006; i--)
           { %>
            <a href="/music/<%=i %>.html" <% if(i.ToString() == Request["date"]){ %> style="color:red"<%} %>>&gt; <%=i%>年</a>
        <% } %>
        </li>
        </asp:PlaceHolder>
    </HeaderTemplate>
    <ItemTemplate>
        <li>》<%#GetLink(Container.DataItem) %></li>
        <asp:PlaceHolder runat="server" ID="Sub">
        <li class="sub">
        <% for (int i = int.Parse(DateTime.Now.ToString("yyyy")); i >= 2006; i--)
           { %>
            <a href="/music/b<%#((BandInfo)Container.DataItem).BandId %>/<%=i%>.html" <% if(i.ToString() == Request["date"]){ %> style="color:red"<%} %>>&gt;  <%=i%>年</a>
        <% } %>
        </li>
        </asp:PlaceHolder>
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
                return string.Format("<a href=\"/music/b{0}.html\">{1}音乐</a>", band.BandId, band.BandName);
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
                return string.Format("<a href=\"/music.html\">全部音乐</a>");
            }
        }

    }

    protected void menuList_ItemDataBind(object source, RepeaterItemEventArgs e)
    {
        PlaceHolder place = e.Item.FindControl("Sub") as PlaceHolder;
        BandInfo band = e.Item.DataItem as BandInfo;
        place.Visible = false;
        if (band == null && String.IsNullOrEmpty(Request["id"]))
        {
            place.Visible = true;
        }
        if (band != null && band.BandId.ToString() == Request["id"])
        {
            place.Visible = true;
        }
    }
</script>
