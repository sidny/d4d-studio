<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/MasterPage/Main.Master" %>

<%@ Import Namespace="D4D.Platform.Domain" %>
<%@ Import Namespace="D4D.Web.Helper" %>
<asp:Content ContentPlaceHolderID="ContentHeader" runat="server" ID="ContentHeader">
</asp:Content>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentMain" runat="server">
<div class="sub-title">
  <p class="title">艺人</p>
  <p class="nav-link">您的位置：首页 > 艺人 > <%=BandInfo.BandName %></p>
</div>
 
<style title="text/css"> 
.sub-nav li.sub {
    background:none; height:auto; line-height:21px; font-weight:normal; padding:5px 30px; 
}
.sub-nav li.sub a {
    display:block; font-size:12px;
}
</style>

<div class="sub-nav clearfix">
  <ul>
    <%
        System.Collections.Generic.List<BandInfo> list = new System.Collections.Generic.List<BandInfo>();
        list.Add(new BandInfo()
        {
            BandId = 0,
            BandName = "全部艺人"
        });
        list.AddRange(Helper.BandColl.Values);
        foreach (BandInfo i in list)
      {
          if (i.BandId == BandId)
          {
           %>
            <li>》<font color="red"><%=i.BandName%></font></li>
            <%if (i.BandId > 0)
              { %>
            <li class="sub">
                <a href="#profile">&gt; <font color="red">个人档案</font></a>
                <a href="/calender/b<%=i.BandId %>/d<%=DateTime.Now.ToString("yyyyMM") %>.html">&gt; 星程</a>
                <a href="/photo/<%=i.BandId %>.html">&gt; 图片</a>
                <a href="/video.html?id=<%=i.BandId %>">&gt; 视频</a>
            </li>
    
    <%}
          }
          else
          {%>
     <li>》<a href="/singer/<%=i.BandId %>.html"><%=i.BandName%></a></li>
    <%}
      } %>
   
  </ul>
</div>
<asp:Panel runat="server" ID="bandAll">
    <div class="band-all">
        <ul>
        <%  foreach (BandInfo i in Helper.BandColl.Values)
            { %>
            <li class="clearfix">
            	<p class="img"><img src="<%=i.Info3 %>" height="180" width="180" /></p>
                <p style="color:#f00; font-size:14px;"><%=i.BandName %></p>
                <br/>
                <p><%=i.Remark %></p>
                <p class="links"><br/><a href="/singer/<%=i.BandId %>.html">档案</a>
                <a href="/calender/b<%=i.BandId %>/d<%=DateTime.Now.ToString("yyyyMM") %>.html">星程</a>
                <a href="/photo/<%=i.BandId %>.html">图片</a>
                <a href="/music/<%=i.BandId %>.html">音乐</a>
                <a href="/video.html?id=<%=i.BandId %>">视频</a></p>
            </li>
            <%} %>
        </ul>
    </div>
</asp:Panel>
<asp:Panel runat="server" ID="bandPanel" Visible="false">
    <script type="text/javascript" src="/static/SpryAssets/SpryTabbedPanels.js"></script>

    <div class="main">
        <div class="channel">
            <h1><%=BandInfo.BandName%> /
                <font color="red">个人档案</font></h1>
        </div>
        <div class="singer">
            <div class="clearfix">
                <%if (!string.IsNullOrEmpty(BandInfo.Info2))
                  { %>
                <img src="<%=BandInfo.Info2 %>" vspace="20" />
                <%} %>
            </div>
            <div class="content">
            <a name="profile"></a>
                <div id="TabbedPanels1" class="TabbedPanels">
                    <ul class="TabbedPanelsTabGroup">
                        <li class="TabbedPanelsTab" tabindex="0">档案 </li>
                        <li class="TabbedPanelsTab" tabindex="0">历程</li>
                        <li class="TabbedPanelsTab" tabindex="0">奖项</li>
                        <li class="TabbedPanelsTab" tabindex="0">专辑</li>
                    </ul>
                    <div class="TabbedPanelsContentGroup">
                        <div class="TabbedPanelsContent">
                            <%=GetProfile(0)%>
                        </div>
                        <div class="TabbedPanelsContent">
                            <%=GetProfile(1)%>
                        </div>
                        <div class="TabbedPanelsContent">
                            <%=GetProfile(2)%>
                        </div>
                        <div class="TabbedPanelsContent">
                            <%=GetProfile(3)%>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script type="text/javascript">
        var TP1 = new Spry.Widget.TabbedPanels("TabbedPanels1");
    </script>
</asp:Panel>
</asp:Content>

<script runat="server">
    private BandInfo band;
    protected BandInfo BandInfo
    {
        get
        {
            if (band == null)
            {
                band = new BandInfo();
                band.BandId = 0;
                band.BandName = "全部";
                if(BandId>0)
                Helper.BandColl.TryGetValue(BandId, out band);
            }

            return band;
        }
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        
            if (BandId > 0)
            {
                bandPanel.Visible = true;
                bandAll.Visible = false;
            }
    }
    protected string GetProfile(int type)
    {
        if (BandId > 0)
        {
            return D4D.Platform.D4DGateway.BandInfoProvider.ReadProfileContent(BandId, type);
        }
        return string.Empty;
    }
    protected int BandId
    {
        get
        {
            if (String.IsNullOrEmpty(Request["id"]))
            {
                return 0;
            }
            else
            {
                return int.Parse(Request["id"]);
            }
        }
    }    
    
</script>

