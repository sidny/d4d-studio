<%@ Page Language="C#" AutoEventWireup="true" ValidateRequest="false" MasterPageFile="~/admin/Admin.Master" %>
<%@ Register Assembly="FredCK.FCKeditorV2" Namespace="FredCK.FCKeditorV2" TagPrefix="FCKeditorV2" %>
<%@ Import Namespace="System.Linq" %>
<%@ Import Namespace="D4D.Platform" %>
<%@ Import Namespace="D4D.Platform.Domain" %>
<%@ Import Namespace="LTP.Accounts.Bus" %>
<%@ Register Src="../Controls/FileUpload.ascx" TagName="FileUpload" TagPrefix="uc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>新闻编辑</title>
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
                    新闻列表   <asp:DropDownList ID="ddlNewsRemarkTypes" runat="server" 
                        onselectedindexchanged="ddlNewsRemarkTypes_SelectedIndexChanged" 
                        AutoPostBack="True">
                        <asp:ListItem Value="-1">全部</asp:ListItem>
                        <asp:ListItem Value="0">普通新闻</asp:ListItem>
                        <asp:ListItem Value="1">视频新闻</asp:ListItem>
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
                                标题
                            </th>
                            <th>
                                类型
                            </th>
                            <th>
                                发布状态
                            </th>
                            <th>
                                新闻日期
                            </th>
                            <th>
                                添加日期
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
                            <asp:HyperLink ID="litTitle" runat="server"></asp:HyperLink>
                        </td>
                        <td>
                            <asp:Literal ID="litNewsType" runat="server"></asp:Literal>
                        </td>
                        <td>
                            <asp:CheckBox ID="litStatus" runat="server"></asp:CheckBox>
                        </td>
                        <td>
                            <asp:Literal ID="litPublishDate" runat="server"></asp:Literal>
                        </td>
                        <td>
                            <asp:Literal ID="litAddDate" runat="server"></asp:Literal>
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
                        <td colspan="7" valign="middle" class="pagestyle" id="pager">
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
                编辑新闻</h1>
        </div>
        <div>
            <table cellspacing="1" cellpadding="4" rules="all" align="center" width="100%" class="grid">
                <tr>
                    <th align="center" width="100">
                        标题
                    </th>
                    <td>
                        <asp:TextBox ID="txtTitle" runat="server" Width="500px"></asp:TextBox>
                        <asp:HiddenField ID="txtNewsId" runat="server" Value="0"></asp:HiddenField>
                        <asp:HiddenField ID="txtHits" runat="server" Value="0"></asp:HiddenField>
                    </td>
                </tr>
                <tr>
                    <th width="100">
                        摘要
                    </th>
                    <td>
                        <asp:TextBox ID="txtPreview" runat="server" Width="500px" TextMode="MultiLine" Height="50px"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <th width="100">
                        正文
                    </th>
                    <td>
                    <FCKeditorV2:FCKeditor ID="txtBody" runat="server" />
			
                    </td>
                </tr>
                <tr>
                    <th width="100">
                        歌手
                    </th>
                    <td>
                        <asp:DropDownList ID="txtBandId" runat="server">
                        </asp:DropDownList>
                    </td>
                </tr>
                <tr>
                    <th width="100">
                        日期
                    </th>
                    <td>
                        <asp:TextBox ID="txtPublishDate" runat="server" CssClass="has-datepicker"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <th width="100">
                        小图
                    </th>
                    <td>
                        <uc1:FileUpload ID="txtSImage" runat="server" AutoCreateThumbnailImage="false" AutoShowAddWaterMark="false"/>
                    </td>
                </tr>
                <tr>
                    <th width="100">
                        大图
                    </th>
                    <td>
                        <uc1:FileUpload ID="txtLImage" runat="server" />
                    </td>
                </tr>
                <tr>
                    <th align="center" width="100">
                        Tag标签
                    </th>
                    <td>
                        <asp:TextBox ID="txtTags" runat="server"></asp:TextBox>
                        
                    </td>
                </tr>
                <tr>
                    <th align="center" width="100">
                        发布状态
                    </th>
                    <td>
                        <asp:CheckBox ID="txtStatus" runat="server"></asp:CheckBox>
                    </td>
                </tr>
                <tr>
                    <th align="center" width="100">
                        视频新闻
                    </th>
                    <td>
                        <asp:CheckBox ID="cbIsVideo" runat="server"></asp:CheckBox>
                    </td>
                </tr>
                <tr>
                    <th align="center" width="100">
                        &nbsp;
                    </th>
                    <td>
                        <asp:Button ID="btnAdd" runat="server" Text="新增" OnClick="btnAdd_Click" />
                    </td>
                </tr>
            </table>
        </div>

        <script type="text/javascript">

            $(document).ready(function() {
                window.selectTags = {};
                $("#<%=txtTags.ClientID %>").after("<input class=\"has-autocomplete\" /><div id='tagsArea' style=\"line-height:21px;padding-top:5px;\"/>")
                $($("#<%=txtTags.ClientID %>").attr("readonly", "readonly").hide().val().split(",")).each(function() {
                    selectTags[this] = this;
                });
                $.getJSON("/svc/admin.svc/GetTag", function(response) {
                    window.tags = response.d;
                    $(tags).each(function() {
                        if (selectTags[this.Id]) {
                            delete selectTags[this.Id];
                            addItem(this);
                        }
                    });
                    $(".has-autocomplete").autocomplete(tags, {
                        minChars: 1,
                        width: 100,
                        // matchContains: "word,number",
                        autoFill: false,
                        formatItem: function(row, i, max) {
                            return row.Text;
                        },
                        formatMatch: function(row, i, max) {
                            return row.Text;
                        },
                        formatResult: function(row) {
                            return "";
                        }
                    }).result(function(event, item) {
                        addItem(item);
                        return false;
                    });
                    function addItem(item) {
                        if (!selectTags[item.Id]) {
                            selectTags[item.Id] = item;
                            var str = "<span style='padding:5px;' tagid=\"" + item.Id + "\"><u>" + item.Text + "</u></span>";
                            $("#tagsArea").append(
                            $(str).click(function() {
                                delete selectTags[$(this).attr("tagid")];
                                $(this).remove();
                                fillValue();
                            })
                            );
                            fillValue();
                        }
                    }
                    function fillValue() {
                        var a = [];
                        for (var i in selectTags) {
                            a.push(i);
                        }
                        $("#<%=txtTags.ClientID %>").val(a.join(","));
                    }
                });
            });
				</script>

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
    private static int totalCount;
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
            txtBody.ToolbarSet = "ShowCity";
        }
    }
    private void BindList()
    {
        PagingContext pager = new PagingContext();
        pager.CurrentPageNumber = PageIndex;
        pager.RecordsPerPage = PageSize;
        
        int iNewsRemarkType;
        int.TryParse(ddlNewsRemarkTypes.SelectedValue, out iNewsRemarkType);
        
        
      
        
        System.Collections.Generic.IList<News> list =
            D4DGateway.NewsProvider.GetPagedNews(pager, PublishStatus.ALL,
            (NewsRemarkType)iNewsRemarkType);
        repList.DataSource = list;
        repList.DataBind();
        totalCount = pager.TotalRecordCount;

    }
    private void BindBandList()
    {
        System.Collections.Generic.List<BandInfo> list = D4DGateway.BandInfoProvider.GetBandInfoList(true);

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
                News m = D4DGateway.NewsProvider.GetNews(id);
                System.Collections.Generic.List<TagRelation> list = D4DGateway.TagsProvider.GetTagRelationByObject(id, ObjectTypeDefine.News);
                DrawAddPanel(m, list);
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
                D4DGateway.NewsProvider.DeleteNews(id);
                D4DGateway.TagsProvider.DeleteTagRelationByObject(id, ObjectTypeDefine.News);
                BindList();
            }
        }

    }

    private const string NormalNews = "普通新闻";
    private const string VideoNews = "视频新闻";
    protected void repList_ItemDataBound(object sender, RepeaterItemEventArgs e)
    {
        News m = e.Item.DataItem as News;

        if (m != null)
        {
            Literal litId = e.Item.FindControl("litID") as Literal;
            HyperLink litTitle = e.Item.FindControl("litTitle") as HyperLink;
            Literal litNewsType = e.Item.FindControl("litNewsType") as Literal;
            CheckBox litStatus = e.Item.FindControl("litStatus") as CheckBox;
            Literal litPublishDate = e.Item.FindControl("litPublishDate") as Literal;
            Literal litAddDate = e.Item.FindControl("litAddDate") as Literal;

            litId.Text = m.NewsId.ToString();
            litTitle.Text = m.Title;
            litTitle.NavigateUrl = "/channel/news/detail.aspx?id="+m.NewsId.ToString();
            litTitle.Target = "_blank";
            if (m.Remark == "video")
                litNewsType.Text = VideoNews;
            else
                litNewsType.Text = NormalNews;
            litStatus.Checked = (m.Status == PublishStatus.Publish);
            litStatus.Enabled = false;
            litAddDate.Text = m.AddDate.ToLongDateString();
            litPublishDate.Text = m.PublishDate.ToLongDateString();
        }
    }

    protected void btnAdd_Click(object sender, EventArgs e)
    {
        News item = new News();
        int id = 0;
        int.TryParse(txtNewsId.Value, out id);
        item.NewsId = id;
        DateTime date = DateTime.MinValue;
        DateTime.TryParse(txtPublishDate.Text, out date);
        item.PublishDate = date;

        if (string.IsNullOrEmpty(txtSImage.UploadResult) && !string.IsNullOrEmpty(txtLImage.ThumbnailImage))
            item.SImage = txtLImage.ThumbnailImage;
        else
            item.SImage = txtSImage.UploadResult;

        item.SImage = txtSImage.UploadResult;
        item.NewsType = Convert.ToInt32(txtBandId.SelectedValue);
        item.Hits = Convert.ToInt32(txtHits.Value);
        if (txtStatus.Checked) item.Status = PublishStatus.Publish;
        item.Title = txtTitle.Text;
        item.Preview = txtPreview.Text;
        item.Body = txtBody.Value ;
        item.AddDate = DateTime.Now;
        item.AddUserID = D4D.Web.Helper.AdminHelper.CurrentUser.UserID;
        if (cbIsVideo.Checked)
            item.Remark = "video";
        else
        {
            item.Remark = "";
        }
        int result = D4DGateway.NewsProvider.SetNews(item);
        D4DGateway.TagsProvider.DeleteTagRelationByObject(result, ObjectTypeDefine.News);
        if (txtTags.Text.Length > 0)
        {
            string[] tags = txtTags.Text.Split(',');
            foreach (string s in tags)
            {
                int i = 0;
                int.TryParse(s, out i);
                if (i > 0)
                {
                    D4DGateway.TagsProvider.SetTagRelation(new TagRelation()
                    {
                        TagId = i,
                        AddDate = DateTime.Now,
                        AddUserID = D4D.Web.Helper.AdminHelper.CurrentUser.UserID,
                        ObjectId = result,
                        ObjectType = ObjectTypeDefine.News
                    });
                }
            }
        }
        addPanel.Visible = false;

        BindList();
    }

    protected void btnAdd_Show(object sender, EventArgs e)
    {
        DrawAddPanel(null);
        addPanel.Visible = true;
        btnAdd.Text = "添加";
    }

    private void DrawAddPanel(News item)
    {
        DrawAddPanel(item, new System.Collections.Generic.List<TagRelation>());
    }
    private void DrawAddPanel(News item, System.Collections.Generic.List<TagRelation> list)
    {
        if (item == null) item = new News();
        txtNewsId.Value = item.NewsId.ToString();

        txtBandId.SelectedValue = item.NewsType.ToString();
        txtHits.Value = item.Hits.ToString();

        txtPublishDate.Text = (item.PublishDate == DateTime.MinValue) ? DateTime.Now.ToLongDateString() : item.PublishDate.ToLongDateString();
        txtLImage.UploadResult = item.LImage;
        txtSImage.UploadResult = item.SImage;
        txtStatus.Checked = (item.Status == PublishStatus.Publish);
        txtTitle.Text = item.Title;
        txtPreview.Text = item.Preview;
        txtBody.Value = item.Body;
        txtTags.Text = String.Join(",", (from i in list
                                         select i.TagId.ToString()).ToArray());

        if (item.Remark == "video")
            cbIsVideo.Checked = true;
        else
            cbIsVideo.Checked = false;




    }

    protected void ddlNewsRemarkTypes_SelectedIndexChanged(object sender, EventArgs e)
    {
        BindList();
    }
</script>

