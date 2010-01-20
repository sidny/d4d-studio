<%@ Page Language="C#" AutoEventWireup="true" ValidateRequest="false" MasterPageFile="~/admin/Admin.Master"  %>
<%@ Import Namespace="System.Linq" %>
<%@ Import Namespace="System.Collections.Generic" %>
<%@ Import Namespace="D4D.Platform" %>
<%@ Import Namespace="D4D.Platform.Domain" %>
<%@ Import Namespace="JANE.Shop" %>
<%@ Import Namespace="JANE.Shop.Domain" %>
<%@ Import Namespace="LTP.Accounts.Bus" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>送货地址编辑</title>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentBody" runat="server">

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
                 <h1>快递送达省市列表 <asp:DropDownList ID="ddlRegion" runat="server" 
                        onselectedindexchanged="ddlRegion_SelectedIndexChanged" 
                        AutoPostBack="True">                       
                        </asp:DropDownList> 
                 </h1>
            </div>
              <asp:Repeater ID="repList" OnItemDataBound="repList_ItemDataBound" runat="server">
                <HeaderTemplate>
                    <table cellspacing="1" cellpadding="4" rules="all" align="center" width="100%" class="grid">
                        <tr align="center">
                            <th align="center" style="width: 30px;">
                                编号
                            </th>
                            <th>
                                省/直辖市
                            </th>
                            <th>
                                名称
                            </th>                          
                            <th>
                                运费
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
                            <asp:Literal ID="litRegion" runat="server"></asp:Literal>
                        </td>
                        <td>
                            <asp:Literal ID="litName" runat="server"></asp:Literal>
                        </td>
                        <td>
                            <asp:Literal ID="litTransferPrice" runat="server"></asp:Literal>
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
                        <td colspan="5" valign="middle" class="pagestyle" id="pager">
                        </td>
                        <td class="pagestyle">
                            <asp:Button ID="btnAddRegion" runat="server" OnClick="btnAdd_Region" Text="新增省直辖市" />
                            <asp:Button ID="btnAddCity" runat="server" OnClick="btnAdd_City" Text="新增市" />
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
                编辑送货省市</h1>
        </div>
        <div>
            <table cellspacing="1" cellpadding="4" rules="all" align="center" width="100%" class="grid">
                <tr>
                    <th width="100">
                        所属省直辖市
                    </th>
                    <td>
                      <asp:DropDownList ID="ddlEditRegion" runat="server">                       
                        </asp:DropDownList> 
                    </td>
                </tr>   
                <tr>
                    <th align="center" width="100">
                        名称
                    </th>
                    <td>
                        <asp:TextBox ID="txtName" runat="server" Width="500px"></asp:TextBox>
                        <asp:HiddenField ID="txtNewsId" runat="server" Value="0"></asp:HiddenField>
                    </td>
                </tr>
                <tr>
                    <th width="100">
                        运费
                    </th>
                    <td>
                       <asp:TextBox ID="txtTransferPrice" runat="server"></asp:TextBox>
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
            <asp:Literal ID="litInfo" runat="server"></asp:Literal>
        </div>
         </asp:Panel>
    </form>
</asp:Content>
<script runat="server">
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            BindRegionList();
            addPanel.Visible = false;
            listPanel.Visible = true;
            BindList(0);           
        }
    }

    private void BindRegionList()
    {
        List<ShopRegion> pList = JaneShopGateway.JaneShopProvier.GetShopRegionsByParentId(0);
        ddlEditRegion.Items.Clear();
        ddlRegion.Items.Clear();
        
        ddlRegion.Items.Add(new ListItem("全部省直辖市","0"));
        ddlEditRegion.Items.Add(new ListItem("全部省直辖市", "0"));
        if (pList != null && pList.Count > 0)
        {
            foreach (ShopRegion sr in pList)
            {
                ddlRegion.Items.Add(new ListItem( sr.Name,sr.Id.ToString()));
                ddlEditRegion.Items.Add(new ListItem(sr.Name, sr.Id.ToString()));
            }
        }
        ddlRegion.SelectedIndex = 0;
    }
    private void BindList(int parentId)
    {
        IList<ShopRegion> list = JaneShopGateway.JaneShopProvier.GetShopRegionsByParentId(parentId);
        repList.DataSource = list;
        repList.DataBind();    

    }

    protected int CurrentSelectParentId
    {
        get
        {
            int parentId = 0;
            int.TryParse(ddlRegion.SelectedValue, out parentId);
            return parentId;
        }
    }
    protected void ddlRegion_SelectedIndexChanged(object sender, EventArgs e)
    {
       
        addPanel.Visible = false;
        listPanel.Visible = true;
        BindList(CurrentSelectParentId);
        
    }

    protected void repList_ItemDataBound(object sender, RepeaterItemEventArgs e)
    {
        ShopRegion m = e.Item.DataItem as ShopRegion;

        if (m != null)
        {
            Literal litId = e.Item.FindControl("litID") as Literal;       
            Literal litRegion = e.Item.FindControl("litRegion") as Literal;
            Literal litName = e.Item.FindControl("litName") as Literal;
            Literal litTransferPrice = e.Item.FindControl("litTransferPrice") as Literal;
          
            litId.Text = m.Id.ToString();
            if (m.ParentId == 0)
                litRegion.Text = "省/直辖市";
            else
                litRegion.Text = ddlRegion.SelectedItem.Text;
            litName.Text = m.Name;
            litTransferPrice.Text = m.TransferPrice.ToString();            
        
        }
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
                ShopRegion m = JaneShopGateway.JaneShopProvier.GetShopRegion(id);
                DrawAddPanel(m,m.ParentId,false);
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
                JaneShopGateway.JaneShopProvier.DeleteShopRegion(id);
                BindList(CurrentSelectParentId);
            }
        }

    }


    protected void btnAdd_Click(object sender, EventArgs e)
    {
        if (string.IsNullOrEmpty(txtName.Text))
        {
            litInfo.Text = "请输入名称";
            return;
        }
        double transferPrice = 0;
        
        if (string.IsNullOrEmpty(txtTransferPrice.Text))
        {            
            litInfo.Text = "请输入送货金额";
            return;
        }
        else if (!double.TryParse(txtTransferPrice.Text , out transferPrice))
        {
            litInfo.Text = "请输入合法的送货金额";
            return;
        }
            ShopRegion item = new ShopRegion();
            int id = 0;
            int.TryParse(txtNewsId.Value, out id);
            item.Id = id;
            
            item.Name = txtName.Text;
            item.TransferPrice =transferPrice;

            int parentId = 0;
            int.TryParse(ddlEditRegion.SelectedValue, out parentId);
            item.ParentId =  parentId;

            int result = JaneShopGateway.JaneShopProvier.SetShopRegion(item);
            addPanel.Visible = false;
            listPanel.Visible = true;
            BindList(CurrentSelectParentId);
            if (parentId == 0)
                BindRegionList();
                
        
    }

    protected void btnAdd_City(object sender, EventArgs e)
    {
        DrawAddPanel(null,CurrentSelectParentId,false);
        addPanel.Visible = true;
        listPanel.Visible = false;
        btnAdd.Text = "添加市";
    }

    protected void btnAdd_Region(object sender, EventArgs e)
    {
        DrawAddPanel(null);
        addPanel.Visible = true;
        listPanel.Visible = false;
        btnAdd.Text = "添加省直辖市";
    }
     private void DrawAddPanel(ShopRegion item)
     {
         DrawAddPanel(item,0,true);    
     }
     private void DrawAddPanel(ShopRegion item,int selectParentId, bool isRegion)
    {
        if (item == null)
        {
            item = new ShopRegion();
        }
        txtNewsId.Value = item.Id.ToString();
        txtName.Text = item.Name;
        txtTransferPrice.Text = item.TransferPrice.ToString();
        if (txtTransferPrice.Text == "0") txtTransferPrice.Text = "10";

        ddlEditRegion.SelectedValue = selectParentId.ToString();
        //if (selectParentId == 0)
        //    ddlEditRegion.Enabled = false;
        //else
        //    ddlEditRegion.Enabled = true;
         
         
    }

</script>