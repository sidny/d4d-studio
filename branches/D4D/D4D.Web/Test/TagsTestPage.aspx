<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="TagsTestPage.aspx.cs" Inherits="D4D.Web.Test.TagsTestPage" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <div>
     <asp:TextBox ID="txtTagId" runat="server">0</asp:TextBox>
    <asp:TextBox ID="txtTagName" runat="server"></asp:TextBox>
    </div>   
    <div>
    <asp:Button ID="btnSetTag" runat="server" Text="SetTag" onclick="btnSetTag_Click" />
     &nbsp;&nbsp;&nbsp;
     <asp:Button ID="btnDeleteTag" runat="server" Text="DeleteTag" 
            onclick="btnDeleteTag_Click" style="height: 26px" />
       &nbsp;&nbsp;&nbsp;
        <asp:Button ID="btnAddTagHits" runat="server" Text="AddTagHits" 
            onclick="btnAddTagHits_Click" />
         &nbsp;&nbsp;&nbsp;
           <asp:Button ID="btnGetOneTag" runat="server" Text="GetOneTag" 
            onclick="btnGetOneTag_Click" style="height: 26px" />
             &nbsp;&nbsp;&nbsp;
              <asp:Button ID="btnGetTopTag" runat="server" Text="GetTopTag" 
            onclick="btnGetTopTag_Click" />
             &nbsp;&nbsp;&nbsp;
              <asp:Button ID="btnGetPagedTags" runat="server" Text="GetPagedTags" 
            onclick="btnGetPagedTags_Click" />
    </div>
    <hr />
    <div>
        <asp:Label ID="labInfo" runat="server" BorderColor="Red"></asp:Label>
        </div>
     </div>
    </form>
</body>
</html>
