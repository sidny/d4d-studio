<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/MasterPage/Main.Master"%>
<%@ Import Namespace="D4D.Platform.Domain" %>
<%@ Import Namespace="System.Collections.Generic" %>
<%@ Import Namespace="System.Linq" %>
<asp:Content ContentPlaceHolderID="ContentHeader" runat="server" ID="ContentHeader">
</asp:Content>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentMain" runat="server">
  <%if (false)
  { %>
   <script type="text/javascript" src="../../static/js/jquery-1.3.2.js"></script>
<%} %>
<style type="text/css">
.album-desc{border:1px solid #d3d3d3; width:580px; padding:15px;}
.album-desc p{ line-height:20px;}
.album-desc p.img{float:left; padding-right:15px;}
.album-desc p.title{ font-size:24px; color:#666666; font-family:微软雅黑,黑体; line-height:normal; height:36px}
.music-list{ border:1px solid #d3d3d3; color:#6e6e6e;  border-top:none; width:610px;}
.music-list td{ border-bottom:1px solid #d3d3d3; height:30px; vertical-align:middle; position:relative;}
.music-list td span{ z-index:100; display:inline-block; position:relative;}
.music-list .processbar{ background:#ff7e33; height:20px; width:0;top:5px; left:0; margin-top:-17px;}
.music-list span.control{ background:url(/static/images/album/player.gif) no-repeat left; border:0; height:11px; width:11px; cursor:pointer}
.music-list span.on{ background-position:right;}
.slider{ float:right;}
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
    <div class="slider">
    <asp:Repeater ID="repMusicTitle" runat="server">
        <HeaderTemplate>
            <ul>
        </HeaderTemplate>
        <ItemTemplate>
            <li>            
            <p class="pic"><a href="<%#(((MusicTitle)Container.DataItem).MusicId) %>.html"><img src="<%#((MusicTitle)Container.DataItem).SImage %>" width="75" height="65" /></a></p>
            <p class="text"><a href="<%#(((MusicTitle)Container.DataItem).MusicId) %>.html">
            <%#((MusicTitle)Container.DataItem).Title %></a></p>
            </li>
        </ItemTemplate>
        <FooterTemplate>
            </ul>
        </FooterTemplate>
    </asp:Repeater>
    
    </div>
    <div class="album-desc clearfix">
        <p class="img"><img src="<%=musicTitle.LImage%>" width="170" height="170" /> </p>
        <p class="title"><%=musicTitle.Title%></p>
        <p>歌手：<%=BandInfo(musicTitle.BandId).BandName%></p>
        <p>出版时间：<%=musicTitle.PublishDate.ToString("yyyy年M月d日")%></p>
        <p><%=musicTitle.Body%></p>
    </div>
    
    <div class="music-list">
    <asp:Repeater ID="repList" runat="server">
        <HeaderTemplate>
     <table border="0" cellpadding="2" cellspacing="0" width="100%">
        <tr><td colspan="4" style="padding-left:40px;"><span id="btn-play-all" href="#全部播放"><img src="/static/images/album/playall.gif" alt="全部播放" /></span></td></tr>
        <tr bgcolor="#d3d3d3">
        <th width="50" height="20"></th>
        <th width="400" align="left">歌曲名</th>
        <th align="left">歌手</th>
        <th width="80">长度</th>
        </tr>
        </HeaderTemplate>
        
        <ItemTemplate>
        <tr>
        <td align="right"><span class="control" index="<%#Container.ItemIndex %>" songId="<%#((MusicSongList)Container.DataItem).ListId %>"></span></td>
        <td><a href="<%#((MusicSongList)Container.DataItem).SongFile %>" onclick="return false"><%#((MusicSongList)Container.DataItem).SongName %></a><div class="processbar"></div>
            
        </td>
         <td><%=BandInfo(musicTitle.BandId).BandName%></td> 
         <td class="song-time" align="center">&nbsp;<%#((MusicSongList)Container.DataItem).SongTime %>&nbsp;</td>
         </tr>
        </ItemTemplate>
        <FooterTemplate>
         </table>
        </FooterTemplate>
    </asp:Repeater>
    </div>
    
    </div>
<div id="player">
    <object id="mp3player"
                    classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000"
                    codebase="http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=9.0.115"                    
                    width="0" height="0">
                <param name="movie" value="/static/images/player.swf" />
                <param name="allowscriptaccess" value="always" />
     <embed src="/static/images/player.swf" quality="high" width="0" height="0" align="middle" allowScriptAccess="sameDomain" type="application/x-shockwave-flash"  name="mp3player"></embed>
     </object>
</div>
<script type="text/javascript">
    var player = null;
    function playerReady(thePlayer) {
        player = window.document[thePlayer.id];
        var musicList = $(".music-list a");
        var buttons = $(".music-list span.control");
        var processbar = $(".music-list div.processbar");
        var songtime = $(".music-list .song-time");
        var current = 1;
        var init = false;
        function playerStateChange(obj) {
            switch (obj.newstate) {
                case "COMPLETED":
                    current++;
                    if (current < buttons.length) {
                        buttons[current].click();
                    } else {
                        buttons.eq(current).removeClass("on");
                    }
                    break;
                case "PLAYING":
                    buttons.eq(current).addClass("on");
                    break;
                case "PAUSED":
                default:
                    buttons.eq(current).removeClass("on");
                    break;
            }
        }
        window.playerStateChange = playerStateChange;
        function playerTimeChange(obj) {
            var percentComplete = Math.round(100 * obj.position / obj.duration);
            processbar.eq(current).css({ width: percentComplete + "%" });
            songtime.eq(current).text(formatTime(obj.duration));
        }
        window.playerTimeChange = playerTimeChange;
        function formatTime(seconds) {
            try {
                var result = "";
                var remaining = Math.floor(seconds);

                if (seconds > 3600) {
                    result += pad((Math.floor(remaining / 3600)).toString(), "00") + ":";
                    remaining = remaining % 3600;
                }

                result += pad((Math.floor(remaining / 60)).toString(), "00") + ":";
                remaining = remaining % 60;

                result += pad(remaining.toString(), "00") + "";
            } catch (e) {
                console.log(e);
            }
            return result;
        }
        function pad(s, l) {
            return (l.substr(0, (l.length - s.length)) + s);
        }
        while (!init) {
            try {
                player.addModelListener("STATE", "playerStateChange");

                player.addModelListener("TIME", "playerTimeChange");
                init = true;
            } catch (e) {

            }
        }

        buttons.click(function() {
            var $this = $(this);

            if (player.getConfig()["state"] == "PLAYING" && current.toString() == $this.attr("index")) {
                player.sendEvent("PLAY", false);
            } else {
                if (player.getConfig()["state"] == "PAUSED") {
                    processbar.not(current).css({ width: 0 });
                } else {
                    processbar.css({ width: 0 })
                }
                buttons.eq(current).removeClass("on");
                current = parseInt($(this).attr("index"));
                player.sendEvent("LOAD", musicList.eq(current).attr("href"));
                player.sendEvent("PLAY", true);
            }
        });
        $("#btn-play-all").css({cursor:"pointer"}).click(function() {
            current = 0;
            player.sendEvent("LOAD", musicList.eq(current).attr("href"));
            player.sendEvent("PLAY", true);
        });

    }

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
