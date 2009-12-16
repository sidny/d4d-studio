<%@ Page Language="C#" AutoEventWireup="true" ValidateRequest="false" MasterPageFile="~/admin/Admin.Master" %>
<%@ Import Namespace="System.Linq" %>
<%@ Import Namespace="System.Collections.Generic" %>
<%@ Import Namespace="D4D.Platform" %>
<%@ Import Namespace="D4D.Platform.Domain" %>
<%@ Import Namespace="JANE.Shop" %>
<%@ Import Namespace="JANE.Shop.Domain" %>
<%@ Import Namespace="LTP.Accounts.Bus" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>订单商品列表</title>
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
                    订单[<%=OrderId %>] - 商品列表</h1>
            </div>
            <asp:Repeater ID="repList" OnItemDataBound="repList_ItemDataBound" runat="server">
                <HeaderTemplate>
                    <table cellspacing="1" cellpadding="4" rules="all" align="center" width="100%" class="grid">
                        <tr align="center">
                            <th align="center" style="width: 30px;">
                                编号
                            </th>
                            <th>
                                订单编号
                            </th>
                            <th>
                                商品编号
                            </th>
                            <th>
                                商品数量
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
                         <asp:Literal ID="litOrderId" runat="server"></asp:Literal>                         
                        </td>
                        <td>
                            <asp:Literal ID="litShopItemId" runat="server"></asp:Literal>
                        </td>
                        <td>
                            <asp:Literal ID="litShopItemCount" runat="server"></asp:Literal>
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
                        <td colspan="5" valign="middle">
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
                编辑商品</h1>
        </div>
        <div>
            <table cellspacing="1" cellpadding="4" rules="all" align="center" width="100%" class="grid">
                <tr>
                    <th align="center" width="100">
                        订单编号
                    </th>
                    <td>
                        <asp:TextBox ID="txtOrderId" runat="server"></asp:TextBox>
                        <asp:HiddenField ID="txtNewsId" runat="server" Value="0"></asp:HiddenField>
                    </td>
                </tr>
                <tr>
                    <th>
                        商品编号
                    </th>
                    <td>
                       <asp:TextBox ID="txtShopItem" runat="server"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <th width="100">
                        商品数量
                    </th>
                    <td>
                        <asp:TextBox ID="txtShopItemCount" runat="server" ></asp:TextBox>
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
            addPanel.Visible = false;
            BindList();           
        }
    }
    private void BindList()
    {
      
        IList<ShopTradelist> list = JaneShopGateway.JaneShopProvier.GetShopTradelistByOrderId(OrderId);
        repList.DataSource = list;
        repList.DataBind();       

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
                ShopTradelist m = JaneShopGateway.JaneShopProvier.GetShopTradelist(id);
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
                JaneShopGateway.JaneShopProvier.DeleteShopTradelist(id);
                BindList();
            }
        }

    }

    protected void repList_ItemDataBound(object sender, RepeaterItemEventArgs e)
    {
        ShopTradelist m = e.Item.DataItem as ShopTradelist;

        if (m != null)
        {
            Literal litId = e.Item.FindControl("litID") as Literal;
            Literal litOrderId = e.Item.FindControl("litOrderId") as Literal;
            Literal litShopItemId = e.Item.FindControl("litShopItemId") as Literal;
            Literal litShopItemCount = e.Item.FindControl("litShopItemCount") as Literal;              

            litId.Text = m.Id.ToString();
            litOrderId.Text = m.OrderId.ToString();
            litShopItemId.Text = string.Format("<a href='/shop/{0}.html' >{0}</a>", m.ItemId);
            litShopItemCount.Text = m.ItemCount.ToString();
           
        }
    }

    protected void btnAdd_Click(object sender, EventArgs e)
    {
        ShopTradelist item = new ShopTradelist();
        int id = 0;
        int.TryParse(txtNewsId.Value, out id);        
        item.Id = id;

        int orderid = 0;
        int.TryParse(txtOrderId.Text, out orderid);
        if (orderid <= 0) orderid = OrderId;
        item.OrderId = OrderId;

        int shopitemid = 0;
        int.TryParse(txtShopItem.Text, out shopitemid);
        item.ItemId = shopitemid;

        int shopitemcount = 0;
        int.TryParse(txtShopItemCount.Text, out shopitemcount);
        item.ItemCount = shopitemcount;
        
        int result = JaneShopGateway.JaneShopProvier.SetShopTradelist(item);
        addPanel.Visible = false;

        BindList();
    }

    protected void btnAdd_Show(object sender, EventArgs e)
    {
        DrawAddPanel(null);
        addPanel.Visible = true;
        btnAdd.Text = "添加";
    }

    private void DrawAddPanel(ShopTradelist item)
    {
        if (item == null) item = new ShopTradelist();
        txtNewsId.Value = item.Id.ToString();

        txtOrderId.Text = item.OrderId.ToString();
        txtShopItem.Text = item.ItemId.ToString();
        txtShopItemCount.Text = item.ItemCount.ToString();
    }

</script>

