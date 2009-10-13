<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="TagsInfo.aspx.cs" Inherits="D4D.Web.admin.Tag.TagsInfo" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>标签管理</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
         <!-- 标签内容编辑 -->
        <div>
        <ul>
            <li>标签ID：<asp:Label ID="labTagId" runat="server" Text=""></asp:Label></li>
            <li>标签计数：<asp:Label ID="labTagHits" runat="server" Text=""></asp:Label></li>
            <li>添加人ID：<asp:Label ID="labAddUserId" runat="server" Text=""></asp:Label></li>
            <li>添加时间：<asp:Label ID="labAddDate" runat="server" Text=""></asp:Label></li>
            <li>标签名称：<asp:TextBox ID="txtTagName" runat="server"></asp:TextBox></li>           
        </ul>           
        </div>
        <div>
            
        </div>
           
         <!-- 标签列表-->
        <div>
            <div>标签列表</div>
            <div>
            </div>
        </div>
    </div>
    </form>
</body>
</html>
