<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/admin/Admin.Master" %>
<%@ Import Namespace="D4D.Platform"%>
<%@ Import Namespace="D4D.Platform.Domain" %>
<%@ Import Namespace="LTP.Accounts.Bus"%>
<asp:Content ContentPlaceHolderID="head" runat="server">
    
</asp:Content>
<asp:Content ContentPlaceHolderID="ContentBody" runat="server">
    <form id="form1" runat="server">
    <asp:Panel runat="server" ID="addPanel">
            <div>Tag编辑</div>
            <div>
             <table cellspacing="1" cellpadding="4" rules="all"  align="center" width="100%" class="grid">
                    <tr>
                      <th align="center" width="100">Tag</th>
                      <td><asp:TextBox ID="txtTitle" runat="server" Width="500px"></asp:TextBox>
                      <asp:HiddenField ID="txtTagId" runat="server" Value="0" ></asp:HiddenField></td>
                      </tr>
                      <tr>
                      <td></td>
                      <td>
                          <asp:Button ID="btnAdd" runat="server" Text="添加" OnClick="btnAdd_Click" />
                          </td>
                      </tr>
                    </table>
           </div>
            </asp:Panel>
            <asp:Panel runat="server" ID="listPanel">
            <div>
             <div>Tag列表</div>
            
            <asp:Repeater ID="repList" runat="server" 
                    onitemdatabound="repList_ItemDataBound">
                <HeaderTemplate>
                <table cellspacing="1" cellpadding="4" rules="all"  align="center" width="100%" class="grid">
                    <tr align="center">
                      <th align="center" style="width: 30px;">编号</th>
                      <th>Tag</th>
                      <th>访问量</th>
                      <th>添加人</th>
                      <th>添加日期</th>
                      <th style="width: 30px;">修改</th>
                      <th style="width: 30px;">删除</th>
                    </tr>
                </HeaderTemplate>
                <ItemTemplate>
                    <tr align="center">
                      <td align="center" style="width: 30px;"><asp:Literal ID="litID" runat="server"></asp:Literal></td>
                      <td><asp:Literal ID="litTitle" runat="server"></asp:Literal></td>
                      <td><asp:Literal ID="litHits" runat="server"></asp:Literal></td>
                      <td><asp:Literal ID="litAddUser" runat="server"></asp:Literal></td>
                      <td><asp:Literal ID="litAddDate" runat="server"></asp:Literal></td>
                      <td style="width: 30px;"><asp:Button ID="btnUpdate" runat="server" OnClick="btnUpdate_Click" Text="修改" /></td>
                      <td style="width: 30px;"><asp:Button ID="btnDelete" runat="server" OnClick="btnDelete_Click"  Text="删除" /> </td>
                    </tr>
                </ItemTemplate>
                <FooterTemplate>
                     <tr align="right" style="font-size: medium; white-space: nowrap;">
                      <td colspan="6" valign="middle" class="pagestyle" id="pager"></td>
                      <td><asp:Button ID="btnAddShow" runat="server" OnClick="btnAdd_Show" Text="新增" /></td>
                    </tr>
                    </table>
                </FooterTemplate>        
                </asp:Repeater>
            </div>

           
                    
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

  
    private void BindList()
    {
        PagingContext pager = new PagingContext();
        pager.CurrentPageNumber = PageIndex;
        pager.RecordsPerPage = PageSize;
        System.Collections.Generic.IList<Tag> list  =  D4DGateway.TagsProvider.GetPagedTags(pager);
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
                Tag tag = D4DGateway.TagsProvider.GetTag(id);
                txtTitle.Text = tag.TagName;
                txtTagId.Value = tag.TagId.ToString();
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
                D4DGateway.TagsProvider.DeleteTag(id);
                BindList();
            }
        }

    }


    protected void repList_ItemDataBound(object sender, RepeaterItemEventArgs e)
    {
       Tag t = e.Item.DataItem as D4D.Platform.Domain.Tag;

        if (t != null)
        {
            Literal litId = e.Item.FindControl("litId") as Literal;
            litId.Text = t.TagId.ToString();
            Literal litTitle = e.Item.FindControl("litTitle") as Literal;
            litTitle.Text = t.TagName;
            Literal litHits = e.Item.FindControl("litHits") as Literal;
            litHits.Text = t.Hits.ToString();
            Literal litAddDate = e.Item.FindControl("litAddDate") as Literal;
            litAddDate.Text = t.AddDate.ToLongDateString();

            Literal litAddUser = e.Item.FindControl("litAddUser") as Literal;
            litAddUser.Text = ((User)D4D.Web.Helper.AdminHelper.AdminCollection[t.AddUserID]).TrueName;
        }
    }

    protected void btnAdd_Click(object sender, EventArgs e)
    {
        Tag tag = new Tag();
        int tagId = 0;
        int.TryParse(txtTagId.Value, out tagId);
        tag.TagId = tagId;
        tag.TagName = txtTitle.Text;
        User user = Session["UserInfo"] as User;
        tag.AddUserID = user.UserID;
        tag.AddDate = DateTime.Now;
        int result = D4DGateway.TagsProvider.SetTag(tag);
        addPanel.Visible = false;

        BindList();
    }

    protected void btnAdd_Show(object sender, EventArgs e)
    {
        txtTagId.Value = "";
        txtTitle.Text = "";
       
        addPanel.Visible = true;
        btnAdd.Text = "添加";
    }


    </script>