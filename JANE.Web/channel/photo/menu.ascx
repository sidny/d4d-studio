<%@ Control Language="C#" AutoEventWireup="true" %>
<%@ Import Namespace="System.Linq" %>
<%@ Import Namespace="System.Collections.Generic" %>
<%@ Import Namespace="D4D.Platform.Domain" %>
<%@ Import Namespace="D4D.Platform" %>
<div class="sub-title">
  <p class="title">图片</p>
  <p class="nav-link">您的位置：首页 > <%=Channel %></p>
</div>
<style type="text/css">
  .sub-nav .sub{height:auto;font-weight:normal;font-size:12px;clear:both; background:none; padding-bottom:30px;}
  </style>
<div class="sub-nav">
  <ul><%
        
        System.Collections.Generic.List<BandInfo> list = new System.Collections.Generic.List<BandInfo>();
        
        list.Add(new BandInfo()
        {
            BandId = 0,
            BandName = "全部"
        });
        list.AddRange(D4D.Web.Helper.Helper.BandColl.Values);
        foreach (BandInfo i in list)
      {
          if (i.BandId == BandId)
          {
           %>
    <li>》<font color="red"><%=i.BandName%>图片</font></li>
    <li class="sub">
    <dl class="dateList clearfix">
     <dt>时间标签</dt>
    <dt class="date">
    <%int startYear = (CurrentSelectYear == DateTime.Now.Year) ? CurrentSelectYear : CurrentSelectYear + 1;
      for (int n = startYear; n > startYear-3; n--)
      {
          int month = 12;
          if (CurrentSelectYear == DateTime.Now.Year)
              month = DateTime.Now.Month;
           %><a href="/photo/<%=BandId %>.html?year=<%=n %>&month=<%=month %>" <%=(CurrentSelectYear==n)?"class=\"on\"":"" %>><%=n%>年</a><%} %>
    </dt>
    <dd><% 
          int length = (CurrentSelectYear == DateTime.Now.Year) ? DateTime.Now.Month : 12;
          for (int n = length; n > 0; n--)
          {%><a href="/photo/<%=BandId %>.html?year=<%=CurrentSelectYear %>&month=<%=n %>" <%=(n == CurrentSelectMonth)?"class=\"on\"":"" %>>
          <%=((n < 10) ? "0" : "") + n.ToString()%>月</a><% }%>
    </dd>
    </dl>
    <dl class="tagList">
        <dt>热门标签</dt>
        <dd>
        <% foreach(Tag tag in ListTags){
               Response.Write(GetTagStr(tag));
           }%>
        </dd>
    </dl>
    </li>
    <%}
          else
          {
              string s = (i.BandId >= 0) ? "/photo/" + i.BandId + ".html" : "/photo.html";
              %>
    <li>》<a href="<%=s %>"><%=i.BandName%>图片</a></li>
    <%}
      } %>
  </ul>
</div>
<script  runat="server">
    public string Channel;
    private static Hashtable channelList = new Hashtable();

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
 	protected int CurrentSelectYear
    {
        get
        {
            int currentSelectYear = DateTime.Now.Year;
            string yid = Request.QueryString["year"];
            if (!string.IsNullOrEmpty(yid))
            {
                int.TryParse(yid, out currentSelectYear);
            }
            return currentSelectYear;
        }
    }
 	protected int CurrentSelectMonth
    {
        get
        {
            int currentSelectMonth = DateTime.Now.Month;
            string yid = Request.QueryString["month"];
            if (!string.IsNullOrEmpty(yid))
            {
                int.TryParse(yid, out currentSelectMonth);
            }
            return currentSelectMonth;
        }
    }
    
    private const string LinkFormat = "<a href=\"{0}\" class=\"sort{1}\">{2}</a>";
    protected List<Tag> ListTags = new List<Tag>();
    protected List<int> tagsSortList;
    protected void Page_Load(object sender, EventArgs e)
    {
        ListTags = D4D.Platform.D4DGateway.TagsProvider.GetTopTags(20);
        ListTags = (from i in ListTags
                    orderby i.TagId
                    select i).ToList();
        tagsSortList = (from i in ListTags
                         group i.Hits by i.Hits into p
                         orderby p.Key descending
                         select p.Key).ToList();
    }
    protected const string AlbumLinkFormat = "/photo/{0}.html{1}";
    protected string GetTagStr(Tag t)
    {
        string link =string.Empty;
        if (BandId != -1)
            link = string.Format(AlbumLinkFormat,BandId,"?tagid=" + t.TagId.ToString() + "&tag=" + HttpUtility.UrlEncode(t.TagName));
           // link += "?id=" + BandId.ToString() + "&tagid=" + t.TagId.ToString() + "&tag=" + HttpUtility.UrlEncode(t.TagName);
        else
            link = string.Format(AlbumLinkFormat, 0, "?tagid=" + t.TagId.ToString() + "&tag=" + HttpUtility.UrlEncode(t.TagName));
         
            //link += "?tagid=" + t.TagId.ToString() + "&tag=" + HttpUtility.UrlEncode(t.TagName);
        int length = tagsSortList.Count-1;
        if(length > 6) length = 6;
        int sort = length - tagsSortList.IndexOf(t.Hits);
        if (sort < 0) sort = 0;
        return string.Format(LinkFormat, link,sort, t.TagName);
        // + " (" + t.Hits.ToString() + ") "
           
    }
	
	
</script>