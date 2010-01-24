<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/MasterPage/Channel.Master" %>
<%@ Import Namespace="D4D.Platform.Domain" %>
<%@ Import Namespace="D4D.Platform" %>
<%@ Import Namespace="System.Collections.Generic" %>
<%@ Import Namespace="D4D.ResourceManager" %>
<%@ Register src="~/Control/pager.ascx" tagname="pager" tagprefix="uc1" %>
<asp:Content ContentPlaceHolderID="ContentHeader" runat="server" ID="ContentHeader"></asp:Content>
<asp:Content ContentPlaceHolderID="ContentMain" runat="server">
<div class="right floatleft">
 <div class="cd_right">
   <div class="w_562 h_578">
     <div class="spacer" style="height:36px"></div>
     	<div class="cd_title news_title">
       		<h1 class="floatleft blue">News<span><asp:Literal ID="litTitle" runat="server"></asp:Literal></span> </h1> 
			<div class="floatright alginright">
            	<div class="spacer4"></div>
			</div>
	  </div>
	  <div class="spacer" style="height:30px"></div>
	  <asp:Repeater ID="repTop" OnItemDataBound="repTop_ItemDataBound" runat="server">
        <HeaderTemplate>
        <div class="head_news">
        </HeaderTemplate>
         <ItemTemplate>
         	<div class="head_news_pic floatleft"><asp:Literal ID="litTopImage" runat="server"></asp:Literal></div>
	    	<div class="head_news_text floatright">
				<h1 class="font14"><a href="/news/d/<%#((News)Container.DataItem).NewsId %>.html"><b><%#((News)Container.DataItem).Title %></b></a></h1>
				<span><asp:Literal ID="litTopTag" runat="server"></asp:Literal>   [<%#((News)Container.DataItem).PublishDate.ToString("yyyy-MM-dd")%>] </span>
				<div class="spacer4"></div>
				<p><%#((News)Container.DataItem).Preview %></p>
			</div>
	    	<div class="clear"></div>
         </ItemTemplate>
        <FooterTemplate>
        </div>
	  	<div class="spacer" style="height:30px"></div>
        </FooterTemplate>
 </asp:Repeater> 
<asp:Repeater ID="repList" OnItemDataBound="repList_ItemDataBound" runat="server">
     <HeaderTemplate>
     <ul class="news_list">
     </HeaderTemplate>
         <ItemTemplate>
         <li> 
			<p><%#GetNewImage((News)Container.DataItem) %> <a href="/news/d/<%#((News)Container.DataItem).NewsId %>.html"><%#((News)Container.DataItem).Title %></a> </p>
			<span><asp:Literal ID="litListTag" Visible="false" runat="server"></asp:Literal>  [<%#((News)Container.DataItem).PublishDate.ToString("yyyy-MM-dd")%>]</span>
		 </li>  
         </ItemTemplate>
      <FooterTemplate>
      	</ul>
      </FooterTemplate>   
</asp:Repeater>
	  <div class="spacer"></div>
	  <div class="spacer"></div>
      <uc1:pager ID="pager1" runat="server"  />
	  <div class="spacer" style="height:20px"></div>
</div>
</div>
</div>
</asp:Content>
<script runat="server">
    
    protected int PageIndex
    {
        get
        {
            string queryPage = Request.QueryString["page"];
            if (string.IsNullOrEmpty(queryPage)) return 1;
           int page = 1;
           int.TryParse(queryPage, out page);
           if (page == 0) page = 1;
           return page;
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
    protected int PageSize = 10;
    /// <summary>
    /// 0 company news 
    /// </summary>
    protected int BandId
    {
        get
        {
            return D4D.Web.Helper.Helper.BandId;
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
           return string.Format("{0}/{1}", TagYear, TagMonth);
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
            BindNews(PageIndex); 
            pager1.PageIndex = PageIndex;
            pager1.PageSize = PageSize;
            pager1.PageTotalCount = PageTotalCount;
        }
        
    }
    
    private const string TitleFormat = "{0}";
    private const string TitleTagFormat = "- {0}";
    private void SetTitle()
    {
       if (!string.IsNullOrEmpty(TagName))
        {
            litTitle.Text += string.Format(TitleTagFormat, TagName);            
        }
       if (!string.IsNullOrEmpty(TagTime))
        {
            litTitle.Text += string.Format(TitleTagFormat, TagTime); 
        }
    }
    private const int MaxTopCount = 1;
    private void BindNews(int pageIndex)
    {
        D4D.Platform.Domain.PagingContext pager = new D4D.Platform.Domain.PagingContext();
        pager.RecordsPerPage = PageSize;
        pager.CurrentPageNumber = pageIndex;
        List<News> resultList=null;
        List<News> topResultList=null;
        if (BandId < 0)
        {
            if (TagId > 0)
            {
                resultList = D4DGateway.NewsProvider.GetPagedNewsByTag(pager, PublishStatus.Publish,TagId, 
                    NewsRemarkType.Normal);
                if (pageIndex <= 1)
                {
                    topResultList = D4DGateway.NewsProvider.GetTopImageNewsByTag(TagId,MaxTopCount,
                         NewsRemarkType.Normal);
                }
            }
            else if (TagYear >= 1900 && TagMonth > 0 && TagMonth <= 12)
            {
                DateTime sTime = new DateTime(TagYear, TagMonth, 1);
                DateTime eTime = sTime.AddMonths(1).AddDays(-1);
               resultList = D4DGateway.NewsProvider.GetPagedNewsByPublishDate(pager,
                  sTime, eTime,PublishStatus.Publish, NewsRemarkType.Normal);
                if (pageIndex <= 1)
                {
                    topResultList = D4DGateway.NewsProvider.GetTopImageNewsByPublishDate(
                        sTime, eTime, MaxTopCount, NewsRemarkType.Normal);
               }
            }
            else
            {
                resultList = D4DGateway.NewsProvider.GetPagedNews(pager, PublishStatus.Publish);
                if (pageIndex <= 1)
                {
                    topResultList = D4DGateway.NewsProvider.GetTopImageNews(MaxTopCount,
                         NewsRemarkType.Normal);
                }
            }
        }
        else
        {
            if (TagId > 0)
            {
                resultList = D4DGateway.NewsProvider.GetPagedNewsByTagAndNewsType(pager, 
                    PublishStatus.Publish, TagId, (BandType)BandId);
                if (pageIndex <= 1)
                {
                    topResultList = D4DGateway.NewsProvider.GetTopImageNewsByTagANDNewsType(TagId,
                       (BandType)BandId, MaxTopCount,NewsRemarkType.Normal);
                }
            }
            else if (TagYear >= 1900 && TagMonth > 0 && TagMonth <= 12)
            {
                DateTime sTime = new DateTime(TagYear, TagMonth, 1);
                DateTime eTime = sTime.AddMonths(1).AddDays(-1);
               resultList = D4DGateway.NewsProvider.GetPagedNewsByTypeANDPublishDate(pager, 
                    (BandType)BandId, sTime, eTime,
                   PublishStatus.Publish);
                 if (pageIndex <= 1)
                {
                    topResultList = D4DGateway.NewsProvider.GetTopImageNewsByNewsTypeANDPublishDate((BandType)BandId,
                        sTime,eTime,MaxTopCount, NewsRemarkType.Normal);
                        
                 }
            }
            else
            {    
                resultList = D4DGateway.NewsProvider.GetPagedNewsByNewsType(pager, (BandType)BandId,
                    PublishStatus.Publish);
                 if (pageIndex <= 1)
                {
                    topResultList = D4DGateway.NewsProvider.GetTopImageNewsByNewsType((BandType)BandId,
                        MaxTopCount, NewsRemarkType.Normal);
                }    
            }              
        }
        //band
        if (resultList != null && resultList.Count > 0)
        {
            repList.DataSource = resultList;
            repList.DataBind();
            totalCount = pager.TotalRecordCount;            
            /*
            if (pageIndex > 1)
            {
                repList.DataSource = resultList;
                repList.DataBind();
            }
            else
            {
                if (resultList.Count >= 3)
                {
                    repTop.DataSource = resultList.GetRange(0, 3);
                    repTop.DataBind();
                    repList.DataSource = resultList; ;
                    repList.DataBind();
                }
                else
                {
                    repTop.DataSource = resultList;
                    repTop.DataBind();
                }
            }
             */
        }
       if (pageIndex <= 1 && topResultList != null)//gettop
        {
            repTop.DataSource = topResultList;
            repTop.DataBind();
        }
    }
    private const string SImageFormat = "<p class=\"pic\"><a href=\"{0}\"><img width=\"100\" height=\"75\" src=\"{1}\" /></a></p>";
    protected void repTop_ItemDataBound(object sender, RepeaterItemEventArgs e)
    {
        /*
        News m = e.Item.DataItem as News;
       if (m != null)
        {
          //Literal litTopLi = e.Item.FindControl("litTopLi") as Literal ;
         
          
         //if (e.Item.ItemIndex == 0)
          //    litTopLi.Text = "<li class=\"big\">";
          //else
          //{
           //   litTopLi.Text = "<li>";
              if (!string.IsNullOrEmpty(m.SImage))
              {
                  Literal litTopImage = e.Item.FindControl("litTopImage") as Literal;
                  litTopImage.Text = string.Format(SImageFormat,
                      "/news/d/" + m.NewsId.ToString() + ".html", m.SImage);                  
              }
              
         // }
         Literal litTopTag = e.Item.FindControl("litTopTag") as Literal;
          litTopTag.Text = GetTagHtml(m.NewsId);  
            
        }
         */
    }
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
    
    private const string TagEmFormat = "Tag：{0}";
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
    protected string GetNewImage(News n)
    {
        if (DateTime.Now > n.PublishDate.AddDays(7))
            return "";
        else
            return "<img src=\"/static/images/new.gif\"> ";
    }
</script>