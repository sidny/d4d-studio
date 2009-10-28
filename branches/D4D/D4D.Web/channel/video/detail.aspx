<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/MasterPage/Main.Master" %>
<%@ Import Namespace="D4D.Platform.Domain" %>
<%@ Import Namespace="D4D.Platform" %>
<%@ Import Namespace="System.Collections.Generic" %>
<asp:Content ContentPlaceHolderID="ContentHeader" runat="server" ID="ContentHeader"></asp:Content>
<asp:Content ContentPlaceHolderID="ContentMain" runat="server">
<div class="sub-title">
        <p class="title">
            视频</p>
        <p class="nav-link">
            您的位置：首页 > 视频</p>
    </div>
<div class="album_detail">
        <div class="channel">
            <h1>
                全部视频 / <%=CurrentNews.Title%></h1>
            <div class="return">
                <a href="/video.html" style="color: red">返回视频首页</a></div>
        </div>
    <div style="text-align:center; padding:20px 0;">
    <%=CurrentNews.Body%>
	</div>
    <div class="comments-area">
            <div class="clearfix">
            <div style="float:left; width:40%;"><%=GetTagHtml(CurrentNews.NewsId)%></div>
            <div class="comments" style="width:50%; float:right">
                <a href="#" id="btnComments">我也要说两句</a> <a href="#">评论（<%=CommentsCount %>）</a>
            </div>
            </div>
           <div class="input-area clearfix" style="display:none">
                <textarea></textarea>
                <button>
                    发表</button>
            </div>
        </div>
    </div>
    
    <script type="text/javascript">
        $(document).ready(function() {
            $("#btnComments").click(function() {
                if ($("#btnLogin").length > 0) {
                    $("#btnLogin").click();
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
                    data: JSON2.stringify({ content: str, id: <%=CurrentNews.NewsId %>, type: <%=(int)ObjectTypeDefine.News %> }),
                    type: "POST", processData: false,
                    dataType:"json",
                    success:function(response){
                        if(response.d>0){
                            alert("发送成功");
                            $(".input-area textarea").val("");
                            location.reload();
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
   
</script>