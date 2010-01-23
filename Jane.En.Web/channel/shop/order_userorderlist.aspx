<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/MasterPage/Main.Master" %>
<%@ Import Namespace="JANE.Shop.Domain" %>
<%@ Import Namespace="D4D.Platform.Domain" %>
<%@ Import Namespace="JANE.Shop" %>
<%@ Import Namespace="System.Collections.Generic" %>
<%@ Import Namespace="System.Linq" %>
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
		<a href="/channel/shop/order_userorderlist.aspx" class="jane_info_menu_on">订单列表</a>
	</div>
	<div class="spacer"></div>
  </div>
  <!--left/-->
  <!--right-->
  <div class="right floatleft">
  <div class="cd_right">
    <div class="w_562 h_578">
	 <asp:Literal ID="litMsg" runat="server"></asp:Literal>
	<asp:Repeater ID="repList" runat="server" OnItemDataBound="repList_ItemDataBound" >
	<HeaderTemplate>
	<div class="shopping_cart_list">
	  	    <div class="shopping_cart_list_num floatleft">订单号</div>	
	  	    <div class="shopping_cart_list_num floatleft">创建日期</div>	
		    <div class="shopping_cart_list_num floatleft">支付方式</div>
		    <div class="shopping_cart_list_num floatleft">支付结果</div>		  
		    <div class="clear"></div>
	     </div>
	</HeaderTemplate>
	    <ItemTemplate>
	    <div class="shopping_cart_list">
	  	    <div class="shopping_cart_list_num floatleft">
	  	     <asp:Literal ID="litOrderId" runat="server"></asp:Literal>
	  	    </div>	  	 
	  	     <div class="shopping_cart_list_num floatleft">
		     <asp:Literal ID="litAddDate" runat="server"></asp:Literal>
		    </div>	   	
		    <div class="shopping_cart_list_num floatleft">
		     <asp:Literal ID="litPayType" runat="server"></asp:Literal>
		    </div>
		    <div class="shopping_cart_list_num floatleft">
		     <asp:Literal ID="litOrderPayResult" runat="server"></asp:Literal>
		    </div>		    
		    <div class="clear"></div>
	     </div>
	    </ItemTemplate>
	    <FooterTemplate>
	      <div class="pages">
	         <div id="pager" class="pages_num" style="width:auto"></div>
		<div class="clear"></div>
	     </div>
	    </FooterTemplate>
	</asp:Repeater>	 
		
		 
		<div class="spacer" style="height:35px"></div>
		<div class="line_01"></div>
		<div class="spacer" style="height:50px"></div>
     
	    
	  <div class="spacer" style="height:30px"></div>
      
	  <div class="clear"></div>
    </div>
	<div class="clear"></div>
	</div>
  </div>
  <!--right/-->
  </div> 
<script type="text/javascript">
    $(document).ready(function() {
        var cur = parseInt("<%=PageIndex %>");
        var total = parseInt("<%=PageTotalCount %>");
        var pageSize = parseInt("<%=PageSize %>");
        var href = location.pathname;
        if (location.search) {
            if (!location.search.match(/page=\d+/ig)) {
                href += location.search + "&page=__id__";
            } else {
                href += location.search;
            }
        } else {
            href += "?page=__id__";
        }
        $("#pager").pagination(
          total,
                {
                    items_per_page: pageSize,
                    num_display_entries: 10,
                    current_page: cur - 1,
                    num_edge_entries: 0,
                    link_to: href.replace(/page=\d+/ig, "page=__id__"),
                    prev_text: "上一页",
                    next_text: "下一页",
                    callback: function(id) {
                        return true;
                    }
                });
    });
</script>
</asp:Content>
<script runat="server"> 
    
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
    protected int PageSize = 20;
    private  int totalCount;
    protected int PageTotalCount
    {
        get
        {
            return totalCount;
        }
    }
 
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            if (D4D.Web.Helper.Helper.IsDizLogin)
            {
                int userId = D4D.Web.Helper.Helper.GetCookieUserId();
                if (userId > 0)
                {
                    PagingContext pager = new PagingContext();
                    pager.RecordsPerPage = PageSize;
                    pager.CurrentPageNumber = PageIndex;
                    List<ShopOrder> listShoporder =
                    JaneShopGateway.JaneShopProvier.GetPagedShopOrderbyUser(pager,
                    userId, OrderType.Order);
                    repList.DataSource = listShoporder;
                    repList.DataBind();
                     totalCount = pager.TotalRecordCount;
                   
    
                }
                else
                    litMsg.Text = "请先登录才能查看";
            }//not login
            else
                litMsg.Text = "请先登录才能查看";
        }//ispostback
    }

    protected void repList_ItemDataBound(object sender, RepeaterItemEventArgs e)
    {
        ShopOrder m = e.Item.DataItem as ShopOrder;

        if (m != null)
        {
            Literal litOrderId = e.Item.FindControl("litOrderId") as Literal;
            Literal litAddDate = e.Item.FindControl("litAddDate") as Literal;
            Literal litOrderPayResult = e.Item.FindControl("litOrderPayResult") as Literal;
            Literal litPayType = e.Item.FindControl("litPayType") as Literal;
            
             litOrderId.Text = string.Format("[<a href='/channel/shop/order_userorder.aspx?id={0}' >{0}</a>]",m.Id);
             litAddDate.Text = m.AddDate.ToString("yyyy-MM-dd HH:mm:ss");

             switch (m.Paytype)
             {
                 case PayType.AliPay:
                     litPayType.Text = "支付宝支付";
                     break;
                 case PayType.BankCard:
                     litPayType.Text = "银行支付";
                     break;
                 case PayType.QuickMonty:
                     litPayType.Text = "快钱支付";
                     break;
                 default:
                     litPayType.Text = "未选择支付方式";
                     break;
             }

             switch (m.Payresult)
             {
                 case PayResult.HasPay:
                     litOrderPayResult.Text = "支付成功";
                     if (!string.IsNullOrEmpty(m.Paythirdnum))
                         litOrderPayResult.Text += " 第三方支付订单号:" + m.Paythirdnum;
                     if (m.Paydate != null)
                         litOrderPayResult.Text += " 支付成功时间:" + m.Paydate.ToString("yyyy-MM-dd HH:mm:ss");
                     break;
                 case PayResult.PayFaild:
                     litOrderPayResult.Text = "支付失败";
                     break;
                 case PayResult.PayTradeSuccess:
                     litOrderPayResult.Text = "交易成功";
                     break;
                 default:
                     litOrderPayResult.Text = "未付款  [" + "<a href=\"/order/finish/" + m.Id.ToString() + ".html\" >重新提交付款</a>" + "]";
                     
                     break;
             }         
            
          
        }
    }
</script>