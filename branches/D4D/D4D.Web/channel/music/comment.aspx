<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/MasterPage/Channel.Master" %>
<%@ Import Namespace="D4D.Platform.Domain" %>
<%@ Import Namespace="D4D.Platform" %>
<%@ Import Namespace="System.Collections.Generic" %>
<asp:Content ContentPlaceHolderID="ContentHeader" runat="server" ID="ContentHeader">
</asp:Content>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentMain" runat="server">
<div class="main">
<div class="channel">
  <h1>评论: <a href="/music/b<%=Music.BandId %>/song/<%=Music.MusicId%>.html"><font color="red"><%=Music.Title%></font></a></h1>
</div>

<ul class="comments">
    <%  bool isAdmin = (D4D.Web.Helper.AdminHelper.CurrentUser!=null &&　D4D.Web.Helper.AdminHelper.CurrentUser.UserType.Trim() == ((int)LTP.Accounts.Bus.UserType.Type.Admin).ToString());
        for (int i = 0; i < CommentList.Count; i++)
      {
          Comment item = CommentList[i];%>
	<li>
    	<p>
    	    <font color="red"><%=item.UserName%></font> 发表于<label> <%=item.AddDate.ToString("yyyy-MM-dd HH:mm:ss")%></label>
    	    <%if(isAdmin){ %><del cid="<%=item.CommentId%>">删除</del><%} %>
    	</p>
    	<p><%=HttpUtility.HtmlEncode(item.Body)%></p>
    </li>
    <%} %>
</ul>
<div class="pagestyle" id="pager"></div>
</div>
<%if (isAdmin)
  { %>
<script type="text/javascript">
    $(document).ready(function() {
        $("del").click(function() {
            if (confirm("确认删除？")) {
                var $self = $(this);
                $.getJSON("/svc/comments.svc/Delete",
                        { id: $self.attr("cid") },
                        function(response) {
                            if (response.d > 0) {
                                alert("删除成功");
                                $self.closest("li").remove();
                            } else if (response.d == -1) {
                                alert("请重新登陆");
                            } else {
                                alert("删除失败");
                            }
                        }
                );
            }
        });
    });
</script>
<%} %>
<script type="text/javascript">
    $(document).ready(function() {
        var cur = parseInt("<%=PageIndex %>");
        var total = parseInt("<%=PageTotalCount %>");
        var pageSize = parseInt("<%=PageSize %>");
        var href = location.pathname;
        if (location.search) {
            if (!location.search.match(/page=\d+/ig)) {
                href += location.search + "&page=__id__";
            } else {
                href += location.search;
            }
        } else {
            href += "?page=__id__";
        }
        $("#pager").pagination(
          total,
                {
                    items_per_page: pageSize,
                    num_display_entries: 10,
                    current_page: cur - 1,
                    num_edge_entries: 0,
                    link_to: href.replace(/page=\d+/ig, "page=__id__"),
                    prev_text: "上一页",
                    next_text: "下一页",
                    callback: function(id) {
                        return true;
                    }
                });
    });
</script>
</asp:Content>
<script runat="server">
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            BindComments();
        }

    }
    protected int MusicId
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
    private MusicTitle musicTitle;
    protected MusicTitle Music
    {
        get
        {
            if (musicTitle == null)
            {
                musicTitle = D4D.Platform.D4DGateway.MusicProvider.GetMusicTitle(MusicId);
            }
            return musicTitle;
        }
    }
    protected BandInfo Band
    {
        get
        {
            BandInfo band;
            D4D.Web.Helper.Helper.BandColl.TryGetValue(Music.BandId, out band);
            if (band == null)
            {
                band = new BandInfo()
                {
                    BandId = 0,
                    BandName = "全部"
                };
            }
            return band;
        }
    }
   
    
    protected int PageIndex
    {
        get
        {
            string queryPage = Request.QueryString["page"];
            if (string.IsNullOrEmpty(queryPage)) return 1;

            int page = 1;

            int.TryParse(queryPage, out page);

            if (page == 0) page = 1;

            return page;
        }
    }

    private int totalCount;
    protected int PageTotalCount
    {
        get
        {
            return totalCount;
        }
    }
    protected int PageSize = 10;
    protected List<Comment> CommentList;
    private void BindComments()
    {
        PagingContext pager = new PagingContext();
        pager.RecordsPerPage = PageSize;
        pager.CurrentPageNumber = PageIndex;
        CommentList = D4DGateway.CommentProvider.GetPagedComments(pager, PublishStatus.Publish, MusicId, ObjectTypeDefine.MusicTitle);
        totalCount = pager.TotalRecordCount;
        
    }
</script>