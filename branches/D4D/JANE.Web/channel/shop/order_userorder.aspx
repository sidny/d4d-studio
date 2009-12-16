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
	    <a href="/shop.html">商城</a>	
		<a href="/channel/shop/order_userorderlist.aspx" >订单列表</a>
	</div>
	<div class="spacer"></div>
  </div>
  <!--left/-->
  <!--right-->
  <div class="right floatleft">
  <div class="cd_right">
    <div class="w_562 h_578">
      <div class="spacer" style="height:36px"></div>
	  
	  <div class="cd_title">订单查询</div>
	  
	  <div class="spacer" style="height:36px"></div>
	   <asp:Literal ID="litMsg" runat="server"></asp:Literal>
	     <div class="order_confirm">	   
	    <div class="order_confirm_left floatleft b">
				订单号：  
		  </div>
		  <div class="order_confirm_right floatleft">
				<%=OrderId%>
		  </div>
		  <div class="clear"></div> 
	  </div>
	  
	  <div class="order_confirm">	   
	    <div class="order_confirm_left floatleft b">
				订单状态：  
		  </div>
		  <div class="order_confirm_right floatleft">
				<%=strOrderState %>
		  </div>
		  <div class="clear"></div> 
	  </div>
	  
	  <div class="order_confirm">	    
		  <div class="order_confirm_left floatleft b">
				送货地址：  
		  </div>
		  <div class="order_confirm_right floatleft">
				<asp:Literal ID="litName" runat="server"></asp:Literal><br />
				<asp:Literal ID="litAddr" runat="server"></asp:Literal><br />
				邮编	<asp:Literal ID="litZipCode" runat="server"></asp:Literal><br />
				<asp:Literal ID="litEmail" runat="server"></asp:Literal><br />
				<asp:Literal ID="litMobile" runat="server"></asp:Literal>
				<div class="spacer"></div>				
		  </div>
		  <div class="clear"></div>
	     </div>
		 
		 <div class="spacer" style="height:30px"></div>
		 
		 <div class="order_confirm">
		  <div class="order_confirm_left floatleft b">
				商品信息：  
		  </div>
		  <div class="order_confirm_right floatleft">
				<asp:Literal ID="litOrderInfo" runat="server"></asp:Literal>
		  </div>
		  <div class="clear"></div>
	     </div>
		 
		 <div class="spacer" style="height:30px"></div>
		 
		 <div class="order_confirm">
		  <div class="order_confirm_left floatleft b">
			订单价格：  
		  </div>
		  <div class="order_confirm_right floatleft">
				<%=TotalPrice %>
		  </div>
		  <div class="clear"></div>
	     </div>
		 
		 <div class="spacer" style="height:10px"></div>
		 
		 <div class="order_confirm">
		  <div class="order_confirm_left floatleft b">
				付款方式：  
		  </div>
		  <div class="order_confirm_right floatleft">
				<%=strPayMethod%>
		  </div>
		  <div class="clear"></div>
	     </div>
	     
	      <div class="order_confirm">
		  <div class="order_confirm_left floatleft b">
				支付结果：  
		  </div>
		  <div class="order_confirm_right floatleft">
				<%=strPayResult%>
		  </div>
		  <div class="clear"></div>
	     </div>
		 
		<div class="spacer12"></div>
		<div class="line_01"></div>
		<div class="spacer12"></div>
		<div class="spacer12"></div>

	  	<div style="padding-left:238px;"></div>
	  
	  <div class="spacer" style="height:30px"></div>
      
	  <div class="clear"></div>
    </div>
	<div class="clear"></div>
	</div>
	<div class="clear"></div>
  </div>
  <!--right/-->
  <div class="clear"></div>
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

    protected string strPayMethod = "未选择支付方式";
    protected string strOrderState = "未知";
    protected string strPayResult = "无";

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            if (D4D.Web.Helper.Helper.IsDizLogin)
            {
                int userId = D4D.Web.Helper.Helper.GetCookieUserId();
                if (userId > 0)
                {

                    //GetAddress from addInfo,2000 is user address
                    AddInfo aInfo =
                        D4D.Platform.D4DGateway.AddInfoProvider.GetAddInfo(userId, 2000);
                    if (aInfo != null)
                    {
                        litName.Text = aInfo.Info1;
                        litAddr.Text = aInfo.Info2;
                        litZipCode.Text = aInfo.Info3;
                        litEmail.Text = aInfo.Info4;
                        litMobile.Text = aInfo.Info5;

                    }

                    //show order info
                    if (OrderId > 0)
                    {
                        ShopOrder sOrder = JaneShopGateway.JaneShopProvier.GetShopOrder(OrderId);
                        if (sOrder != null && sOrder.UserId == userId)
                        {
                            switch (sOrder.Ordertype)
                            {
                                case OrderType.Order:
                                    strOrderState = "已确认订单";
                                    break;
                                case OrderType.ShopCar:
                                    strOrderState = "未确认订单，仍处于购物车状态";
                                    break;
                                default:
                                    break;    
                            }

                            switch (sOrder.Paytype)
                            {
                                case PayType.AliPay:
                                    strPayMethod = "支付宝支付";
                                    break;
                                case PayType.BankCard:
                                    strPayMethod = "银行支付";
                                    break;
                                case PayType.QuickMonty:
                                    strPayMethod = "快钱支付";
                                    break;
                                 
                            }

                            switch (sOrder.Payresult)
                            {
                                case PayResult.HasPay:
                                    strPayResult = "支付成功";
                                    if (!string.IsNullOrEmpty(sOrder.Paythirdnum))
                                        strPayResult += " 第三方支付订单号:" + sOrder.Paythirdnum;
                                    if (sOrder.Paydate != null)
                                        strPayResult += " 支付成功时间:" + sOrder.Paydate.ToString("yyyy-MM-dd HH:mm:ss");
                                    break;
                                case PayResult.PayFaild:
                                    strPayResult = "支付失败";
                                    break;
                                case PayResult.PayTradeSuccess:
                                    strPayResult = "交易成功";
                                    break;
                            }               
                          List<ShopTradelist> tradeList = JaneShopGateway.JaneShopProvier.GetShopTradelistByOrderId(OrderId);
                          if (tradeList != null && tradeList.Count > 0)
                          {

                              ShopItem shopItem;
                              Dictionary<int, ShopItem> dicItemPrice = new Dictionary<int, ShopItem>();
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
                                          litOrderInfo.Text += shopItem.Name + "x" + t.ItemCount.ToString() + " ";
                                          TotalPrice += (t.ItemCount * (shopItem.Price));
                                      }
                                  }
                              }
                          }//tradeList != null && tradeList.Count > 0
                         
                        }//sOrder != null && sOrder.UserId == userId
                        else
                            litMsg.Text = "订单不存在！"; 
                    }//orderid>0
                    else
                        litMsg.Text = "错误的订单号！"; 
                }//userid>0
                else
                    litMsg.Text = "请先登录才能查看订单!";
            }//islogin
            else
                litMsg.Text = "请先登录才能查看订单";
           
        }//postback
    }
</script>