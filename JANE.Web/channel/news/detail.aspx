<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/MasterPage/Channel.Master" %>
<%@ Import Namespace="D4D.Platform.Domain" %>
<%@ Import Namespace="D4D.Platform" %>
<%@ Import Namespace="System.Collections.Generic" %>
<asp:Content ContentPlaceHolderID="ContentHeader" runat="server" ID="ContentHeader">

</asp:Content>
<asp:Content ContentPlaceHolderID="ContentMain" runat="server">
<asp:Literal ID="litTitle" runat="server" Visible="false"></asp:Literal>
<div class="right floatleft">
  <div class="cd_right">
    <div class="w_562 h_578">
      <div class="spacer" style="height:36px"></div>
	  <div class="cd_title news_title" style="margin-bottom:10px;">
         <div class="floatright alginright"><a href="/news.html">返回资讯首页</a></div>
         <span class="font18">全部资讯</span>
      </div>
	  <div class="cd_title news_con_title">
	  	<h1 class="font24 blue"><%=CurrentNews.Title%></h1>
	  </div>
	  <div class="spacer4"></div>
	  <div align="center">
	    <%=GetTagHtml(CurrentNews.NewsId, true)%>　　<%=CurrentNews.PublishDate.ToString("yyyy-MM-dd")%>
	  </div>
	  <div class="spacer" style="height:30px"></div>
	  <div class="news_con">
	        <%=CurrentNews.Body%>
	<%if (!string.IsNullOrEmpty(CurrentNews.LImage))
   { %>
	<p align="center"><img src="<%=CurrentNews.LImage%>" alt="" /></p>
	<%} %>
	</div>
    <div class="spacer"></div>
	  <div class="spacer"></div>
	  <div class="video_play_bar">
	    <div class="video_play_bar_tag floatleft deepblue"><%=GetTagHtml(CurrentNews.NewsId)%></div>
	    <div class="video_play_bar_commend floatright">
		
		<a href="/news/c/<%=NewsId %>.html" class="btn_gray floatleft"><span>发表评论</span></a>
		<div class="vspacer"></div>
		<a href="/news/c/<%=NewsId %>.html" class="btn_gray floatleft"><span>评论（<%=CommentsCount%>条）</span></a>
		</div>
	  </div>	  
     <div style="border-top:1px solid #dad7d5; padding:30px 0 30px 0; line-height:20px; margin-top:20px">   <%for(int i=0;i<NextPrev.Count;i++){
      News news = NextPrev[i];%>
    <p><%if( news.NewsId > CurrentNews.NewsId){%>上一条<%}else{ %>下一条<%} %> ：<a href="/news/d/<%= news.NewsId%>.html"><%= news.Title%></a> &nbsp;&nbsp; <%= news.PublishDate.ToString("yyyy-MM-dd")%></p>
    <%} %>
    </div> 
    </div>
    </div>
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
        string queryid = Request.QueryString["nid"];
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
protected int CommentsCount
{
    get
    {
        int count = 0;
        List<int> list = new List<int>();
        list.Add(CurrentNews.NewsId);
        IDictionary<int, int> idict = D4DGateway.CommentProvider.GetComments20(list, ObjectTypeDefine.News);
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
        SetTitle();
        BindNews();
    }
    /*
    comment1.ObjectId = NewsId;
    comment1.ObjectType = (int)ObjectTypeDefine.News;
    comment1.CommentsCount = CommentsCount;
    comment1.CommentUrl = "/news/c/" + NewsId + ".html";
    */
}

private const string TitleFormat = "{0}新闻";
private const string TitleTagFormat = "/<font color=\"red\">{0}</font>";
private void SetTitle()
{
    //check bandName
    BandInfo info;
    if (BandColl.TryGetValue(BandId, out info))
    {
        litTitle.Text = string.Format(TitleFormat, info.BandName);
    }

    if (!string.IsNullOrEmpty(TagName))
    {
        litTitle.Text += string.Format(TitleTagFormat, TagName);
    }

    if (!string.IsNullOrEmpty(TagTime))
    {
        litTitle.Text += string.Format(TitleTagFormat, TagTime);
    }

}
protected News CurrentNews;
private void BindNews()
{

    CurrentNews = D4DGateway.NewsProvider.GetNewsAddHits(NewsId);
    NextPrev = D4DGateway.NewsProvider.GetNewsPreviousNext(NewsId);

}
protected List<News> NextPrev = new List<News>(2);
private const string SImageFormat = "<p class=\"pic\"><a href=\"{0}\"><img width=\"70\" height=\"60\" src=\"{1}\" /></a></p>";

private string GetTagHtml(int newsId)
{
    return GetTagHtml(newsId, false);
}
private string GetTagHtml(int newsId, bool addHist)
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
        if (addHist)
        {
            D4DGateway.TagsProvider.AddTagHit(tagids);
        }
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
private const string TagLinkFormat = "/channel/news/news.aspx?id={0}&tagid={1}&tag={2}";
protected void repList_ItemDataBound(object sender, RepeaterItemEventArgs e)
{
    News m = e.Item.DataItem as News;

    if (m != null)
    {

        Literal litListTag = e.Item.FindControl("litListTag") as Literal;
        litListTag.Text = GetTagHtml(m.NewsId);
    }
}
</script>