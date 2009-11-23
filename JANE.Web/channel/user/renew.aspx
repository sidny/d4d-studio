<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/MasterPage/Main.Master" %>

<%@ Import Namespace="D4D.Platform.Domain" %>
<asp:Content ContentPlaceHolderID="ContentHeader" runat="server" ID="ContentHeader">
</asp:Content>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentMain" runat="server">
    <div class="sub-title">
  <p class="title">找回密码</p>
  <p class="nav-link">您的位置：首页 > 找回密码</p>
</div>
<style type="text/css">
	#form1 input.text{ border:1px solid #bababa; width:200px;}
</style>
<div class="clearfix" style="border:1px solid #e5e5e5; width:870px; padding:20px; margin:20px auto;">
    <div style="font-size:24px; font-family:微软雅黑,黑体; color:red; border-bottom:1px solid #e5e5e5; padding-bottom:10px; padding-left:30px; margin-bottom:10px;">
        找回密码
    </div>
    <asp:Panel runat="server" ID="regPanel"><form id="form1" name="form1" method="post">
    <table width="810" border="0" align="center" cellpadding="0" cellspacing="0">
    <tr>
    <td height="40" colspan="2">
        第一步，请输入您在本站注册的用户名和邮箱</td>
  </tr>
    <tr>
    <td width="100" height="40" align="right">用户名：</td>
    <td width="704"><input name="username" type="text" id="username" class="text" maxlength="20" size="20"  />  <asp:Label runat="server" ID="msg"></asp:Label></td>
  </tr>
  <tr>
    <td height="40" align="right">邮箱：   </td>
    <td><input type="text" class="text" name="email" id="email" /></td>
  </tr>
  <tr>
    <td height="40" align="right">&nbsp;</td>
    <td><input type="image" src="/static/images/user/next.gif"/></td>
  </tr>
  
</table> </form>
<script type="text/javascript">
    $(document).ready(function() {
        $("#form1").submit(function() {
            if ($("#username", this).val() == "") {
                alert("请输入用户名");
                return false;
            }
            if ($("#email", this).val() == "") {
                alert("请输入邮箱");
                return false;
            }
        });
    });

</script>
</asp:Panel>

<asp:Panel runat="server" ID="messagePanel" Visible="false">
<div id="Div1" style=" text-align:center; padding:100px 0;  font-size:18px; font-family:'微软雅黑','黑体'; color:#666;"><img alt="" align="absmiddle" src="/static/images/user/success.jpg" /> 密码更新成功，请<a href="#"><font color="red">重新登录</font></a></div>
<script type="text/javascript">
    $(document).ready(function() {
        $("#Div1 a").click(function() {
            $("#btnLogin").click();
        });
    });
</script>
</asp:Panel>
<asp:Panel runat="server" ID="nextPanel" Visible="false">
<form id="form2" name="form1" method="post">
    
    <input type="hidden" name="flag" value="changePass" />
    <input type="hidden" name="username" value="<%=Request["username"] %>" />
    <table width="810" border="0" align="center" cellpadding="0" cellspacing="0">
    <tr>
    <td height="40" colspan="2">
        第二步，请重新设置您的密码</td>
  </tr>
    <tr>
    <td width="100" height="40" align="right">重置密码：</td>
    <td width="704"><input name="password" type="password" id="password" class="text" maxlength="20" size="20"  />  <asp:Label runat="server" ID="Label1"></asp:Label></td>
  </tr>
  <tr>
    <td height="40" align="right">密码确认：</td>
    <td><input type="password" class="text" name="repass" id="repass" /></td>
  </tr>
  <tr>
    <td height="40" align="right">&nbsp;</td>
    <td><input type="image" src="/static/images/user/next.gif"/></td>
  </tr>
  
</table> </form>
<script type="text/javascript">
    $(document).ready(function() {
        $("#form2").submit(function() {
            if ($("#password", this).val().length < 6) {
                alert("请正确输入密码，长度不小于6位");
                return false;
            }
            if ($("#repass", this).val() != $("#password", this).val()) {
                alert("两次输入的密码不相同");
                return false;
            }
        });
    });

</script></asp:Panel>
</div>

</asp:Content>
<script runat="server">

    protected void Page_Load(object sender, EventArgs e)
        {
            msg.Style.Add("color", "red");
            string username = Request["username"];
            string email = Request["email"];
            string flag = Request["flag"];
            if (flag != "changePass")
            {
                if (!String.IsNullOrEmpty(username) && !String.IsNullOrEmpty(email))
                {
                    LTP.Accounts.Bus.User newUser = new LTP.Accounts.Bus.User(username);
                    if (newUser == null)
                    {
                        msg.Text = "没有这个用户";

                    }
                    else if (newUser.Email.Trim() != email)
                    {
                        msg.Text = "用户名与邮箱不匹配";
                    }
                    else
                    {
                        nextPanel.Visible = true;
                        regPanel.Visible = false;

                    }

                }
            }
            else
            {
                string password = Request["password"];
                if (!string.IsNullOrEmpty(password))
                {
                    LTP.Accounts.Bus.User newUser = new LTP.Accounts.Bus.User();
                    newUser.SetPassword(username, password);
                    nextPanel.Visible = false;
                    regPanel.Visible = false;
                    messagePanel.Visible = true;
                }
            }
        }    
</script>