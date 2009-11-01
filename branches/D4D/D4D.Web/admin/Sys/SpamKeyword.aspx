<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/admin/Admin.Master"%>
<%@ Import Namespace="System.Collections.Generic" %>
<%@ Import Namespace="D4D.Platform.Domain" %>
<%@ Import Namespace="LTP.Accounts.Bus" %>
<%@ Import Namespace="System.Linq" %>
<%@ Import Namespace="D4D.Platform" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>关键词编辑</title>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentBody" runat="server">
    <form id="form1" runat="server">
    <asp:Panel runat="server" ID="addPanel">
            <div>关键词编辑</div>
            <div>
             <table cellspacing="1" cellpadding="4" rules="all"  align="center" width="100%" class="grid">
                    <tr>
                      <th align="center" width="100">关键词</th>
                      <td><asp:TextBox ID="txtKeyword" runat="server" Width="300px"></asp:TextBox>
                      <asp:HiddenField ID="txtId" runat="server" Value="0" ></asp:HiddenField></td>
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
             <div>关键词列表</div>
            
            <asp:Repeater ID="repKeywords" runat=server 
                    onitemdatabound="repKeywords_ItemDataBound">
                <HeaderTemplate>
                <table cellspacing="1" cellpadding="4" rules="all"  align="center" width="100%" class="grid">
                    <tr align="center">
                      <th align="center" style="width: 30px;">编号</th>
                      <th>关键词</th>                     
                      <th>添加人</th>
                      <th>添加日期</th>
                      <th style="width: 30px;">修改</th>
                      <th style="width: 30px;">删除</th>
                    </tr>
                </HeaderTemplate>
                <ItemTemplate>
                    <tr align="center">
                      <td align="center" style="width: 30px;"><asp:Literal ID="litID" runat="server"></asp:Literal></td>   
                      <td><asp:Literal ID="litKeyword" runat="server"></asp:Literal></td>           
                      <td><asp:Literal ID="litAddUserId" runat="server"></asp:Literal></td>
                      <td><asp:Literal ID="litAddDate" runat="server"></asp:Literal></td>
                      <td style="width: 30px;"><asp:Button ID="btnUpdate" runat="server" OnClick="btnUpdate_Click" Text="修改" /></td>
                      <td style="width: 30px;"><asp:Button ID="btnDelete" runat="server" OnClick="btnDelete_Click"  Text="删除" /> </td>
                    </tr>
                </ItemTemplate>
                <FooterTemplate>
                     <tr align="right" style="font-size: medium; white-space: nowrap;">
                      <td colspan="5" valign="middle" class="pagestyle" id="pager"></td>
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
            BindList(PageIndex);           
           // labCurrentPage.Text = PageIndex.ToString();
        }
    }


    private void BindList(int pageIndex)
    {
        PagingContext pager = new PagingContext();
        pager.RecordsPerPage = PageSize;
        pager.CurrentPageNumber = pageIndex;
        repKeywords.DataSource = D4DGateway.SpamKeywordProvider.GetPagedSpamKeywords(pager);
        repKeywords.DataBind();
        totalCount = pager.TotalRecordCount;

    }

  
    protected void btnUpdate_Click(object sender, EventArgs e)
    {
        Button bt = sender as Button;

        RepeaterItem ri = bt.Parent as RepeaterItem;

        Literal litID = ri.FindControl("litID") as Literal;
        Literal litKeyword = ri.FindControl("litKeyword") as Literal;
     

        if (!object.Equals(litID, null))
        {
            int id = 0;
            if (int.TryParse(litID.Text, out id))
            {
                txtId.Value = litID.Text;   
                txtKeyword.Text = litKeyword.Text;               
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
                D4DGateway.SpamKeywordProvider.DeleteKeyword(id);
                BindList(1);
            }
        }
    }
    protected void repKeywords_ItemDataBound(object sender, RepeaterItemEventArgs e)
    {
        D4D.Platform.Domain.SpamKeyword m = e.Item.DataItem as D4D.Platform.Domain.SpamKeyword;

        if (m != null)
        {
            Literal litID = e.Item.FindControl("litID") as Literal;
            Literal litKeyword = e.Item.FindControl("litKeyword") as Literal;
            Literal litAddUserId = e.Item.FindControl("litAddUserId") as Literal;
            Literal litAddDate = e.Item.FindControl("litAddDate") as Literal;


            litID.Text = m.Id.ToString();
            litKeyword.Text = m.Keyword;
            litAddUserId.Text = m.AddUserID.ToString();
            litAddDate.Text = m.AddDate.ToLongDateString();      
         
        }
    }

    protected void btnAdd_Click(object sender, EventArgs e)
    {
        D4D.Platform.Domain.SpamKeyword m = new D4D.Platform.Domain.SpamKeyword();

        int id = 0;
        int.TryParse(txtId.Value, out id);
        m.Id = id;
        
        m.Keyword = txtKeyword.Text;   
     
        User currentUser = Session["UserInfo"] as User;
        m.AddUserID = currentUser.UserID;
      
        m.AddDate = DateTime.Now;

       
        int result = D4DGateway.SpamKeywordProvider.SetSpamKeyword(m);
        addPanel.Visible = false;
        listPanel.Visible = true;
        BindList(1);
    }

    protected void btnAdd_Show(object sender, EventArgs e)
    {
        addPanel.Visible = true;
        listPanel.Visible = false;
        txtKeyword.Text = string.Empty;
        txtId.Value = "0";    
        addPanel.Visible = true;
        listPanel.Visible = false;       
        btnAdd.Text = "添加";
    }
    </script>