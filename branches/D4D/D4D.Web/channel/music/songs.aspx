<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/MasterPage/Main.Master"%>
<%@ Import Namespace="D4D.Platform.Domain" %>
<%@ Import Namespace="System.Collections.Generic" %>
<%@ Import Namespace="System.Linq" %>
<asp:Content ContentPlaceHolderID="ContentHeader" runat="server" ID="ContentHeader">
</asp:Content>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentMain" runat="server">

<div class="sub-title">
  <p class="title">音乐</p>
  <p class="nav-link">您的位置：首页 > 音乐 ><%=Music.Title %></p>
</div>
    <div class="music">
    
    <div class="musicTitle">
    	<%=Music.Title%>(<%=PageTotalCount%>)
    </div>
    <asp:Repeater ID="repList" runat="server">
        <HeaderTemplate>
            <ul>
        </HeaderTemplate>
        <ItemTemplate>
        <li>
        	<%#((MusicSongList)Container.DataItem).ListId %>
           <%#((MusicSongList)Container.DataItem).MusicId %>
           <%#((MusicSongList)Container.DataItem).SongName %>
           <%#((MusicSongList)Container.DataItem).SongFile %>
           <%#((MusicSongList)Container.DataItem).SongTime %>
           </li>
        </ItemTemplate>
        <FooterTemplate>
            </ul>
        </FooterTemplate>
    </asp:Repeater>
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
