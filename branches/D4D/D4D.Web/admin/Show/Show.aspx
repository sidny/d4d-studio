<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/admin/Admin.Master" %>
<%@ Import Namespace="D4D.Platform"%>
<%@ Import Namespace="D4D.Platform.Domain" %>
<%@ Import Namespace="LTP.Accounts.Bus"%>
<%@ Register src="../Controls/FileUpload.ascx" tagname="FileUpload" tagprefix="uc1" %>
<asp:Content ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ContentPlaceHolderID="ContentBody" runat="server">
<form id="form1" runat="server">
            <asp:Panel ID="listPanel" runat="server">
            <div>
             <div><h1>星程列表</h1></div>
             
            <asp:Repeater ID="repList" runat="server" OnItemDataBound="repList_ItemDataBound">
                <HeaderTemplate>
                <table cellspacing="1" cellpadding="4" rules="all"  align="center" width="100%" class="grid">
                    <tr align="center">
                      <th align="center" style="width: 30px;">编号</th>
                      <th>名称</th>
                      <th>地点</th>
                      <th>状态</th>
                      <th>开始日期</th>
                      <th>结束日期</th>
                      <th style="width: 30px;">修改</th>
                      <th style="width: 30px;">删除</th>
                    </tr>
                     </HeaderTemplate>
                    <ItemTemplate>
                    <tr align="center">
                      <td align="center" style="width: 30px;"><asp:Literal ID="litID" runat="server"></asp:Literal></td>
                      <td><asp:Literal ID="litTitle" runat="server"></asp:Literal></td>
                      <td><asp:Literal ID="litShowPlace" runat="server"></asp:Literal></td>
                      <td><asp:CheckBox ID="litStatus" Enabled="false" runat="server"></asp:CheckBox></td>
                      <td><asp:Literal ID="litShowDate" runat="server"></asp:Literal></td>
                      <td><asp:Literal ID="litEndDate" runat="server"></asp:Literal></td>
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
            <asp:Panel ID="addPanel" runat="server">
            <div><h1>编辑星程</h1></div>
            <div>
             <table cellspacing="1" cellpadding="4" rules="all"  align="center" width="100%" class="grid">
                    <tr>
                      <th align="center" width="100">标题</th>
                      <td><asp:TextBox ID="txtTitle" runat="server" Width="500px"></asp:TextBox>
                      <asp:HiddenField ID="txtShowId" runat="server" Value="0" ></asp:HiddenField></td>
                      </tr>
                      <tr>
                     <th width="100">Body</th>
                      <td><asp:TextBox ID="txtBody" Rows="4" runat="server" Width="500px" TextMode="MultiLine"></asp:TextBox></td>
                    </tr>
                     <tr>
                     <th align="center" width="100">SImage</th>
                      <td><uc1:FileUpload ID="txtSImage" runat="server" AutoCreateThumbnailImage="false" AutoShowAddWaterMark="false"/></td>
                    </tr>
                     <tr>
                     <th align="center" width="100">LImage</th>
                      <td><uc1:FileUpload ID="txtLImage" runat="server" /></td>
                    </tr>
                     <tr>
                     <th align="center" width="100">BandId</th>
                      <td><asp:DropDownList ID="txtBandId" runat="server">
                          </asp:DropDownList></td>
                    </tr>
                    <tr>
                     <th width="100">开始日期</th>
                      <td><asp:TextBox ID="txtShowDate" runat="server" CssClass="has-datepicker"></asp:TextBox></td>
                    </tr>
                    <tr>
                     <th width="100">结束日期</th>
                      <td><asp:TextBox ID="txtEndDate" runat="server" CssClass="has-datepicker"></asp:TextBox></td>
                    </tr>
                    <tr>
                     <th width="100">ShowPlace</th>
                      <td><asp:TextBox ID="txtShowPlace" runat="server" Width="500px"></asp:TextBox></td>
                    </tr>
                    <tr>
                     <th width="100">状态</th>
                      <td><asp:CheckBox ID="txtStatus" runat="server"></asp:CheckBox></td>
                    </tr>
                    <tr>
                    <th align="center" width="100">&nbsp;</th>
                      <td><asp:Button ID="btnAdd" runat="server" Text="保存" onclick="btnAdd_Click" /></td>
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
            BindBandList();
        }
    }

   
    private void BindList()
    {
        PagingContext pager = new PagingContext();
        pager.RecordsPerPage = PageSize;
        pager.CurrentPageNumber = PageIndex;
        System.Collections.Generic.IList<Show> list = D4DGateway.ShowProvider.GetPagedShow(pager,PublishStatus.ALL);
        repList.DataSource = list;
        totalCount = pager.TotalRecordCount;
        repList.DataBind();

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
                Show show = D4DGateway.ShowProvider.GetShow(id);
                DrawAddPanel(show);
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
                D4DGateway.ShowProvider.DeleteShow(id);
                BindList();
            }
        }
    }


    protected void repList_ItemDataBound(object sender, RepeaterItemEventArgs e)
    {
        Show item = e.Item.DataItem as Show;
        if (item != null)
        {
            Literal litID = e.Item.FindControl("litID") as Literal;
            litID.Text = item.ShowId.ToString();
            CheckBox litStatus = e.Item.FindControl("litStatus") as CheckBox;
            litStatus.Checked = (item.Status == PublishStatus.Publish);

            Literal litTitle = e.Item.FindControl("litTitle") as Literal;
            litTitle.Text = item.Title;
            Literal litShowPlace = e.Item.FindControl("litShowPlace") as Literal;
            litShowPlace.Text = item.ShowPlace;
            Literal litShowDate = e.Item.FindControl("litShowDate") as Literal;
            litShowDate.Text = item.ShowDate.ToString("yyyy-MM-dd");
            Literal litEndDate = e.Item.FindControl("litEndDate") as Literal;
            litEndDate.Text = item.EndDate.ToString("yyyy-MM-dd");
        }
    }

    protected void btnAdd_Click(object sender, EventArgs e)
    {
        Show item = new Show();
        int id = 0;
        int.TryParse(txtShowId.Value, out id);
        item.ShowId = id;
        int.TryParse(txtBandId.SelectedValue, out id);
        item.BandId = id;
        item.Body = txtBody.Text;
        DateTime date = DateTime.MinValue;    
        DateTime.TryParse(txtShowDate.Text, out date);
        item.ShowDate = date;
        DateTime.TryParse(txtEndDate.Text, out date);
        item.EndDate = date;
        item.LImage = txtLImage.UploadResult ;
        if (string.IsNullOrEmpty(txtSImage.UploadResult) && !string.IsNullOrEmpty(txtLImage.ThumbnailImage))
            item.SImage = txtLImage.ThumbnailImage;
        else
            item.SImage = txtSImage.UploadResult;
        item.ShowPlace = txtShowPlace.Text;
        if(txtStatus.Checked) item.Status = PublishStatus.Publish;
         item.Title = txtTitle.Text ;
         item.AddDate = DateTime.Now;
         item.AddUserID = D4D.Web.Helper.AdminHelper.CurrentUser.UserID;
        int result = D4DGateway.ShowProvider.SetShow(item);
        addPanel.Visible = false;

        BindList();
    }

    protected void btnAdd_Show(object sender, EventArgs e)
    {
        DrawAddPanel(null);
        addPanel.Visible = true;
    }
    private void DrawAddPanel(Show item)
    {
        if (item == null) item = new Show();
        txtShowId.Value = item.ShowId.ToString();
        if (item.BandId > 0)
        {
            txtBandId.SelectedValue = item.BandId.ToString();
        }
        txtBody.Text =  item.Body;
        txtEndDate.Text = (item.EndDate == DateTime.MinValue) ? DateTime.Now.ToLongDateString() : item.EndDate.ToLongDateString();
        txtShowDate.Text = (item.ShowDate == DateTime.MinValue) ? DateTime.Now.ToLongDateString() : item.ShowDate.ToLongDateString();
        txtLImage.UploadResult = item.LImage;
        txtSImage.UploadResult = item.SImage;
        txtShowPlace.Text = item.ShowPlace;
        txtStatus.Checked = (item.Status == PublishStatus.Publish);
        txtTitle.Text = item.Title;
    }

    </script>