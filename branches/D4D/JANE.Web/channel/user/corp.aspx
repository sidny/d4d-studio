﻿<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/MasterPage/Main.Master" %>

<%@ Import Namespace="D4D.Platform.Domain" %>
<asp:Content ContentPlaceHolderID="ContentHeader" runat="server" ID="ContentHeader">
</asp:Content>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentMain" runat="server">
<div class="cd_body jane_info">
  <!--left-->
  <div class="left floatleft">
    <div class="spacer" style="height:56px;"></div>
	<div class="jane_info_menu">
		<a href="/about.html">公司介绍</a> 
		<a href="/links.html">合作伙伴</a> 
		<a href="/contact.html">联系我们</a>
		<a href="#">靓颖演唱会</a>
        <a href="#">靓颖历程</a> 
		<a href="#">靓颖奖项</a>
		<a href="#">靓颖演唱会</a>
	</div>
	<div class="spacer"></div>
  </div>
  <!--left/-->
  <!--right-->
  <div class="right floatleft">
  <div class="cd_right">
    <div class="w_562 h_578">
      <div class="spacer" style="height:36px"></div>
	  
	  <div class="cd_title jane_info_title">
      	<h1 class="blue"><%=Channel%></h1>
      </div>
	  
	  <div class="spacer" style="height:20px"></div>
	  <div class="jane_info_text">
	  	<asp:Label runat="server" ID="text"></asp:Label>
	  </div>
	  <div class="spacer" style="height:30px"></div>
      
	  <div class="clear"></div>
    </div>
	<div class="clear"></div>
	</div>
	<div class="clear"></div>
  </div>
  <!--right/-->
  <div class="clear"></div>
</div>
</asp:Content>
<script runat="server">
    protected string Channel = string.Empty;

    protected void Page_Load(object sender, EventArgs e)
        {
            string page = Request["page"];
            switch (Request["page"])
            {
                
                case "contact":
                    Channel = "联系我们";
                    break;
                case "zhaopin":
                    Channel = "招聘信息";
                    break;
                case "copyright":
                    Channel = "免责声明";
                    break;
				case "adservice":
                    Channel = "广告服务";
                    break;
				case "links":
                    Channel = "合作伙伴";
                    break;
                case "about":
                default:
                    page = "about";
                    Channel = "公司介绍";
                    break;
                
            }
            
           text.Text = D4D.Platform.D4DGateway.CorpInfoProvider.ReadProfileContent(page);
          
        }    
</script>