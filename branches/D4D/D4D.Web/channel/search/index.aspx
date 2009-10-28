<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/MasterPage/Main.Master" %>
<%@ Import Namespace="D4D.Platform.Domain" %>
<%@ Import Namespace="D4D.Platform" %>
<%@ Import Namespace="System.Collections.Generic" %>
<asp:Content ContentPlaceHolderID="ContentHeader" runat="server" ID="ContentHeader"></asp:Content>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentMain" runat="server">
<script type="text/javascript" src="/static/js/jquery.highlight.js"></script>
<style type="text/css">
    .highlight {  color:Red }
</style>
<script type="text/javascript">
    $(document).ready(function() {
        $(".search-list").highlight("张靓颖");
    });
</script>
<div class="sub-title">
  <p class="title">搜索结果</p>
  <p class="nav-link">您的位置：首页 > 搜索</p>
</div>

<div class="search">
    <div class="search-nav">
        <p class="on">全部</p>
        <p>新闻</p>
        <p>星程</p>
        <p>音乐</p>
        <p>视频</p>
    </div>
    <div class="search-list">
        <ul>
            <li>
                <p> [<a href="#">新闻</a>] <a href="#">烧成时代官方网战</a></p>
                <p>这是一个关于少城时代的官方网站包含公司旗下艺人张靓颖，王铮亮的最新消息，图片， 视频，新闻，访问等等.</p>
            </li>
            <li>
                <p> [<a href="#">新闻</a>] <a href="#">烧成时代官方网战</a></p>
                <p>这是一个关于少城时代的官方网站包含公司旗下艺人张靓颖，王铮亮的最新消息，图片， 视频，新闻，访问等等.</p>
            </li>
            <li>
                <p> [<a href="#">新闻</a>] <a href="#">烧成时代官方网战</a></p>
                <p>这是一个关于少城时代的官方网站包含公司旗下艺人张靓颖，王铮亮的最新消息，图片， 视频，新闻，访问等等.</p>
            </li>
            <li>
                <p> [<a href="#">新闻</a>] <a href="#">烧成时代官方网战</a></p>
                <p>这是一个关于少城时代的官方网站包含公司旗下艺人张靓颖，王铮亮的最新消息，图片， 视频，新闻，访问等等.</p>
            </li>
            <li>
                <p> [<a href="#">新闻</a>] <a href="#">烧成时代官方网战</a></p>
                <p>这是一个关于少城时代的官方网站包含公司旗下艺人张靓颖，王铮亮的最新消息，图片， 视频，新闻，访问等等.</p>
            </li>
            <li>
                <p> [<a href="#">新闻</a>] <a href="#">烧成时代官方网战</a></p>
                <p>这是一个关于少城时代的官方网站包含公司旗下艺人张靓颖，王铮亮的最新消息，图片， 视频，新闻，访问等等.</p>
            </li>

        </ul>
        
        
    </div>
</div>
</asp:Content>