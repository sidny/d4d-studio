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
		<a href="/channel/shop/order_userorderlist.aspx" class="jane_info_menu_on">订单列表</a>
	</div>
	<div class="spacer"></div>
  </div>
  <!--left/-->
  <!--right-->
  <div class="right floatleft">
  <div class="cd_right">
    <div class="w_562 h_578">
      <div class="spacer" style="height:36px"></div>
	  
	  <div class="cd_title">订单列表</div>
	  
	  <div class="spacer" style="height:36px"></div> 	  
		 
		 
	<asp:Repeater ID="repList" runat="server">
	<HeaderTemplate>
	<div class="shopping_cart_list">
	  	    <div class="shopping_cart_list_img floatleft">订单号</div>		
		    <div class="shopping_cart_list_num floatleft">订单状态</div>
		    <div class="shopping_cart_list_num floatleft">支付结果</div>
		    <div class="clear"></div>
	     </div>
	</HeaderTemplate>
	    <ItemTemplate>
	    <div class="shopping_cart_list">
	  	    <div class="shopping_cart_list_img floatleft">
	  	     <asp:Literal ID="orderId" runat="server"></asp:Literal>
	  	    </div>		
		    <div class="shopping_cart_list_num floatleft">
		     <asp:Literal ID="orderType" runat="server"></asp:Literal>
		    </div>
		    <div class="shopping_cart_list_num floatleft">
		     <asp:Literal ID="orderPayResult" runat="server"></asp:Literal>
		    </div>
		    <div class="clear"></div>
	     </div>
	    </ItemTemplate>
	</asp:Repeater>	  
		
		 
		<div class="spacer" style="height:35px"></div>
		<div class="line_01"></div>
		<div class="spacer" style="height:50px"></div>
     
	    
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
          
        }//ispostback
    }
</script>