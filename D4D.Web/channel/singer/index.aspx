<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/MasterPage/Channel.Master" %>

<%@ Import Namespace="D4D.Platform.Domain" %>
<asp:Content ContentPlaceHolderID="ContentHeader" runat="server" ID="ContentHeader">
</asp:Content>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentMain" runat="server">
<script type="text/javascript" src="/static/SpryAssets/SpryTabbedPanels.js"></script>
 <div class="main">
    <div class="channel">
      <h1><font color="red">王铮亮</font>/个人档案</h1>
    </div>
    
    <div class="singer">
      <div class="clearfix"><img src="/static/images/pic2.jpg" vspace="20" /></div>
      <div class="content">
        <div id="TabbedPanels1" class="TabbedPanels">
          <ul class="TabbedPanelsTabGroup">
            <li class="TabbedPanelsTab" tabindex="0">档案 </li>
            <li class="TabbedPanelsTab" tabindex="0">历程</li>
            <li class="TabbedPanelsTab" tabindex="0">奖项</li>
            <li class="TabbedPanelsTab" tabindex="0">专辑</li>
          </ul>
          <div class="TabbedPanelsContentGroup">
            <div class="TabbedPanelsContent">
              <p>中文名：王铮亮 <br />
                英文名：Reno Wang<br />
                昵称：小亮 <br />
                籍贯：四川·成都 <br />
                身高：175cm<br />
                体重：67kg<br />
                生日：1977年11月30日 <br />
                生肖：蛇<br />
                血型：O型<br />
                星座：射手座 <br />
                性格：幽默，开朗 <br />
                学历：四川音乐学院手风琴专业 <br />
                特长：唱歌，键盘乐器，CS ，音乐创作 <br />
                座右铭：努力实现音乐梦想 <br />
                最欣赏自己的地方：对音乐的理解、宽容 <br />
                最喜欢的颜色：蓝色 <br />
                最崇拜的人：父母 <br />
                最喜欢的艺人：王力宏 <br />
                艺人最大愿望：开一场大型演唱会 </p>
              <p></p>
            </div>
            <div class="TabbedPanelsContent">1、1998年首次于PUB演出。 <br />
              2、成都市“爱浪杯”歌唱比赛亚军。 <br />
              3、全国大学生“统一冰红茶”歌手大赛成都赛区第一名。 <br />
              4、2004年全国大学生“统一冰红茶”歌手大赛全国总决赛冠军、“京都念慈庵”PUB歌手大赛全国总冠军,但是没有和华纳唱片签约。 <br />
              5、2005年参加湖南卫视大众歌手选拔赛 超级女声,超级女声成都分唱区亚军。 <br />
            6、专辑/单曲:2005年7月25日发表首支单曲“Open up your dream”。</div>
            <div class="TabbedPanelsContent">1995年波罗的海国际手风琴大奖赛（圣彼得堡）青年组第一名 <br />
              2005年全国PUB歌手大赛冠军 <br />
              2007年快乐男声第十名 <br />
              4月10日 王铮亮参加海选 三首歌和三个问题成就的辉煌 <br />
            </div>
            <div class="TabbedPanelsContent">Content 4</div>
          </div>
        </div>
      </div>
    </div>
  </div>
  <script type="text/javascript">
	var TP1 = new Spry.Widget.TabbedPanels("TabbedPanels1");
</script> 
</asp:Content>
