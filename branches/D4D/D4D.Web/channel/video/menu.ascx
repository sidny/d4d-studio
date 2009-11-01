<%@ Control Language="C#" AutoEventWireup="true" %>
<%@ Import Namespace="System.Collections.Generic" %>
<%@ Import Namespace="D4D.Platform.Domain" %>
<%@ Import Namespace="D4D.Platform" %>
 <style type="text/css">
  .sub-nav .sub{height:auto;font-weight:normal;font-size:12px;clear:both;}
  .sub-nav .sub a{ font-weight:normal}
  .sub-nav .sub dl{width:200px;}
  .sub-nav .sub dt.date{ background:#999999;padding-left:10px;}
  .subv-nav .sub dt.date a{ color:white; padding: 0 3px;}
  .sub-nav .sub dd{ margin:0; padding:10px; background:#ccc}
  .sub-nav .sub dd a{ display:block; width:30px; text-align:center;float:left}
  </style>
<div class="sub-title">
  <p class="title">视频</p>
  <p class="nav-link">您的位置：首页 > 视频</p>
</div>
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
    <li>》<font color="red"><%=i.BandName%>视频</font></li>
    <li class="sub">
    <dl class="clearfix">
     <dt>时间标签</dt>
    <dt>
    <%int startYear = (CurrentSelectYear == DateTime.Now.Year) ? CurrentSelectYear : CurrentSelectYear + 1;
      for (int n = startYear; n > startYear-3; n--)
      {
          int month = 12;
          if (CurrentSelectYear == DateTime.Now.Year)
              month = DateTime.Now.Month;
           %>
        <a href="?year=<%=n %>&month=<%=month %>" <%=(CurrentSelectYear==n)?"class=\"on\"":"" %>><%=n%></a>
    <%} %>
    </dt>
    <dd class="clearfix">
    	<% 
          int length = (CurrentSelectYear == DateTime.Now.Year) ? DateTime.Now.Month : 12;
          for (int n = length; n > 0; n--)
          {%> 
        <a href="?year=<%=CurrentSelectYear %>&month=<%=n %>"><%=((n < 10) ? "0" : "") + n.ToString()%></a>
        <% }%>
    </dd>
    </dl>
    <dl>
        <dt>Tag标签</dt>
        <dd>
        <% foreach(Tag tag in ListTags){
               Response.Write(GetTagStr(tag));
           }%>
        </dd>
    </dl>
    </li>
    <%}
          else
          {%>
    <li>》<a href="/video.html?id=<%=i.BandId %>"><%=i.BandName%></a></li>
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
            if (String.IsNullOrEmpty(Request["id"]))
            {
                return 0;
            }
            else
            {
                return int.Parse(Request["id"]);
            }
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
    private const string LinkFormat = "<a href=\"{0}\">{1}</a>";
    protected List<Tag> ListTags = new List<Tag>();
    protected void Page_Load(object sender, EventArgs e)
    {
        ListTags = D4D.Platform.D4DGateway.TagsProvider.GetTopTags(10);
           
    }
    
    protected string GetTagStr(Tag t)
    {
        string link = "/video.html";
        if (BandId != -1)
            link += "?id=" + BandId.ToString() + "&tagid=" + t.TagId.ToString() + "&tag=" + HttpUtility.UrlEncode(t.TagName);
        else
            link += "?tagid=" + t.TagId.ToString() + "&tag=" + HttpUtility.UrlEncode(t.TagName);

        return string.Format(LinkFormat, link, t.TagName) + " (" + t.Hits.ToString() + ") ";
           
    }
	
	
</script>