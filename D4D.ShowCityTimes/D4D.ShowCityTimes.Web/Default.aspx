<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="D4D.ShowCityTimes.Web._Default" %>
<%@ Import Namespace="System.ComponentModel" %>
<%@ Import Namespace="D4D.ShowCityTimes.Domain" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
    <asp:Repeater ID="TagRepeater" runat="server">
    <HeaderTemplate><ul></HeaderTemplate>
        <ItemTemplate>
        <li><a href="/detail.aspx?id=<%#((Tag)Container.DataItem).Id%>"><%#((Tag)Container.DataItem).Name%> <%#((Tag)Container.DataItem).Adddate.ToString()%></a></li>
        </ItemTemplate>
        <FooterTemplate></ul></FooterTemplate>
    </asp:Repeater>
    <asp:Repeater ID="NewsRepeater" runat="server">
    <HeaderTemplate><ul></HeaderTemplate>
        <ItemTemplate>
        <li><a href="/detail.aspx?id=<%#((News)Container.DataItem).Id%>"><%#((News)Container.DataItem).Title%> <%#((News)Container.DataItem).Adddate%></a>
        <p><%#((News)Container.DataItem).Detail%></p>
        </li>
        </ItemTemplate>
         <FooterTemplate></ul></FooterTemplate>
    </asp:Repeater>
    
    </div>
    </form>
</body>
</html>
