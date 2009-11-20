using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Web;
using D4D.Platform.Domain;
using System.Text.RegularExpressions;

namespace D4D.Platform.Helper.Discuz
{
    public class DiscuzHelper
    {      

        /// <summary>
        /// 返回论坛用户密码cookie明文
        /// </summary>
        /// <param name="key">密钥</param>
        /// <returns></returns>
        public static string GetCookiePassword(string key)
        {
            return DES.Decode(GetCookie("password"), key).Trim();

        }

        /// <summary>
        /// 返回论坛用户密码cookie明文
        /// </summary>
        /// <param name="password">密码密文</param>
        /// <param name="key">密钥</param>
        /// <returns></returns>
        public static string GetCookiePassword(string password, string key)
        {
            return DES.Decode(password, key);

        }

        /// <summary>
        /// 返回密码密文
        /// </summary>
        /// <param name="password">密码明文</param>
        /// <param name="key">密钥</param>
        /// <returns></returns>
        public static string SetCookiePassword(string password, string key)
        {
            //			if (password.Length < 32)
            //			{
            //				password = password.PadRight(32);
            //			}
            return DES.Encode(password, key);
        }

        /// <summary>
        /// 写论坛cookie值
        /// </summary>
        /// <param name="strName">项</param>
        /// <param name="strValue">值</param>
        public static void WriteCookie(string strName, string strValue)
        {
            HttpCookie cookie = HttpContext.Current.Request.Cookies["dnt"];
            if (cookie == null)
            {
                cookie = new HttpCookie("dnt");
                cookie.Values[strName] = Utils.UrlEncode(strValue);
            }
            else
            {

                cookie.Values[strName] = Utils.UrlEncode(strValue);
                if (HttpContext.Current.Request.Cookies["dnt"]["expires"] != null)
                {
                    int expires = Utils.StrToInt(HttpContext.Current.Request.Cookies["dnt"]["expires"].ToString(), 0);
                    if (expires > 0)
                    {
                        cookie.Expires = DateTime.Now.AddMinutes(Utils.StrToInt(HttpContext.Current.Request.Cookies["dnt"]["expires"].ToString(), 0));
                    }
                }
            }

            string cookieDomain = GetCookieDomain() ;
            if (cookieDomain != string.Empty && HttpContext.Current.Request.Url.Host.IndexOf(cookieDomain) > -1 && IsValidDomain(HttpContext.Current.Request.Url.Host))
                cookie.Domain = cookieDomain;

            HttpContext.Current.Response.AppendCookie(cookie);

        }


        /// <summary>
        /// 写cookie值
        /// </summary>
        /// <param name="strName">名称</param>
        /// <param name="intValue">值</param>
        public static void WriteCookie(string strName, int intValue)
        {
            WriteCookie(strName, intValue.ToString());
        }



        /// <summary>
        /// 写论坛登录用户的cookie
        /// </summary>
        /// <param name="uid">用户Id</param>
        /// <param name="expires">cookie有效期</param>
        /// <param name="passwordkey">用户密码Key</param>
        /// <param name="templateid">用户当前要使用的界面风格</param>
        /// <param name="invisible">用户当前的登录模式(正常或隐身)</param>
        public static void WriteUserCookie(int uid, int expires, string passwordkey, int templateid, int invisible)
        {
            DiscuzShortUserInfo userinfo = DiscuzGateway.DiscuzAccountProvider.GetShortUserInfo(uid);
            WriteUserCookie(userinfo, expires, passwordkey, templateid, invisible);
        }

        /// <summary>
        /// 写论坛登录用户的cookie
        /// </summary>
        /// <param name="userinfo">用户信息</param>
        /// <param name="expires">cookie有效期</param>
        /// <param name="passwordkey">用户密码Key</param>
        /// <param name="templateid">用户当前要使用的界面风格</param>
        /// <param name="invisible">用户当前的登录模式(正常或隐身)</param>
        public static void WriteUserCookie(DiscuzShortUserInfo userinfo, 
            int expires, string passwordkey, int templateid, int invisible)
        {
            if (userinfo == null)
            {
                return;
            }
            HttpCookie cookie = new HttpCookie("dnt");
            cookie.Values["userid"] = userinfo.Uid.ToString();
            cookie.Values["password"] = Utils.UrlEncode(SetCookiePassword(userinfo.Password, passwordkey));
            //if (Templates.GetTemplateItem(templateid) == null)
            //{
            //    templateid = 0;

            //    foreach (string strTemplateid in Utils.SplitString(Templates.GetValidTemplateIDList(), ","))
            //    {

            //        if (strTemplateid.Equals(userinfo.Templateid.ToString()))
            //        {
            //            templateid = userinfo.Templateid;
            //            break;
            //        }
            //    }
            //}
            //remark here is avatar use?
            //cookie.Values["avatar"] = Utils.UrlEncode(userinfo.Avatar.ToString());
            cookie.Values["tpp"] = userinfo.Tpp.ToString();
            cookie.Values["ppp"] = userinfo.Ppp.ToString();
            cookie.Values["pmsound"] = userinfo.Pmsound.ToString();
            if (invisible != 0 || invisible != 1)
            {
                invisible = userinfo.Invisible;
            }
            cookie.Values["invisible"] = invisible.ToString();

            cookie.Values["referer"] = "index.aspx";
            cookie.Values["sigstatus"] = userinfo.Sigstatus.ToString();
            cookie.Values["expires"] = expires.ToString();
            if (expires > 0)
            {
                cookie.Expires = DateTime.Now.AddMinutes(expires);
            }
            string cookieDomain = GetCookieDomain(); ;
            if (cookieDomain != string.Empty && 
                HttpContext.Current.Request.Url.Host.IndexOf(cookieDomain) > -1 && 
                IsValidDomain(HttpContext.Current.Request.Url.Host))
            {
                cookie.Domain = cookieDomain;
            }

            HttpContext.Current.Response.AppendCookie(cookie);
            //if (templateid > 0)
            //{
            //    Utils.WriteCookie(Utils.GetTemplateCookieName(), templateid.ToString(), 999999);
            //}
            //SetCookieExpires(expires);
        }

        /// <summary>
        /// 写论坛登录用户的cookie
        /// </summary>
        /// <param name="uid">用户Id</param>
        /// <param name="expires">cookie有效期</param>
        /// <param name="passwordkey">用户密码Key</param>
        public static void WriteUserCookie(int uid, int expires, string passwordkey)
        {
            WriteUserCookie(uid, expires, passwordkey, 0, -1);
        }

        /// <summary>
        /// 写论坛登录用户的cookie
        /// </summary>
        /// <param name="userinfo">用户信息</param>
        /// <param name="expires">cookie有效期</param>
        /// <param name="passwordkey">用户密码Key</param>
        public static void WriteUserCookie(DiscuzShortUserInfo userinfo, int expires, string passwordkey)
        {
            WriteUserCookie(userinfo, expires, passwordkey, 0, -1);
        }

        /// <summary>
        /// 获得论坛cookie值
        /// </summary>
        /// <param name="strName">项</param>
        /// <returns>值</returns>
        public static string GetCookie(string strName)
        {
            if (HttpContext.Current.Request.Cookies != null 
                && HttpContext.Current.Request.Cookies["dnt"] != null 
                && HttpContext.Current.Request.Cookies["dnt"][strName] != null)
            {
                return Utils.UrlDecode(
                    HttpContext.Current.Request.Cookies["dnt"][strName].ToString());
            }

            return "";
        }


        /// <summary>
        /// 清除论坛登录用户的cookie
        /// </summary>
        public static void ClearUserCookie()
        {
            ClearUserCookie("dnt");
        }

        public static void ClearUserCookie(string cookieName)
        {
            HttpCookie cookie = new HttpCookie(cookieName);
            cookie.Values.Clear();
            cookie.Expires = DateTime.Now.AddYears(-1);
            string cookieDomain = GetCookieDomain();
            if (cookieDomain != string.Empty && HttpContext.Current.Request.Url.Host.IndexOf(cookieDomain) > -1
                && IsValidDomain(HttpContext.Current.Request.Url.Host))
                cookie.Domain = cookieDomain;
            HttpContext.Current.Response.AppendCookie(cookie);
        }

        /// <summary>
        /// 是否为有效域
        /// </summary>
        /// <param name="host">域名</param>
        /// <returns></returns>
        public static bool IsValidDomain(string host)
        {
            Regex r = new Regex(@"^\d+$");
            if (host.IndexOf(".") == -1)
            {
                return false;
            }
            return r.IsMatch(host.Replace(".", string.Empty)) ? false : true;
        }

        public static string GetCookieDomain()
        {
            string cookieDomain =
            System.Configuration.ConfigurationManager.AppSettings["CookieDomain"];
            if (string.IsNullOrEmpty(cookieDomain))
                cookieDomain = ".janezhang.com";

            return cookieDomain;

        }

    }
}
