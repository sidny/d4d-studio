<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/admin/Admin.Master" %>
<%@ Import Namespace="D4D.Platform"%>
<%@ Import Namespace="D4D.Platform.Domain" %>
<%@ Import Namespace="LTP.Accounts.Bus"%>
<asp:Content ContentPlaceHolderID="head" runat="server">
    <title>音乐专辑编辑</title>
</asp:Content>
<asp:Content ContentPlaceHolderID="ContentBody" runat="server">
    <form id="form1" runat="server">
            <asp:Panel runat="server" ID="listPanel">
            <div>
             <div>歌曲列表</div>
            
            <table cellspacing="1" cellpadding="4" rules="all"  align="center" width="100%" class="grid">
                    <tr align="center">
                      <th align="center" style="width: 30px;"><asp:Image ID="imgMusic" runat="server" Width="30" /></th>
                      <td>专辑名称:  <asp:Label ID="txtMusicTitle" runat="server"></asp:Label></td>
                      <td width="30"><a href="MusicTitle.aspx">返回</a></td>
                    </tr>
            </table>
            <br />
            <br />
            <asp:Repeater ID="repSongList" runat="server"
                    onitemdatabound="repSongList_ItemDataBound">
                <HeaderTemplate>
                <table cellspacing="1" cellpadding="4" rules="all"  align="center" width="100%" class="grid">
                    <tr align="center">
                      <th align="center" style="width: 30px;">编号</th>
                      <th>歌曲名称</th>
                      <th>歌曲地址</th>
                      <th>发布状态</th>
                      <th>添加人ID</th>
                      <th>添加日期</th>
                      <th style="width: 30px;">修改</th>
                      <th style="width: 30px;">删除</th>
                    </tr>
                </HeaderTemplate>
                <ItemTemplate>
                    <tr align="center">
                      <td align="center" style="width: 30px;"><asp:Literal ID="litID" runat="server"></asp:Literal></td>
                      <td><asp:Literal ID="litSongName" runat="server"></asp:Literal></td>
                      <td><asp:Literal ID="litSongFile" runat="server"></asp:Literal></td>
                      <td><asp:CheckBox ID="litStatus" runat="server"></asp:CheckBox></td>
                      <td><asp:Literal ID="litAddUserId" runat="server"></asp:Literal></td>
                      <td><asp:Literal ID="litAddDate" runat="server"></asp:Literal></td>
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
            <div>专辑歌曲</div>
            <div>
             <table cellspacing="1" cellpadding="4" rules="all"  align="center" width="100%" class="grid">
                    <tr>
                      <th align="center" width="100">歌曲名称</th>
                      <td><asp:TextBox ID="txtTitle" runat="server" Width="500px"></asp:TextBox>
                      <asp:HiddenField ID="txtMusicId" runat="server" Value="0" ></asp:HiddenField></td>
                      </tr>
                      <tr>
                     <th width="100">歌曲链接</th>
                      <td><asp:TextBox ID="txtBody" runat="server" Width="500px"></asp:TextBox></td>
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
    protected int MusicId
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
            BindSongList();
            BindMusicTitle();
        }
    }

    private void BindMusicTitle()
    {
        MusicTitle music = D4DGateway.MusicProvider.GetMusicTitle(MusicId);
        imgMusic.ImageUrl = music.SImage;
        txtMusicTitle.Text = music.Title;
    }

    private void BindSongList()
    {
        System.Collections.Generic.IList<MusicSongList> list  =  D4DGateway.MusicProvider.GetMusicSongListByMusicId(MusicId,PublishStatus.ALL);
        repSongList.DataSource = list;
        repSongList.DataBind();


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
                D4D.Platform.Domain.MusicSongList m = D4DGateway.MusicProvider.GetMusicSongList(id);
                txtMusicId.Value = id.ToString();
                txtStatus.Checked = (m.Status == PublishStatus.Publish);
                txtTitle.Text = m.SongName;
                txtBody.Text = m.SongFile;
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
                D4DGateway.MusicProvider.DeleteMusicSongList(id);
                BindSongList();
            }
        }

    }


    protected void repSongList_ItemDataBound(object sender, RepeaterItemEventArgs e)
    {
        D4D.Platform.Domain.MusicSongList m = e.Item.DataItem as D4D.Platform.Domain.MusicSongList;

        if (m != null)
        {
            Literal litId = e.Item.FindControl("litID") as Literal;
            Literal litSongName= e.Item.FindControl("litSongName") as Literal;
            Literal litSongFile = e.Item.FindControl("litSongFile") as Literal;
            CheckBox litStatus = e.Item.FindControl("litStatus") as CheckBox;
            Literal litAddDate = e.Item.FindControl("litAddDate") as Literal;
            
            litId.Text = m.ListId.ToString();
            litSongName.Text = m.SongName;
            litSongFile.Text = m.SongFile.ToString();
            litStatus.Checked = (m.Status == PublishStatus.Publish);
            litStatus.Enabled = false;
            litAddDate.Text = m.AddDate.ToLongDateString();
        }
    }

    protected void btnAdd_Click(object sender, EventArgs e)
    {
        D4D.Platform.Domain.MusicSongList m = new D4D.Platform.Domain.MusicSongList();
        m.SongName = txtTitle.Text;
        m.SongFile = txtBody.Text;
        int musicId = 0;
        int.TryParse(txtMusicId.Value, out musicId);
        m.ListId = musicId;
        m.MusicId = MusicId;
        User currentUser = Session["UserInfo"] as User;
        m.AddUserID = currentUser.UserID;
        int status = 0;
        if (txtStatus.Checked) status = 1;
        
        m.Status = (PublishStatus)status;
        int result = D4DGateway.MusicProvider.SetMusicSongList(m);
        addPanel.Visible = false;

        BindSongList();
    }

    protected void btnAdd_Show(object sender, EventArgs e)
    {
        txtMusicId.Value = "0";
        txtTitle.Text = "";
        txtBody.Text = "";
        txtStatus.Checked = false;
        addPanel.Visible = true;
        btnAdd.Text = "添加";
    }


    </script>