<%@ Page Language="C#" AutoEventWireup="true"
    MasterPageFile="~/MasterPage/Main.Master" %>
<%@ Import Namespace="D4D.Platform.Domain" %>
<%@ Import Namespace="System.Linq" %>
<%@ Import Namespace="System.Collections.Generic" %>
<asp:Content ContentPlaceHolderID="ContentHeader" runat="server" ID="ContentHeader">
</asp:Content>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentMain" runat="server">
<div class="cd_body">
  <!--right-->
  <div class="right_1100">
  <div class="cd_right_902">
    <div class="w_782 h_578">
      <div class="spacer" style="height:46px"></div>
	  <div class="cd_title_782"></div>
	  <div class="spacer" style="height:40px"></div>
	  <asp:Repeater ID="repMusicTitle" runat="server">
        <HeaderTemplate>
       <ul class="cd_list_01">
        </HeaderTemplate>
        <ItemTemplate>
        <li>
            <span class="cd_img floatleft"><a href="<%#GetUrl(((MusicTitle)Container.DataItem).MusicId,2) %>"><img src="<%#((MusicTitle)Container.DataItem).LImage %>" width="60" height="60" /></a></span>
		    <div class="floatright cd_list_01_text">
		    <h1><%#GetNewImage((MusicTitle)Container.DataItem)%><a href="<%#GetUrl(((MusicTitle)Container.DataItem).MusicId,2) %>">
            <%#((MusicTitle)Container.DataItem).Title %></a></h1>
		    <div class="clear" style="height:4px"></div>
		    <p><%#GetDate(((MusicTitle)Container.DataItem).PublishDate)%></p>
		    <div class="clear" style="height:4px"></div>
		    <div>
                <a href="<%#GetUrl(((MusicTitle)Container.DataItem).MusicId,2) %>" class="btn_play">播放此专辑</a>
                <div class="vspacer"></div>
                <a href="<%#GetAddUrl(((MusicTitle)Container.DataItem).MusicId,1) %>#" class="btn_gray floatleft"><span class="floatleft">JOYO购买</span></a>
                <div class="vspacer"></div>
                <a href="<%#GetAddUrl(((MusicTitle)Container.DataItem).MusicId,2) %>#" class="btn_gray floatleft"><span class="floatleft">当当购买</span></a>			    </div>
            </div>
           </li>
        </ItemTemplate>
        <FooterTemplate>
            </ul>
        </FooterTemplate>
    </asp:Repeater>	  
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
        BindMusicTitleRep();
    }
    protected int BandId
    {
        get
        {
            return D4D.Web.Helper.Helper.BandId;
        }
    }
    protected Dictionary<int,AddInfo> AddInfos;
    private void BindMusicTitleRep()
    {
        D4D.Platform.Domain.PagingContext pager = new D4D.Platform.Domain.PagingContext();
        pager.RecordsPerPage = 1000;
        System.Collections.Generic.List<MusicTitle> list = D4D.Platform.D4DGateway.MusicProvider.GetPagedMusicTitlesByBandId(
            pager, BandId, PublishStatus.Publish);
        repMusicTitle.DataSource = list ;
        List<int> ids = (from i in list
                        select i.MusicId).ToList();
        AddInfos = D4D.Platform.D4DGateway.AddInfoProvider.GetAddInfos20(ids,(int)ObjectTypeDefine.MusicTitle);
        repMusicTitle.DataBind();

    }
    protected string GetUrl(int id, int type)
    {
        switch (type)
        {
            case 1:
                if (IsRewrite)  return string.Format("/music/b{0}.html", id);
                else return string.Format("index.aspx?id=" + id);

            case 2:
                if (IsRewrite) return string.Format("/music/b{0}/song/{1}.html",BandId, id);
                else return string.Format("songs.aspx?id={0}&bandid={1}", id, BandId);
            default:
                return (IsRewrite)? "/music.html":"index.aspx";
        }
        
    }
    protected string GetDate(DateTime date)
    {
		if(date.Year > 2000)
        return date.ToString("yyyy-MM-d");
		else
			return "未发行";
    }
    private static bool IsRewrite
    {
        get
        {
            string key = ConfigurationManager.AppSettings["RewriteUrl"];
            bool result = false;
            bool.TryParse(key, out result);
            return result;
        }
    }
    protected string GetNewImage(MusicTitle m)
    {
        if (DateTime.Now > m.PublishDate.AddDays(7))
            return "";
        else
            return "<img src=\"/static/images/new.gif\" align=\"absmiddle\"> ";
    }
    protected string GetAddUrl(int Id, int Type)
    {
        AddInfo info = new AddInfo();
        AddInfos.TryGetValue(Id, out info);
        if (info == null) return string.Empty;
        else
        {
            if (Type == 1)
                return info.Info1;
            if (Type == 2)
                return info.Info2;
        }
        return string.Empty;
    }
</script>

