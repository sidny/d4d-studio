<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="news.aspx.cs" Inherits="D4D.Web.channel.news.news" MasterPageFile="~/MasterPage/Channel.Master" %>
<asp:Content ContentPlaceHolderID="ContentHeader" runat="server" ID="ContentHeader"></asp:Content>
<asp:Content ContentPlaceHolderID="ContentMain" runat="server">
    <%=Request["id"] %>
</asp:Content>