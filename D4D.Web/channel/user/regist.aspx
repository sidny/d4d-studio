<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/MasterPage/Main.Master" %>

<%@ Import Namespace="D4D.Platform.Domain" %>
<asp:Content ContentPlaceHolderID="ContentHeader" runat="server" ID="ContentHeader">
</asp:Content>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentMain" runat="server">
<div class="sub-title">
  <p class="title">会员注册</p>
  <p class="nav-link">您的位置：首页 > 会员注册</p>
</div>
<style type="text/css">
	#form1 input.text{ border:1px solid #bababa; width:200px;}
</style>
<div class="clearfix" style="border:1px solid #e5e5e5; width:870px; padding:20px; margin:20px auto;">
    <div style="font-size:24px; font-family:微软雅黑,黑体; color:red; border-bottom:1px solid #e5e5e5; padding-bottom:10px; padding-left:30px;">
        会员注册
    </div>
    <asp:Panel runat="server" ID="regPanel">
    <table width="810" border="0" align="center" cellpadding="0" cellspacing="0">
    <form id="form1" name="form1" method="post">
  <tr>
    <td width="100" height="40" align="right">用户名：</td>
    <td width="704"><input name="username" type="text" id="username" class="text" maxlength="20" size="20"  onblur="checkusername(this.value);" /><span id="checkresult">不超过20个字符</span></td>
  </tr>
  <tr>
    <td height="40" align="right">注册密码：</td>
    <td><input name="password" type="password" class="text" id="password" size="20" onkeyup="return loadinputcontext(this);" /><span>不得少于6个字符</span></td>
  </tr>
  <tr>
    <td height="40" align="right">密码强度：</td>
    <td><strong id="showmsg"></strong></td>
  </tr>
  <tr>
    <td height="40" align="right">再次输入密码：</td>
    <td><input type="password" class="text" name="repass" id="repass"  /><span></span></td>
  </tr>
  <tr>
    <td height="40" align="right">邮箱：   </td>
    <td><input type="text" class="text" name="email" id="email" /></td>
  </tr>
  <tr>
    <td align="right" valign="top">服务条款：</td>
    <td>
      <textarea name="textarea" cols="45" rows="5" disabled="disabled" readonly="readonly" id="textarea"></textarea></td>
  </tr>
  <tr>
    <td height="40" align="right">&nbsp;</td>
    <td>
      <label>
        <input type="checkbox" name="eval" id="checkbox" />
        我已阅读，并同意以上服务条款。</label>
   </td>
  </tr>
  <tr>
    <td height="40" align="right">&nbsp;</td>
    <td><input type="image" src="/static/images/user/reg.jpg"/></td>
  </tr>
   </form>
</table>
<script type="text/javascript">
    $(document).ready(function() {
        window.result = {};
        $("#form1").bind("submit", function() {

        });
        $("#repass").blur(function() {
            if (this.value == $("#password").val()) $(this).next().html("");
            else $(this).next().html("<font color='#009900'>两次输入的密码不相同</font>");
        });
    });
        var PasswordStrength ={
            Level : ["极佳","一般","较弱","太短"],
            LevelValue : [15,10,5,0],//强度值
            Factor : [1,2,5],//字符加数,分别为字母，数字，其它
            KindFactor : [0,0,10,20],//密码含几种组成的加数 
            Regex : [/[a-zA-Z]/g,/\d/g,/[^a-zA-Z0-9]/g] //字符正则数字正则其它正则
            }
        PasswordStrength.StrengthValue = function(pwd)
        {
            var strengthValue = 0;
            var ComposedKind = 0;
            for(var i = 0 ; i < this.Regex.length;i++)
            {
                var chars = pwd.match(this.Regex[i]);
                if(chars != null)
                {
                    strengthValue += chars.length * this.Factor[i];
                    ComposedKind ++;
                }
            }
            strengthValue += this.KindFactor[ComposedKind];
            return strengthValue;
        } 
        PasswordStrength.StrengthLevel = function(pwd)
        {
            var value = this.StrengthValue(pwd);
            for(var i = 0 ; i < this.LevelValue.length ; i ++)
            {
                if(value >= this.LevelValue[i] )
                    return this.Level[i];
            }
        }
		function loadinputcontext(o)
		{
		   var showmsg=PasswordStrength.StrengthLevel(o.value);
		   switch(showmsg)
		   {
			  case "太短": showmsg+=" <img src='/static/images/user/1.gif' width='88' height='11' />";break;
			  case "较弱": showmsg+=" <img src='/static/images/user/2.gif' width='88' height='11' />";break;
			  case "一般": showmsg+=" <img src='/static/images/user/3.gif' width='88' height='11' />";break;
			  case "极佳": showmsg+=" <img src='/static/images/user/4.gif' width='88' height='11' />";break;
		   }
		   document.getElementById('showmsg').innerHTML = showmsg;
	}
	
		function htmlEncode(source, display, tabs)
		{
			function special(source)
			{
				var result = '';
				for (var i = 0; i < source.length; i++)
				{
					var c = source.charAt(i);
					if (c < ' ' || c > '~')
					{
						c = '&#' + c.charCodeAt() + ';';
					}
					result += c;
				}
				return result;
			}
			function format(source)
			{
				// Use only integer part of tabs, and default to 4
				tabs = (tabs >= 0) ? Math.floor(tabs) : 4;
				// split along line breaks
				var lines = source.split(/\r\n|\r|\n/);
				// expand tabs
				for (var i = 0; i < lines.length; i++)
				{
					var line = lines[i];
					var newLine = '';
					for (var p = 0; p < line.length; p++)
					{
						var c = line.charAt(p);
						if (c === '\t')
						{
							var spaces = tabs - (newLine.length % tabs);
							for (var s = 0; s < spaces; s++)
							{
								newLine += ' ';
							}
						}
						else
						{
							newLine += c;
						}
					}
					// If a line starts or ends with a space, it evaporates in html
					// unless it's an nbsp.
					newLine = newLine.replace(/(^ )|( $)/g, '&nbsp;');
					lines[i] = newLine;
				}
				// re-join lines
				var result = lines.join('<br />');
				// break up contiguous blocks of spaces with non-breaking spaces
				result = result.replace(/  /g, ' &nbsp;');
				// tada!
				return result;
			}
			var result = source;
			// ampersands (&)
			result = result.replace(/\&/g,'&amp;');
			// less-thans (<)
			result = result.replace(/\</g,'&lt;');
			// greater-thans (>)
			result = result.replace(/\>/g,'&gt;');
			if (display)
			{
				// format for display
				result = format(result);
			}
			else
			{
				// Replace quotes if it isn't for display,
				// since it's probably going in an html attribute.
				result = result.replace(new RegExp('"','g'), '&quot;');
			}
			// special characters
			result = special(result);
			// tada!
			return result;
		}
		var profile_username_toolong = '对不起，您的用户名超过 20 个字符，请输入一个较短的用户名。';
		var profile_username_tooshort = '对不起，您输入的用户名小于3个字符, 请输入一个较长的用户名。';
		var profile_username_pass = "可用";
		function checkusername(username)
		{
			var unlen = username.replace(/[^\x00-\xff]/g, "**").length;
			if(unlen < 3 || unlen > 20) {
				document.getElementById("checkresult").innerHTML = "<font color='#009900'>" + (unlen < 3 ? profile_username_tooshort : profile_username_toolong) + "</font>";
				return;
			}
			$.getJSON("/svc/user.svc/CheckUserName?username=" + escape(username),function(response){
					showcheckresult(response,username);
				});
		}
		function showcheckresult(obj, username)
		{
			var res =obj.d;
			var resContainer = document.getElementById("checkresult");
			var result = obj.d;
			
			if (result)
			{
				resContainer.innerHTML = "<font color='#009900'>对不起，您输入的用户名 \"" + htmlEncode(username, true, 4) + "\" 已经被他人使用或被禁用，请选择其他名字后再试。</font>";
			}
			else
			{
				resContainer.innerHTML = profile_username_pass;
			}
		}
		function checkSetting()
		{
			if ($('receiveuser').checked)
			{
				$('showhint').disabled = false;
			}
			else
			{			
				$('showhint').checked = false;
				$('showhint').disabled = true;
			}
		}
</script>
</asp:Panel>
<asp:Panel runat="server" ID="sucPanel" Visible="false">
<div id="success" style=" text-align:center; height:100px; line-height:100px;"><img alt="" align="absmiddle" src="/static/images/user/success.jpg" />注册成功，欢迎您，<%=D4D.Web.Helper.AdminHelper.CurrentUser.UserName %></div>
</asp:Panel>
</div>

</asp:Content>
<script runat="server">

    protected void Page_Load(object sender, EventArgs e)
        {
            string username = Request["username"];
            string password = Request["username"];
            string email = Request["username"];
            int userid = 0;
            try
            {
                LTP.Accounts.Bus.User newUser = new LTP.Accounts.Bus.User();
                newUser.UserName = username;
                //newUser.Password=AccountsPrincipal.EncryptPassword(txtPassword.Text);
                newUser.NonEncryptPasswordPassword = password;
                newUser.TrueName = username;
                newUser.Email = email;
                newUser.Sex = "";
                newUser.Phone = "";
                newUser.EmployeeID = 0;
                //newUser.DepartmentID=this.Dropdepart.SelectedValue;
                newUser.Activity = true;
                newUser.UserType = ((int)LTP.Accounts.Bus.UserType.Type.Guest).ToString();
                newUser.Style = 1;
                userid = newUser.Create();
                if (userid > 0)
                {
                    sucPanel.Visible = true;
                    regPanel.Visible = false;
                    LTP.Accounts.Bus.User currentUser = new LTP.Accounts.Bus.User(userid);
                    HttpContext.Current.Session["UserInfo"] = currentUser;
                    HttpContext.Current.Session["Style"] = currentUser.Style;
                }
            }
            catch (Exception ex)
            {
                log4net.LogManager.GetLogger("d4d").Error(ex);
            }
        }    
</script>