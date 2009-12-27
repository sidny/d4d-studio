<%@ Control Language="C#" AutoEventWireup="true" %>
<div id="pager" class="pages_num"></div>
<div id="jumper" style="width:160px; margin: 5px auto;"><div class="floatleft">跳转至 <input size="1" maxlength="2" type="text"/> 页　</div>
<span id="go" style="margin-left:10px;" class="btn_blue floatleft"><span>GO</span></span>
</div>
<script type="text/javascript">
    function getUrlForPager(str) {
        str = str || "__id__";
        var href = location.pathname;
        if (location.search) {
            if (!location.search.match(/page=\d+/ig)) {
                href += location.search + "&page=" + str;
            } else {
                href += location.search.replace(/page=\d+/ig, "page="+str);
            }
        } else {
            href += "?page=" + str;
        }
        return href;
    }
    $(document).ready(function() {
        var cur = parseInt("<%=PageIndex %>");
        var total = parseInt("<%=PageTotalCount %>");
        var pageSize = parseInt("<%=PageSize %>");
        var href = getUrlForPager();
        $("#pager").pagination(
          total,
                {
                    items_per_page: pageSize,
                    num_display_entries: 10,
                    current_page: cur - 1,
                    num_edge_entries: 1,
                    link_to: href,
                    prev_text: "上一页",
                    next_text: "下一页",
                    callback: function(id) {
                        return true;
                    }
                });
				
               	$("#go").click(function() {
                    var page = parseInt($(this).prev().find("input").val());
                    if (page > 0) {
                        location.href = getUrlForPager(page);
                    }
                }).css("cursor","pointer");
    });
</script>
<script runat="server">
    public int PageIndex
    {
        get;
        set;
    }
    public int PageSize
    {
        get;
        set;
    }
    public int PageTotalCount
    {
        get;
        set;
    }
</script>