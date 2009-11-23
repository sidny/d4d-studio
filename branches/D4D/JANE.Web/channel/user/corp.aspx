<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/MasterPage/Main.Master" %>

<%@ Import Namespace="D4D.Platform.Domain" %>
<asp:Content ContentPlaceHolderID="ContentHeader" runat="server" ID="ContentHeader">
</asp:Content>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentMain" runat="server">
<div class="sub-title">
  <p class="title"><%=Channel %></p>
  <p class="nav-link">您的位置：首页 > <%=Channel %></p>
</div>
<div class="clearfix" style=" width:680px; padding:20px; margin:20px auto; line-height:20px;">
       <asp:Label runat="server" ID="text"></asp:Label>
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
                    Channel = "少城招聘";
                    break;
                case "copyright":
                    Channel = "使用条款";
                    break;
				case "links":
                    Channel = "友情链接";
                    break;
                case "about":
                default:
                    page = "about";
                    Channel = "关于我们";
                    break;
                
            }
            
           text.Text = D4D.Platform.D4DGateway.CorpInfoProvider.ReadProfileContent(page);
          
        }    
</script>