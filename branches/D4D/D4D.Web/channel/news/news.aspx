<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/MasterPage/Channel.Master" %>
<%@ Import Namespace="D4D.Platform.Domain" %>
<%@ Import Namespace="D4D.Platform" %>
<%@ Import Namespace="System.Collections.Generic" %>
<asp:Content ContentPlaceHolderID="ContentHeader" runat="server" ID="ContentHeader"></asp:Content>
<asp:Content ContentPlaceHolderID="ContentMain" runat="server">
<div class="main">
<div class="channel">
  <h1><asp:Literal ID="litTitle" runat="server"></asp:Literal></h1>
</div>
<ul class="news-top">
  <li class="big">
	<p class="title"><a href="#"><b>《张靓颖@音乐》日本首发鉴赏会即将举行！</b></a> <em>标签：<a href="#">张靓影</a> <a href="#">蓝色畅想</a></em> <label> 2009-3-29</label></p>
    <p><a href="#"><img src="/static/images/pic.jpg"/></a></p>
	<p>2009年3月29日晚，日本东京时尚聚集地涩谷区，张靓颖的新专辑《张靓颖@音乐》日本首发鉴赏会将拉开帷幕。</p>
  </li>
 
  <li>
	<p class="pic"><a href="#"><img width="70" height="60" /></a></p>
	<p><a href="#"><b>《张靓颖@音乐》日本首发鉴赏会即将举行！</b></a> <em>标签：<a href="#">张靓影</a> <a href="#">蓝色畅想</a></em> <label> 2009-3-29</label></p>
	<p>2009年3月29日晚，日本东京时尚聚集地涩谷区，张靓颖的新专辑《张靓颖@音乐》日本首发鉴赏会将拉开帷幕。</p>
  </li>
  <li>
	<p class="pic"><a href="#"><img width="70" height="60" /></a></p>
	<p><a href="#"><b>《张靓颖@音乐》日本首发鉴赏会即将举行！</b></a> <em>标签：<a href="#">张靓影</a> <a href="#">蓝色畅想</a></em> <label> 2009-3-29</label></p>
	<p>2009年3月29日晚，日本东京时尚聚集地涩谷区，张靓颖的新专辑《张靓颖@音乐》日本首发鉴赏会将拉开帷幕。</p>
  </li>
</ul>
<ul class="news-list">
	<li> + <a href="#" target="_blank">风雨难阻歌迷热情，张靓颖献歌广汉</a> <em>标签：<a href="#">张靓影</a> <a href="#">蓝色畅想</a></em> <label> 2009-3-29</label></li>
    <li> + <a href="#" target="_blank">风雨难阻歌迷热情，张靓颖献歌广汉</a> <em>标签：<a href="#">张靓影</a> <a href="#">蓝色畅想</a></em> <label> 2009-3-29</label></li>
    <li> + <a href="#" target="_blank">风雨难阻歌迷热情，张靓颖献歌广汉</a> <em>标签：<a href="#">张靓影</a> <a href="#">蓝色畅想</a></em> <label> 2009-3-29</label></li>
    <li> + <a href="#" target="_blank">风雨难阻歌迷热情，张靓颖献歌广汉</a> <em>标签：<a href="#">张靓影</a> <a href="#">蓝色畅想</a></em> <label> 2009-3-29</label></li>
    <li> + <a href="#" target="_blank">风雨难阻歌迷热情，张靓颖献歌广汉</a> <em>标签：<a href="#">张靓影</a> <a href="#">蓝色畅想</a></em> <label> 2009-3-29</label></li>
    <li> + <a href="#" target="_blank">风雨难阻歌迷热情，张靓颖献歌广汉</a> <em>标签：<a href="#">张靓影</a> <a href="#">蓝色畅想</a></em> <label> 2009-3-29</label></li>
    <li> + <a href="#" target="_blank">风雨难阻歌迷热情，张靓颖献歌广汉</a> <em>标签：<a href="#">张靓影</a> <a href="#">蓝色畅想</a></em> <label> 2009-3-29</label></li>
    <li> + <a href="#" target="_blank">风雨难阻歌迷热情，张靓颖献歌广汉</a> <em>标签：<a href="#">张靓影</a> <a href="#">蓝色畅想</a></em> <label> 2009-3-29</label></li>
	
</ul>
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
    protected int PageSize = 12;
    /// <summary>
    /// 0 company news 
    /// </summary>
    protected int BandId
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
            band.BandName = "全部";

            BandInfo bandCompany = new BandInfo();
            bandCompany.BandId = -1;
            bandCompany.BandName = "公司";
            
            coll.Add(band.BandId, band);
            coll.Add(bandCompany.BandId, bandCompany);
            return coll;

        }
    } 
    
    protected void Page_Load(object sender, EventArgs e)
    {
        SetTitle();
    }
    private const string TitleFormat = "{0}新闻";
    private const string TitleTagFormat = "/<font color=\"red\">{0}</font>";
    private void SetTitle()
    {
        //check bandName
        BandInfo info;
        if (BandColl.TryGetValue(BandId, out info))
        {
            litTitle.Text = string.Format(TitleFormat,info.BandName);
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
</script>