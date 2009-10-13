<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="MusicTitle.aspx.cs" MasterPageFile="~/admin/Admin.Master" Inherits="D4D.Web.admin.Music.MusicTitle" %>
<asp:Content ContentPlaceHolderID="head" runat="server">
    <title>音乐专辑编辑</title>
</asp:Content>
<asp:Content ContentPlaceHolderID="ContentBody" runat="server">
    <form id="form1" runat="server">
    <div>
            <div>专辑编辑</div>
            <div>
             <table cellspacing="1" cellpadding="4" rules="all"  align="center" width="100%" class="grid">
                    <tr>
                      <th align="center" width="100">专辑名称</th>
                      <td><asp:TextBox ID="txtTitle" runat="server" Width="500px"></asp:TextBox></td>
                      </tr>
                      <tr>
                     <th width="100">专辑描述</th>
                      <td><asp:TextBox ID="txtBody" runat="server" Width="500px"></asp:TextBox></td>
                    </tr>
                     <tr>
                     <th align="center" width="100">歌手</th>
                      <td><asp:TextBox ID="txtBandId" runat="server">1</asp:TextBox></td>
                    </tr>
                     <tr>
                     <th align="center" width="100">发布状态</th>
                      <td><asp:TextBox ID="txtStatus" runat="server">1</asp:TextBox></td>
                    </tr>
                    <tr>
                    <th align="center" width="100">封面小图</th>
                      <td><asp:TextBox ID="txtSImage" runat="server" Width="500px">http://images.google.com/intl/en_ALL/images/logos/images_logo_lg.gif</asp:TextBox></td>
                    </tr>
                     <tr>
                    <th align="center" width="100">封面大图</th>
                      <td><asp:TextBox ID="txtLImage" runat="server" Width="500px">http://images.google.com/intl/en_ALL/images/logos/images_logo_lg.gif</asp:TextBox></td>
                    </tr>
                     <tr>
                    <th align="center" width="100">添加人ID</th>
                      <td><asp:TextBox ID="txtAddUserId" runat="server">1</asp:TextBox> </td>
                    </tr> 
                    <tr>
                    <th align="center" width="100">&nbsp;</th>
                      <td><asp:Button ID="btnAdd" runat="server" Text="新增" onclick="btnAdd_Click" /></td>
                    </tr>
                    </table>
            <div>专辑列表</div>
            <div>
            
            
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
                      <th>添加人ID</th>
                      <th>添加日期</th>
                      <th style="width: 30px;">修改</th>
                      <th style="width: 30px;">删除</th>
                    </tr>
                </HeaderTemplate>
                <ItemTemplate>
                    <tr align="center">
                      <td align="center" style="width: 30px;"><asp:Literal ID="litID" runat="server"></asp:Literal></td>
                      <td><asp:Literal ID="litTitle" runat="server"></asp:Literal></td>
                      <td><asp:Literal ID="litBandId" runat="server"></asp:Literal></td>
                      <td style="width: 30px;"><a href='<asp:Literal ID="litLImage" runat="server"></asp:Literal>' target="_blank"><img src='<asp:Literal ID="litSImage" runat="server"></asp:Literal>' width="25" height="25" /></a>
                      </td>
                      <td><asp:Literal ID="litStutes" runat="server"></asp:Literal></td>
                      <td><asp:Literal ID="litAddUserId" runat="server"></asp:Literal></td>
                      <td><asp:Literal ID="litAddDate" runat="server"></asp:Literal></td>
                      <td style="width: 30px;"><asp:Button ID="btnUpdate" runat="server" OnClick="btnUpdate_Click" Text="修改" /></td>
                      <td style="width: 30px;"><asp:Button ID="btnDelete" runat="server" OnClick="btnDelete_Click"  Text="删除" /> </td>
                    </tr>
                </ItemTemplate>
                <FooterTemplate>
                     <tr align="right" style="font-size: medium; white-space: nowrap;">
                      <td colspan="9" valign="middle" class="pagestyle" id="pager"></td>
                    </tr>
                    </table>
                </FooterTemplate>        
                </asp:Repeater>
            </div>

            <div>当前页：<asp:Label ID="labCurrentPage" runat="server" Text="0"></asp:Label>,总页数：<asp:Label ID="labTotalCount" runat="server" Text="0"></asp:Label>,
               去第<asp:TextBox ID="txtGoToPageNum" runat="server" Width="35px">1</asp:TextBox>页<asp:Button 
                    ID="btnGoPage" runat="server" Text="Go" onclick="btnGoPage_Click" /></div>
    </div>
    
<script type="text/javascript">
    $(document).ready(function() {
    var cur = parseInt("<%=PageIndex %>");
        var total = parseInt("<%=PageTotalCount %>");
        $("#pager").pagination(
          total,
                {
                    items_per_page: 1,
                    num_display_entries: 10,
                    current_page: cur -1,
                    num_edge_entries: 0,
                    prev_text: "上一页",
                    next_text: "下一页",
                    callback:function(id){
                        location.href="musictitle.aspx?page="+ (id+1);
                    }
                });
    });
</script>
    </form>
    
    </asp:Content>