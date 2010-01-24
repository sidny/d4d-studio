<%@ Control Language="C#" AutoEventWireup="true" %>
<%@ Import Namespace="System.Linq" %>
<%@ Import Namespace="System.Collections.Generic" %>
<%@ Import Namespace="D4D.Platform.Domain" %>
<%@ Import Namespace="D4D.Platform" %>
<div class="left floatleft">
    <div class="spacer" style="height:43px;"></div>
	<div class="spacer"></div>
	
	<div class="video_tag_time">
		<h2 class="black_5757">Date Tag</h2>
	    <div class="video_tag_time_year">
       	<%int startYear = (CurrentSelectYear == DateTime.Now.Year) ? CurrentSelectYear : CurrentSelectYear + 1;
		int month = 12;
          if (CurrentSelectYear == DateTime.Now.Year)
              month = DateTime.Now.Month;
      		for (int n = startYear; n > startYear-3; n--)
      			{
           %><a  href="/news.html?year=<%=n %>&month=<%=month %>" <%=(CurrentSelectYear==n)?"class=\"white\"":"" %>><%=n%></a> <%}%>
           <a href="/news.html?year=<%=CurrentSelectYear-1 %>&month=<%=month %>" class="video_tag_time_year_img"><img src="/static/images/ico_next.gif" /></a>
           <%if(startYear > CurrentSelectYear){%>
		   <a href="/news.html?year=<%=CurrentSelectYear+1 %>&month=<%=month %>" class="video_tag_time_year_img"><img src="/static/images/ico_up.gif" /></a>
           <%}%>
		</div>
	    <div class="spacer"></div>
	    <div class="video_tag_time_moth">
			<% 
          int length = (CurrentSelectYear == DateTime.Now.Year) ? DateTime.Now.Month : 12;
          for (int n = length; n > 0; n--)
          {%><a href="/news.html?year=<%=CurrentSelectYear %>&month=<%=n %>" <%=(n == CurrentSelectMonth)?"class=\"orange\"":"" %>>
          <%=((n < 10) ? "0" : "") + n.ToString()%></a><% }%>
		</div>
	</div>
	<div class="spacer" style="height:30px"></div>
	<div class="video_tag_hot">
		<h2>Hot Tag</h2>
	    <div class="video_tag_hot_key">
		<% foreach(Tag tag in ListTags){
               Response.Write(GetTagStr(tag) + " ");
           }%>
	  </div>
  </div>
</div>
<script  runat="server">
    public string Channel;
    private static Hashtable channelList = new Hashtable();
    protected int BandId
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
        ListTags = D4D.Platform.D4DGateway.TagsProvider.GetTopTags(10);
        ListTags = (from i in ListTags
                    orderby i.TagId
                    select i).ToList();
        tagsSortList = (from i in ListTags
                         group i.Hits by i.Hits into p
                         orderby p.Key descending
                         select p.Key).ToList();
    }
    
    protected string GetTagStr(Tag t)
    {
        string link = (BandId>=0)? "/news/"+BandId+".html":"/news.html";
        if (BandId != -1)
            link += "?tagid=" + t.TagId.ToString() + "&tag=" + HttpUtility.UrlEncode(t.TagName);
        else
            link += "?tagid=" + t.TagId.ToString() + "&tag=" + HttpUtility.UrlEncode(t.TagName);
        int length = tagsSortList.Count-1;
        if(length > 6) length = 6;
        int sort = length - tagsSortList.IndexOf(t.Hits);
        if (sort < 0) sort = 0;
        return string.Format(LinkFormat, link,sort, t.TagName);
        // + " (" + t.Hits.ToString() + ") "
           
    }
	
	
</script>