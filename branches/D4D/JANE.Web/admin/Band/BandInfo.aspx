<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/admin/Admin.Master" %>
<%@ Import Namespace="D4D.Platform"%>
<%@ Import Namespace="D4D.Platform.Domain" %>
<%@ Import Namespace="LTP.Accounts.Bus"%>
<%@ Register src="../Controls/FileUpload.ascx" tagname="FileUpload" tagprefix="uc1" %>
<asp:Content ContentPlaceHolderID="head" runat="server">
    <title>艺人编辑</title>
</asp:Content>
<asp:Content ContentPlaceHolderID="ContentBody" runat="server">
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
           
             <div>语言列表</div>
             <asp:Repeater ID="repList" runat="server" OnItemDataBound="repList_ItemDataBound">
                <HeaderTemplate>
                <table cellspacing="1" cellpadding="4" rules="all"  align="center" width="100%" class="grid">
                    <tr align="center">
                      <th align="center" style="width: 30px;">编号</th>
                      <th>语言类型</th>
                      <th style="width: 30px;">修改</th>
                      <th style="width: 30px;">删除</th>
                    </tr>
                    </HeaderTemplate>
                    <ItemTemplate>
                    <tr align="center">
                      <td align="center" style="width: 30px;"><asp:Literal ID="litId" runat="server"></asp:Literal></td>
                      <td><asp:HyperLink ID="litBandName" runat="server"></asp:HyperLink></td>
                      <td style="width: 30px;"><asp:Button ID="btnUpdate" runat="server" OnClick="btnUpdate_Click" Text="修改" /></td>
                      <td style="width: 30px;"><asp:Button ID="btnDelete" runat="server" OnClick="btnDelete_Click"  Text="删除" OnClientClick="return  ConfirmDelete()" /> </td>
                    </tr>
                </ItemTemplate>
                <FooterTemplate>
                     <tr align="right" style="font-size: medium; white-space: nowrap;">
                      <td colspan="3" valign="middle" class="pagestyle" id="pager"></td>
                      <td class="pagestyle"><asp:Button ID="btnAddShow" runat="server" OnClick="btnAdd_Show" Text="新增" /></td>
                    </tr>
                    </table>
                    </FooterTemplate>
               </asp:Repeater>
            </div>
            </asp:Panel>
            
            <asp:Panel ID="addPanel" runat="server">
            <div>编辑艺人</div>
            <div>
             <table cellspacing="1" cellpadding="4" rules="all"  align="center" width="100%" class="grid">
                    <tr>
                      <th align="center" width="100">艺人名称</th>
                      <td><asp:TextBox ID="txtBandName" runat="server" Width="500px"></asp:TextBox>
                      <asp:HiddenField ID="txtBandId" runat="server" Value="0" ></asp:HiddenField></td>
                      </tr>
                      <tr>
                     <th width="100">小图(56x56)</th>
                      <td><uc1:FileUpload ID="txtInfo1" runat="server" AutoCreateThumbnailImage="false" AutoShowAddWaterMark="false"/></td>
                    </tr>
                     <tr>
                     <th align="center" width="100">大图(680x300)</th>
                      <td><uc1:FileUpload ID="txtInfo2" runat="server" /></td>
                    </tr>
                     <tr>
                     <th align="center" width="100">艺人首页图(180x180)</th>
                      <td><uc1:FileUpload ID="txtInfo3" runat="server" /></td>
                    </tr>
                     <tr>
                     <th align="center" width="100">艺人首页文字(300字)</th>
                      <td>
                      <asp:TextBox ID="txtRemark" MaxLength="300" TextMode="MultiLine" runat="server" Width="600px" 
                    Height="200px"></asp:TextBox></td>
                    </tr>
                    <tr>
                    <th align="center" width="100">&nbsp;</th>
                      <td><asp:Button ID="btnAdd" runat="server" Text="新增" onclick="btnAdd_Click" /></td>
                    </tr>
                    </table>
           </div>
           </asp:Panel>
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
    private int totalCount;
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

    private static System.Collections.Generic.IList<BandInfo> bandList;
       
    private void BindList()
    {
        System.Collections.Generic.IList<BandInfo> list = D4DGateway.BandInfoProvider.GetBandInfoList(false);
        repList.DataSource = list;
        repList.DataBind();
        bandList = list;

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
                BandInfo band = new BandInfo();
                foreach (var i in bandList) 
                {
                    if (id == i.BandId)
                    {
                        band = i;
                        break;
                    }
                }
                HyperLink litBandName = ri.FindControl("litBandName") as HyperLink;
                txtBandId.Value = band.BandId.ToString();
                txtBandName.Text = band.BandName;
                txtInfo1.UploadResult = band.Info1;
                txtInfo2.UploadResult = band.Info2;
                txtInfo3.UploadResult = band.Info3;
                txtRemark.Text = band.Remark;
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
                HyperLink litBandName = ri.FindControl("litBandName") as HyperLink;
                BandInfo item = new BandInfo();            
                item.BandId = id;
                item.BandName = litBandName.Text;   
                item.Info1 = string.Empty;
                item.Info2 = string.Empty;
                item.Info3 = string.Empty;
                item.Remark = string.Empty;
                item.DeleteFlag = 1;
                int result = D4DGateway.BandInfoProvider.SetBandInfo(item);
                addPanel.Visible = false;

                BindList();
            }
        }
    }


    protected void repList_ItemDataBound(object sender, RepeaterItemEventArgs e)
    {
        BandInfo t = e.Item.DataItem as BandInfo;

        if (t != null)
        {
            Literal litId = e.Item.FindControl("litId") as Literal;
            litId.Text = t.BandId.ToString();
            HyperLink litBandName = e.Item.FindControl("litBandName") as HyperLink;
            litBandName.Text = t.BandName;
            litBandName.NavigateUrl = "BandProfile.aspx?id=" + t.BandId.ToString()
                +"&name="+HttpUtility.UrlEncode(t.BandName);
        }
    }

    protected void btnAdd_Click(object sender, EventArgs e)
    {

         BandInfo item = new BandInfo();
        int id = 0;
        int.TryParse(txtBandId.Value, out id);
        item.BandId = id;
        item.BandName = txtBandName.Text;

        if (string.IsNullOrEmpty(txtInfo1.UploadResult) && !string.IsNullOrEmpty(txtInfo2.ThumbnailImage))
            item.Info1 = txtInfo2.ThumbnailImage;
        else
            item.Info1 = txtInfo1.UploadResult;
        
       // item.Info1 = txtInfo1.UploadResult;
        item.Info2 = txtInfo2.UploadResult;
        item.Info3 = txtInfo3.UploadResult;
        item.Remark = txtRemark.Text;
         item.DeleteFlag = 0;
        int result = D4DGateway.BandInfoProvider.SetBandInfo(item);
        addPanel.Visible = false;

        BindList();
    }

    protected void btnAdd_Show(object sender, EventArgs e)
    {

        txtBandId.Value = "";
        txtBandName.Text = "";
        txtInfo1.UploadResult = "";
        txtInfo3.UploadResult = "";
        txtInfo2.UploadResult = "";
        addPanel.Visible = true;
        btnAdd.Text = "添加";
    }


    </script>