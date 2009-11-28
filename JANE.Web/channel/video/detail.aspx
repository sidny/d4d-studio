<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/MasterPage/Channel.Master" %>
<%@ Import Namespace="D4D.Platform.Domain" %>
<%@ Import Namespace="D4D.Platform" %>
<%@ Import Namespace="System.Collections.Generic" %>
<%@ Register src="~/Control/comment.ascx" tagname="comment" tagprefix="uc1" %>
<asp:Content ContentPlaceHolderID="ContentHeader" runat="server" ID="ContentHeader"></asp:Content>
<asp:Content ContentPlaceHolderID="ContentMain" runat="server">
<div class="right floatleft">
  <div class="cd_right">
    <div class="w_562 h_578">
      <div class="spacer" style="height:36px"></div>
	  <div class="cd_title video_title font24"><h1 class="floatleft font24" style="width:98%">- <%=CurrentNews.Title%></h1></div>
	  <div class="spacer" style="height:20px"></div>
	  <div class="video_play">
	  	<%=CurrentNews.Body%>
	  </div>
	  
	  <div class="spacer"></div>
	  <div class="spacer"></div>
	  <div class="video_play_bar">
	    <div class="video_play_bar_tag floatleft deepblue"><%=GetTagHtml(CurrentNews.NewsId)%></div>
	    <div class="video_play_bar_commend floatright">
		
		<a href="/video/c/<%=NewsId %>.html" class="btn_gray floatleft"><span>发表评论</span></a>
		<div class="vspacer"></div>
		<a href="/video/c/<%=NewsId %>.html" class="btn_gray floatleft"><span>评论（<%=CommentsCount%>条）</span></a>
		</div>
	  </div>
	  <div class="spacer" style="height:20px"></div>
	  
      
	  <div class="clear"></div>
    </div>
	<div class="clear"></div>
	</div>
	<div class="clear"></div>
  </div>
</asp:Content>

<script runat="server">
    
    

    /// <summary>
    /// 0 company news 
    /// </summary>
    protected int BandId
    {
        get
        {
            string queryid = Request.QueryString["bid"];
            if (string.IsNullOrEmpty(queryid)) return -1;

            int id = 0;

            int.TryParse(queryid, out id);
            return id;
        }
    }
    protected int NewsId
    {
        get
        {
            string queryid = Request.QueryString["id"];
            if (string.IsNullOrEmpty(queryid)) return -1;

            int id = 0;

            int.TryParse(queryid, out id);
            return id;
        }
    }
    protected int TagId
    {
        get
        {
            string tid = Request.QueryString["tagid"];
            if (string.IsNullOrEmpty(tid)) return 0;

            int id = 0;

            int.TryParse(tid, out id);
            return id;
        }
    }
    protected static int CommentsCount
    {
        get
        {
            int count = 0;
            List<int> list = new List<int>();
            list.Add(CurrentNews.NewsId);
            IDictionary<int, int> idict = D4DGateway.CommentProvider.GetComments20(list, ObjectTypeDefine.Video);
            idict.TryGetValue(CurrentNews.NewsId, out count);
            return count;
        }
    }


    public string TagName
    {
        get
        {
            string tagName = Request.QueryString["tag"];
            if (string.IsNullOrEmpty(tagName))
                return string.Empty;
            else
                return tagName;
        }
    }

    public int TagYear        
    {
        get
        {
            string yid = Request.QueryString["year"];
            if (string.IsNullOrEmpty(yid)) return 0;

            int id = 0;

            int.TryParse(yid, out id);
            return id;
        }
    }

    public int TagMonth
    {
        get
        {
            string mid = Request.QueryString["month"];
            if (string.IsNullOrEmpty(mid)) return 0;

            int id = 0;

            int.TryParse(mid, out id);
            return id;
        }
    }

    public string TagTime
    {
        get
        {
            if (TagYear <= 1900) return string.Empty;
            if (TagMonth > 12 && TagMonth <= 0) return string.Empty;

            return string.Format("{0}年{1}月", TagYear, TagMonth);
        }
    }

    public static IDictionary<int, BandInfo> BandColl
    {
        get
        {
            System.Collections.Generic.IDictionary<int, BandInfo> coll = D4D.Web.Helper.Helper.BandColl;

            BandInfo band = new BandInfo();
            band.BandId = 0;
            band.BandName = "公司";

            BandInfo bandCompany = new BandInfo();
            bandCompany.BandId = -1;
            bandCompany.BandName = "全部";
            
            coll.Add(band.BandId, band);
            coll.Add(bandCompany.BandId, bandCompany);
            
            return coll;

        }
    } 
    
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            BindNews();
        }
    }
    
    private const string TitleFormat = "{0}新闻";
    private const string TitleTagFormat = "/<font color=\"red\">{0}</font>";
   
    protected static News CurrentNews;
    private void BindNews()
    {
        CurrentNews = D4DGateway.NewsProvider.GetNewsAddHits(NewsId);
       
    }
    protected List<News> NextPrev = new List<News>(2);
    private const string SImageFormat = "<p class=\"pic\"><a href=\"{0}\"><img width=\"70\" height=\"60\" src=\"{1}\" /></a></p>";
  
    private string GetTagHtml(int newsId)
    {
        string result = string.Empty;
        //get tag
        List<TagRelation> relationList =
        D4DGateway.TagsProvider.GetTagRelationByObject(newsId, ObjectTypeDefine.News);

        if (relationList != null && relationList.Count > 0)
        {
            int maxCount = relationList.Count;
            if (maxCount > 20) maxCount = 20;
            List<int> tagids = new List<int>(maxCount);
            for (int i = 0; i < maxCount; i++)
            {
                tagids.Add(relationList[i].TagId);
            }
            Dictionary<int, Tag> tagDic = D4DGateway.TagsProvider.GetTags20(tagids);
            D4DGateway.TagsProvider.AddTagHit(tagids);
            if (tagDic != null && tagDic.Count > 0)
            {
                StringBuilder sb = new StringBuilder(1024);
                foreach (KeyValuePair<int, Tag> kvp in tagDic)
                {
                    sb.Append(" ");
                    sb.AppendFormat(AFormat,
                     string.Format(TagLinkFormat, BandId, kvp.Key, HttpUtility.UrlEncode(kvp.Value.TagName)),
                     kvp.Value.TagName);
                }


                result = string.Format(TagEmFormat, sb.ToString());
            }

        }
        return result;
    }
    
    
    private const string TagEmFormat = "标签：{0}";
    private const string AFormat = "<a href=\"{0}\">{1}</a>";
    private const string TagLinkFormat = "/channel/video/news.aspx?id={0}&tagid={1}&tag={2}";
   
</script>