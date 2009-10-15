﻿<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/MasterPage/Main.Master" %>

<%@ Import Namespace="D4D.Platform.Domain" %>
<asp:Content ContentPlaceHolderID="ContentHeader" runat="server" ID="ContentHeader">
</asp:Content>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentMain" runat="server">

<div class="sub-title">
  <p class="title">星闻</p>
  <p class="nav-link">您的位置：首页 > 星闻</p>
</div>

<div class="album_detail">
<div class="channel">
  <h1>全部照片/靓丽影</h1>
  <div class="pager">
    <a href="#">上一张</a>
        4/200
    <a href="#">上一张</a>
  </div>
  <div class="return"><a href="#" style="color:red">返回图片首页</a></div>
</div>

<div class="detail"><img src="/static/images/album/big.jpg" />
    <div class="pager">
        <a href="#">上一张</a>
         4/200
        <a href="#">上一张</a>
    </div>
</div>
<div class="album_slider">
    <div class="prev">&lt;</div>
    <div class="next">&gt;</div>
	<ul class="clearfix">
		<li>
            <a href="#"><img src="/static/images/album/ex.gif" align="absmiddle" /></a> 
        </li>
        <li class="on">
            <a href="#"><img src="/static/images/album/ex.gif" align="absmiddle" /></a> 
        </li>
        <li>
            <a href="#"><img src="/static/images/album/ex.gif" align="absmiddle" /></a> 
        </li>
        <li>
            <a href="#"><img src="/static/images/album/ex.gif" align="absmiddle" /></a> 
        </li>
        <li>
            <a href="#"><img src="/static/images/album/ex.gif" align="absmiddle" /></a> 
        </li>
        <li>
            <a href="#"><img src="/static/images/album/ex.gif" align="absmiddle" /></a> 
        </li>
       	<li>
            <a href="#"><img src="/static/images/album/ex.gif" align="absmiddle" /></a> 
        </li>
    </ul>
</div>
<div class="comments-area">
    <div class="comments">
        <a href="#">我也要说两句</a>  <a href="#">评论（20）</a>
    </div>
    <div class="input-area"><textarea ></textarea>
    <button>发表</button>
    </div>
</div>
</div>
</asp:Content>
