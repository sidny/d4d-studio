<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="D4D.Web._Default" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server" id="Header">
    <title></title>
<script type="text/javascript" src="/static/js/jquery-1.3.2.js"></script>
    <script type="text/javascript" src="/static/js/jquery.pagination.js"></script>
</head>
<body>
    <form id="form1" runat="server">
    <div id="list">
    <asp:Repeater ID="ListNews" runat="server">
    <ItemTemplate>
     </ItemTemplate>
    </asp:Repeater>
    </div>
    </form>
    <div id="pager"></div>
<script type="text/javascript">
    $(document).ready(function() {
        
        $("#pager").pagination(
        parseInt("<%=TotalCount %>"),
        { items_per_page: "<%=PageSize %>",
            link_to:location.href.replace(/page=\d+/ig,"page=__id__"),
            callback: function(page) {
                $.get("/svc/news.svc/getnewslist",
                { p: page, size: "<%=PageSize %>",cache:false},
                     function(data) {
                         var str = "";
                         $(data.d).each(function() {
                             str += this.Id + " = " + this.Title + "<br/>";
                         });
                         $("#list").html(str);
                     }
                 ,"json"
                );
            }
        }
    );
    });
</script>
</body>
</html>
