<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/MasterPage/Main.Master" %>
<%@ Import Namespace="System.Collections.Generic" %>
<%@ Import Namespace="D4D.Platform.Domain" %>
<%@ Import Namespace="D4D.Platform" %>
<%@ Import Namespace="D4D.Web.Helper" %>
<asp:Content ContentPlaceHolderID="ContentHeader" runat="server" ID="ContentHeader">
  <style type="text/css">
  .content{ padding-bottom:20px;}
dl, dd, dt {
	padding:0;
	margin:0;
	width:auto;
}
.more {
    position:absolute;
	right:0;
	margin-top:60px;
}
.videoList,.albumList,.musicList{ position:relative;}
.musicList .more { margin-top:15px; position:static; float:right;}
.content .musicList img {
	background:url(/static/images/music/cd.gif);
	height:60px;
	width:60px;
	padding:1px 8px 2px 6px;
}
.content .musicList p {
	margin-top:15px;
	float:left;
	width:115px;
	text-align:center
}
.content .musicList a.cd {
	display:block;
	margin: 0 auto;
}
.content .musicList a.cd-title {
	display:block;
	margin:10px auto
}
dt {
	font-family:"微软雅黑", "黑体"; font-weight:bold; font-size:14px; border-bottom:1px solid #cbcbcb; height:24px; margin-top:10px;
}
.albumList { height:180px;}
.videoList { height:180px;}
.albumList dd{ float:left; width:150px; margin-right:20px; text-align:center}
.albumList dd a{ display:block; padding-top:10px; line-height:20px;}
.videoList dd{ float:left; width:150px; margin-right:20px; text-align:center}
.videoList dd a{ display:block; padding-top:10px; line-height:20px;}
</style>
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
    <li class="sub"> <a href="#profile">&gt; <font color="red">个人档案</font></a> <a href="/calender/b<%=i.BandId %>/d<%=DateTime.Now.ToString("yyyyMM") %>.html">&gt; 星程</a> <a href="/photo/<%=i.BandId %>.html">&gt; 图片</a> <a href="/video.html?id=<%=i.BandId %>">&gt; 视频</a> </li>
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
        <p class="links"><br/>
          <a href="/singer/<%=i.BandId %>.html">档案</a> <a href="/calender/b<%=i.BandId %>/d<%=DateTime.Now.ToString("yyyyMM") %>.html">星程</a> <a href="/photo/<%=i.BandId %>.html">图片</a> <a href="/music/b<%=i.BandId %>.html">音乐</a> <a href="/video.html?id=<%=i.BandId %>">视频</a></p>
      </li>
      <%} %>
    </ul>
  </div>
  </asp:Panel>
<asp:Panel runat="server" ID="bandPanel" Visible="false">
<script type="text/javascript" src="/static/SpryAssets/SpryTabbedPanels.js"></script>
<div class="main">
  <div class="channel">
    <h1><%=BandInfo.BandName%> / <font color="red">个人档案</font></h1>
  </div>
  <div class="singer">
    <div class="clearfix">
      <%if (!string.IsNullOrEmpty(BandInfo.Info2))
                  { %>
      <img src="<%=BandInfo.Info2 %>" vspace="20" />
      <%} %>
    </div>
    <div class="content"> <a name="profile"></a>
      <div id="TabbedPanels1" class="TabbedPanels">
        <ul class="TabbedPanelsTabGroup">
          <li class="TabbedPanelsTab" tabindex="0">档案 </li>
          <li class="TabbedPanelsTab" tabindex="0">历程</li>
          <li class="TabbedPanelsTab" tabindex="0">奖项</li>
          <li class="TabbedPanelsTab" tabindex="0">专辑</li>
        </ul>
        <div class="TabbedPanelsContentGroup">
          <div class="TabbedPanelsContent"><%=GetProfile(0)%></div>
          <div class="TabbedPanelsContent"> <%=GetProfile(1)%> </div>
          <div class="TabbedPanelsContent"> <%=GetProfile(2)%> </div>
          <div class="TabbedPanelsContent">
          	<div class="musicList">
            <div class="more">>><a href="/music/b<%=BandId%>.html">查看更多音乐</a></div>
            <% foreach (MusicTitle item in MusicList)
                               { %>
            <p> <a class="cd" href="/music/b<%=BandId%>/song/<%=item.MusicId %>.html"><img  src="<%=item.LImage %>" /></a> <a class="cd-title" href="/music/b<%=BandId%>/song/<%=item.MusicId %>.html"><%=item.Title %></a> </p>
            <%} %>
            </a>
          </div>
        </div>
      </div>
    </div>
    <div class="showList">
      <dl>
        <dt>星程</dt>
        <dd>
        <table width="690" border="0" cellspacing="6" cellpadding="0" class="calander">
         <% foreach (Show item in ShowList)
				   { %>
        <tr>
          <td width="56" align="center" valign="middle"><img src="<%=BandInfo.Info1%>" width="56" height="56" /><br />
			<%=BandInfo.BandName%>	</td>
          <td width="110" align="center" valign="middle"><%=item.ShowDate.ToString("yyyy-MM-dd") %></td>
          <td width="110" align="center" valign="middle"><%=item.ShowPlace %></td>
          <td width="136" align="center" valign="middle"><%=item.Title %></td>
          <td width="278" valign="middle"><%=item.Body %></td>
        </tr>
        <tr><td colspan="5" class="line"></td></tr>
         <%} %>
     	</table>
     	</dd>
      </dl>
      <div align="right">>><a href="/calender/b<%=BandId%>/d<%=DateTime.Now.ToString("yyyyMM")%>.html">查看更多星程</a></div>
      </div>
      <div class="albumList clearfix">
        <div class="more">>><a href="/music/b<%=BandId%>.html">查看更多相册</a></div>
        <dl>
          <dt>相册</dt>
          <% foreach (Album item in AlbumList)
				   { %>
          <dd>
          	<a href="/photo/album/<%=item.AlbumId %>.html"><img alt="" src="<%=item.SImage %>" /></a>
            <a href="/photo/album/<%=item.AlbumId %>.html"><%=item.Title%></a>
            </dd>
          <%} %>
        </dl>
      </div>
      <div class="videoList clearfix">
        <div class="more">>><a href="/video/b<%=BandId%>.html">查看更多视频</a></div>
        <dl>
          <dt>视频</dt>
          <% for (int i = 0; i < VideoList.Count;i++ )
                    {
                    News item = VideoList[i];%>
          <dd>
          	<a href="/video/d/<%=item.NewsId %>.html" index="<%=i %>"><img src="<%=item.SImage %>" /></a>
          	<a href="/video/d/<%=item.NewsId %>.html" index="<%=i %>"><%=item.Title %></a>
            </dd>
          <%} %>
        </dl>
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

    private List<Show> showList;
    private List<News> videoList;
    private List<MusicTitle> musicList;
    private List<Album> albumList;
    protected List<Show> ShowList
    {
        get
        {
            if (showList == null)
            {
                PagingContext pager = new PagingContext();
                pager.RecordsPerPage = 2;
                pager.CurrentPageNumber = 1;
                showList = D4DGateway.ShowProvider.GetPagedShowByBandId(pager,BandId, PublishStatus.Publish);
            }
            return showList;
        }
    }
    protected List<News> VideoList
    {
        get
        {
            if (videoList == null)
            {
                PagingContext pager = new PagingContext();
                pager.RecordsPerPage = 3;
                pager.CurrentPageNumber = 1;
                videoList = D4DGateway.NewsProvider.GetPagedNewsByNewsType(pager, (BandType)BandId, PublishStatus.Publish, NewsRemarkType.Video);
            }
            return videoList;

        }
    }
   
    protected List<MusicTitle> MusicList
    {
        get
        {
            if (musicList == null)
            {
                PagingContext pager = new PagingContext();
                pager.RecordsPerPage = 4;
                pager.CurrentPageNumber = 1;
                musicList = D4DGateway.MusicProvider.GetPagedMusicTitlesByBandId(pager,BandId, PublishStatus.Publish);
            }
            return musicList;

        }
    }
    protected List<Album> AlbumList
    {
        get
        {
            PagingContext pager = new PagingContext();
            pager.RecordsPerPage = 3;
            pager.CurrentPageNumber = 1;
            return D4DGateway.AlbumProvider.GetPagedAlbumsByBandId(pager, PublishStatus.Publish,BandId);
        }
    }
    
</script>
