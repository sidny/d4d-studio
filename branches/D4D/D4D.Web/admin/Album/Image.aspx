<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/admin/Admin.Master" %>
<%@ Import Namespace="D4D.Platform"%>
<%@ Import Namespace="D4D.Platform.Domain" %>
<%@ Import Namespace="LTP.Accounts.Bus"%>
<%@ Register src="../Controls/FileUpload.ascx" tagname="FileUpload" tagprefix="uc1" %>
<asp:Content ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ContentPlaceHolderID="ContentBody" runat="server">
    <form id="form1" runat="server">
            <asp:Panel runat="server" ID="listPanel">
            <div>
             <div><h1>图片列表</h1></div>
            
            <table cellspacing="1" cellpadding="4" rules="all"  align="center" width="100%" class="grid">
                    <tr align="center">
                      <th align="center" style="width: 30px;"><asp:Image ID="imgAlbum" runat="server" Width="30" /></th>
                      <td>相册名称:  <asp:Label ID="txtAlbumTitle" runat="server"></asp:Label></td>
                      <td width="30"><a href="Album.aspx">返回</a></td>
                    </tr>
            </table>
            <br />
            <br />
            <asp:Repeater ID="repList" runat="server"
                    onitemdatabound="repList_ItemDataBound">
                <HeaderTemplate>
                <table cellspacing="1" cellpadding="4" rules="all"  align="center" width="100%" class="grid">
                    <tr align="center">
                      <th align="center" style="width: 30px;">编号</th>
                      <th>图片名称</th>
                      <th>小图</th>
                      <th>发布状态</th>
                      <th>发布时间</th>
                      <th style="width: 30px;">修改</th>
                      <th style="width: 30px;">删除</th>
                    </tr>
                </HeaderTemplate>
                <ItemTemplate>
                    <tr align="center">
                      <td align="center" style="width: 30px;"><asp:Literal ID="litID" runat="server"></asp:Literal></td>
                      <td><asp:Literal ID="litImageName" runat="server"></asp:Literal></td>
                      <td><asp:Image ID="litSImageFile" runat="server"></asp:Image></td>
                      <td><asp:CheckBox ID="litStatus" runat="server"></asp:CheckBox></td>
                      <td><asp:Literal ID="LitAddDate" runat="server"></asp:Literal></td>
                      <td style="width: 30px;"><asp:Button ID="btnUpdate" runat="server" OnClick="btnUpdate_Click" Text="修改" /></td>
                      <td style="width: 30px;"><asp:Button ID="btnDelete" runat="server" OnClick="btnDelete_Click"  Text="删除" /> </td>
                    </tr>
                </ItemTemplate>
                <FooterTemplate>
                     <tr align="right" style="font-size: medium; white-space: nowrap;">
                      <td colspan="6" valign="middle" class="pagestyle" id="pager"></td>
                      <td class="pagestyle"><asp:Button ID="btnAddShow" runat="server" OnClick="btnAdd_Show" Text="新增" /></td>
                    </tr>
                    </table>
                </FooterTemplate>        
                </asp:Repeater>
            </div>

                    
          </asp:Panel>
    
    <asp:Panel runat="server" ID="addPanel">
            <div><h1>添加图片</h1></div>
            <div>
             <table cellspacing="1" cellpadding="4" rules="all"  align="center" width="100%" class="grid">
                    <tr>
                      <th align="center" width="100">图片名称</th>
                      <td><asp:TextBox ID="txtImageName" runat="server" Width="500px"></asp:TextBox>
                      <asp:HiddenField ID="txtImageId" runat="server" Value="0" ></asp:HiddenField></td>
                      </tr>
                       <tr>
                     <th width="100">小图 (150 * 100)</th>
                      <td> <uc1:FileUpload ID="txtSImageFile" runat="server" AutoCreateThumbnailImage="false"/></td>
                    </tr>
                      <tr>
                     <th width="100">图片地址 ( 宽度大于 800px )</th>
                      <td> <uc1:FileUpload ID="txtLImageFile" runat="server" /></td>
                    </tr>
                     
                     <tr>
                     <th align="center" width="100">发布状态</th>
                      <td><asp:CheckBox ID="txtStatus" runat="server"></asp:CheckBox></td>
                    </tr>
                    <tr>
                    <th align="center" width="100">&nbsp;</th>
                      <td><asp:Button ID="btnAdd" runat="server" Text="新增" onclick="btnAdd_Click" /></td>
                    </tr>
                    </table>
           </div>
            </asp:Panel>

</form>

<script type="text/javascript">
    $(document).ready(function() {
        var cur = parseInt("<%=PageIndex %>");
        var total = parseInt("<%=PageTotalCount %>");
        var pageSize = parseInt("<%=PageSize %>");
        var href = location.pathname;
        if(location.search){
            if(!location.search.match(/page=\d+/ig)){
                href += location.search + "&page=__id__";
            }else{
                href += location.search;
            }
        }else{
            href +="?page=__id__";
        }
        $("#pager").pagination(
          total,
                {
                    items_per_page: pageSize,
                    num_display_entries: 10,
                    current_page: cur - 1,
                    num_edge_entries: 0,
                    link_to:href.replace(/page=\d+/ig,"page=__id__"),
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
    protected int PageSize = 10;
    private int totalCount;	
    protected int AlbumId
    {
        get
        {
            string queryPage = Request.QueryString["id"];
            if (string.IsNullOrEmpty(queryPage)) return 0;

            int page ;

            int.TryParse(queryPage, out page);

            return page;
        }
    }
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
            BindTitle();
        }
    }

    private void BindTitle()
    {
        Album item = D4DGateway.AlbumProvider.GetAlbum(AlbumId);
        imgAlbum.ImageUrl = item.SImage;
        txtAlbumTitle.Text = item.Title;
    }

    private void BindList()
    {
        System.Collections.Generic.IList<D4D.Platform.Domain.Image> list  =  D4DGateway.AlbumProvider.GetImagesByAlbumId(AlbumId,PublishStatus.ALL);
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
                D4D.Platform.Domain.Image item = D4DGateway.AlbumProvider.GetImage(id);
                DrawAddPanel(item);
                addPanel.Visible = true;
                btnAdd.Text = "更新";
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
                D4DGateway.AlbumProvider.DeleteImage(id);
                BindList();
            }
        }

    }


    protected void repList_ItemDataBound(object sender, RepeaterItemEventArgs e)
    {
        D4D.Platform.Domain.Image m = e.Item.DataItem as D4D.Platform.Domain.Image;

        if (m != null)
        {
            Literal litId = e.Item.FindControl("litID") as Literal;
            Literal litImageName = e.Item.FindControl("litImageName") as Literal;
            System.Web.UI.WebControls.Image litSImageFile = e.Item.FindControl("litSImageFile") as System.Web.UI.WebControls.Image;
            CheckBox litStatus = e.Item.FindControl("litStatus") as CheckBox;
            Literal litAddDate = e.Item.FindControl("litAddDate") as Literal;
            
            litId.Text = m.ImageId.ToString();
            litImageName.Text = m.ImageName;
            litSImageFile.ImageUrl = m.SImageFile.ToString();
            litStatus.Checked = (m.Status == PublishStatus.Publish);
            litStatus.Enabled = false;
            litAddDate.Text = m.AddDate.ToLongDateString();
        }
    }

    protected void btnAdd_Click(object sender, EventArgs e)
    {
        D4D.Platform.Domain.Image item = new D4D.Platform.Domain.Image();
        int id = 0;
        int.TryParse(txtImageId.Value, out id);
        item.ImageId = id;
        item.ImageFile = txtLImageFile.UploadResult;
        if (string.IsNullOrEmpty(txtSImageFile.UploadResult) && !string.IsNullOrEmpty(txtLImageFile.ThumbnailImage))
            item.SImageFile = txtLImageFile.ThumbnailImage;
        else
            item.SImageFile = txtSImageFile.UploadResult;
        item.ImageName = txtImageName.Text;
        item.AddDate = DateTime.Now;
        item.AlbumId = AlbumId;
        User currentUser = Session["UserInfo"] as User;
        item.AddUserID = currentUser.UserID;
        if (txtStatus.Checked)
            item.Status = PublishStatus.Publish;
        int result = D4DGateway.AlbumProvider.SetImage(item);
        
        
        addPanel.Visible = false;
        
        BindList();
    }

    protected void btnAdd_Show(object sender, EventArgs e)
    {
        DrawAddPanel(null);
        addPanel.Visible = true;
        btnAdd.Text = "添加";
    }

    private void DrawAddPanel(D4D.Platform.Domain.Image item)
    {
        if (item == null) item = new D4D.Platform.Domain.Image();
        txtImageId.Value = item.ImageId.ToString();
        txtLImageFile.UploadResult = item.ImageFile;
        txtSImageFile.UploadResult = item.SImageFile;
        txtStatus.Checked = (item.Status == PublishStatus.Publish);
        txtImageName.Text = item.ImageName;
    }

    </script>