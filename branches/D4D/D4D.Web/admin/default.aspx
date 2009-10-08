<%@ Page Title="" Language="C#" MasterPageFile="~/admin/Admin.Master" AutoEventWireup="true" CodeBehind="default.aspx.cs" Inherits="D4D.Web.admin._default" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <%if (false)
  { %>
   <script type="text/javascript" src="../static/js/jquery-1.3.2.js"></script>
<%} %>
<script type="text/javascript">
    window.currentPermission = <%=PermissionStr %>;
    $(document).ready(function() {
        var perCollection = {};
        $(currentPermission).each(function(){
            perCollection[this] = true;
        })
        $("div.top-nav span").css("cursor", "pointer")
        .click(function() {
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
body{ padding:0; margin:0;}
.top-nav{  float:right; text-align:center;}
.left-nav{ float:left; width:200px; height:600px;}
.content{ height:600px; width:800px; float:left; border:1px solid #ccc; border-right:0;}
</style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentBody" runat="server">
    <div class="top" style="height: 100px; width:1000px;">
    <div class="top-nav">
        <asp:Repeater ID="menuList" runat="server">
            <ItemTemplate>
               <span href="<%#((Hashtable)Container.DataItem)["CategoryID"]%>"><%#((Hashtable)Container.DataItem)["Description"]%></span>
            </ItemTemplate>
        </asp:Repeater>
        <p></p>
        <p></p>
        
    </div>
</div>
<div class="left-nav">

</div>
<div class="content">
<iframe scrolling="yes" id="ContentFrame" name="ContentFrame"  frameborder="0" src="about:blank" width="100%" height="100%"></iframe>
</div>
</asp:Content>
