<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/MasterPage/Channel.Master" %>
<%@ Import Namespace="D4D.Platform.Domain" %>
<%@ Import Namespace="System.Collections.Generic" %>
<%@ Import Namespace="System.Linq" %>
<%@ Register Src="~/Control/comment.ascx" TagName="comment" TagPrefix="uc1" %>
<asp:Content ContentPlaceHolderID="ContentHeader" runat="server" ID="ContentHeader">
  <script src="/static/js/jquery.ad-gallery.js" type="text/javascript"></script>
  <style type="text/css">
@import "http://cn.janezhang.com/static/jquery.ad-gallery.css";
.ad-controls p.ad-info {
	text-align: center;
	float: none;
}
.ad-controls .ad-slideshow-controls {
	display: none;
}
</style>
</asp:Content>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentMain" runat="server">
  <div class="right floatleft">
    <div class="cd_right">
      <div class="w_562 h_578">
        <div class="spacer" style="height: 36px"> </div>
        <div class="cd_title pic_title">
          <h1 class="font24 floatleft blue">Photos<span>- <%=CurrentAlbum.Title%></span></h1>
          <div class="floatright alginright">
            <div class="spacer4"> </div>
            <a href="/photo.html">&lt;&lt;Return</a> </div>
        </div>
        <div class="spacer" style="height: 40px"> </div>
        <div class="ad-gallery" id="gallery">
          <div class="ad-image-wrapper"> </div>
          <div class="album_slider" style="padding: 20px;">
            <div class="ad-nav">
              <div class="ad-thumbs">
                <ul class="ad-thumb-list">
                  <%
                                            int startIndex = 0;
                                            for (int i = 0; i < ImageList.Count; i++)
                                            {
                                                D4D.Platform.Domain.Image item = ImageList[i] as D4D.Platform.Domain.Image;
                                                if (ImageId == item.ImageId)
                                                {
                                                    startIndex = i;

                                                }
                 %>
                  <li><a href="<%=item.ImageFile%>"> <img src="<%=item.SImageFile%>" title="<%=HttpUtility.HtmlEncode(item.ImageName)%>"
                                                longdesc="<%=CurrentAlbum.PublishDate.ToLongDateString()%>" class="image<%=i+1 %>"> </a></li>
                  <%} %>
                </ul>
              </div>
            </div>
          </div>
        </div>
        <script type="text/javascript">
        $(document).ready(function() {
            var galleries = $('.ad-gallery').adGallery({ loader_image: "http://cn.janezhang.com/static/images/album/loader.gif",start_at_index:<%=startIndex %>});
        });
    </script>
        <div class="spacer" style="height:35px"></div>
        <div class="video_play_bar">
          <div class="video_play_bar_commend floatright" style="width:50%"> <a href="/photo/c/<%=AlbumId %>.html" class="btn_gray floatleft"><span>Comment This</span></a>
            <div class="vspacer"></div>
            <a href="/photo/c/<%=AlbumId %>.html" class="btn_gray floatleft"><span>Comments（<%=CommentsCount %>）</span></a> </div>
        </div>
        <div class="spacer" style="height:50px"></div>
        <div class="clear"></div>
      </div>
    </div>
  </div>
</asp:Content>
<script runat="server">
    protected int AlbumId
    {
        get
        {
            string queryid = Request.QueryString["albumid"];
            if (string.IsNullOrEmpty(queryid)) return 0;

            int id = 0;

            int.TryParse(queryid, out id);
            return id;
        }
    }
    protected int ImageId
    {
        get
        {
            string queryid = Request.QueryString["id"];
            if (string.IsNullOrEmpty(queryid)) return 0;

            int id = 0;

            int.TryParse(queryid, out id);
            return id;
        }
    }

    protected List<D4D.Platform.Domain.Image> ImageList;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (AlbumId > 0)
        {
            ImageList = D4D.Platform.D4DGateway.AlbumProvider.GetImagesByAlbumId(
               AlbumId, D4D.Platform.Domain.PublishStatus.Publish);
        }

    }
    protected BandInfo Band
    {
        get
        {
            return D4D.Web.Helper.Helper.BandColl[CurrentAlbum.BandId];
        }
    }
    protected Album CurrentAlbum
    {
        get
        {
            return D4D.Platform.D4DGateway.AlbumProvider.GetAlbum(AlbumId);
        }
    }
    private int? count;
    protected int CommentsCount
    {
        get
        {
            if (!count.HasValue)
            {
                int i = 0;
                List<int> list = new List<int>();
                list.Add(AlbumId);
                IDictionary<int, int> idict = D4D.Platform.D4DGateway.CommentProvider.GetComments20(list, ObjectTypeDefine.Album);
                idict.TryGetValue(AlbumId, out i);
                count = i;
            }
            return count.Value;
        }
    }

</script>
