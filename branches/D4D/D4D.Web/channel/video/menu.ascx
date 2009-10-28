<%@ Control Language="C#" AutoEventWireup="true" %>
<div class="sub-title">
  <p class="title">视频</p>
  <p class="nav-link">您的位置：首页 > 视频</p>
</div>
<div class="sub-nav">
  <ul>
    <li>》<font color="red">张靓影</font></li>
    <li>》<a href="#">王铮亮</a></li>
  </ul>
</div>
<script  runat="server">
    public string Channel;
    private static Hashtable channelList = new Hashtable();
    
    protected void Page_Load(object sender, EventArgs e)
    {
        
    }    
</script>