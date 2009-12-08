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
<script language="javascript">
    function ConfirmDelete() {
        if (window.confirm("您确认清空购物车么？")) {
            return true;
        }
        else
            return false;
    }   
    
</script>
<div class="cd_body shop_bg">
  <!--left-->
  <div class="left floatleft">
    <div class="spacer" style="height:46px;"></div>
	<div class="jane_info_menu">
		<a href="/order/<%=OrderId %>.html" class="jane_info_menu_on">购物车</a> 
		<a href="/order/check/<%=OrderId %>.html">订单确认</a> 
		<a href="/order/addr/<%=OrderId %>.html">收货地址</a>
		<a href="#">订单确认</a>
	</div>
	<div class="spacer"></div>
  </div>
  <!--left/-->
  <!--right-->
  <div class="right floatleft">
  <div class="cd_right">
    <div class="w_562 h_578">
      <div class="spacer" style="height:36px"></div>
	  
	  <div class="cd_title shopping_cart_title">
	  <div class="spacer12"></div>	 
	  <a href="/shop/shoporderhandler.ashx?t=cleartradelist&id=<%=OrderId %>&rurl=<%=GetReturnUrl() %>" onclick="return  ConfirmDelete()" class="btn_gray floatright"><span>清空购物车</span></a>
	  </div>
	  
    <asp:MultiView ID="mvTradeList" runat="server" ActiveViewIndex="0">
        <asp:View ID="empty" runat="server">
        	  <div class="spacer12" style="height:83px"></div>

	          <div class="buy_none font14">
	  	        如果您现在不想购买任何商品，可以下次再来购买了<br /><br />
        	
        		
		        更多靓颖资讯，请浏览张靓颖官方网站<br />
        	
		        <a href="/news.html" class="font14 blue">资讯</a>  <a href="/calender.html" class="font14 blue">行程</a>  <a href="/singer.html" class="font14 blue">档案</a>  <a href="/music.html" class="font14 blue">唱片</a>  <a href="/video.html" class="font14 blue">视频</a>  <a href="/photo.html" class="font14 blue">图片</a>  <a href="http://bbs.janezhang.com/" class="font14 blue">论坛</a>
	          </div>
	  
        </asp:View>
        <asp:View ID="tradelist" runat="server">
        	  <div class="spacer12"></div>
    <asp:PlaceHolder ID="delDialog" runat="server" Visible ="false">
	  <div class="dialog">
	  	<div class="dialog_con floatleft"><asp:Literal ID="deleteMsg" runat="server"></asp:Literal></div>
		<div class="dialog_btn floatleft"><a href="/shop/shoporderhandler.ashx?t=delonetradelist&tid=<%=TradeListId %>&id=<%=OrderId %>&rurl=<%=GetReturnUrl() %>" class="btn_gray floatleft"><span>是的</span></a><div class="vspacer"></div><a href="/order/<%=OrderId %>.html" class="btn_gray floatleft"><span>取消</span></a></div>
		<div class="clear"></div>
	  </div>
	</asp:PlaceHolder>
	<asp:Repeater ID="repList" runat="server">
	    <ItemTemplate>
	    <div class="shopping_cart_list">
	  	<div class="shopping_cart_list_img floatleft"><a href="/shop/d/<%#((ShopTradelistDetail)Container.DataItem).ItemId %>.html"><img src="<%#((ShopTradelistDetail)Container.DataItem).Item.LImage %>" /></a></div>
		<div class="shopping_cart_list_price floatleft">
			<h2><%#((ShopTradelistDetail)Container.DataItem).Item.Name%></h2>
			<p><%#((ShopTradelistDetail)Container.DataItem).Item.Price%>元</p>
			<div class="spacer"></div>
			<div><a href="/shop/order_tradelist.aspx?id=<%=OrderId %>&t=deltid&tid=<%#((ShopTradelistDetail)Container.DataItem).Id%>&tname=<%#((ShopTradelistDetail)Container.DataItem).UrlEncodeItemName%>"  class="btn_gray floatleft"><span>删除</span></a></div>
		</div>
		<div class="shopping_cart_list_num floatleft">
			<a href="/shop/order_tradelist.aspx?id=<%=OrderId %>&t=subtractcount&tid=<%#((ShopTradelistDetail)Container.DataItem).Id%>" ><img src="/static/images/ico_subtract.gif" /></a>
			<input type="text"  readonly style="width:45px;" value="<%#((ShopTradelistDetail)Container.DataItem).ItemCount%>" class="input01" />
			<a href="/shop/order_tradelist.aspx?id=<%=OrderId %>&t=addcount&tid=<%#((ShopTradelistDetail)Container.DataItem).Id%>" ><img src="/static/images/ico_add.gif" /></a>
			<div class="clear"></div>
		</div>
		<div class="clear"></div>
	  </div>
	    </ItemTemplate>
	</asp:Repeater>	  

	  <div class="spacer"></div>
	  <div class="spacer"></div>
	  
	  <div class="amount">
	  	<div class="amount_num floatleft">共1页  共<%=TotalItems %>件商品</div>
		<div class="amount_money blue b floatleft">共计：<%=TotalPrice %>元</div>
		<div class="vspacer"></div>
		<a href="/order/check/<%=OrderId %>.html" class="btn_blue floatleft"><span>购买</span></a>
		<div class="clear"></div>
	  </div>
        </asp:View>
    </asp:MultiView>
    
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
    protected double TotalPrice
    {
        get;
        set;
    }
    protected int TotalItems
    {
        get;
        set;
    }

    protected int TradeListId
    {
        get
        {
            string queryid = Request.QueryString["tid"];
            if (string.IsNullOrEmpty(queryid)) return 0;

            int id = 0;

            int.TryParse(queryid, out id);
            return id;
        }
    }
    
    protected int OrderId
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

    protected string GetReturnUrl()
    {
        return HttpUtility.UrlEncode("/order/" + OrderId .ToString()+ ".html");
    }

   

    protected void Page_Load(object sender, EventArgs e)
    {
      
        if (!IsPostBack)
        {
            bool bRedirect = true;
              if (D4D.Web.Helper.Helper.IsDizLogin)
            {
                ShopOrder sOrder = JaneShopGateway.JaneShopProvier.GetShopOrder(OrderId);
                if (sOrder != null)
                {
                    if (sOrder.Ordertype == OrderType.ShopCar)//购物车状态
                    {
                        int userId = D4D.Web.Helper.Helper.GetCookieUserId();
                        if (userId > 0)
                        {

                            bRedirect = false;
                        }
                    }
                    else if (sOrder.Ordertype == OrderType.Order)
                    {
                        Response.Redirect("/order/finish/" + OrderId.ToString() + ".html", true);
                        return;
                    }             
                }       
            }
              if (bRedirect)
                  Response.Redirect("/", true);
              else
              {
                  bool bBindList = true;
                  string strT = Request.QueryString["t"];
                  if (!string.IsNullOrEmpty(strT))
                  {
                      switch (strT.ToLower())
                      {
                          case "deltid":
                              delDialog.Visible = true;  
                              deleteMsg.Text = string.Format("是否要删除“{0}”商品？",Request.QueryString["tname"]);                              
                              break;
                           case "subtractcount":
                              if (TradeListId > 0)
                              {
                                  ShopTradelist sTradeList = JaneShopGateway.JaneShopProvier.GetShopTradelist(TradeListId);
                                  if (sTradeList != null && sTradeList.OrderId == OrderId && sTradeList.ItemCount > 0)
                                  {
                                      sTradeList.ItemCount = sTradeList.ItemCount - 1;
                                      JaneShopGateway.JaneShopProvier.SetShopTradelist(sTradeList);
                                  }
                              }
                              break;
                           case "addcount":
                              if (TradeListId > 0)
                              {
                                  ShopTradelist aTradeList = JaneShopGateway.JaneShopProvier.GetShopTradelist(TradeListId);
                                  if (aTradeList != null && aTradeList.OrderId == OrderId )
                                  {
                                      aTradeList.ItemCount = aTradeList.ItemCount + 1;
                                      JaneShopGateway.JaneShopProvier.SetShopTradelist(aTradeList);
                                  }
                              }
                              break;
                      }   
                  }         
                  if (bBindList)         
                     BindList();
              }
        }
    }

    public class ShopTradelistDetail : ShopTradelist
    {
        public ShopTradelistDetail() { }
        public ShopTradelistDetail(ShopTradelist tradeList)
        {
            this.Id = tradeList.Id;
            this.ItemId = tradeList.ItemId;
            this.ItemCount = tradeList.ItemCount;
            this.OrderId = tradeList.OrderId;
        }

        public ShopTradelistDetail(ShopTradelist tradeList,ShopItem item)
        {
            this.Id = tradeList.Id;
            this.ItemId = tradeList.ItemId;
            this.ItemCount = tradeList.ItemCount;
            this.OrderId = tradeList.OrderId;
            this.Item = item;
        }

        public string UrlEncodeItemName
        {
            get
            {
                string name = string.Empty;
                if (Item != null && !string.IsNullOrEmpty(Item.Name))
                {
                    name = HttpUtility.UrlEncode(Item.Name);
                }
                return name;
            }
        }
        public ShopItem Item
        {
            get;
            set;
        }
    }

    private void BindList()
    {
        bool bIsEmptyTradeList = true;
        if (OrderId > 0)
        {
            //getOrderList
            List<ShopTradelist> list =
                JaneShopGateway.JaneShopProvier.GetShopTradelistByOrderId(OrderId);

            if (list != null && list.Count > 0)
            {
                Dictionary<int, ShopItem> dicItemPrice = new Dictionary<int, ShopItem>();
                List<ShopTradelistDetail> detailList = new List<ShopTradelistDetail>(list.Count);
                  ShopItem shopItem;                 
                foreach (ShopTradelist t in list)
                {
                    shopItem = null;
                    TotalItems += t.ItemCount;
                    //getPrice
                    if (t.ItemId > 0)
                    {
                        if (!dicItemPrice.ContainsKey(t.ItemId))
                        {
                            shopItem = JaneShopGateway.JaneShopProvier.GetShopItem(t.ItemId);
                            if (shopItem != null)
                                dicItemPrice.Add(t.ItemId, shopItem);
                        }
                        else
                        {
                            dicItemPrice.TryGetValue(t.ItemId, out shopItem);                      
                            
                        }

                        if (shopItem != null)
                        {
                            detailList.Add(new ShopTradelistDetail(t, shopItem));
                            TotalPrice += (t.ItemCount * (shopItem.Price));
                        }
                    }
                }
                if (detailList.Count > 0)
                    bIsEmptyTradeList = false;
                repList.DataSource = detailList;
                repList.DataBind();
            }
        }

        if (bIsEmptyTradeList)
        {
            mvTradeList.ActiveViewIndex = 0;
        }
        else
            mvTradeList.ActiveViewIndex = 1;
    }
</script>