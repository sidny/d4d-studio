<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/admin/Admin.Master" ValidateRequest="false"%>
<%@ Import Namespace="D4D.Platform"%>
<%@ Import Namespace="D4D.Platform.Domain" %>
<%@ Import Namespace="LTP.Accounts.Bus"%>
<%@ Register Src="../Controls/FileUpload.ascx" TagName="FileUpload" TagPrefix="uc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>首页Flash广告</title>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentBody" runat="server">
<form id="form1" runat="server">
      <div><h1><asp:Button ID="btnSave" runat="server" Text="保存返回" OnClick="btnSave_Click" /> <asp:Button ID="btnBack" runat="server" Text="返回" OnClick="btnBack_Click" />
      </h1>
     </div>
      <table cellspacing="1" cellpadding="4" rules="all"  align="center" width="100%" class="grid">
      <!-- 1 -->
         <tr >
            <th align="center" style="width: 40px;">链接1</th>
            <td>
             <asp:TextBox ID="txtAd1" runat="server" Width="500px"  ></asp:TextBox>
             </td>
         </tr>
         <tr >
            <th align="center" style="width: 40px;">标题1</th>
            <td>
             <asp:TextBox ID="txtPicAlt1" runat="server" Width="500px"  ></asp:TextBox>
             </td>
         </tr>
          <tr >
             <th align="center" style="width: 40px;">图片1</th>
            <td>           
              <uc1:FileUpload ID="txtAdPic1" runat="server" AutoCreateThumbnailImage="false" AutoShowAddWaterMark="false"/>
            </td>
         </tr>
         <tr>
            <th colspan="2" style="width: 100%;"></th>
         </tr>
         <!-- 2 -->
          <tr >
             <th align="center" style="width: 40px;">链接2</th>
            <td>
             <asp:TextBox ID="txtAd2" runat="server" Width="500px"  ></asp:TextBox>
             </td>
         </tr>
         <tr >
            <th align="center" style="width: 40px;">标题2</th>
            <td>
             <asp:TextBox ID="txtPicAlt2" runat="server" Width="500px"  ></asp:TextBox>
             </td>
         </tr>
          <tr >
             <th align="center" style="width: 40px;">图片2</th>
            <td>           
              <uc1:FileUpload ID="txtAdPic2" runat="server" AutoCreateThumbnailImage="false" AutoShowAddWaterMark="false"/>
            </td>
         </tr>
          <tr>
            <th colspan="2" style="width: 100%;"></th>
         </tr>
           <!--3 -->
          <tr >
             <th align="center" style="width: 40px;">链接3</th>
            <td>
             <asp:TextBox ID="txtAd3" runat="server" Width="500px"  ></asp:TextBox>
             </td>
         </tr>
          <tr >
            <th align="center" style="width: 40px;">标题3</th>
            <td>
             <asp:TextBox ID="txtPicAlt3" runat="server" Width="500px"  ></asp:TextBox>
             </td>
         </tr>
          <tr >
             <th align="center" style="width: 40px;">图片3</th>
            <td>           
              <uc1:FileUpload ID="txtAdPic3" runat="server" AutoCreateThumbnailImage="false" AutoShowAddWaterMark="false"/>
            </td>
         </tr>
          <tr>
            <th colspan="2" style="width: 100%;"></th>
         </tr>
          <!--4-->
          <tr >
             <th align="center" style="width: 40px;">链接4</th>
            <td>
             <asp:TextBox ID="txtAd4" runat="server" Width="500px"  ></asp:TextBox>
             </td>
         </tr>
          <tr >
            <th align="center" style="width: 40px;">标题4</th>
            <td>
             <asp:TextBox ID="txtPicAlt4" runat="server" Width="500px"  ></asp:TextBox>
             </td>
         </tr>
          <tr >
             <th align="center" style="width: 40px;">图片4</th>
            <td>           
              <uc1:FileUpload ID="txtAdPic4" runat="server" AutoCreateThumbnailImage="false" AutoShowAddWaterMark="false"/>
            </td>
         </tr>
          <tr>
            <th colspan="2" style="width: 100%;"></th>
         </tr>
          <!--5-->
          <tr >
             <th align="center" style="width: 40px;">链接5</th>
            <td>
             <asp:TextBox ID="txtAd5" runat="server" Width="500px"  ></asp:TextBox>
             </td>
         </tr>
           <tr >
            <th align="center" style="width: 40px;">标题5</th>
            <td>
             <asp:TextBox ID="txtPicAlt5" runat="server" Width="500px"  ></asp:TextBox>
             </td>
         </tr>
          <tr >
             <th align="center" style="width: 40px;">图片5</th>
            <td>           
              <uc1:FileUpload ID="txtAdPic5" runat="server" AutoCreateThumbnailImage="false" AutoShowAddWaterMark="false"/>
            </td>
         </tr>
        
       </table>
</form>
</asp:Content>
<script runat="server">
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            string adString = D4DGateway.CorpInfoProvider.ReadProfileContent("ad");
            /*
            if (string.IsNullOrEmpty(adString))//for text
             adString="<li><a href=\"/news/d/43.html\"><img src=\"/static/images/ad/qianyuehuanqiu.jpg\" alt=\"签约环球\" /></a></li>"+
"<li><a href=\"/music/b0/song/11.html\"><img src=\"/static/images/ad/manman.jpg\" alt=\"王铮亮-《满满》\" /></a></li>"+
"<li><a href=\"/photo/album/4.html\"><img src=\"/static/images/ad/chengdu.jpg\" alt=\"2009成都演唱会\" /></a></li>"+
"<li><a href=\"/news/d/7.html\"><img src=\"/static/images/ad/myspace.jpg\" alt=\"入驻聚友网\" /></a></li>";
           */
            if (!string.IsNullOrEmpty(adString))
            {
                //adString = adString.ToLower().Replace("</li>",string.Empty);
                //Setcontent

                string[] liS =
                    adString.Split(new string[1] { "</a>" }, 
                    StringSplitOptions.RemoveEmptyEntries);
                if (liS != null && liS.Length > 0)
                {
                    Regex regExHref = new Regex("href=\"([^\"]*)\"");
                    Regex regExSrc = new Regex("src=\"([^\"]*)\"");
                    Regex regExAlt = new Regex("alt=\"([^\"]*)\"");
                    Match match;
                    int liCount = 1;
                    foreach (string li in liS)
                    {
                        if (liCount > 5) break;
                        match = regExHref.Match(li);
                        if (match.Success)
                        {
                            TextBox txtAd = this.Form.FindControl("txtAd" + liCount.ToString()) as TextBox;
                            if (txtAd!=null&&match.Groups.Count>1)
                                txtAd.Text = match.Groups[1].Value;
                               
                        }
                        match = regExSrc.Match(li);
                        if (match.Success)
                        {
                            D4D.Web.admin.Controls.FileUpload txtAdPic = this.Form.FindControl("txtAdPic" + liCount.ToString()) as  D4D.Web.admin.Controls.FileUpload;
                            if (txtAdPic != null && match.Groups.Count > 1)
                            {
                                txtAdPic.UploadResult = match.Groups[1].Value;
                            }
                        }
                        match = regExAlt.Match(li);
                        if (match.Success)
                        {
                            TextBox txtPicAlt = this.Form.FindControl("txtPicAlt" + liCount.ToString()) as TextBox;
                            if (txtPicAlt != null && match.Groups.Count > 1)
                                txtPicAlt.Text = match.Groups[1].Value;
                        }
                        liCount++;
                    }
                }
                
            }
        }
    }
   // private const string LiFormat = "<li><a href=\"{0}\"><img src=\"{1}\" alt=\"{2}\" /></a></li>";
    private const string LiFormat = "<a href=\"{0}\" target=\"_blank\"><img src=\"{1}\" alt=\"{2}\"  /><br/> {2}</a>";
    protected void btnSave_Click(object sender, EventArgs e)
    {
        StringBuilder sb = new StringBuilder(2048);

        for (int i = 1; i < 6; i++)
        {
            TextBox txtAd = this.Form.FindControl("txtAd" + i.ToString()) as TextBox;
            if (txtAd != null && !string.IsNullOrEmpty(txtAd.Text))
            {
                D4D.Web.admin.Controls.FileUpload txtAdPic = this.Form.FindControl("txtAdPic" + i.ToString()) as D4D.Web.admin.Controls.FileUpload;
                if (txtAdPic != null && !string.IsNullOrEmpty(txtAdPic.UploadResult))
                {

                    TextBox txtPicAlt = this.Form.FindControl("txtPicAlt" + i.ToString()) as TextBox;
                    if (txtPicAlt != null && !string.IsNullOrEmpty(txtPicAlt.Text))
                    {
                        string picUrl = txtAdPic.UploadResult.ToLower();
                        if (!picUrl.Contains("http://cn.janezhang.com/"))
                        {
                            picUrl = "http://cn.janezhang.com" + picUrl;
                        }
                        sb.AppendFormat(LiFormat, txtAd.Text, picUrl, txtPicAlt.Text);
                        sb.AppendLine();
                    }
                }
            }                                                     
        }
        if (sb.Length > 0)
        {
            D4DGateway.CorpInfoProvider.SetProfileContent("ad", sb.ToString());
            btnBack_Click(null, null);
        }
    }
    protected void btnBack_Click(object sender, EventArgs e)
    {
        Response.Redirect("CorpProfile.aspx");
    }
            
</script>