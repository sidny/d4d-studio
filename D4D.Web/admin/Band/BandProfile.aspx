<%@ Page Language="C#" AutoEventWireup="true"MasterPageFile="~/admin/Admin.Master" ValidateRequest="false" %>
<%@ Import Namespace="D4D.Platform"%>
<%@ Import Namespace="D4D.Platform.Domain" %>
<%@ Import Namespace="LTP.Accounts.Bus"%>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>艺人个人档案编辑</title>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentBody" runat="server">
<form id="form1" runat="server">
     <div><h1><asp:Literal ID="litBandName" runat="server"></asp:Literal>
     <asp:Button ID="btnSave" runat="server" Text="保存" OnClick="btnSave_Click" />    <a href="BandInfo.aspx">返回</a></h1>
     </div>
     <asp:Literal ID="litId" runat="server" Visible="false"></asp:Literal>
       <table cellspacing="1" cellpadding="4" rules="all"  align="center" width="100%" class="grid">
         <tr >
            <th align="center" style="width: 30px;">档案</th>
            <td>
                <asp:TextBox ID="txtProfile" TextMode="MultiLine" runat="server" Width="100%" 
                    Height="300px"></asp:TextBox>
            </td>
         </tr>
         <tr >
            <th align="center" style="width: 30px;">历程</th>
            <td>
                <asp:TextBox ID="txtCourse" TextMode="MultiLine" runat="server" Width="100%" 
                    Height="300px"></asp:TextBox>
            </td>
         </tr>
         <tr >
            <th align="center" style="width: 30px;">奖项</th>
            <td>
                <asp:TextBox ID="txtAward" TextMode="MultiLine" runat="server" Width="100%" 
                    Height="300px"></asp:TextBox>
            </td>
         </tr>
          <tr >
            <th align="center" style="width: 30px;">视频</th>
            <td>
                <asp:TextBox ID="txtVideo" TextMode="MultiLine" runat="server" Width="100%" 
                    Height="300px"></asp:TextBox>
            </td>
         </tr>
         <tr >
            <th align="center" style="width: 30px;">其他</th>
            <td>
              专辑、星程、相册自动获取
            </td>
         </tr>
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
           txtProfile.Text = D4DGateway.BandInfoProvider.ReadProfileContent(Id, 0);
           txtCourse.Text = D4DGateway.BandInfoProvider.ReadProfileContent(Id, 1);
           txtAward.Text = D4DGateway.BandInfoProvider.ReadProfileContent(Id, 2);
           txtVideo.Text = D4DGateway.BandInfoProvider.ReadProfileContent(Id, 3);
        }
    }

    protected void btnSave_Click(object sender, EventArgs e)
    {
        if (!string.IsNullOrEmpty(txtProfile.Text))
            D4DGateway.BandInfoProvider.SetProfileContent(Id, 0, txtProfile.Text);
      
        if (!string.IsNullOrEmpty(txtCourse.Text))
            D4DGateway.BandInfoProvider.SetProfileContent(Id, 1, txtCourse.Text);

        if (!string.IsNullOrEmpty(txtAward.Text))
            D4DGateway.BandInfoProvider.SetProfileContent(Id, 2, txtAward.Text);

        if (!string.IsNullOrEmpty(txtVideo.Text))
            D4DGateway.BandInfoProvider.SetProfileContent(Id, 3, txtVideo.Text);

        Response.Redirect("BandInfo.aspx");
    }
</script>