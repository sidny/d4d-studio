<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="UploadTest.aspx.cs" Inherits="D4D.Web.admin.Upload.UploadTest" %>

<%@ Register src="../Controls/FileUpload.ascx" tagname="FileUpload" tagprefix="uc1" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <uc1:FileUpload ID="FileUpload1" runat="server" />
        <asp:DropDownList ID="ddlPublishStatus" runat="server">
                              <asp:ListItem Value="0">未发布</asp:ListItem>
                              <asp:ListItem Selected="True" Value="1">发布</asp:ListItem>                              
                          </asp:DropDownList>
        <asp:Button ID="Button1" runat="server" Text="Button" onclick="Button1_Click" />
        <asp:Button ID="Button2" runat="server" onclick="Button2_Click" Text="Button" />
    </div>
    </form>
    
</body>
</html>
