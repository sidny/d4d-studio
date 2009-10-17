<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/admin/Admin.Master" %>
<%@ Import Namespace="D4D.Platform"%>
<%@ Import Namespace="D4D.Platform.Domain" %>
<%@ Import Namespace="LTP.Accounts.Bus"%>
<%@ Register src="../Controls/FileUpload.ascx" tagname="FileUpload" tagprefix="uc1" %>
<asp:Content ContentPlaceHolderID="head" runat="server">
    <title>星程编辑</title>
</asp:Content>
<asp:Content ContentPlaceHolderID="ContentBody" runat="server">
<form id="form1" runat="server">
            <div>
             <div>星程列表</div>
                <table cellspacing="1" cellpadding="4" rules="all"  align="center" width="100%" class="grid">
                    <tr align="center">
                      <th align="center" style="width: 30px;">编号</th>
                      <th>名称</th>
                      <th>状态</th>
                      <th>开始日期</th>
                      <th>结束日期</th>
                      <th style="width: 30px;">修改</th>
                      <th style="width: 30px;">删除</th>
                    </tr>
                    <tr align="center">
                      <td align="center" style="width: 30px;"><asp:Literal ID="litId" runat="server"></asp:Literal></td>
                      <td><asp:Literal ID="litTitle1" runat="server"></asp:Literal></td>
                      <td><asp:Literal ID="litStatus" runat="server"></asp:Literal></td>
                      <td><asp:Literal ID="litShowDate" runat="server"></asp:Literal></td>
                      <td><asp:Literal ID="litEndDate" runat="server"></asp:Literal></td>
                      <td style="width: 30px;"><asp:Button ID="btnUpdate" runat="server" OnClick="btnUpdate_Click" Text="修改" /></td>
                      <td style="width: 30px;"><asp:Button ID="btnDelete" runat="server" OnClick="btnDelete_Click"  Text="删除" /> </td>
                    </tr>
             
                     <tr align="right" style="font-size: medium; white-space: nowrap;">
                      <td colspan="6" valign="middle" class="pagestyle" id="pager"></td>
                      <td class="pagestyle"><asp:Button ID="btnAddShow" runat="server" OnClick="btnAdd_Show" Text="新增" /></td>
                    </tr>
                    </table>
               
            </div>

                    
            <div>编辑星程</div>
            <div>
             <table cellspacing="1" cellpadding="4" rules="all"  align="center" width="100%" class="grid">
                    <tr>
                      <th align="center" width="100">标题</th>
                      <td><asp:TextBox ID="txtTitle1" runat="server" Width="500px"></asp:TextBox>
                      <asp:HiddenField ID="txtShowId" runat="server" Value="0" ></asp:HiddenField></td>
                      </tr>
                      <tr>
                     <th width="100">Body</th>
                      <td><asp:TextBox ID="txtBody" runat="server" Width="500px"></asp:TextBox></td>
                    </tr>
                     <tr>
                     <th align="center" width="100">SImage</th>
                      <td><uc1:FileUpload ID="txtSImage" runat="server" /></td>
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
                      <td><asp:TextBox ID="txtShowDate" runat="server" Width="500px"></asp:TextBox></td>
                    </tr>
                    <tr>
                     <th width="100">结束日期</th>
                      <td><asp:TextBox ID="txtEndDate" runat="server" Width="500px"></asp:TextBox></td>
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
                      <td><asp:Button ID="btnAdd" runat="server" Text="新增" onclick="btnAdd_Click" /></td>
                    </tr>
                    </table>
           </div>
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
        }
    }

   
    private void BindList()
    {
       

    }

    protected void btnUpdate_Click(object sender, EventArgs e)
    {
        
    }
    protected void btnDelete_Click(object sender, EventArgs e)
    {
       
    }


    protected void repList_ItemDataBound(object sender, RepeaterItemEventArgs e)
    {
        
    }

    protected void btnAdd_Click(object sender, EventArgs e)
    {
    }

    protected void btnAdd_Show(object sender, EventArgs e)
    {
       
    }


    </script>