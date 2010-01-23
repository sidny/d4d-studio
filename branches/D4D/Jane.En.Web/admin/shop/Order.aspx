<%@ Page Language="C#" AutoEventWireup="true" ValidateRequest="false" MasterPageFile="~/admin/Admin.Master" %>
<%@ Import Namespace="System.Linq" %>
<%@ Import Namespace="System.Collections.Generic" %>
<%@ Import Namespace="D4D.Platform" %>
<%@ Import Namespace="D4D.Platform.Domain" %>
<%@ Import Namespace="JANE.Shop" %>
<%@ Import Namespace="JANE.Shop.Domain" %>
<%@ Import Namespace="LTP.Accounts.Bus" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>订单管理</title>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentBody" runat="server">

    <script type="text/javascript" src="/static/js/jquery.autocomplete.js"></script>

    <script language="javascript">
        function ConfirmDelete() {
            if (window.confirm("您确认删除么？"))
                return true;
            else
                return false;
        }
</script>

    <form id="form1" runat="server">
    <asp:Panel ID="listPanel" runat="server">
        <div>
            <div>
                <h1>
                    订单列表 <asp:DropDownList ID="ddlOrderTypeFilter" runat="server" 
                        onselectedindexchanged="ddlOrderTypeFilter_SelectedIndexChanged" 
                        AutoPostBack="True">
                        <asp:ListItem Value="2">全部</asp:ListItem>
                        <asp:ListItem Value="1">已生成订单</asp:ListItem>
                        <asp:ListItem Value="0">购物车</asp:ListItem>
                        </asp:DropDownList></h1>
            </div>
            <asp:Repeater ID="repList" OnItemDataBound="repList_ItemDataBound" runat="server">
                <HeaderTemplate>
                    <table cellspacing="1" cellpadding="4" rules="all" align="center" width="100%" class="grid">
                        <tr align="center">
                            <th align="center" style="width: 30px;">
                                编号
                            </th>
                            <th>
                                用户ID
                            </th>
                            <th>
                                添加日期
                            </th>
                            <th>
                                订单状态
                            </th>
                             <th>
                                送货地域
                            </th>
                            <th>
                                发货地址
                            </th>
                             <th>
                                邮编
                            </th>
                            <th>
                                邮箱
                            </th>
                             <th>
                                电话
                            </th>
                             <th>
                                收货人
                            </th>
                             <th>
                                金额
                            </th>
                             <th>
                                支付方式
                            </th>
                             <th>
                               支付结果
                            </th>
                             <th>
                               支付日期
                            </th>
                             <th>
                               第三方支付单号
                            </th>
                             <th>
                               支付备注
                            </th>
                            <th>
                               商品
                            </th>
                            <th style="width: 30px;">
                                修改
                            </th>
                            <th style="width: 30px;">
                                删除
                            </th>
                        </tr>
                </HeaderTemplate>
                <ItemTemplate>
                    <tr align="center">
                        <td align="center" style="width: 30px;">
                            <asp:Literal ID="litID" runat="server"></asp:Literal>
                        </td>
                        <td>
                          <asp:Literal ID="litUserId" runat="server"></asp:Literal>
                        </td>
                        <td>
                            <asp:Literal ID="litAddDate" runat="server"></asp:Literal>
                        </td>
                        <td>
                            <asp:Literal ID="litOrderType" runat="server"></asp:Literal>
                        </td>
                         <td>
                            <asp:Literal ID="litRegionStr" runat="server"></asp:Literal>
                        </td>
                        <td>
                            <asp:Literal ID="litAddr" runat="server"></asp:Literal>
                        </td>
                        <td>
                            <asp:Literal ID="litZipCode" runat="server"></asp:Literal>
                        </td>
                         <td>
                            <asp:Literal ID="litEmail" runat="server"></asp:Literal>
                        </td>
                         <td>
                            <asp:Literal ID="litMobile" runat="server"></asp:Literal>
                        </td>
                         <td>
                            <asp:Literal ID="litUserName" runat="server"></asp:Literal>
                        </td>
                         <td>
                            <asp:Literal ID="litPaymoney" runat="server"></asp:Literal>
                        </td>
                         <td>
                            <asp:Literal ID="litPayType" runat="server"></asp:Literal>
                        </td>
                         <td>
                            <asp:Literal ID="litPayResult" runat="server"></asp:Literal>
                        </td>
                         <td>
                            <asp:Literal ID="listPayDate" runat="server"></asp:Literal>
                        </td>
                         <td>
                            <asp:Literal ID="litPayThirdNum" runat="server"></asp:Literal>
                        </td>
                         <td>
                            <asp:Literal ID="litPayRemark" runat="server"></asp:Literal>
                        </td>
                         <td>
                            <asp:Literal ID="litTradeList" runat="server"></asp:Literal>
                        </td>
                        <td style="width: 30px;">
                            <asp:Button ID="btnUpdate" runat="server" OnClick="btnUpdate_Click" Text="修改" />
                        </td>
                        <td style="width: 30px;">
                            <asp:Button ID="btnDelete" runat="server" OnClick="btnDelete_Click" Text="删除" OnClientClick="return  ConfirmDelete()" />
                        </td>
                    </tr>
                </ItemTemplate>
                <FooterTemplate>
                    <tr align="right" style="font-size: medium; white-space: nowrap;">
                        <td colspan="18" valign="middle" class="pagestyle" id="pager">
                        </td>
                        <td class="pagestyle">
                            <asp:Button ID="btnAddShow" runat="server" OnClick="btnAdd_Show" Text="新增" />
                        </td>
                    </tr>
                    </table>
                </FooterTemplate>
            </asp:Repeater>
        </div>
    </asp:Panel>
    <asp:Panel ID="addPanel" runat="server">
        <div>
            <h1>
                编辑订单</h1>
        </div>
        <div>
            <table cellspacing="1" cellpadding="4" rules="all" align="center" width="100%" class="grid">
                <tr>
                    <th>
                        用户ID
                    </th>
                    <td>
                        <asp:TextBox ID="txtUserId" runat="server"></asp:TextBox>
                        <asp:HiddenField ID="txtNewsId" runat="server" Value="0"></asp:HiddenField>
                    </td>
                </tr>
                <tr>
                    <th >
                        添加日期
                    </th>
                    <td>
                       <asp:TextBox ID="txtAddDate" runat="server"  CssClass="has-datepicker"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <th >
                        订单状态
                    </th>
                    <td>
                       <asp:DropDownList ID="ddpOrderType" runat="server">
                            <asp:ListItem Text="购物车" Value="0"></asp:ListItem>
                            <asp:ListItem Text="已确认订单" Value="1"></asp:ListItem>
                        </asp:DropDownList>
                    </td>
                </tr>                
                <tr>
                    <th>
                        发货地址
                    </th>
                    <td>
                        <asp:TextBox ID="txtAddr" runat="server"></asp:TextBox>
                    </td>
                </tr>               
                <tr>
                    <th>
                        邮编
                    </th>
                    <td>
                         <asp:TextBox ID="txtZipCode" runat="server"></asp:TextBox>
                    </td>
                </tr>
                 <tr>
                    <th>
                        邮箱
                    </th>
                    <td>
                         <asp:TextBox ID="txtEmail" runat="server"></asp:TextBox>
                    </td>
                </tr>
                 <tr>
                    <th>
                        电话
                    </th>
                    <td>
                         <asp:TextBox ID="txtMobile" runat="server"></asp:TextBox>
                    </td>
                </tr>
                 <tr>
                    <th>
                        收货人
                    </th>
                    <td>
                         <asp:TextBox ID="txtUserName" runat="server"></asp:TextBox>
                    </td>
                </tr>
                 <tr>
                    <th>
                        金额
                    </th>
                    <td>
                         <asp:TextBox ID="txtPaymoney" runat="server"></asp:TextBox>
                    </td>
                </tr>
                 <tr>
                    <th>
                        支付方式
                    </th>
                    <td>
                          <asp:DropDownList ID="ddpPayType" runat="server">
                            <asp:ListItem Text="未选择支付方式" Value="0"></asp:ListItem>
                            <asp:ListItem Text="支付宝" Value="1"></asp:ListItem>
                            <asp:ListItem Text="银行卡" Value="2"></asp:ListItem>
                            <asp:ListItem Text="快钱" Value="3"></asp:ListItem>
                        </asp:DropDownList>
                    </td>
                </tr>
                 <tr>
                    <th>
                        支付结果
                    </th>
                    <td>
                          <asp:DropDownList ID="ddpPayResult" runat="server">
                            <asp:ListItem Text="未支付" Value="0"></asp:ListItem>
                            <asp:ListItem Text="支付完毕" Value="1"></asp:ListItem>
                            <asp:ListItem Text="支付失败" Value="2"></asp:ListItem>  
                            <asp:ListItem Text="第三方支付成功待完毕" Value="3"></asp:ListItem>                            
                        </asp:DropDownList>
                    </td>
                </tr>
                 <tr>
                    <th>
                        支付日期
                    </th>
                    <td>
                         <asp:TextBox ID="txtPayDate" runat="server" CssClass="has-datepicker"></asp:TextBox>
                    </td>
                </tr>
                 <tr>
                    <th>
                         第三方支付单号
                    </th>
                    <td>
                         <asp:TextBox ID="txtPayThirdNum" runat="server"></asp:TextBox>
                    </td>
                </tr>
                 <tr>
                    <th>
                        支付备注
                    </th>
                    <td>
                         <asp:TextBox ID="txtPayRemark" runat="server"></asp:TextBox>
                    </td>
                </tr>                
                  <tr>
                    <th>
                        运送地区id
                    </th>
                    <td>
                         <asp:TextBox ID="txtRegionId" runat="server"></asp:TextBox>
                    </td>
                </tr>
                 <tr>
                    <th>
                        运送地域
                    </th>
                    <td>
                         <asp:TextBox ID="txtRegionStr" runat="server"></asp:TextBox>
                    </td>
                </tr>        
                  <tr>
                    <th>
                        运费
                    </th>
                    <td>
                         <asp:TextBox ID="txtFreight" runat="server"></asp:TextBox>
                    </td>
                </tr>    
                <tr>
                    <th align="center" width="100">&nbsp;
                        
                    </th>
                    <td>
                        <asp:Button ID="btnAdd" runat="server" Text="新增" OnClick="btnAdd_Click" />
                    </td>
                </tr>
            </table>
        </div>

    </asp:Panel>

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

    </form>
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
    protected int PageSize = 10;
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
            addPanel.Visible = false;
            BindList();
          
        }
    }
    private void BindList()
    {
        int iorderType;
        int.TryParse(ddlOrderTypeFilter.SelectedValue, out iorderType);
        
        PagingContext pager = new PagingContext();
        pager.CurrentPageNumber = PageIndex;
        pager.RecordsPerPage = PageSize;
        IList<ShopOrder> list = JaneShopGateway.JaneShopProvier.GetPagedShopOrder(pager, (OrderType)(iorderType));
        repList.DataSource = list;
        repList.DataBind();
        totalCount = pager.TotalRecordCount;

    }
   

    protected void btnUpdate_Click(object sender, EventArgs e)
    {
        Button bt = sender as Button;

        RepeaterItem ri = bt.Parent as RepeaterItem;

        Literal litID = ri.FindControl("litID") as Literal;

        if (!object.Equals(litID, null))
        {
            int id = 0;
            if (int.TryParse(litID.Text, out id))
            {
                ShopOrder m = JaneShopGateway.JaneShopProvier.GetShopOrder(id);
                DrawAddPanel(m);
                btnAdd.Text = "更新";
                addPanel.Visible = true;
            }
        }
    }
    protected void btnDelete_Click(object sender, EventArgs e)
    {
        Button bt = sender as Button;

        RepeaterItem ri = bt.Parent as RepeaterItem;

        Literal litID = ri.FindControl("litID") as Literal;
        if (!object.Equals(litID, null))
        {
            int id = 0;
            if (int.TryParse(litID.Text, out id))
            {
                JaneShopGateway.JaneShopProvier.DeleteShopOrder(id);
                BindList();
            }
        }

    }

    protected void repList_ItemDataBound(object sender, RepeaterItemEventArgs e)
    {
        ShopOrder m = e.Item.DataItem as ShopOrder;

        if (m != null)
        {
            Literal litId = e.Item.FindControl("litID") as Literal;
            Literal litUserId = e.Item.FindControl("litUserId") as Literal;
            Literal litAddDate = e.Item.FindControl("litAddDate") as Literal;
            Literal litOrderType = e.Item.FindControl("litOrderType") as Literal;
            Literal litAddr = e.Item.FindControl("litAddr") as Literal;
            Literal litZipCode = e.Item.FindControl("litZipCode") as Literal;
            Literal litEmail = e.Item.FindControl("litEmail") as Literal;
            Literal litMobile = e.Item.FindControl("litMobile") as Literal;
            Literal litUserName = e.Item.FindControl("litUserName") as Literal;
            Literal litPaymoney = e.Item.FindControl("litPaymoney") as Literal;
            Literal litPayType = e.Item.FindControl("litPayType") as Literal;
            Literal litPayResult = e.Item.FindControl("litPayResult") as Literal;

            Literal listPayDate = e.Item.FindControl("listPayDate") as Literal;
            Literal litPayThirdNum = e.Item.FindControl("litPayThirdNum") as Literal;
            Literal litPayRemark = e.Item.FindControl("litPayRemark") as Literal;
            Literal litTradeList = e.Item.FindControl("litTradeList") as Literal;
            Literal litRegionStr = e.Item.FindControl("litRegionStr") as Literal;

            litId.Text = m.Id.ToString();
            litUserId.Text = m.UserId.ToString();
            litAddDate.Text = m.AddDate.ToString("yyyy-MM-dd HH:mm:ss");
            litOrderType.Text = (m.Ordertype == OrderType.Order)?"已生成订单":"购物车";

            litRegionStr.Text = m.RegionStr;
            litAddr.Text = m.Address;
            litZipCode.Text = m.ZipCode;
            litEmail.Text = m.Email;
            litMobile.Text = m.Mobile;
            litUserName.Text = m.UserName;
            litPaymoney.Text = m.Paymoney.ToString();
            switch (m.Paytype)
            {
                case PayType.AliPay:
                    litPayType.Text = "支付宝";
                    break;
                case PayType.BankCard:
                    litPayType.Text = "银行卡";
                    break;
                case PayType.QuickMonty:
                    litPayType.Text = "快钱";
                    break;
                default:
                    litPayType.Text = "未选择支付方式";
                    break;
            }
            switch (m.Payresult)
            {
                case PayResult.HasPay:
                    litPayResult.Text = "支付完毕";
                    break;
                case PayResult.PayFaild:
                    litPayResult.Text = "支付失败";
                    break;
                case PayResult.PayTradeSuccess:
                    litPayResult.Text = "第三方支付成功待完毕";
                    break;
                default:
                    litPayResult.Text = "未支付";
                    break;
            }
            listPayDate.Text = m.Paydate.ToString("yyyy-MM-dd HH:mm:ss");
            litPayThirdNum.Text = m.Paythirdnum;
            litPayRemark.Text = m.Payremark;
            litTradeList.Text =string.Format("<a href='OrderTradeList.aspx?id={0}'>详细</a>",m.Id);
         
        }
    }

    protected void btnAdd_Click(object sender, EventArgs e)
    {
        ShopOrder item = new ShopOrder();
        int id = 0;
        int.TryParse(txtNewsId.Value, out id);
        item.Id = id;

        int userid = 0;
        int.TryParse(txtUserId.Text, out userid);
        item.UserId = userid;
        
        DateTime dateAdd = DateTime.MinValue;
        DateTime.TryParse(txtAddDate.Text, out dateAdd);
        if (dateAdd == DateTime.MinValue)
            dateAdd = DateTime.Now;
        item.AddDate = dateAdd;

        int orderType = 0;
        int.TryParse(ddpOrderType.SelectedValue, out orderType);
        item.Ordertype = (OrderType)orderType;

        item.Address = txtAddr.Text;
        item.ZipCode = txtZipCode.Text;
        item.Email = txtEmail.Text;
        item.Mobile = txtMobile.Text;
        item.UserName = txtUserName.Text;
        
        double payMoney = 0.0;
        double.TryParse(txtPaymoney.Text, out payMoney);
        item.Paymoney = payMoney;

        int payType=0;
        int.TryParse(ddpPayType.SelectedValue, out payType);
        item.Paytype = (PayType)payType;

        int payResult = 0;
        int.TryParse(ddpPayResult.SelectedValue, out payResult);
        item.Payresult = (PayResult)payResult;

        DateTime payDate = new DateTime(1900,1,1);
        DateTime.TryParse(txtPayDate.Text, out payDate);
        item.AddDate = payDate;


        item.Paythirdnum = txtPayThirdNum.Text;
        item.Payremark = txtPayRemark.Text;

        int iRegionId = 0;
        int.TryParse(txtRegionId.Text, out iRegionId);
        item.RegionId = iRegionId;

        double freight = 0;
        double.TryParse(txtFreight.Text, out freight);
        item.Freight = freight;

        item.RegionStr = txtRegionStr.Text;
         
        
        int result = JaneShopGateway.JaneShopProvier.SetShopOrder(item);
        addPanel.Visible = false;

        BindList();
    }

    protected void btnAdd_Show(object sender, EventArgs e)
    {
        DrawAddPanel(null);
        addPanel.Visible = true;
        btnAdd.Text = "添加";
    }

    private void DrawAddPanel(ShopOrder item)
    {
        if (item == null) item = new ShopOrder();
        txtNewsId.Value = item.Id.ToString();
        txtUserId.Text = item.UserId.ToString();
        if (item.AddDate == null || item.AddDate == DateTime.MinValue)
            txtAddDate.Text = DateTime.Now.ToLongDateString();
        else
            txtAddDate.Text = item.AddDate.ToLongDateString();

        ddpOrderType.SelectedValue = ((int)item.Ordertype).ToString();
        txtAddr.Text = item.Address;
        txtZipCode.Text = item.ZipCode;
        txtEmail.Text = item.Email; ;
        txtMobile.Text = item.Mobile;
        txtUserName.Text = item.UserName;
        txtPaymoney.Text = item.Paymoney.ToString();
        ddpPayType.SelectedValue = ((int)item.Paytype).ToString();
        ddpPayResult.SelectedValue = ((int)item.Payresult).ToString();

        txtPayDate.Text = item.Paydate.ToLongDateString();
        txtPayThirdNum.Text = item.Paythirdnum;
        txtPayRemark.Text = item.Payremark;

        txtRegionId.Text = item.RegionId.ToString();
        txtFreight.Text = item.Freight.ToString();
        txtRegionStr.Text = item.RegionStr;
    }

    protected void ddlOrderTypeFilter_SelectedIndexChanged(object sender, EventArgs e)
    {
        BindList();
    }

</script>

