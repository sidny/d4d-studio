<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="FileUpload.ascx.cs" Inherits="D4D.Web.admin.Controls.FileUpload" %>
<asp:FileUpload ID="fileUpload" runat="server" Width="500px" /><asp:TextBox ID="txtUploadResult"
    runat="server" Visible="false"  Width="500px"></asp:TextBox>
<asp:Button ID="btnUpload"
    runat="server" Text="上传" onclick="btnUpload_Click" />&nbsp;<asp:Button 
    ID="btnShowResult" runat="server" Text="直接输入地址" onclick="btnShowResult_Click" />
<%if (AutoCreateThumbnailImage){ %>
<br />
自动生成缩略图地址：<label><asp:Literal ID="hiddenThumbnailImage" runat="server" ></asp:Literal></label>
<%} %>
<asp:Label ID="labInfo" runat="server" BackColor="Red"></asp:Label>

