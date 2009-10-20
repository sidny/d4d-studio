<%@ Page Title="" Language="C#" MasterPageFile="~/admin/Admin.Master" AutoEventWireup="true" CodeBehind="default.aspx.cs" Inherits="D4D.Web.admin._default" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <%if (false)
  { %>
   <script type="text/javascript" src="../static/js/jquery-1.3.2.js"></script>
<%} %>
<script type="text/javascript">
    window.currentPermission = <%=PermissionStr %>;
    $(document).ready(function() {
        $(window).bind("resize",function(){
            $(".left-nav").css({height:$(window).height()-64});
            $(".content").css({height:$(window).height()-64,width:$(window).width()-250});
            });
         $(".left-nav").css({height:$(window).height()-64});
         $(".content").css({height:$(window).height()-64,width:$(window).width()-250});
        var perCollection = {};
        $(currentPermission).each(function(){
            perCollection[this] = true;
        })
        $("div.top-nav span").css("cursor", "pointer")
        .click(function() {
			$(this).parent().children().removeClass("on");
			$(this).addClass("on");
            $.get("/svc/admin.svc/getPermission",
                { catId: $(this).attr("href"),cache:false },
                function(response) {
                    var str = "";
                    $(response.d).each(function() {
                        if(this.Url &&　perCollection[this.Id])
                            str += '<p><a href="' + this.Url + '" target="ContentFrame">' + this.Desc + '</a></p>';
                    });
                    $("div.left-nav").html(str);
                }, "json");
        });
    });
</script>
<style type="text/css">
body{ padding:0; margin:0; font-size:12px; overflow:hidden;}
.top{height: 64px; background:url(/static/images/admin/top.png) bottom repeat-x;}
.top-nav{  float:left; width:760px; padding-top:41px;}
.top-nav span{ padding:10px; font-weight:bold; color:white;}
.top-nav span.on{background:white; color:black}
.top-nav span a{ color:#FCC; text-decoration:none}
.left-nav{ float:left; width:240px; height:500px; background:#4f4f4f;}
.left-nav p{ border-bottom: 1px solid #616161; color:white; padding-left:60px; height:23px;}
.left-nav p a{ color:white; text-decoration:none}
.content{ height:500px; width:760px; float:left; border-left:1px solid #ccc; }

</style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentBody" runat="server">
    <div class="top">
    <img src="/static/images/admin/logo.png" align="left" />
    <div class="top-nav">
    
    <asp:Repeater ID="menuList" runat="server">
	<ItemTemplate><span href="<%#((Hashtable)Container.DataItem)["CategoryID"]%>"><%#((Hashtable)Container.DataItem)["Description"]%></span></ItemTemplate>
    </asp:Repeater>
    <span><a href="logout.aspx" target="_top">退出登录</a></span>
    </div>
</div>
<div class="left-nav">

</div>
<div class="content">
<iframe scrolling="auto" id="ContentFrame" name="ContentFrame"  frameborder="0" src="about:blank" width="100%" height="99.9%"></iframe>
</div>
</asp:Content>
