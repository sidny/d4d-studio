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
		<a href="/order/<%=OrderId %>.html">购物车</a> 
		<a href="/order/check/<%=OrderId %>.html" class="jane_info_menu_on">订单确认</a> 
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
	  
	  <div class="cd_title order_confirm_title"></div>
	  
	  <div class="spacer" style="height:36px"></div>
	  
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
				<a href="/order/addr/<%=OrderId %>.html" class="btn_gray floatleft"><span>更新收获地址</span></a>
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
				<ul class="pay_sort">
					<li>
						<img src="images/pay_xyk.gif" />
						<asp:RadioButton ID="RadioButton1" runat="server"
                                                    GroupName="paymethod" Checked="True" Text="银行卡信用卡支付"></asp:RadioButton>                          
					</li>
					<li>
						<img src="images/pay_zfb.gif" />
							<asp:RadioButton ID="RadioButton2" runat="server"
                                                    GroupName="paymethod"  Text="支付宝支付"></asp:RadioButton>                     
					</li>
					<li>
						<img src="images/pay_kq.gif" />
						<asp:RadioButton ID="RadioButton3" runat="server"
                                                    GroupName="paymethod" Text="快钱支付"></asp:RadioButton>                     
					</li>
				</ul>
		  </div>
		  <div class="clear"></div>
	     </div>
		 
		<div class="spacer12"></div>
		<div class="line_01"></div>
		<div class="spacer12"></div>
		<div class="spacer12"></div>

	  	<div style="padding-left:238px;"><asp:LinkButton ID="btnConfirm" CssClass="btn_blue floatleft" runat="server" OnClick="btnConfirm_Click"> <span>确认订单</span></asp:LinkButton></div>
	  
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
  </form>
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
                    else
                    {
                        Response.Redirect("/order/addr/" + OrderId.ToString() + ".html", true);
                        return;
                    }

                    //show order info
                    if (OrderId > 0)
                    {
                        ShopOrder sOrder = JaneShopGateway.JaneShopProvier.GetShopOrder(OrderId);
                        if (sOrder != null && sOrder.UserId == u.Uid)
                        {
                            if (sOrder.Ordertype == OrderType.ShopCar)//购物车状态
                            {
                                List<ShopTradelist> tradeList = JaneShopGateway.JaneShopProvier.GetShopTradelistByOrderId(OrderId);
                                if (tradeList != null && tradeList.Count > 0)
                                {
                                    bRedirect = false;
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

                                }
                                else if (sOrder.Ordertype == OrderType.Order)
                                {
                                    Response.Redirect("/order/finish/" + OrderId.ToString() + ".html", true);
                                    return;
                                }
                            }
                        }
                    }
                }                
            }
            if (bRedirect)
            {
                Response.Redirect("/", true);
                return;
            }
        }
    }

    protected void btnConfirm_Click(object sender, EventArgs e)
    {
       
          ShopOrder sOrder = JaneShopGateway.JaneShopProvier.GetShopOrder(OrderId);
          if (sOrder != null && sOrder.Ordertype ==OrderType.ShopCar)
          {
              if (RadioButton1.Checked)
              {
                  sOrder.Paytype = PayType.BankCard;
              }
              else if (RadioButton2.Checked)
              {
                  sOrder.Paytype = PayType.AliPay;
              }
              else
              {
                  sOrder.Paytype = PayType.QuickMonty;
              }
              sOrder.Ordertype = OrderType.Order;
              sOrder.UserName = litName.Text;
              sOrder.Address = litAddr.Text;
              sOrder.Email = litEmail.Text;
              sOrder.Mobile = litMobile.Text;
              sOrder.ZipCode = litZipCode.Text;

              JaneShopGateway.JaneShopProvier.SetShopOrder(sOrder);
              Response.Redirect("/order/finish/"+ OrderId.ToString()+".html");
          }
    
    }
    
</script>