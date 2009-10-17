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
                      <th>添加日期</th>
                      <th>TotalCount</th>
                      <th style="width: 30px;">修改</th>
                      <th style="width: 30px;">删除</th>
                    </tr>
                    </headertemplate>
                    <itemtemplate>
                    <tr align="center">
                      <td align="center" style="width: 30px;"><asp:Literal ID="litID" runat="server"></asp:Literal></td>
                      <td><asp:Literal ID="litTitle" runat="server"></asp:Literal></td>
                      <td><asp:Literal ID="litSImage" runat="server"></asp:Literal></td>
                      <td><asp:CheckBox ID="litStatus" runat="server"></asp:CheckBox></td>
                      <td><asp:Literal ID="litAddDate" runat="server"></asp:Literal></td>
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
                      <asp:HiddenField ID="AlbumId" runat="server" Value="0" ></asp:HiddenField></td>
                      </tr>
                      <tr>
                     <th width="100">歌手</th>
                      <td><asp:Literal ID="litBandId" runat="server"></asp:Literal></td>
                    </tr>
                      <tr>
                     <th width="100">日期</th>
                      <td><asp:TextBox ID="litPublishDate" runat="server"></asp:TextBox></td>
                    </tr>
                      <tr>
                     <th width="100">小图</th>
                      <td><uc1:FileUpload ID="fuSImage" runat="server" /></td>
                    </tr>
                      <tr>
                     <th width="100">大图</th>
                      <td><uc1:FileUpload ID="fuLImage" runat="server" /></td>
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
           //addPanel.Visible = false;
            BindList();
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
              /*  Album m = D4DGateway.AlbumProvider.GetAlbum(id);
                txtId.Value = id.ToString();
                txtStatus.Checked = (m.Status == PublishStatus.Publish);
                addPanel.Visible = true;
                btnAdd.Text = "更新";*/
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
               /* D4DGateway.MusicProvider.DeleteMusicSongList(id);
                BindList();*/
            }
        }

    }


    protected void repList_ItemDataBound(object sender, RepeaterItemEventArgs e)
    {
        /*Album m = e.Item.DataItem as Album;

        if (m != null)
        {
            Literal litId = e.Item.FindControl("litID") as Literal;
            Literal litSongName= e.Item.FindControl("litSongName") as Literal;
            Literal litSongFile = e.Item.FindControl("litSongFile") as Literal;
            CheckBox litStatus = e.Item.FindControl("litStatus") as CheckBox;
            Literal litAddDate = e.Item.FindControl("litAddDate") as Literal;

            litId.Text = m.AlbumId.ToString();
            litTitle.Text = m.Title;
            litSongFile.Text = m.SongFile.ToString();
            litStatus.Checked = (m.Status == PublishStatus.Publish);
            litStatus.Enabled = false;
            litAddDate.Text = m.AddDate.ToLongDateString();
        }*/
    }

    protected void btnAdd_Click(object sender, EventArgs e)
    {
    }

    protected void btnAdd_Show(object sender, EventArgs e)
    {
    }


    </script>