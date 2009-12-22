<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/admin/Admin.Master" %>
<%@ Import Namespace="System.Collections.Generic" %>
<%@ Import Namespace="D4D.Platform.Domain" %>
<%@ Import Namespace="LTP.Accounts.Bus" %>
<%@ Import Namespace="System.Linq" %>
<%@ Import Namespace="D4D.Platform" %>
<%@ Register src="../Controls/FileUpload.ascx" tagname="FileUpload" tagprefix="uc1" %>
<asp:Content ContentPlaceHolderID="head" runat="server">
    <title>音乐专辑编辑</title>
</asp:Content>
<asp:Content ContentPlaceHolderID="ContentBody" runat="server">
    <form id="form1" runat="server">
    <asp:Panel runat="server" ID="addPanel">
            <div>专辑编辑</div>
            <div>
             <table cellspacing="1" cellpadding="4" rules="all"  align="center" width="100%" class="grid">
                    <tr>
                      <th align="center" width="100">专辑名称</th>
                      <td><asp:TextBox ID="txtTitle" runat="server" Width="500px"></asp:TextBox>
                      <asp:HiddenField ID="txtMusicId" runat="server" Value="0" ></asp:HiddenField></td>
                      </tr>
                      <tr>
                     <th width="100">专辑描述</th>
                      <td><asp:TextBox ID="txtBody" runat="server" Width="500px"></asp:TextBox></td>
                    </tr>
                     <tr>
                     <th align="center" width="100">歌手</th>
                      <td>
                          <asp:DropDownList ID="bandIdList" runat="server">
                          </asp:DropDownList>
                         </td>
                    </tr>
                     <tr>
                     <th align="center" width="100">发布状态</th>
                      <td>
                          <asp:DropDownList ID="ddlPublishStatus" runat="server">
                              <asp:ListItem Value="0">未发布</asp:ListItem>
                              <asp:ListItem Selected="True" Value="1">发布</asp:ListItem>                              
                          </asp:DropDownList>
                        </td>
                    </tr>
                    <tr>
                    <th align="center" width="100">封面小图</th>
                      <td>
                          <uc1:FileUpload ID="fuSImage" runat="server" AutoCreateThumbnailImage="false" AutoShowAddWaterMark="false"/>
                        </td>
                    </tr>
                     <tr>
                    <th align="center" width="100">封面大图</th>
                      <td>
                          <uc1:FileUpload ID="fuLImage" runat="server" />
                         </td>
                    </tr>
                     <tr>
                    <th align="center" width="100">发行日期</th>
                      <td><asp:TextBox ID="txtPublishDate" CssClass="has-datepicker" runat="server"></asp:TextBox> </td>
                    </tr> 
                    <th align="center" width="100">amazon链接</th>
                      <td><asp:TextBox ID="txtJoyo" runat="server"></asp:TextBox> </td>
                    </tr> 
                    <th align="center" width="100">当当链接</th>
                      <td><asp:TextBox ID="txtDangDang" runat="server"></asp:TextBox> </td>
                    </tr> 
                    <tr>
                    <th align="center" width="100">&nbsp;</th>
                      <td><asp:Button ID="btnAdd" runat="server" Text="新增" onclick="btnAdd_Click" /></td>
                    </tr>
                    </table>
           </div>
            </asp:Panel>
            <asp:Panel runat="server" ID="listPanel">
            <div>
             <div>专辑列表</div>
            
            <asp:Repeater ID="repMusicTitle" runat=server 
                    onitemdatabound="repMusicTitle_ItemDataBound">
                <HeaderTemplate>
                <table cellspacing="1" cellpadding="4" rules="all"  align="center" width="100%" class="grid">
                    <tr align="center">
                      <th align="center" style="width: 30px;">编号</th>
                      <th>专辑名称</th>
                      <th>歌手</th>
                      <th style="width: 30px;">封面小图</th>
                      <th>发布状态</th>
                      <th>添加日期</th>
                      <th style="width: 30px;">修改</th>
                      <th style="width: 30px;">删除</th>
                    </tr>
                </HeaderTemplate>
                <ItemTemplate>
                    <tr align="center">
                      <td align="center" style="width: 30px;"><asp:Literal ID="litID" runat="server"></asp:Literal></td>
                      <td><a href='songs.aspx?id=<asp:Literal ID="litID_1" runat="server"/>'><asp:Literal ID="litTitle" runat="server"></asp:Literal></a></td>
                      <td><asp:Literal ID="litBandId" runat="server"></asp:Literal></td>
                      <td style="width: 30px;"><a href='<asp:Literal ID="litLImage" runat="server"></asp:Literal>' target="_blank"><img src='<asp:Literal ID="litSImage" runat="server"></asp:Literal>' width="25" height="25" /></a>
                      </td>
                      <td><asp:Literal ID="litStutes" runat="server"></asp:Literal></td>
                      <td><asp:Literal ID="litAddDate" runat="server"></asp:Literal></td>
                      <td style="width: 30px;"><asp:Button ID="btnUpdate" runat="server" OnClick="btnUpdate_Click" Text="修改" /></td>
                      <td style="width: 30px;"><asp:Button ID="btnDelete" runat="server" OnClick="btnDelete_Click"  Text="删除" /> </td>
                    </tr>
                </ItemTemplate>
                <FooterTemplate>
                     <tr align="right" style="font-size: medium; white-space: nowrap;">
                      <td colspan="7" valign="middle" class="pagestyle" id="pager"></td>
                      <td><asp:Button ID="btnAddShow" runat="server" OnClick="btnAdd_Show" Text="新增" /></td>
                    </tr>
                    </table>
                </FooterTemplate>        
                </asp:Repeater>
            </div>

            <!-- div>当前页：<asp:Label ID="labCurrentPage" runat="server" Text="0"></asp:Label>,总页数：<asp:Label ID="labTotalCount" runat="server" Text="0"></asp:Label>,
               去第<asp:TextBox ID="txtGoToPageNum" runat="server" Width="35px">1</asp:TextBox>页<asp:Button 
                    ID="btnGoPage" runat="server" Text="Go" onclick="btnGoPage_Click" /></div -->
                    
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
            BindMusicTitleRep(PageIndex);
            BindBandList();
            labCurrentPage.Text = PageIndex.ToString();
        }
    }

    private void BindBandList()
    {
        List<BandInfo> list = D4DGateway.BandInfoProvider.GetBandInfoList();

        bandIdList.DataSource = list;
        bandIdList.DataValueField = "BandId";
        bandIdList.DataTextField = "BandName";
        bandIdList.DataBind();
    }

    private void BindMusicTitleRep(int pageIndex)
    {
        PagingContext pager = new PagingContext();
        pager.RecordsPerPage = PageSize;
        pager.CurrentPageNumber = pageIndex;
        repMusicTitle.DataSource = D4DGateway.MusicProvider.GetPagedMusicTitles(pager,
            PublishStatus.ALL);
        repMusicTitle.DataBind();
        totalCount = pager.TotalRecordCount;

    }

    protected void btnGoPage_Click(object sender, EventArgs e)
    {
        Response.Redirect("admin/Music/MusicTitle.aspx?page=" + txtGoToPageNum.Text.Trim());
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
                D4D.Platform.Domain.MusicTitle musicTitle = D4DGateway.MusicProvider.GetMusicTitle(id);
                txtMusicId.Value = musicTitle.MusicId.ToString();
                fuLImage.UploadResult = musicTitle.LImage;
                fuSImage.UploadResult = musicTitle.SImage;
                ddlPublishStatus.SelectedValue = ((int)musicTitle.Status).ToString();
                //txtLImage.Text = musicTitle.LImage;
                //txtSImage.Text = musicTitle.SImage;
                //txtStatus.Text = ((int)musicTitle.Status).ToString();
                txtPublishDate.Text = musicTitle.PublishDate.ToLongDateString();
                txtTitle.Text = musicTitle.Title;
                txtBody.Text = musicTitle.Body;
                bandIdList.SelectedValue = musicTitle.BandId.ToString();
                addPanel.Visible = true;
                listPanel.Visible = false;
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
                D4DGateway.MusicProvider.DeleteMusicTitle(id);
                D4DGateway.AddInfoProvider.DeleteAddInfo(id, (int)ObjectTypeDefine.MusicTitle);
                BindMusicTitleRep(1);
            }
        }

    }


    protected void repMusicTitle_ItemDataBound(object sender, RepeaterItemEventArgs e)
    {
        D4D.Platform.Domain.MusicTitle m = e.Item.DataItem as D4D.Platform.Domain.MusicTitle;

        if (m != null)
        {
            Literal litId = e.Item.FindControl("litID") as Literal;
            Literal litId_1 = e.Item.FindControl("litID_1") as Literal;
            Literal litTitle = e.Item.FindControl("litTitle") as Literal;
            Literal litBandId = e.Item.FindControl("litBandId") as Literal;
            Literal litSImage = e.Item.FindControl("litSImage") as Literal;
            Literal litLImage = e.Item.FindControl("litLImage") as Literal;
            Literal litStutes = e.Item.FindControl("litStutes") as Literal;
            Literal litAddDate = e.Item.FindControl("litAddDate") as Literal;

            litId_1.Text = litId.Text = m.MusicId.ToString();
            litTitle.Text = m.Title;
            litBandId.Text = m.BandId.ToString();
            litSImage.Text = m.SImage;
            litLImage.Text = m.LImage;
            litStutes.Text = m.Status.ToString();
            litAddDate.Text = m.AddDate.ToLongDateString();
        }
    }

    protected void btnAdd_Click(object sender, EventArgs e)
    {
        D4D.Platform.Domain.MusicTitle m = new D4D.Platform.Domain.MusicTitle();
        m.Title = txtTitle.Text;
        m.Body = txtBody.Text;
        //m.SImage = txtSImage.Text;
        //m.LImage = txtLImage.Text;
        if (string.IsNullOrEmpty(fuSImage.UploadResult) && !string.IsNullOrEmpty(fuLImage.ThumbnailImage))
            m.SImage = fuLImage.ThumbnailImage;
        else
            m.SImage = fuSImage.UploadResult;

        m.LImage = fuLImage.UploadResult;
        int musicId = 0;
        int.TryParse(txtMusicId.Value, out musicId);
        m.MusicId = musicId;
        int bandId = 1;
        int.TryParse(bandIdList.SelectedValue, out bandId);
        m.BandId = bandId;
        User currentUser = Session["UserInfo"] as User;
        m.AddUserID = currentUser.UserID;
        DateTime date = DateTime.Now;
        DateTime.TryParse(txtPublishDate.Text, out date);
        
        m.PublishDate = date;

        int status = 1;
        //int.TryParse(txtStatus.Text, out status);
        int.TryParse(ddlPublishStatus.SelectedValue, out status);
        m.Status = (PublishStatus)status;
        int result = D4DGateway.MusicProvider.SetMusicTitle(m);
        AddInfo addInfo = new AddInfo();
        addInfo.ObjectId = result;
        addInfo.ObjectType =(int)ObjectTypeDefine.MusicTitle;
        addInfo.Info1 = txtJoyo.Text;
        addInfo.Info2 = txtDangDang.Text;
        D4DGateway.AddInfoProvider.SetAddInfo(addInfo);
        addPanel.Visible = false;
        listPanel.Visible = true;
        BindMusicTitleRep(1);
    }

    protected void btnAdd_Show(object sender, EventArgs e)
    {
        addPanel.Visible = true;
        listPanel.Visible = false;
        txtMusicId.Value = "";
        fuLImage.UploadResult = "";
        fuSImage.UploadResult = "";
        ddlPublishStatus.SelectedIndex = 0;
        //txtLImage.Text = musicTitle.LImage;
        //txtSImage.Text = musicTitle.SImage;
        //txtStatus.Text = ((int)musicTitle.Status).ToString();
        txtPublishDate.Text = DateTime.Now.ToLongDateString();
        txtTitle.Text = "";
        txtBody.Text = "";
        bandIdList.SelectedIndex = 0;
        txtJoyo.Text = "";
        txtDangDang.Text = "";
        addPanel.Visible = true;
        listPanel.Visible = false;
        btnAdd.Text = "更新";
        btnAdd.Text = "添加";
    }
    </script>