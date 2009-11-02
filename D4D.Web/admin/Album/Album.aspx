<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/admin/Admin.Master" %>
<%@ Import Namespace="D4D.Platform"%>
<%@ Import Namespace="D4D.Platform.Domain" %>
<%@ Import Namespace="LTP.Accounts.Bus"%>
<%@ Register src="../Controls/FileUpload.ascx" tagname="FileUpload" tagprefix="uc1" %>
<asp:Content ContentPlaceHolderID="head" runat="server">
    
</asp:Content>
<asp:Content ContentPlaceHolderID="ContentBody" runat="server">
<form runat="server" id="form1">
		<asp:Panel ID="listPanel" runat="server">
            <div>
             <div><h1>相册列表</h1></div>
             <asp:Repeater Id="repList" OnItemDataBound="repList_ItemDataBound" runat="server">
             	<headertemplate>
                <table cellspacing="1" cellpadding="4" rules="all"  align="center" width="100%" class="grid">
                    <tr align="center">
                      <th align="center" style="width: 30px;">编号</th>
                      <th>相册名称</th>
                      <th>小图</th>
                      <th>发布状态</th>
                      <th>发布日期</th>
                      <th>TotalCount</th>
                      <th style="width: 30px;">修改</th>
                      <th style="width: 30px;">删除</th>
                    </tr>
                    </headertemplate>
                    <itemtemplate>
                    <tr align="center">
                      <td align="center" style="width: 30px;"><asp:Literal ID="litID" runat="server"></asp:Literal></td>
                      <td><asp:HyperLink ID="litTitle" runat="server"></asp:HyperLink></td>
                      <td><asp:Image ID="litSImage" runat="server"></asp:Image></td>
                      <td><asp:CheckBox ID="litStatus" runat="server"></asp:CheckBox></td>
                      <td><asp:Literal ID="litPublishDate" runat="server"></asp:Literal></td>
                      <td><asp:Literal ID="litTotalCount" runat="server"></asp:Literal></td>
                      <td style="width: 30px;"><asp:Button ID="btnUpdate" runat="server" OnClick="btnUpdate_Click" Text="修改" /></td>
                      <td style="width: 30px;"><asp:Button ID="btnDelete" runat="server" OnClick="btnDelete_Click"  Text="删除" /> </td>
                    </tr>
                </ItemTemplate>
                <FooterTemplate>
                     <tr align="right" style="font-size: medium; white-space: nowrap;">
                      <td colspan="7" valign="middle" class="pagestyle" id="pager"></td>
                      <td class="pagestyle"><asp:Button ID="btnAddShow" runat="server" OnClick="btnAdd_Show" Text="新增" /></td>
                    </tr>
                    </table>
                </FooterTemplate>        
                </asp:Repeater>
            </div>

                    	
          </asp:Panel>
    
    <asp:Panel runat="server" ID="addPanel">
            <div><h1>编辑相册</h1></div>
            <div>
             <table cellspacing="1" cellpadding="4" rules="all"  align="center" width="100%" class="grid">
                    <tr>
                      <th align="center" width="100">相册名称</th>
                      <td><asp:TextBox ID="txtTitle" runat="server" Width="500px"></asp:TextBox>
                      <asp:HiddenField ID="txtAlbumId" runat="server" Value="0" ></asp:HiddenField></td>
                      </tr>
                      <tr>
                     <th width="100">歌手</th>
                      <td><asp:DropDownList ID="txtBandId" runat="server"></asp:DropDownList></td>
                    </tr>
                      <tr>
                     <th width="100">发布日期</th>
                      <td><asp:TextBox ID="txtPublishDate" runat="server" CssClass="has-datepicker"></asp:TextBox></td>
                    </tr>
                      <tr>
                     <th width="100">小图 (150 * 100)</th>
                      <td><uc1:FileUpload ID="txtSImage" runat="server" AutoCreateThumbnailImage="false" AutoShowAddWaterMark="false"/></td>
                    </tr>
                      <tr style="display:none">
                     <th width="100">大图</th>
                      <td><uc1:FileUpload ID="txtLImage" runat="server" /></td>
                    </tr>
                     <tr>
                     <th align="center" width="100">Tag标签</th>
                      <td><asp:TextBox ID="txtTags" Width="500px" runat="server"></asp:TextBox></td>
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
            BindBandList();
        }
    }
    
    

   
    private void BindList()
    {
        PagingContext pager = new PagingContext();
        pager.CurrentPageNumber = PageIndex;
        pager.RecordsPerPage = PageSize;
        System.Collections.Generic.IList<Album> list = D4DGateway.AlbumProvider.GetPagedAlbums(pager, PublishStatus.ALL);
        repList.DataSource = list;
        repList.DataBind();
        totalCount = pager.TotalRecordCount;


    }
    private void BindBandList()
    {
        System.Collections.Generic.List<BandInfo> list = D4DGateway.BandInfoProvider.GetBandInfoList();

        txtBandId.DataSource = list;
        txtBandId.DataValueField = "BandId";
        txtBandId.DataTextField = "BandName";
        txtBandId.DataBind();
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
                 Album m = D4DGateway.AlbumProvider.GetAlbum(id);
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
                D4DGateway.AlbumProvider.DeleteAlbum(id);
                BindList();
            }
        }

    }


    protected void repList_ItemDataBound(object sender, RepeaterItemEventArgs e)
    {
        Album m = e.Item.DataItem as Album;

        if (m != null)
        {
            Literal litId = e.Item.FindControl("litID") as Literal;
            HyperLink litTitle = e.Item.FindControl("litTitle") as HyperLink;
            System.Web.UI.WebControls.Image litSImage = e.Item.FindControl("litSImage") as System.Web.UI.WebControls.Image;
            CheckBox litStatus = e.Item.FindControl("litStatus") as CheckBox;
            Literal litPublishDate = e.Item.FindControl("litPublishDate") as Literal;
            Literal litTotalCount = e.Item.FindControl("litTotalCount") as Literal;

            litId.Text = m.AlbumId.ToString();
            litTitle.Text = m.Title;
            litTitle.NavigateUrl = "image.aspx?id=" + m.AlbumId;
            litSImage.ImageUrl = m.SImage.ToString();
            litStatus.Checked = (m.Status == PublishStatus.Publish);
            litStatus.Enabled = false;
            litPublishDate.Text = m.PublishDate.ToLongDateString();
            litTotalCount.Text = m.TotalCount.ToString();
        }
    }

    protected void btnAdd_Click(object sender, EventArgs e)
    {
        Album item = new Album();
        int id = 0;
        int.TryParse(txtAlbumId.Value, out id);
        item.AlbumId = id;
        DateTime date = DateTime.MinValue;
        DateTime.TryParse(txtPublishDate.Text, out date);
        item.PublishDate = date;
        item.LImage = txtLImage.UploadResult;

        if (string.IsNullOrEmpty(txtSImage.UploadResult) && !string.IsNullOrEmpty(txtLImage.ThumbnailImage))
            item.SImage = txtLImage.ThumbnailImage;
        else
            item.SImage = txtSImage.UploadResult;
        if (txtStatus.Checked) item.Status = PublishStatus.Publish;
        item.Title = txtTitle.Text;
        item.AddDate = DateTime.Now;
        item.AddUserID = D4D.Web.Helper.AdminHelper.CurrentUser.UserID;
        item.BandId =Convert.ToInt32( txtBandId.SelectedValue);
        int result = D4DGateway.AlbumProvider.SetAlbum(item);
     
        addPanel.Visible = false;

        BindList();
    }

    protected void btnAdd_Show(object sender, EventArgs e)
    {
        DrawAddPanel(null);
        addPanel.Visible = true;
        btnAdd.Text = "添加";
    }

    private void DrawAddPanel(Album item)
    {
        if (item == null) item = new Album();
        txtAlbumId.Value = item.AlbumId.ToString(); 
        if (item.BandId > 0)
        {
            txtBandId.SelectedValue = item.BandId.ToString();
        }
        txtPublishDate.Text = (item.PublishDate == DateTime.MinValue) ? DateTime.Now.ToLongDateString() : item.PublishDate.ToLongDateString();
        txtLImage.UploadResult = item.LImage;
        txtSImage.UploadResult = item.SImage;
        txtStatus.Checked = (item.Status == PublishStatus.Publish);
        txtTitle.Text = item.Title;
    }

    </script>