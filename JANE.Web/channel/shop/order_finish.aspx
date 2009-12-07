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
			
			<span class="blue font16">此订单已交处理中心，很快您会收到一封确认信，请注意查收！</span>
	     </div>
		 
		<div class="spacer" style="height:35px"></div>
		<div class="line_01"></div>
		<div class="spacer" style="height:50px"></div>

	  	<div class="aligncenter">正准备自动连接银行支付页面，请稍后3秒钟……</div>
	  
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

    protected float TotalPrice
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
                    if (OrderId > 0)
                    {
                          ShopOrder sOrder = JaneShopGateway.JaneShopProvier.GetShopOrder(OrderId);
                          if (sOrder != null && sOrder.UserId == userId)
                          {
                              bRedirect = false;
                              string info = "未知";
                              switch (sOrder.Paytype)
                              {
                                  case PayType.AliPay:
                                      info = "支付宝支付";
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