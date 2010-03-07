<%@ Page Language="C#" AutoEventWireup="true"MasterPageFile="~/admin/Admin.Master" ValidateRequest="false" %>
<%@ Import Namespace="D4D.Platform"%>
<%@ Import Namespace="D4D.Platform.Domain" %>
<%@ Import Namespace="LTP.Accounts.Bus"%>
<%@ Register Assembly="FredCK.FCKeditorV2" Namespace="FredCK.FCKeditorV2" TagPrefix="FCKeditorV2" %>
<%@ Register src="../Controls/FileUpload.ascx" tagname="FileUpload" tagprefix="uc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title></title>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentBody" runat="server">
<form id="form1" runat="server">
     <div><h1><asp:Literal ID="litBandName" runat="server"></asp:Literal>
     <asp:Button ID="btnSave" runat="server" Text="保存" OnClick="btnSave_Click" /> <asp:Button ID="Button1" runat="server" Text="首页广告编辑" OnClick="btnGoFlashPage_Click" /></h1>
     </div>
     <asp:Literal ID="litId" runat="server" Visible="false"></asp:Literal>
       <table cellspacing="1" cellpadding="4" rules="all"  align="center" width="100%" class="grid">
         <tr >
            <th align="center" style="width: 30px;">首页活动<a href="CorpTopFlash.aspx" ><font color="red" >直接编辑</font></a></th>
            <td>
                <asp:TextBox ID="txtAd" TextMode="MultiLine" runat="server" Width="100%" 
                    Height="100px"></asp:TextBox>
            </td>
         </tr>
         <tr >
            <th align="center" style="width: 30px;">关于我们</th>
            <td>
               <FCKeditorV2:FCKeditor ID="txtAbout" ToolbarSet="ShowCity"  runat="server" />
            </td>
         </tr>
         <tr >
            <th align="center" style="width: 30px;">联系我们</th>
            <td>
                 <FCKeditorV2:FCKeditor ID="txtContact" ToolbarSet="ShowCity" runat="server" />
            </td>
         </tr>
          <tr >
            <th align="center" style="width: 30px;">少城招聘</th>
            <td>
                 <FCKeditorV2:FCKeditor ID="txtZhaopin" ToolbarSet="ShowCity"  runat="server" />
            </td>
         </tr>
         <tr >
            <th align="center" style="width: 30px;">使用条款</th>
            <td>
               <FCKeditorV2:FCKeditor ID="txtCopyright" ToolbarSet="ShowCity" runat="server" />
            </td>
         </tr>
         <tr >
            <th align="center" style="width: 30px;">友情链接</th>
            <td>
               <FCKeditorV2:FCKeditor ID="txtLinks" ToolbarSet="ShowCity" runat="server" />
            </td>
         </tr>
          <tr >
            <th align="center" style="width: 30px;">广告服务</th>
            <td>
               <FCKeditorV2:FCKeditor ID="txtAdservice" ToolbarSet="ShowCity" runat="server" />
            </td>
         </tr>
         <tr>
            <th align="center" style="width: 30px;">首页FLV</th>
            <td>
               <asp:TextBox ID="txtFlv" runat="server" Width="100%"></asp:TextBox>
            </td>
         </tr>
         <tr>
            <th align="center" style="width: 30px;">首页LOGO</th>
            <td>
               <uc1:FileUpload ID="txtLogo" runat="server" AutoCreateThumbnailImage="false" AutoShowAddWaterMark="false"/>
            </td>
         </tr>
         <tr>
          
       </table>
</form>
</asp:Content>
<script runat="server">
    protected string BandName
    {
        get
        {
            return litBandName.Text;
        }
    }

    public int Id
    {
        get
        {
            int id;
            int.TryParse(litId.Text, out id);
            return id;
        }
    }
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
           litBandName.Text = Request.QueryString["name"];
           litId.Text = Request.QueryString["id"];
            
            //bindList
           txtAd.Text = D4DGateway.CorpInfoProvider.ReadProfileContent("ad");
           txtAbout.Value = D4DGateway.CorpInfoProvider.ReadProfileContent("about");
           txtContact.Value = D4DGateway.CorpInfoProvider.ReadProfileContent("contact");
           txtZhaopin.Value = D4DGateway.CorpInfoProvider.ReadProfileContent("zhaopin");
           txtCopyright.Value = D4DGateway.CorpInfoProvider.ReadProfileContent("copyright");
		   txtLinks.Value = D4DGateway.CorpInfoProvider.ReadProfileContent("links");
           txtAdservice.Value = D4DGateway.CorpInfoProvider.ReadProfileContent("adservice");
           txtFlv.Text = D4DGateway.CorpInfoProvider.ReadProfileContent("flv");
		   txtLogo.UploadResult = D4DGateway.CorpInfoProvider.ReadProfileContent("logo");
        }
    }
    protected void btnGoFlashPage_Click(object sender, EventArgs e)
    {
        Response.Redirect("CorpTopFlash.aspx");
    }
    

    protected void btnSave_Click(object sender, EventArgs e)
    {
        //if (!string.IsNullOrEmpty(txtAd.Text))          
            D4DGateway.CorpInfoProvider.SetProfileContent("ad",txtAd.Text,false);

        //if (!string.IsNullOrEmpty(txtAbout.Value))
            D4DGateway.CorpInfoProvider.SetProfileContent("about", txtAbout.Value, false);

        //if (!string.IsNullOrEmpty(txtContact.Value))
            D4DGateway.CorpInfoProvider.SetProfileContent("contact", txtContact.Value, false);

        //if (!string.IsNullOrEmpty(txtZhaopin.Value))
            D4DGateway.CorpInfoProvider.SetProfileContent("zhaopin", txtZhaopin.Value, false);

       // if (!string.IsNullOrEmpty(txtCopyright.Value))
            D4DGateway.CorpInfoProvider.SetProfileContent("copyright", txtCopyright.Value, false);
		
		//if (!string.IsNullOrEmpty(txtLinks.Value))
            D4DGateway.CorpInfoProvider.SetProfileContent("links", txtLinks.Value, false);
       // if (!string.IsNullOrEmpty(txtAdservice.Value))
            D4DGateway.CorpInfoProvider.SetProfileContent("adservice", txtAdservice.Value, false);

        D4DGateway.CorpInfoProvider.SetProfileContent("flv", txtFlv.Text,false);
		D4DGateway.CorpInfoProvider.SetProfileContent("logo", txtLogo.UploadResult,false);
        Response.Redirect("CorpProfile.aspx");
    }
</script>