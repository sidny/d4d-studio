<%@ Control Language="C#" AutoEventWireup="true" %>
<%@ Import Namespace="D4D.Platform" %>
<%@ Import Namespace="D4D.Platform.Domain" %>
<%@ Import Namespace="System.Collections.Generic" %>
<div class="sub-title">
  <p class="title"><%=Channel %></p>
  <p class="nav-link">您的位置：首页 > <%=Channel %></p>
</div>
<div class="sub-nav">
  <ul>
  <asp:Repeater ID="repMenu" OnItemDataBound="repMenu_ItemDataBound" runat="server">
   <ItemTemplate>
    <li>》<asp:Literal ID="litLink" runat="server"></asp:Literal></li>
    </ItemTemplate>
  </asp:Repeater>   
  </ul>
  <!-- Time tag -->
   <div id="TabbedPanels1" class="TabbedPanels">
                    <ul class="TabbedPanelsTabGroup">
                      <asp:Repeater ID="repYear" OnItemDataBound="repYear_ItemDataBound" runat="server">
                       <ItemTemplate>
                        <li class="TabbedPanelsTab">  
                          <asp:Literal ID="litYearhLink" runat="server"></asp:Literal>
                        </li>                 
                        </ItemTemplate>
                      </asp:Repeater>    
                          
                    </ul>
                    <div class="TabbedPanelsContentGroup">
                    <asp:Repeater ID="repMonth" OnItemDataBound="repMonth_ItemDataBound" runat="server">
                       <ItemTemplate>
                         <div class="TabbedPanelsContent">
                          <asp:Literal ID="litMonthLink" runat="server"></asp:Literal>
                        </div>                      
                        </ItemTemplate>
                      </asp:Repeater>                            
                    </div>
                </div>
   <!--  tag -->
   <ul>
     <asp:Repeater ID="repTags" OnItemDataBound="repTags_ItemDataBound" runat="server">
   <ItemTemplate>
    <li><asp:Literal ID="litTagLink" runat="server"></asp:Literal></li>
    </ItemTemplate>
  </asp:Repeater>   
   </ul>
</div>
<script  runat="server">
    public string Channel;
    private static Hashtable channelList = new Hashtable();
    private const int MaxTagsCount = 8;
    private const string baseLink = "/news.html";

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

    protected void repYear_ItemDataBound(object sender, RepeaterItemEventArgs e)
    {
        int m = (int)(e.Item.DataItem);


        Literal litYearhLink = e.Item.FindControl("litYearhLink") as Literal;

        string link = baseLink;

        int month = 12;
        string yearName = string.Empty ;

        int currentSelectYear = CurrentSelectYear;

        if (currentSelectYear == m)
        {
            month = DateTime.Now.Month;
            yearName = "<font color=\"red\">" + m.ToString() + "</font>";
        }
        else
        {
            yearName = m.ToString();
        }

        if (BandId != -1)
            link += "?id=" + BandId.ToString() + "&year=" + m.ToString() + "&month=" + month.ToString();
        else
            link += "?year=" + m.ToString() + "&month=" + month.ToString();


        litYearhLink.Text = string.Format(LinkFormat, link, yearName);



    }

    
    protected void repMonth_ItemDataBound(object sender, RepeaterItemEventArgs e)
    {
              int m =(int)( e.Item.DataItem);

       
            Literal litMonthLink = e.Item.FindControl("litMonthLink") as Literal;

            string link = baseLink;

            if (BandId != -1)
               link += "?id=" +BandId.ToString()+"&year="+CurrentSelectYear.ToString()+"&month="+m.ToString();
            else
                link += "?year=" + CurrentSelectYear.ToString() + "&month=" + m.ToString();

            string monthName = string.Empty;
            if (m < 10)
                monthName = "0" + m.ToString() + "月";
            else
                monthName = m.ToString() + "月";
            litMonthLink.Text = string.Format(LinkFormat, link, monthName);
            
            
        
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        channelList["news"] =  "星闻";
        channelList["anews"] = "星闻";
        string[] path = Request.AppRelativeCurrentExecutionFilePath.Split('/');
        if (path.Length >= 3)
        {
            Channel = channelList[path[2]] as string;
        }

        if (!IsPostBack)
        {
            System.Collections.Generic.IDictionary<int, BandInfo> coll = D4D.Web.Helper.Helper.BandColl;            
            List<BandInfo> list = new  System.Collections.Generic.List<BandInfo>(coll.Count+2);    
            BandInfo band = new BandInfo();
            band.BandId = -1;
            band.BandName = "全部";

            BandInfo bandCompany = new BandInfo();
            bandCompany.BandId = 0;
            bandCompany.BandName = "公司";

            list.Add(band);
            list.Add(bandCompany);

            list.AddRange(coll.Values);
            
            repMenu.DataSource = list;
            repMenu.DataBind();
            
            //bindYear
            List<int> listYear = new List<int>(3);

            for (int i = 0; i < 3; i++)
                listYear.Add(CurrentSelectYear - i);

            repYear.DataSource = listYear;
            repYear.DataBind(); 
            
            //bindmonth
            List<int> listMonth = new List<int>();
            int endMonth = 12;
            if (DateTime.Now.Year == CurrentSelectYear)
                endMonth = DateTime.Now.Month;

            for (int i = 0; i < endMonth; i++)
                listMonth.Add(endMonth - i);
        
            repMonth.DataSource = listMonth;
            repMonth.DataBind();

            //bindtags
            List<Tag> listTags = 
            D4D.Platform.D4DGateway.TagsProvider.GetTopTags(MaxTagsCount);
            repTags.DataSource = listTags;
            repTags.DataBind();
        }      
           
    }

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
    private const string LinkFormat = "<a href=\"{0}\">{1}</a>";
    protected void repMenu_ItemDataBound(object sender, RepeaterItemEventArgs e)
    {
        BandInfo m = e.Item.DataItem as BandInfo;

        if (m != null)
        {
            Literal litLink = e.Item.FindControl("litLink") as Literal;
         
            string menuName = string.Empty;
            if (BandId == m.BandId)
                menuName = "<font color=\"red\">"+m.BandName+"新闻</font>";
            else
                menuName = m.BandName+"新闻";

            string link = baseLink;
            
            if (m.BandId!=-1)
                link +="?id="+m.BandId.ToString();

            litLink.Text = string.Format(LinkFormat, link, menuName);
        }
    }
    
    protected void repTags_ItemDataBound(object sender, RepeaterItemEventArgs e)
    {
        Tag m = e.Item.DataItem as Tag;

        if (m != null)
        {
            Literal litTagLink = e.Item.FindControl("litTagLink") as Literal;

            string link = baseLink;

            if (BandId != -1)
                link += "?id=" +BandId.ToString()+"&tagid="+m.TagId.ToString()+"&tag="+HttpUtility.UrlEncode(m.TagName);
            else
                link += "?tagid=" + m.TagId.ToString() + "&tag=" + HttpUtility.UrlEncode(m.TagName);

            litTagLink.Text = string.Format(LinkFormat, link,m.TagName) + " ("+m.Hits.ToString()+") ";
            
            
        }
    }
       
</script>