<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/MasterPage/Main.Master" %>
<%@ Import Namespace="JANE.Shop.Domain" %>
<%@ Import Namespace="D4D.Platform.Domain" %>
<%@ Import Namespace="JANE.Shop" %>
<%@ Import Namespace="System.Collections.Generic" %>
<%@ Import Namespace="System.Linq" %>
<%@ Register src="~/Control/pager.ascx" tagname="pager" tagprefix="uc1" %>
<asp:Content ContentPlaceHolderID="ContentHeader" runat="server" ID="ContentHeader">
<script src="/static/js/jquery.pagination.js" type="text/javascript"></script>
</asp:Content>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentMain" runat="server">
 <form id="Form1" method="post" runat="server">
 <div class="cd_body shop_bg">
  <!--left-->
  <div class="left floatleft">
    <div class="spacer" style="height:46px;"></div>
    <div class="jane_info_menu">
        <a href="/shop.html" class="jane_info_menu_on">全部商品</a> 
	</div>
		<%
            List<ShopItem> list =JaneShopGateway.JaneShopProvier.GetTopPublishedShopItemsOrderByHits(5);
		if(list.Count>0){        
        %>
        <div class="video_tag_hot">
        <h2>热门商品</h2>
		<div class="video_tag_hot_key">
		    <% foreach (ShopItem item in list)
         { %>
		    <a href="/shop/d/<%=item.Id %>.html"><%=item.Name %></a>
		    <%} %>
	  </div>
    	</div>
		<%} %>
        <div class="spacer"></div>
     <div class="jane_info_menu">
       <%if (D4D.Web.Helper.Helper.IsDizLogin)
         { %>
        <a href="/channel/shop/order_userorderlist.aspx">我的订单</a> 
        <%} %>
	</div>
	<div class="spacer"></div>
  </div>
  <!--left/-->
  <!--right-->
  <div class="right floatleft">
  <div class="cd_right">
    <div class="w_562 h_578">
      <div class="spacer" style="height:36px"></div>
	  
	  <div class="cd_title shop_title">
	  	<h1 class="floatleft blue">商城<span> <asp:Literal ID="litTitle" runat="server" /></span></h1>
	  </div>
	  
	  <div class="spacer"></div> 
		
		 <asp:Repeater ID="repList" runat="server"  OnItemDataBound="repList_ItemDataBound">
                <HeaderTemplate>
                </HeaderTemplate>
                <ItemTemplate>               
                <asp:Literal ID="litItemId" runat="server" Visible="false" ></asp:Literal>                 
                <div class="shopping_cart_list">
                <div class="shopping_cart_list_img floatleft">
                <a href="/shop/d/<%#((ShopItem)Container.DataItem).Id %>.html"><img src="<%#((ShopItem)Container.DataItem).LImage %>" width="80" height="80" alt="" /></a></div>
                <div class="shopping_cart_list_price width260 floatleft">
                <h2><%#((ShopItem)Container.DataItem).Name %></h2>
                <div><%#((ShopItem)Container.DataItem).Description %></div>
                <div class="spacer4"></div>
                <p><%#((ShopItem)Container.DataItem).Price %></p>              
                </div>
                <div class="shopping_cart_list_buy floatleft">
                <asp:LinkButton ID="btnBuy" CssClass="btn_blue floatleft" runat="server" OnClick="btnBuy_Click"><span>购买</span></asp:LinkButton>               
                <div class="vspacer"></div>
                <asp:LinkButton ID="btnAddShopCar" CssClass="btn_blue floatleft" runat="server" OnClick="btnAddShopCar_Click"><span>收藏到购物车</span></asp:LinkButton>
                
                <div class="clear"></div>
                </div>
                <div class="clear"></div>
                </div>
                </ItemTemplate>
                <FooterTemplate>
                </FooterTemplate>
            </asp:Repeater>
	  <asp:Literal ID="litMsg" runat="server"></asp:Literal>
	  <div class="spacer"></div>
	  <div class="spacer"></div>
	  <div class="spacer"></div>
	  
	  <div class="pages">
	  	<div class="pages_amount floatleft">共<%=totalCount %>件商品</div>
		<uc1:pager ID="pager1" runat="server"  />
		<div class="clear"></div>
	  </div>
	    
		
	    <div class="spacer" style="height:50px"></div>
      
	  <div class="clear"></div>
    </div>
	<div class="clear"></div>
	</div>
  </div>
  <!--right/-->
  </div>
  </form>
</asp:Content>

<script runat="server">
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            BindMusicTitleRep(PageIndex);
            SetTitle();
            pager1.PageIndex = PageIndex;
            pager1.PageSize = PageSize;
            pager1.PageTotalCount = PageTotalCount;
        }
    }

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
    protected int BandId
    {
        get
        {
            return D4D.Web.Helper.Helper.BandId;
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
    protected int PageSize = 6;
    protected string DateStr
    {
        get
        {
            if (string.IsNullOrEmpty(Request["date"]))
            {
                return string.Empty;
            }
            else
            {
                return Request["date"];
            }
        }
    }
    protected DateTime sDate = DateTime.MinValue;
    protected DateTime eDate = DateTime.MinValue;
    
    private void BindMusicTitleRep(int pageIndex)
    {
        System.Globalization.CultureInfo zhCN = new System.Globalization.CultureInfo("zh-CN");

        if (DateStr.Length == 6)
        {
            DateTime.TryParseExact(DateStr, "yyyyMM", zhCN,
                           System.Globalization.DateTimeStyles.None, out sDate);
            eDate = sDate.AddMonths(1);
            eDate = eDate.AddDays(-1);
        }
        else if (DateStr.Length == 8)
        {
            DateTime.TryParseExact(DateStr, "yyyyMMdd", zhCN,
                           System.Globalization.DateTimeStyles.None, out sDate);
            eDate = sDate;
        }
        D4D.Platform.Domain.PagingContext pager = new D4D.Platform.Domain.PagingContext();
        pager.RecordsPerPage = PageSize;
        pager.CurrentPageNumber = pageIndex;
        List<ShopItem> resultList;
        if (sDate > DateTime.MinValue)
        {
            resultList = JaneShopGateway.JaneShopProvier.GetPagedShopItemByPublishDate
                (pager, PublishStatus.Publish, sDate, eDate);
        }
        else
        {
            resultList = JaneShopGateway.JaneShopProvier.GetPagedShopItem(
                pager, PublishStatus.Publish);
        }
        repList.DataSource = resultList;
        repList.DataBind();
        totalCount = pager.TotalRecordCount;
        

    }

    protected void repList_ItemDataBound(object sender, RepeaterItemEventArgs e)
    {
        ShopItem m = e.Item.DataItem as ShopItem;

        if (m != null)
        {
            Literal litItemId = e.Item.FindControl("litItemId") as Literal;
            litItemId.Text = m.Id.ToString();
           
        }
    }
   
    private const string TitleFormat = "- {0}";
    private void SetTitle()
    {
        if(sDate>DateTime.MinValue){
            litTitle.Text = string.Format(TitleFormat,sDate.ToString("yyyy年MM月"));
        }
        
    }
    protected string GetDate(DateTime date)
    {
        return date.ToString("yyyy年M月d日");
    }
    private static bool IsRewrite
    {
        get
        {
            string key = ConfigurationManager.AppSettings["RewriteUrl"];
            bool result = false;
            bool.TryParse(key, out result);
            return result;
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
            coll.Add(band.BandId, band);
            return coll;

        }
    }
    protected string GetNewImage(Album n)
    {
        if (DateTime.Now > n.PublishDate.AddDays(7))
            return "";
        else
            return "<img src=\"/static/images/new.gif\"> ";
    }

    protected void btnBuy_Click(object sender, EventArgs e)
    {
        LinkButton bt = sender as LinkButton;
        RepeaterItem ri = bt.Parent as RepeaterItem;
        int orderid = 0;
        if (D4D.Web.Helper.Helper.IsDizLogin)
        {
            int userId = D4D.Web.Helper.Helper.GetCookieUserId();
            if (userId > 0)
            {
                Literal litItemId = ri.FindControl("litItemId") as Literal;
                if (litItemId != null)
                {
                    int currentItemId;
                    int.TryParse(litItemId.Text, out currentItemId);
                    if (currentItemId > 0)
                    {                       
                        orderid = SetShopCar(userId, currentItemId, 1);
                    }

                    Response.Redirect("/order/" + orderid.ToString() + ".html");
                }

            }
            else
                litMsg.Text = "<span style=\"color: #FF3300;\">请先登录！</span>";
        }
        else
            litMsg.Text = "<span style=\"color: #FF3300;\">请先登录！</span>";
     
    }

    protected void btnAddShopCar_Click(object sender, EventArgs e)
    {
        LinkButton bt = sender as LinkButton;
        RepeaterItem ri = bt.Parent as RepeaterItem;

        if (D4D.Web.Helper.Helper.IsDizLogin)
        {
            int userId = D4D.Web.Helper.Helper.GetCookieUserId();
            if (userId > 0)
              {
                  Literal litItemId = ri.FindControl("litItemId") as Literal;
                  if (litItemId != null)
                  {
                      int currentItemId;
                      int.TryParse(litItemId.Text, out currentItemId);
                      if (currentItemId > 0)
                      {                         
                          SetShopCar(userId, currentItemId, 1);
                      }
                      
                  }
                 
              }
            else
                litMsg.Text = "<span style=\"color: #FF3300;\">请先登录！</span>";
        }
        else
            litMsg.Text = "<span style=\"color: #FF3300;\">请先登录！</span>";
    }

    private int SetShopCar(int userId, int itemId, int itemCount)
    {
        ShopOrder shopOrder =
        JANE.Web.Classes.Helper.ShopHelper.GetUserShopCar(userId);

        if (shopOrder != null && shopOrder.Id > 0)
        {
            JANE.Web.Classes.Helper.ShopHelper.SetTradeList(shopOrder.Id, itemId, itemCount);
            return shopOrder.Id;
        }
        else
            return 0;
    }
</script>

