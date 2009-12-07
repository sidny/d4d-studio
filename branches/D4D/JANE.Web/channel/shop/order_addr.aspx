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
		<a href="/order/check/<%=OrderId %>.html">订单确认</a> 
		<a href="/order/addr/<%=OrderId %>.html" class="jane_info_menu_on">收货地址</a>
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
	  
	  <div class="cd_title to_addrees_title"></div>
	  
	  <div class="spacer" style="height:36px"></div> 
 
	  <div class="order_confirm">
		  <div class="order_confirm_left floatleft b">
				姓    名：  
		  </div>
		  <div class="order_confirm_right floatleft">
		       <asp:TextBox ID="txtName" runat="server" CssClass="input01" Width="218px"></asp:TextBox>				
		  </div>
		  <div class="clear"></div>
	     </div>
		 
		 <div class="spacer12"></div>
		 
		 <div class="order_confirm">
		  <div class="order_confirm_left floatleft b">
				地    址：  
		  </div>
		  <div class="order_confirm_right floatleft">
		   <asp:TextBox ID="txtAddr" runat="server" CssClass="input01" Width="376px"></asp:TextBox>
		  </div>
		  <div class="clear"></div>
	     </div>		 
		 
		 <div class="spacer12"></div>
		 
		 <div class="order_confirm">
		  <div class="order_confirm_left floatleft b">
				邮    编：  
		  </div>
		  <div class="order_confirm_right floatleft">		 
			  <asp:TextBox ID="txtZipCode" runat="server" CssClass="input01" Width="218px"></asp:TextBox>	
		  </div>
		  <div class="clear"></div>
	     </div>
		 
		 <div class="spacer12"></div>
		 
		 <div class="order_confirm">
		  <div class="order_confirm_left floatleft b">
				E-mail：  
		  </div>
		  <div class="order_confirm_right floatleft">
				  <asp:TextBox ID="txtEmail" runat="server" CssClass="input01" Width="218px"></asp:TextBox>	
		  </div>
		  <div class="clear"></div>
	     </div>
		 
		 <div class="spacer12"></div>
		 
		 <div class="order_confirm">
		  <div class="order_confirm_left floatleft b">
				联系电话：  
		  </div>
		  <div class="order_confirm_right floatleft">		
				 <asp:TextBox ID="txtMobile" runat="server" CssClass="input01" Width="218px"></asp:TextBox>	
		  </div>
		  <div class="clear"></div>
	     </div>
		 
		<div class="spacer" style="height:35px"></div>
		<div class="line_01"></div>
		<div class="spacer12"></div>
		<div class="spacer12"></div>

	  	<div style="padding-left:238px;"><asp:LinkButton ID="btnUpdateAddr" CssClass="btn_blue floatleft" runat="server" OnClick="btnUpdateAddr_Click"> <span>更新收货地址</span></asp:LinkButton></div>
	  <asp:Literal ID="litInfo" runat="server"></asp:Literal>
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

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            bool bRedirect = true;
            if (D4D.Web.Helper.Helper.IsDizLogin)
            {
                int userId = D4D.Web.Helper.Helper.GetCookieUserId();
                if (userId> 0)
                {
                    bRedirect = false;
                    //GetAddress from addInfo,2000 is user address
                    AddInfo aInfo =
                        D4D.Platform.D4DGateway.AddInfoProvider.GetAddInfo(userId, 2000);
                    if (aInfo != null)
                    {
                        txtName.Text = aInfo.Info1;
                        txtAddr.Text = aInfo.Info2;
                        txtZipCode.Text = aInfo.Info3;
                        txtEmail.Text = aInfo.Info4;
                        txtMobile.Text = aInfo.Info5;
                        
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

    protected void btnUpdateAddr_Click(object sender, EventArgs e)
    {
        AddInfo aInfo = new AddInfo();
        aInfo.ObjectType = 2000;
        if (string.IsNullOrEmpty(txtName.Text))
        {
            litInfo.Text = "请输入姓名！";
            return;
        }
        if (string.IsNullOrEmpty(txtAddr.Text))
        {
            litInfo.Text = "请输入地址！";
            return;
        }
        if (string.IsNullOrEmpty(txtZipCode.Text))
        {
            litInfo.Text = "请输入邮编！";
            return;
        }
        if (string.IsNullOrEmpty(txtEmail.Text))
        {
            litInfo.Text = "请输入邮箱！";
            return;
        }
        if (string.IsNullOrEmpty(txtMobile.Text))
        {
            litInfo.Text = "请输入电话联系方式！";
            return;
        }
        int userId = D4D.Web.Helper.Helper.GetCookieUserId();
        if (userId > 0)
         {
             aInfo.Info1 = txtName.Text;
             aInfo.Info2 = txtAddr.Text;
             aInfo.Info3 = txtZipCode.Text;
             aInfo.Info4 = txtEmail.Text;
             aInfo.Info5 = txtMobile.Text;
             aInfo.ObjectId = userId;

             D4D.Platform.D4DGateway.AddInfoProvider.SetAddInfo(aInfo);
         }
    
    }
</script>