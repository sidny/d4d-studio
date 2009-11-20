using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using D4D.Platform.Domain;
using D4D.Platform.Persistence;
using D4D.Platform.Helper.Discuz;
using System.Web;
namespace D4D.Platform.Providers
{
    public class DiscuzAccountProvider
    {
        #region instance
        private static readonly DiscuzAccountProvider instance = new DiscuzAccountProvider();

        internal static DiscuzAccountProvider Instance
        {
            get
            {
                return instance;
            }
        }
        #endregion
        /// <summary>
        /// 创建新用户.
        /// </summary>
        /// <param name="__userinfo">用户信息</param>
        /// <returns>返回用户ID, 如果已存在该用户名或者错误则返回-1</returns>
        public int CreateUser(DiscuzUserInfo userinfo)
        {
            if (userinfo == null) return -1;
            if (string.IsNullOrEmpty(userinfo.Username)) return -1;
            if (ExistsUserName(userinfo.Username)) return -1;

            return DiscuzAccountDao.CreateUser(userinfo);
        }

        public  string GetIP()
        {


            string result = String.Empty;

            result = HttpContext.Current.Request.ServerVariables["HTTP_X_FORWARDED_FOR"];
            if (string.IsNullOrEmpty(result))
            {
                result = HttpContext.Current.Request.ServerVariables["REMOTE_ADDR"];
            }

            if (string.IsNullOrEmpty(result))
            {
                result = HttpContext.Current.Request.UserHostAddress;
            }

            if (string.IsNullOrEmpty(result) || !Utils.IsIP(result))
            {
                return "127.0.0.1";
            }

            return result;

        }

        public int QuickCreateUser(string username, string password, string email)
        {
            DiscuzUserInfo userinfo = new DiscuzUserInfo();

            userinfo.Username = username;
            userinfo.Nickname = string.Empty;// Utils.HtmlEncode(ForumUtils.BanWordFilter(DNTRequest.GetString("nickname")));
            userinfo.Password = Utils.MD5(password);
            userinfo.Secques = string.Empty;// ForumUtils.GetUserSecques(DNTRequest.GetInt("question", 0), DNTRequest.GetString("answer"));
            userinfo.Gender = 0;// DNTRequest.GetInt("gender", 0);
            userinfo.Adminid = 0;
            userinfo.Groupexpiry = 0;
            userinfo.Extgroupids = "";
            userinfo.Regip = GetIP();// DNTRequest.GetIP();
            userinfo.Joindate = DateTime.Now;//Utils.GetDateTime();
            userinfo.Lastip = userinfo.Regip;// DNTRequest.GetIP();
            userinfo.Lastvisit = DateTime.Now;// Utils.GetDateTime();
            userinfo.Lastactivity = DateTime.Now;// Utils.GetDateTime();
            userinfo.Lastpost = DateTime.Now;// Utils.GetDateTime();
            userinfo.Lastpostid = 0;
            userinfo.Lastposttitle = "";
            userinfo.Posts = 0;
            userinfo.Digestposts = 0;
            userinfo.Oltime = 0;
            userinfo.Pageviews = 0;
            userinfo.Credits = 0;
            userinfo.Extcredits1 = 0;// Scoresets.GetScoreSet(1).Init;
            userinfo.Extcredits2 = 0;//Scoresets.GetScoreSet(2).Init;
            userinfo.Extcredits3 = 0;//Scoresets.GetScoreSet(3).Init;
            userinfo.Extcredits4 = 0;//Scoresets.GetScoreSet(4).Init;
            userinfo.Extcredits5 = 0;//Scoresets.GetScoreSet(5).Init;
            userinfo.Extcredits6 = 0;//Scoresets.GetScoreSet(6).Init;
            userinfo.Extcredits7 = 0;//Scoresets.GetScoreSet(7).Init;
            userinfo.Extcredits8 = 0;//Scoresets.GetScoreSet(8).Init;
            userinfo.Avatarshowid = 0;
            userinfo.Email = email;
            userinfo.Bday = string.Empty;// tmpBday;
            userinfo.Sigstatus =1;// DNTRequest.GetInt("sigstatus", 0);

            //if (userinfo.Sigstatus != 0)
            //{
            //    userinfo.Sigstatus = 1;
            //}
            userinfo.Tpp = 0;// DNTRequest.GetInt("tpp", 0);
            userinfo.Ppp = 0;// DNTRequest.GetInt("ppp", 0);
            userinfo.Templateid = 0;// DNTRequest.GetInt("templateid", 0);
            userinfo.Pmsound = 1;// DNTRequest.GetInt("pmsound", 0);
            userinfo.Showemail = 1;// DNTRequest.GetInt("showemail", 0);

            //int receivepmsetting = 1;
            //foreach (string rpms in DNTRequest.GetString("receivesetting").Split(','))
            //{
            //    if (rpms != string.Empty)
            //    {
            //        int tmp = int.Parse(rpms);
            //        receivepmsetting = receivepmsetting | tmp;
            //    }
            //}

            //if (config.Regadvance == 0)
            //{
            //    receivepmsetting = 7;
            //}

            userinfo.Newsletter = 7;// (ReceivePMSettingType)receivepmsetting;
            userinfo.Invisible = 0;// DNTRequest.GetInt("invisible", 0);
            userinfo.Newpm = 1;
            userinfo.Medals = "";
            //if (config.Welcomemsg == 1)
            //{
            //    userinfo.Newpm = 1;
            //}
            userinfo.Accessmasks = 0;// DNTRequest.GetInt("accessmasks", 0);
            userinfo.Website = string.Empty;// Utils.HtmlEncode(DNTRequest.GetString("website"));
            userinfo.Icq = string.Empty;// Utils.HtmlEncode(DNTRequest.GetString("icq"));
            userinfo.Qq = string.Empty;//Utils.HtmlEncode(DNTRequest.GetString("qq"));
            userinfo.Yahoo = string.Empty;//Utils.HtmlEncode(DNTRequest.GetString("yahoo"));
            userinfo.Msn = string.Empty;//Utils.HtmlEncode(DNTRequest.GetString("msn"));
            userinfo.Skype = string.Empty;// Utils.HtmlEncode(DNTRequest.GetString("skype"));
            userinfo.Location = string.Empty;//Utils.HtmlEncode(DNTRequest.GetString("location"));
            //if (usergroupinfo.Allowcstatus == 1)
            //{
            //    userinfo.Customstatus = Utils.HtmlEncode(DNTRequest.GetString("customstatus"));
            //}
            //else
            //{
            //    userinfo.Customstatus = "";
            //}
            userinfo.Customstatus = "";
            userinfo.Avatar = @"avatars\common\0.gif";
            userinfo.Avatarwidth = 0;
            userinfo.Avatarheight = 0;
            userinfo.Bio = string.Empty;//ForumUtils.BanWordFilter(DNTRequest.GetString("bio"));
            userinfo.Signature = string.Empty;//Utils.HtmlEncode(ForumUtils.BanWordFilter(DNTRequest.GetString("signature")));

            //PostpramsInfo postpramsinfo = new PostpramsInfo();
            //postpramsinfo.Usergroupid = usergroupid;
            //postpramsinfo.Attachimgpost = config.Attachimgpost;
            //postpramsinfo.Showattachmentpath = config.Showattachmentpath;
            //postpramsinfo.Hide = 0;
            //postpramsinfo.Price = 0;
            //postpramsinfo.Sdetail = userinfo.Signature;
            //postpramsinfo.Smileyoff = 1;
            //postpramsinfo.Bbcodeoff = 1 - usergroupinfo.Allowsigbbcode;
            //postpramsinfo.Parseurloff = 1;
            //postpramsinfo.Showimages = usergroupinfo.Allowsigimgcode;
            //postpramsinfo.Allowhtml = 0;
            //postpramsinfo.Smiliesinfo = Smilies.GetSmiliesListWithInfo();
            //postpramsinfo.Customeditorbuttoninfo = Editors.GetCustomEditButtonListWithInfo();
            //postpramsinfo.Smiliesmax = config.Smiliesmax;

            userinfo.Sightml = string.Empty;// UBB.UBBToHTML(postpramsinfo);

            //
            userinfo.Authtime = DateTime.Now;// Utils.GetDateTime();

            ////邮箱激活链接验证
            //if (config.Regverify == 1)
            //{
            //    userinfo.Authstr = ForumUtils.CreateAuthStr(20);
            //    userinfo.Authflag = 1;
            //    userinfo.Groupid = 8;
            //    SendEmail(tmpUsername, DNTRequest.GetString("password").Trim(), DNTRequest.GetString("email").Trim(), userinfo.Authstr);
            //}
            ////系统管理员进行后台验证
            //else if (config.Regverify == 2)
            //{
            //    userinfo.Authstr = DNTRequest.GetString("website");
            //    userinfo.Groupid = 8;
            //    userinfo.Authflag = 1;
            //}
            //else
            //{
            //    userinfo.Authstr = "";
            //    userinfo.Authflag = 0;
            //    userinfo.Groupid = UserCredits.GetCreditsUserGroupID(0).Groupid;
            //}
            userinfo.Authstr = "";
            userinfo.Authflag = 0;
            userinfo.Groupid = 10;//default group is 10?//UserCredits.GetCreditsUserGroupID(0).Groupid;
            userinfo.Realname = "";// DNTRequest.GetString("realname");
            userinfo.Idcard = "";// DNTRequest.GetString("idcard");
            userinfo.Mobile = "";// DNTRequest.GetString("mobile");
            userinfo.Phone = "";// DNTRequest.GetString("phone");           

            return CreateUser(userinfo);
        }

        public bool ExistsUserName(string username)
        {
            int uid = GetUserIdByUserName(username);

            return (uid > 0);
        }

        public int GetUserIdByUserName(string username)
        {
            return DiscuzAccountDao.GetUserIdByUserName(username.Trim());
        }

        public DiscuzShortUserInfo GetShortUserInfo(int uid)
        {
            return DiscuzAccountDao.GetShortUserInfo(uid);
        }

        public DiscuzUserInfo GetUserInfo(int uid)
        {
            return DiscuzAccountDao.GetUserInfo(uid);
        }

        public DiscuzPasswordAuthInfo GetPasswordAuthInfo(string username, string password, bool originalpassword)
        {
            return DiscuzAccountDao.GetPasswordAuthInfo(username, password, originalpassword);
        }

        public DiscuzPasswordAuthInfo GetPasswordAuthInfo(int uid, string password, bool originalpassword)
        {
            return DiscuzAccountDao.GetPasswordAuthInfo(uid, password, originalpassword);
        }

        /// <summary>
        /// 判断指定用户密码是否正确.
        /// </summary>
        /// <param name="uid">用户ID</param>
        /// <param name="password">用户密码</param>
        /// <returns>如果用户密码正确则返回true, 否则返回false</returns>
        public  int CheckPassword(int uid, string password, bool originalpassword)
        {
            DiscuzPasswordAuthInfo dai = GetPasswordAuthInfo(uid, password, originalpassword);
            int ruid = -1;
            if (dai != null && dai.Uid > 0)
                ruid = dai.Uid;

            return ruid;
        }

        /// <summary>
        /// 检测密码
        /// </summary>
        /// <param name="uid">用户id</param>
        /// <param name="password">密码</param>
        /// <param name="originalpassword">是否非MD5密码</param>
        /// <param name="groupid">用户组id</param>
        /// <param name="adminid">管理id</param>
        /// <returns>如果用户密码正确则返回uid, 否则返回-1</returns>
        public  int CheckPassword(int uid, string password, bool originalpassword, out int groupid, out int adminid)
        {
            int ruid = -1;
            groupid = 7;
            adminid = 0;
            DiscuzPasswordAuthInfo dai = GetPasswordAuthInfo(uid, password, originalpassword);

            if (dai != null && dai.Uid > 0)
            {
                ruid = dai.Uid;
                groupid = dai.Groupid;
                adminid = dai.Adminid;
            }

            return ruid;
        }


        /// <summary>
        /// 检查密码
        /// </summary>
        /// <param name="username">用户名</param>
        /// <param name="password">密码</param>
        /// <param name="originalpassword">是否非MD5密码</param>
        /// <returns>如果正确则返回用户id, 否则返回-1</returns>
        public int CheckPassword(string username, string password, bool originalpassword)
        {
              DiscuzPasswordAuthInfo dai = GetPasswordAuthInfo(username, password, originalpassword);
              int uid = -1;
              if (dai != null && dai.Uid > 0)
                  uid = dai.Uid;

              return uid;
        }

        public int CheckPassword(string username, string password, bool originalpassword, out int groupid, out int adminid)
        {
            int uid = -1;
            groupid = 7;
            adminid = 0;
            DiscuzPasswordAuthInfo dai = GetPasswordAuthInfo(username, password, originalpassword);

            if (dai!=null && dai.Uid > 0)
            {
                uid = dai.Uid;
                groupid = dai.Groupid;
                adminid = dai.Adminid;
            }

            return uid;

        }
      

    }
}
