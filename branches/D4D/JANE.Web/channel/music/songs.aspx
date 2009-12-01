<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/MasterPage/Channel.Master"%>
<%@ Import Namespace="D4D.Platform.Domain" %>
<%@ Import Namespace="System.Collections.Generic" %>
<%@ Import Namespace="System.Linq" %>
<%@ Register src="~/Control/comment.ascx" tagname="comment" tagprefix="uc1" %>
<asp:Content ContentPlaceHolderID="ContentHeader" runat="server" ID="ContentHeader">
<style type="text/css">
.slider .jCarouselLite{ width:131px; padding-left:20px; margin:0 auto; height:440px;}
</style>
 <script src="/static/js/AC_OETags.js" type="text/javascript"></script>
<script src="/static/js/jcarousellite_1.0.1.pack.js" type="text/javascript"></script>
</asp:Content>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentMain" runat="server">
  <div class="right floatleft">
  <div class="cd_right">
    <div class="w_562 h_578">
      <div class="spacer" style="height:36px"></div>
	  
	  <div class="cd_title">
      <h1 class="floatleft font24 blue">唱片<span>- <%=Music.Title%></span></h1>
	  <div class="floatright"><a href="/music.html">返回唱片</a></div>
	  </div>
	  
	  <div class="spacer" style="height:20px"></div>
	  
	  <div class="cd_intro">
	    <div class="cd_img floatleft"><img width="120" height="120" src="<%=Music.LImage%>" /></div>
	    <div class="cd_info floatright">
			<div class="spacer" style="height:2px;"></div>
			<h1><%=Music.Title%></h1>
			<div class="spacer" style="height:12px;"></div>
			<p><%if (Music.PublishDate.Year < 2000)
        { %>未发行
        <%}else{
              Response.Write(Music.PublishDate.ToString("yyyy年M月d日"));
          }%><br />
            <%=Music.Body%></p>
		    <div class="spacer" style="height:11px"></div>
		    <div class="cd_info_btn">
			<a href="#" id="btn-play-all" class="btn_play">播放此专辑</a>
			<div class="vspacer"></div>
			<a href="#" class="btn_gray floatleft"><span class="floatleft">YOJO购买</span></a>
			<div class="vspacer"></div>
			<a href="#" class="btn_gray floatleft"><span class="floatleft">当当购买</span></a>			</div>
	    </div>
	    <div class="clear"></div>
	  </div>
      
    <asp:Repeater ID="repList" runat="server">
        <HeaderTemplate>
	    <div class="cd_music_list">
	    </HeaderTemplate>
	    <ItemTemplate>
	    <div class="cd_music_list_item_a">
		  <div class="cd_music_vote_1"></div>
		  <div class="cd_music_vote_2"></div>
		  <div class="cd_music_list_name floatleft">
			<a href="#" song="<%#((MusicSongList)Container.DataItem).SongFile %>" index="<%#Container.ItemIndex %>" songId="<%#((MusicSongList)Container.DataItem).ListId %>">play</a>
			<span><%#((MusicSongList)Container.DataItem).SongName %></span>
		  </div>
		  <div class="cd_music_list_time floatright"><%#((MusicSongList)Container.DataItem).SongTime %></div>
		</div>
		</ItemTemplate>
		<AlternatingItemTemplate>
	    <div class="cd_music_list_item_b">
		  <div class="cd_music_vote_1"></div>
		  <div class="cd_music_vote_2"></div>
		  <div class="cd_music_list_name floatleft">
			<a href="#" song="<%#((MusicSongList)Container.DataItem).SongFile %>" index="<%#Container.ItemIndex %>" songId="<%#((MusicSongList)Container.DataItem).ListId %>">play</a>
			<span><%#((MusicSongList)Container.DataItem).SongName %></span>
		  </div>
		  <div class="cd_music_list_time floatright"><%#((MusicSongList)Container.DataItem).SongTime %></div>
		</div>
		</AlternatingItemTemplate>
		<FooterTemplate>
	    </div>
		</FooterTemplate>
	</asp:Repeater>
		
	  
	  <div class="spacer" style="height:20px"></div>
	  
      <div class="cd_music_btn">
		  <a href="/music/b<%=Music.BandId%>/c/<%=Music.MusicId%>.html" class="btn_gray floatright"><span class="floatleft">评论(<%=CommentsCount %>条)</span></a>
		
		  <a href="/music/b<%=Music.BandId%>/c/<%=Music.MusicId%>.html" class="btn_gray floatright mgr_10"><span class="floatleft">发表评论</span></a>
		  
	      <div class="clear"></div>
      </div>
	  <div class="clear"></div>
    </div>
	<div class="clear"></div>
	</div>
	<div class="clear"></div>
  </div>
  <!--right/-->
    
    <div id="player">
<script type="text/javascript"> 
	if(DetectFlashVer(10,0,3)){
		AC_FL_RunContent(
		"src", "/static/images/player",
		"width", "0",
		"height", "0",
		"align", "middle",
		"id", "mp3player",
		"quality", "high",
		"bgcolor", "#3A6EA5",
		"name", "mp3player",
		"allowScriptAccess","always",
		"type", "application/x-shockwave-flash",
		"pluginspage", "http://www.adobe.com/go/getflashplayer"
	);
	}else{
		if(confirm("您还没有安装最新的Flash Player,是否进行安装")){
			window.open("http://get.adobe.com/flashplayer/");
		}
	}
</script>  
</div>
<script type="text/javascript">
    var player = null;
    function playerReady(thePlayer) {
        player = window.document[thePlayer.id];
        var buttons = $(".cd_music_list a");
        var processbar = $(".cd_music_list .cd_music_vote_2");
        var songtime = $(".cd_music_list .cd_music_list_time");
        var current = 1;
        var init = false;
        function playerStateChange(obj) {
            switch (obj.newstate) {
                case "COMPLETED":
                    current++;
                    if (current < buttons.length) {
                        buttons[current].click();
                    } else {
                    buttons.eq(current).removeClass("cd_music_playing");
                    }
                    break;
                case "PLAYING":
                    buttons.eq(current).addClass("cd_music_playing");
                    break;
                case "PAUSED":
                default:
                    buttons.eq(current).removeClass("cd_music_playing");
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
            if ($("#btnLogin").length > 0) $("#btnLogin").click();
            else {
                var $this = $(this);

                if (player.getConfig()["state"] == "PLAYING" && current.toString() == $this.attr("index")) {
                    player.sendEvent("PLAY", false);
                } else {
                    if (player.getConfig()["state"] == "PAUSED") {
                        processbar.not(current).css({ width: 0 });
                    } else {
                        processbar.css({ width: 0 })
                    }
                    buttons.eq(current).removeClass("cd_music_playing");
                    current = parseInt($(this).attr("index"));
                    player.sendEvent("LOAD", buttons.eq(current).attr("song"));
                    player.sendEvent("PLAY", true);
                }
            }
            return false;
        });
        $("#btn-play-all").css({cursor:"pointer"}).click(function() {
            current = 0;
            buttons.eq(current).click();
        });

    }

</script>
</asp:Content>

<script runat="server">

    protected void Page_Load(object sender, EventArgs e)
    {
        BindSongList();
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
    private int? count;
    protected int CommentsCount
    {
        get
        {
            if (!count.HasValue)
            {
                int i = 0;
                List<int> list = new List<int>();
                list.Add(MusicId);
                IDictionary<int, int> idict = D4D.Platform.D4DGateway.CommentProvider.GetComments20(list, ObjectTypeDefine.MusicTitle);
                idict.TryGetValue(MusicId, out i);
                count = i;
            }
            return count.Value;
        }
    }

    
</script>
