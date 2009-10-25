<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/MasterPage/Main.Master"%>
<%@ Import Namespace="D4D.Platform.Domain" %>
<%@ Import Namespace="System.Collections.Generic" %>
<%@ Import Namespace="System.Linq" %>
<asp:Content ContentPlaceHolderID="ContentHeader" runat="server" ID="ContentHeader">
</asp:Content>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentMain" runat="server">
  <%if (false)
  { %>
   <script type="text/javascript" src="~/static/js/jquery-1.3.2.js"></script>
<%} %>
<style type="text/css">
.album-desc{border:1px solid #d3d3d3; width:580px; padding:15px;}
.album-desc p{ line-height:20px;}
.album-desc p.img{float:left; padding-right:15px;}
.album-desc p.title{ font-size:24px; color:#666666; font-family:微软雅黑,黑体; line-height:normal; height:36px}
.music-list{ border:1px solid #d3d3d3; color:#6e6e6e;  border-top:none; width:610px;}
.music-list td{ border-bottom:1px solid #d3d3d3; height:30px; vertical-align:middle; position:relative;}
.music-list td span{ z-index:100; display:inline-block; position:relative;}
.music-list .processbar{ background:#ffc18e; height:20px; position:absolute; top:5px; left:0;}
 </style>
<div class="sub-title">
  <p class="title">音乐</p>
  <p class="nav-link">您的位置：首页 > 音乐 ><%=Music.Title %></p>
</div>
    <div style="margin:20px auto; width:780px">
    <div class="sub-title">
        <p class="title">全部音乐 / <%=Music.Title%>(<%=PageTotalCount%>)</p>
        <p class="nav-link"><a href="/music.html">返回音乐首页</a></p>
    </div>
    <div class="album-desc">
        <p class="img"><img src="<%=musicTitle.LImage%>" width="170" height="170" /> </p>
        <p class="title"><%=musicTitle.Title%></p>
        <p>歌手：<%=BandInfo(musicTitle.BandId).BandName%></p>
        <p>出版时间：<%=musicTitle.PublishDate.ToString("yyyy年M月d日")%></p>
        <p><%=musicTitle.Body%></p>
    </div>
    <div class="music-list">
    <asp:Repeater ID="repList" runat="server">
        <HeaderTemplate>
     <table border="0" cellpadding="0" cellspacing="0" width="100%">
        <tr><td colspan="4">全部播放</td></tr>
        <tr bgcolor="#d3d3d3">
        <th width="50" height="20"></th>
        <th width="400" align="left">歌曲名</th>
        <th align="left">歌手</th>
        <th width="80">长度</th>
        </tr>
        </HeaderTemplate>
        
        <ItemTemplate>
        <tr>
        <td><%#((MusicSongList)Container.DataItem).ListId %></td>
        <td><div class="processbar"></div><span><%#((MusicSongList)Container.DataItem).SongName %><%#((MusicSongList)Container.DataItem).SongFile %></span>
            
        </td>
         <td><%=BandInfo(musicTitle.BandId).BandName%></td> 
         <td>&nbsp;<%#((MusicSongList)Container.DataItem).SongTime %>&nbsp;</td>
         </tr>
        </ItemTemplate>
        <FooterTemplate>
            </table>
        </FooterTemplate>
    </asp:Repeater>
    </div>
    <div class="slider">
    <asp:Repeater ID="repMusicTitle" runat="server">
        <HeaderTemplate>
            <ul>
        </HeaderTemplate>
        <ItemTemplate>
            <li>            
            <p class="pic"><a href="<%#(((MusicTitle)Container.DataItem).MusicId) %>"><img src="<%#((MusicTitle)Container.DataItem).SImage %>" width="75" height="65" /></a></p>
            <p class="text"><a href="<%#(((MusicTitle)Container.DataItem).MusicId) %>">
            <%#((MusicTitle)Container.DataItem).Title %></a> 
               <br />
               歌手：<%#((MusicTitle)Container.DataItem).BandId %>
               发行：<%#GetDate(((MusicTitle)Container.DataItem).PublishDate)%>
            </p>
            </li>
            <%#(Container.ItemIndex%2 == 1)?"<li class=\"line\"></li>":"" %>
        </ItemTemplate>
        <FooterTemplate>
            </ul>
        </FooterTemplate>
    </asp:Repeater>
    
    </div>
    </div>
<script type="text/javascript">
    $(document).ready(function() {
        
    });
</script>
</asp:Content>

<script runat="server">

    protected void Page_Load(object sender, EventArgs e)
    {
        BindSongList();
		BindMusicTitleRep();
    }

   
    protected int MusicId
    {
        get
        {
            string queryid = Request.QueryString["id"];
            if (string.IsNullOrEmpty(queryid)) return 0;

            int id = 0;

            int.TryParse(queryid, out id);
            return id;
        }
    }
	private MusicTitle musicTitle;
	protected MusicTitle Music{
		get{
			if(musicTitle==null){
				musicTitle = D4D.Platform.D4DGateway.MusicProvider.GetMusicTitle(MusicId);
			}
			return musicTitle;
		}
	}
    private int totalCount;
    protected int PageTotalCount
    {
        get
        {
            return totalCount;
        }
    }
    private void BindSongList()
    {
        List<MusicSongList> list = D4D.Platform.D4DGateway.MusicProvider.GetMusicSongListByMusicId(MusicId,PublishStatus.Publish);
		repList.DataSource = list;
        repList.DataBind();
        totalCount = list.Count;

    }
	private void BindMusicTitleRep()
    {
        D4D.Platform.Domain.PagingContext pager = new D4D.Platform.Domain.PagingContext();
        pager.RecordsPerPage = 10000;
        pager.CurrentPageNumber = 1;
		int BandId = Music.BandId;
        repMusicTitle.DataSource = D4D.Platform.D4DGateway.MusicProvider.GetPagedMusicTitles(pager,
                           D4D.Platform.Domain.PublishStatus.Publish);
        
        repMusicTitle.DataBind();

    }
   	protected BandInfo BandInfo(int Id)
    {
        BandInfo band = new BandInfo();
        BandColl.TryGetValue(Id, out band);
        return band;
    }
	public static IDictionary<int,BandInfo> BandColl
        {
            get
            {
                IDictionary<int, BandInfo> coll = D4D.Web.Helper.Helper.BandColl;
					
				BandInfo band = new BandInfo();
				band.BandId = 0;
				band.BandName = "公司";
				coll.Add(band.BandId,band);
                return coll;

            }
        }
    protected string GetDate(DateTime date)
    {
        return date.ToString("yyyy年M月d日");
    }
	
    
</script>
