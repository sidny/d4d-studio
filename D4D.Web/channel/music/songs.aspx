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
.album-desc{border:1px solid #d3d3d3;_height:170px; min-height:170px; width:580px; padding:15px;}
.album-desc p{ padding-left:185px;line-height:20px;}
.album-desc p.img{float:left; padding-right:15px; padding-left:0;}
.album-desc p.title{ font-size:24px; color:#666666; font-family:微软雅黑,黑体; padding:0; line-height:normal; height:36px}
.music-list{ border:1px solid #d3d3d3; color:#6e6e6e;  border-top:none; width:610px;}
.music-list td{ border-bottom:1px solid #d3d3d3; height:30px; vertical-align:middle; position:relative;}
.music-list td span{ z-index:100; display:inline-block; position:relative;}
.music-list .processbar{ background:#ff7e33; height:20px; width:0; left:0; position:absolute; top:8px;}
.music-list span {margin-top:6px;  padding-top:5px;}
.music-list span.control{ padding-top:2px; background:url(/static/images/album/player.gif) no-repeat left; border:0; height:20px; width:11px; cursor:pointer; }
.music-list span.on{ background-position:right;}
.slider{ float:right; height:520px;}
.slider .jCarouselLite{ width:131px; height:440px; padding-top:5px;}
.slider ul{width:131px; height:440px; overflow:hidden; text-align:center; line-height:26px;}
.slider ul li img{ background:url(/static/images/music/cd.gif); padding:1px 8px 2px 6px; width:60px; height:60px;}
 </style>
 <script src="/static/js/AC_OETags.js" type="text/javascript"></script>
<script src="/static/js/jcarousellite_1.0.1.pack.js" type="text/javascript"></script>
<div class="sub-title">
  <p class="title">音乐</p>
  <p class="nav-link">您的位置：首页 > 音乐 ><%=Music.Title %></p>
</div>
    <div style="margin:20px auto; width:780px; _height:600px; min-height:600px;">
    <div class="sub-title" style="border:none">
        <p class="title" style="width:50%">全部音乐 / <%=Music.Title%></p>
        <p class="nav-link"><a href="/music.html">返回音乐首页</a></p>
    </div>
    <div class="slider">
    <div class="prev"><input type="image" src="/static/images/music/prev.gif" /></div>
    <div class="jCarouselLite">
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
    <div class="next"><input type="image" src="/static/images/music/next.gif" /></div>
    </div>
    <div>
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
     <table border="0" cellpadding="2" cellspacing="0" width="100%">
        <tr><td colspan="4" valign="middle" style="padding-left:40px;"><span id="btn-play-all" href="#全部播放"><img src="/static/images/album/playall.gif" alt="全部播放" /></span></td></tr>
        <tr bgcolor="#d3d3d3">
        <th width="50" height="20"></th>
        <th width="400" align="left">歌曲名</th>
        <th align="left">歌手</th>
        <th width="80">长度</th>
        </tr>
        </HeaderTemplate>
        
        <ItemTemplate>
        <tr>
        <td align="right" valign="middle"><span class="control"  href="<%#((MusicSongList)Container.DataItem).SongFile %>" index="<%#Container.ItemIndex %>" songId="<%#((MusicSongList)Container.DataItem).ListId %>"></span></td>
        <td><span><%#((MusicSongList)Container.DataItem).SongName %></span><div class="processbar"></div>
            
        </td>
         <td><span><%=BandInfo(musicTitle.BandId).BandName%></span></td> 
         <td class="song-time" align="center">&nbsp;<%#((MusicSongList)Container.DataItem).SongTime %>&nbsp;</td>
         </tr>
        </ItemTemplate>
        <FooterTemplate>
         </table>
        </FooterTemplate>
    </asp:Repeater>
    </div>
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
    </div>
    <div class="comments-area">
            <div class="clearfix">
            <div style="float:left; width:40%;"></div>
            <div class="comments" style="width:50%; float:right">
                <a href="#" id="btnComments">我也要说两句</a> <a href="/music/b<%=Music.BandId %>/c/<%=MusicId%>.html">评论（<%=CommentsCount%>）</a>
            </div>
            </div>
           <div class="input-area clearfix" style="display:none">
                <textarea></textarea>
                <button>
                    发表</button>
            </div>
        </div>
    
    <script type="text/javascript">
        $(document).ready(function() {
            $("#btnComments").click(function() {
                if ($("#btnLogin").length > 0) {
                    $("#btnLogin").click();
                    return false;
                } else {
                   $(".input-area").show();
                   return false;
                }
            });
            $(".input-area button").click(function() {
                var str = $(".input-area textarea").val();
                if(str.length < 10) {
                    alert("评论内容过短");
                    return;
                }
                $.ajax({
                    contentType: "application/json",
                    url: "/svc/comments.svc/create",
                    data: JSON2.stringify({ content: str, id: <%=MusicId %>, type: <%=(int)ObjectTypeDefine.MusicTitle %> }),
                    type: "POST", processData: false,
                    dataType:"json",
                    success:function(response){
                        if(response.d>0){
                            alert("发送成功");
                            $(".input-area textarea").val("");
                        }else if(response.d==-1){
                            alert("请先登录");
                        }else if(response.d==0){
                            alert("发送失败，请联系管理员");
                        }else{
                            alert(JSON2.stringify(response));
                        }
                    }
                })
            });
        });
    </script>
    </div>

<script type="text/javascript">
    $(function() {
        $(".slider .jCarouselLite").jCarouselLite({
            btnNext: ".slider .next",
            btnPrev: ".slider .prev",
            speed: 500,
			vertical:true,
			circular: false,
			visible: 4
        });
    });
    var player = null;
    function playerReady(thePlayer) {
        player = window.document[thePlayer.id];
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
                player.sendEvent("LOAD", buttons.eq(current).attr("href"));
                player.sendEvent("PLAY", true);
            }
        });
        $("#btn-play-all").css({cursor:"pointer"}).click(function() {
            current = 0;
            player.sendEvent("LOAD", buttons.eq(current).attr("href"));
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
        repMusicTitle.DataSource = D4D.Platform.D4DGateway.MusicProvider.GetPagedMusicTitlesByBandId(pager,Music.BandId,
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
