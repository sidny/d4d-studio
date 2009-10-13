<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="MusicTitle.aspx.cs" Inherits="D4D.Web.admin.Music.MusicTitle" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>音乐专辑编辑</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
            <div>专辑编辑</div>
            <div>
            专辑名称:<asp:TextBox ID="txtTitle" runat="server" Width="500px"></asp:TextBox>
             <br />专辑描述:<asp:TextBox ID="txtBody" runat="server" Width="500px"></asp:TextBox>
            <br />歌手:<asp:TextBox ID="txtBandId" runat="server">1</asp:TextBox>
           <br /> 发布状态:<asp:TextBox ID="txtStatus" runat="server">1</asp:TextBox>
           <br />封面小图: <asp:TextBox ID="txtSImage" runat="server" Width="500px">http://images.google.com/intl/en_ALL/images/logos/images_logo_lg.gif</asp:TextBox>
           <br />封面大图: <asp:TextBox ID="txtLImage" runat="server" Width="500px">http://images.google.com/intl/en_ALL/images/logos/images_logo_lg.gif</asp:TextBox>
           <br /> 添加人ID:<asp:TextBox ID="txtAddUserId" runat="server">1</asp:TextBox>           
            </div>
            <div>
            <asp:Button ID="btnAdd" runat="server" Text="新增" onclick="btnAdd_Click" />
            </div>
            <div>专辑列表</div>
            <div>
            <ul>
            <asp:Repeater ID="repMusicTitle" runat=server 
                    onitemdatabound="repMusicTitle_ItemDataBound">
                <HeaderTemplate>
                ID，专辑名称，歌手，封面小图，封面大图，发布状态，添加人ID，添加日期
                </HeaderTemplate>
                <ItemTemplate>
                <li>
                    <asp:Literal ID="litID" runat="server"></asp:Literal>，
                    <asp:Literal ID="litTitle" runat="server"></asp:Literal>，
                    <asp:Literal ID="litBandId" runat="server"></asp:Literal>，
                     <asp:Literal ID="litSImage" runat="server"></asp:Literal>，
                      <asp:Literal ID="litLImage" runat="server"></asp:Literal>，
                    <asp:Literal ID="litStutes" runat="server"></asp:Literal>，
                    <asp:Literal ID="litAddUserId" runat="server"></asp:Literal>，
                    <asp:Literal ID="litAddDate" runat="server"></asp:Literal>
                    |<asp:Button ID="btnUpdate" runat="server" OnClick="btnUpdate_Click" Text="修改" />
                    |<asp:Button ID="btnDelete" runat="server" OnClick="btnDelete_Click"  Text="删除" />                    
                </li>   
                </ItemTemplate>             
                </asp:Repeater>
            </ul>
            </div>

            <div>当前页：<asp:Label ID="labCurrentPage" runat="server" Text="0"></asp:Label>,总页数：<asp:Label ID="labTotalCount" runat="server" Text="0"></asp:Label>,
               去第<asp:TextBox ID="txtGoToPageNum" runat="server" Width="35px">1</asp:TextBox>页<asp:Button 
                    ID="btnGoPage" runat="server" Text="Go" onclick="btnGoPage_Click" /></div>
    </div>
    </form>
</body>
</html>
