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
	  <div class="cd_title" style="width:782px; background-repeat:repeat"><h1 class="floatleft font24 blue">唱片</h1></div>
	  <div class="spacer" style="height:40px"></div>
       <ul class="cd_list_01">
       <%for(int i = 0;i<musicList.Count;i++){
             MusicTitle item = musicList[i];
             AddInfo info;
             AddInfos.TryGetValue(item.MusicId, out info);
             if (info == null) info = new AddInfo();
             %>
        <li>
            <span class="cd_img floatleft"><a href="<%=GetUrl(item.MusicId,2) %>"><img src="<%=item.LImage %>" width="60" height="60" /></a></span>
		    <div class="floatright cd_list_01_text">
		    <h1><%=GetNewImage(item)%><a href="<%=GetUrl(item.MusicId,2) %>">
            <%=item.Title %></a></h1>
		    <div class="clear" style="height:4px"></div>
		    <p><%=GetDate(item.PublishDate)%></p>
		    <div class="clear" style="height:4px"></div>
		    <div>
                <a href="<%=GetUrl(item.MusicId,2) %>" class="btn_play">播放此专辑</a>
                <%if (!string.IsNullOrEmpty(info.Info1)){ %>
                <div class="vspacer"></div>
                <a href="<%=info.Info1%>" class="btn_gray floatleft"><span class="floatleft">amazon购买</span></a>
                <%}
                    if(!string.IsNullOrEmpty(info.Info2)){
                 %>
                <div class="vspacer"></div>
                <a href="<%=info.Info2%>" class="btn_gray floatleft"><span class="floatleft">当当购买</span></a> <%} %>
            </div>
            </div>
           </li>
           <%} %>
            </ul>
    </div>
	<div class="clear"></div>
	</div>
  </div>
  <!--right/-->
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
    protected List<MusicTitle> musicList;
    private void BindMusicTitleRep()
    {
        D4D.Platform.Domain.PagingContext pager = new D4D.Platform.Domain.PagingContext();
        pager.RecordsPerPage = 1000;
        System.Collections.Generic.List<MusicTitle> list = D4D.Platform.D4DGateway.MusicProvider.GetPagedMusicTitlesByBandId(
            pager, BandId, PublishStatus.Publish);
        musicList = list;
        List<int> ids = (from i in list
                        select i.MusicId).ToList();
        AddInfos = D4D.Platform.D4DGateway.AddInfoProvider.GetAddInfos20(ids,(int)ObjectTypeDefine.MusicTitle);

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

