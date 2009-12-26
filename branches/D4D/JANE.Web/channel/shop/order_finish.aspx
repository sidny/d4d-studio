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
		<a href="#">购物车</a> 
		<a href="#">订单确认</a> 
		<a href="#">收货地址</a>
		<a href="#" class="jane_info_menu_on">订单完成</a>
	</div>
	<div class="spacer"></div>
  </div>
  <!--left/-->
  <!--right-->
  <div class="right floatleft">
  <div class="cd_right">
    <div class="w_562 h_578">
      <div class="spacer" style="height:36px"></div>
	  
	  <div class="cd_title order_ok_title"></div>
	  
	  <div class="spacer" style="height:36px"></div> 
 
	  
		 
		 
		 
		 <div class="order_ok font16 b">
		  	张靓颖官方网站 感谢您的订购！<br />
			您的订单号： <%=OrderId%><br />                   
			支付方式为：<asp:Literal ID="litPayType" runat="server" ></asp:Literal><br /><br /><br />
			<span class="blue font16"><%=strMessage %></span>
			 <!--
			<span class="blue font16">此订单已交处理中心，很快您会收到一封确认信，请注意查收！</span>
				-->
	     </div>
		 
		<div class="spacer" style="height:35px"></div>
		<div class="line_01"></div>
		<div class="spacer" style="height:50px"></div>
        <!--
	  	<div class="aligncenter">正准备自动连接银行支付页面，请稍后3秒钟……</div>	  	
	  	-->
	  	
	    
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
  	<%if (!string.IsNullOrEmpty(payUrl))
        { %>
  <script type="text/javascript">
      window.open('<%=payUrl %>');
  </script>
    <%} %>
</asp:Content>
<script runat="server">
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
    protected string strMessage = string.Empty;
    protected string payUrl = string.Empty;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            bool bRedirect = true;
            if (D4D.Web.Helper.Helper.IsDizLogin)
            {
                int userId = D4D.Web.Helper.Helper.GetCookieUserId();
                if (userId > 0)
                {
                    if (OrderId > 0)
                    {
                          ShopOrder sOrder = JaneShopGateway.JaneShopProvier.GetShopOrder(OrderId);
                          if (sOrder != null && sOrder.UserId == userId && sOrder.Ordertype == OrderType.Order
                              && sOrder.Id > 0 && (sOrder.Payresult == PayResult.None || sOrder.Payresult == PayResult.PayFaild)
                              )
                          {
                               List<ShopTradelist> tradeList = JaneShopGateway.JaneShopProvier.GetShopTradelistByOrderId(OrderId);
                               if (tradeList != null && tradeList.Count > 0)
                               {
                                   bRedirect = false;
                                   string info = "未知";
                                   #region GetItem
                                   ShopItem shopItem;
                                   Dictionary<int, ShopItem> dicItemPrice = new Dictionary<int, ShopItem>();
                                   StringBuilder sbShopItems = new StringBuilder(256);
                                   foreach (ShopTradelist t in tradeList)
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
                                               sbShopItems.Append(shopItem.Name);
                                               sbShopItems.Append("x");
                                               sbShopItems.Append(t.ItemCount);
                                               //litOrderInfo.Text += shopItem.Name + "x" + t.ItemCount.ToString() + " ";
                                               TotalPrice += (t.ItemCount * (shopItem.Price));
                                           }
                                       }
                                   }//end foreach
                                   string shopitemDes = sbShopItems.ToString();
                                   if (!string.IsNullOrEmpty(shopitemDes))
                                   {
                                       shopitemDes = "张靓颖官网商品";
                                   }
                                   else if (shopitemDes.Length > 350)
                                       shopitemDes = shopitemDes.Substring(0, 350);
                                   #endregion
                                   switch (sOrder.Paytype)
                                   {
                                       case PayType.AliPay:
                                           info = "支付宝支付";
                                           //create alipay url
                                           AliPayConfig aliPayConfig = new AliPayConfig();
                                           payUrl = JaneShopGateway.AliPayProvider.CreatUrl(
                                             aliPayConfig.GatewayUrl,
                                            AliPayDefinition.SERVICE_CREATE_DIRECT_PAY_BY_USER,
                                            aliPayConfig.PartnerID,
                                            AliPayDefinition.DEFAULT_SIGNTYPE,
                                            sOrder.Id.ToString(),
                                            "张靓颖官网商品",
                                            shopitemDes,
                                            ((int)AliPaymentType.BuyProduct).ToString(),//1
                                            TotalPrice.ToString(),
                                            "http://cn.janezhang.com",//商品展示链接
                                            aliPayConfig.SellerEmail, //"bd@showcitytimes.net",
                                            aliPayConfig.PartnerKey,
                                            aliPayConfig.ReturnUrl,
                                            aliPayConfig.EncodingName,
                                            aliPayConfig.NotifyUrl);
                                           //add strMessage
                                           strMessage = "此订单已提交支付宝支付，请注意弹出支付宝窗口是否被浏览器拦截！";
                                           break;
                                       case PayType.BankCard:
                                           info = "银行卡支付";
                                           break;
                                       case PayType.QuickMonty:
                                           info = "快钱支付";
                                           break;
                                       default:
                                           break;
                                   }

                                   litPayType.Text = info;
                               }//tradeList
                               else
                               {
                                   strMessage = "订单状态错误：没有选择购物物品！";
                               }
                          }//else order error
                          else
                          {
                              strMessage = "订单状态错误：单号错误或者已经付款完毕！";
                          }
                          
                    }
                }
            }
            if (bRedirect)
            {
                Response.Redirect("/", true);
                return;
            }
        }//ispostback
    }
</script>