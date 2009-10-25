﻿<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/MasterPage/Main.Master" %>

<%@ Import Namespace="D4D.Platform.Domain" %>
<%@ Import Namespace="System.Collections.Generic" %>
<%@ Import Namespace="System.Linq" %>
<asp:Content ContentPlaceHolderID="ContentHeader" runat="server" ID="ContentHeader">
</asp:Content>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentMain" runat="server">

    <script src="/static/js/jquery.ad-gallery.js" type="text/javascript"></script>

    <style type="text/css">
        @import "/static/jquery.ad-gallery.css";
        .ad-controls p.ad-info{ text-align:center; float:none}
        .ad-controls .ad-slideshow-controls{ display:none;}
    </style>
    <div class="sub-title">
        <p class="title">
            图片</p>
        <p class="nav-link">
            您的位置：首页 > 图片</p>
    </div>
    <div class="album_detail">
        <div class="channel">
            <h1>
                全部照片/<%=Band.BandName%></h1>
            <div class="return">
                <a href="/photo.html" style="color: red">返回图片首页</a></div>
        </div>
        <div class="ad-gallery"  id="gallery">
            <div class="ad-controls">
            </div>
            <div class="ad-image-wrapper">
            </div>
            <div class="ad-controls">
            </div>
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
                            <li><a href="<%=item.ImageFile%>">
                                <img src="<%=item.SImageFile%>" title="<%=item.ImageName%>" longdesc="<%=item.ImageName%>"
                                    class="image<%=i+1 %>">
                            </a></li>
                            <%} %>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
        <div class="comments-area">
            <div class="comments">
                <a href="#">我也要说两句</a> <a href="#">评论（20）</a>
            </div>
            <div class="input-area">
                <textarea></textarea>
                <button>
                    发表</button>
            </div>
        </div>
    </div>

    <script type="text/javascript">
        $(document).ready(function() {
            var galleries = $('.ad-gallery').adGallery({ loader_image: "/static/images/album/loader.gif",start_at_index:<%=startIndex %>});
        });
    </script>

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
    private Album currentAlbum;
    protected Album CurrentAlbum
    {
        get
        {
            if (currentAlbum == null) currentAlbum = D4D.Platform.D4DGateway.AlbumProvider.GetAlbum(AlbumId);
            return currentAlbum;
        }
    }
    

</script>
