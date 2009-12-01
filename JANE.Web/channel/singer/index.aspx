<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/MasterPage/Main.Master" %>
<%@ Import Namespace="System.Collections.Generic" %>
<%@ Import Namespace="D4D.Platform.Domain" %>
<%@ Import Namespace="D4D.Platform" %>
<%@ Import Namespace="D4D.Web.Helper" %>
<asp:Content ContentPlaceHolderID="ContentHeader" runat="server" ID="ContentHeader">
<script type="text/javascript">
    $(function() {
        $(".jane_info_text").hide().eq(0).show();
        $(".jane_info_menu a").each(function(index, self) {
            $(self).click(function() {
                $(this).parent().find(".jane_info_menu_on").removeClass("jane_info_menu_on");
                $(this).addClass("jane_info_menu_on");
                $(".jane_info_text").hide().eq(index).show();
                $(".jane_info_title span").html("- "+$(this).text());
            });
        });
    });
</script>
</asp:Content>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentMain" runat="server">
<div class="cd_body jane_info">
  <!--left-->
  <div class="left floatleft">
    <div class="spacer" style="height:56px;"></div>
	<div class="jane_info_menu">
		<a href="#" class="jane_info_menu_on">靓颖档案</a> 
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
      	<h1 class="blue">档案<span>- 张靓颖档案</span></h1>
      </div>
	  
	  <div class="spacer" style="height:20px"></div>
	  <div class="jane_info_text">
	  	<%=GetProfile(0)%>
	  </div>
	  <div class="jane_info_text">
	  	<%=GetProfile(1)%>
	  </div>
	  <div class="jane_info_text">
	  	<%=GetProfile(2)%>
	  </div>
	  <div class="jane_info_text">
	  	<%=GetProfile(3)%>
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
    protected void Page_Load(object sender, EventArgs e)
    {
        
    }
    protected string GetProfile(int type)
    {
        return D4D.Platform.D4DGateway.BandInfoProvider.ReadProfileContent(
                Helper.BandId, type);
    }
   
</script>
