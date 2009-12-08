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
 <div class="cd_body shop_bg">
  <!--left-->
  <div class="left floatleft">
    <div class="spacer" style="height:46px;"></div>
	<div class="jane_info_menu">
		<a href="/shop.html"
		<%if (String.IsNullOrEmpty(DateStr))
       {%>class="jane_info_menu_on"<%} %>>全部商品</a> 
		<%for (int i = 0; i < 12; i++)
    { 
        DateTime date = DateTime.Now.AddMonths(-1*i);
        %>
		<a href="/shop/<%=date.ToString("yyyyMM") %>.html"
		<%if(date.ToString("yyyyMM") == DateStr){ %>
		class="jane_info_menu_on"<%} %>><%=date.ToString("yyyy年MM月") %></a> 
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
	  	<h1 class="floatleft font24"></h1>
	  </div>
	  
	  <div class="spacer" style="height:36px"></div> 
 
	  <div class="shop_pd">
	  	<div class="vspacer"></div>
	  	<div class="shop_pd_img floatleft"><img src="<%=Item.LImage%>" /></div>
		<div class="vspacer" style="width:20px;"></div>
		<div class="shop_pd_info floatleft">
			<div class="spacer" style="height:40px"></div>
			<h2 class="font14"><%=Item.Name%></h2>
			<p><%=Item.Description%><br />
			<span class="blue b"><%=Item.Price %>元</span>
			</p>
			<div class="spacer"></div>
			<div class="spacer"></div>
			<div>
				   <asp:LinkButton ID="btnBuy" CssClass="btn_blue floatleft" runat="server" OnClick="btnBuy_Click"><span>购买</span></asp:LinkButton>               
            <div class="vspacer"></div>
				   <asp:LinkButton ID="btnAddShopCar" CssClass="btn_blue floatleft" runat="server" OnClick="btnAddShopCar_Click"><span>收藏到购物车</span></asp:LinkButton>
				    <asp:Literal ID="litMsg" runat="server"></asp:Literal>
        </div>
		</div>
		<div class="clear"></div>
	  </div>
		 
		<div class="spacer" style="height:35px"></div>
		
		<div class="shop_pd_represent_title b">
			商品描述
		</div>
		<div class="spacer"></div>
		<div class="spacer"></div>
	    <div class="shop_pd_represent_con"><%=Item.Body%>
		</div>
		
	    <div class="spacer" style="height:30px"></div>
      
	  <div class="clear"></div>
    </div>
	<div class="clear"></div>
	</div>
	<div class="clear"></div>
  </div>
  <!--right/-->
  <div class="clear"></div>
  </div>
</asp:Content>

<script runat="server">
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            BindItem();
        }
    }

    protected int ItemId
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
    protected ShopItem Item;
    private void BindItem()
    {
        ShopItem item = JaneShopGateway.JaneShopProvier.GetShopItem(ItemId);
        Item = item;
    }
   
    private const string TitleFormat = "- {0}";
   
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

    protected void btnBuy_Click(object sender, EventArgs e)
    {
        
        
        int orderid = 0;
        if (D4D.Web.Helper.Helper.IsDizLogin)
        {
            int userId = D4D.Web.Helper.Helper.GetCookieUserId();
            if (userId > 0)
            {
              
                if (Item != null)
                    orderid = SetShopCar(userId, Item.Id, 1);

                Response.Redirect("/order/" + orderid.ToString() + ".html");
            }
            else
                litMsg.Text = "请登录！";
        }
        else
            litMsg.Text = "请登录！";
      
    }

    protected void btnAddShopCar_Click(object sender, EventArgs e)
    {
     

        if (D4D.Web.Helper.Helper.IsDizLogin)
        {
            int userId = D4D.Web.Helper.Helper.GetCookieUserId();
            if (userId > 0)
            {
                if (Item != null)
                    SetShopCar(userId, Item.Id, 1);
            }
            else
                litMsg.Text = "请登录！";
        }
        else
            litMsg.Text = "请登录！";
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

