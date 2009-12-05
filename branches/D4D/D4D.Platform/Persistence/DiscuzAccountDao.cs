using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using D4D.Platform.Domain;
using Core.Data;
using D4D.Platform.Helper.Discuz;
namespace D4D.Platform.Persistence
{
    internal static class DiscuzAccountDao
    {
        /*
         *  USE [newbbs]
            GO
            SET ANSI_NULLS ON
            GO
            SET QUOTED_IDENTIFIER ON
            GO

            CREATE PROCEDURE [newbbs].[dnt_getuidbyusername]
            @username nchar(20)
            AS
            SELECT TOP 1 [uid] FROM [dnt_users] WHERE [username]=@username
         */
        internal static int GetUserIdByUserName(string username)
        {
            int uid = -1;
            SafeProcedure.ExecuteAndMapRecords(
                   Database.GetDatabase(D4DDefine.JaneBBSDBInstanceName),
                  "newbbs.dnt_getuidbyusername",
                  delegate(IRecord record)
                  {
                      uid = record.GetInt32OrDefault(0, 0);
                    
                  
                  },
               username);

            return uid;
        }

        internal static int CreateUser(DiscuzUserInfo userinfo)
        {
            int uid = -1;
            object resultId =

                SafeProcedure.ExecuteScalar(Database.GetDatabase(D4DDefine.JaneBBSDBInstanceName),
                    "newbbs.dnt_createuser",
                     delegate(IParameterSet parameters)
                     {
                         parameters.AddWithValue("@username", userinfo.Username);
                         parameters.AddWithValue("@nickname", userinfo.Nickname);
                         parameters.AddWithValue("@password", userinfo.Password);
                         parameters.AddWithValue("@secques", userinfo.Secques);
                         parameters.AddWithValue("@gender", userinfo.Gender);
                         parameters.AddWithValue("@adminid", userinfo.Adminid);
                         parameters.AddWithValue("@groupid", userinfo.Groupid);
                         parameters.AddWithValue("@groupexpiry", userinfo.Groupexpiry);
                         parameters.AddWithValue("@extgroupids", userinfo.Extgroupids);
                         parameters.AddWithValue("@regip", userinfo.Regip);

                         parameters.AddWithValue("@joindate", userinfo.Joindate.ToString("yyyy-MM-dd HH:mm:ss"));
                         parameters.AddWithValue("@lastip", userinfo.Lastip);
                         parameters.AddWithValue("@lastvisit", userinfo.Lastvisit.ToString("yyyy-MM-dd HH:mm:ss"));
                         parameters.AddWithValue("@lastactivity", userinfo.Lastactivity.ToString("yyyy-MM-dd HH:mm:ss"));
                         parameters.AddWithValue("@lastpost", userinfo.Lastpost.ToString("yyyy-MM-dd HH:mm:ss"));
                         parameters.AddWithValue("@lastpostid", userinfo.Lastpostid);
                         parameters.AddWithValue("@lastposttitle", userinfo.Lastposttitle);
                         parameters.AddWithValue("@posts", userinfo.Posts);
                         parameters.AddWithValue("@digestposts", userinfo.Digestposts);
                         parameters.AddWithValue("@oltime", userinfo.Oltime);


                         parameters.AddWithValue("@pageviews", userinfo.Pageviews);
                         parameters.AddWithValue("@credits", userinfo.Credits);
                         parameters.AddWithValue("@extcredits1", userinfo.Extcredits1);
                         parameters.AddWithValue("@extcredits2", userinfo.Extcredits2);
                         parameters.AddWithValue("@extcredits3", userinfo.Extcredits3);
                         parameters.AddWithValue("@extcredits4", userinfo.Extcredits4);
                         parameters.AddWithValue("@extcredits5", userinfo.Extcredits5);
                         parameters.AddWithValue("@extcredits6", userinfo.Extcredits6);
                         parameters.AddWithValue("@extcredits7", userinfo.Extcredits7);
                         parameters.AddWithValue("@extcredits8", userinfo.Extcredits8);

                         parameters.AddWithValue("@avatarshowid", userinfo.Avatarshowid);
                         parameters.AddWithValue("@email", userinfo.Email);
                         parameters.AddWithValue("@bday", userinfo.Bday);
                         parameters.AddWithValue("@tpp", userinfo.Tpp);
                         parameters.AddWithValue("@ppp", userinfo.Ppp);
                         parameters.AddWithValue("@templateid", userinfo.Templateid);
                         parameters.AddWithValue("@pmsound", userinfo.Pmsound);
                         parameters.AddWithValue("@showemail", userinfo.Showemail);
                         parameters.AddWithValue("@newsletter", userinfo.Newsletter);
                         parameters.AddWithValue("@invisible", userinfo.Invisible);

                         parameters.AddWithValue("@newpm", userinfo.Newpm);
                         parameters.AddWithValue("@accessmasks", userinfo.Accessmasks);
                         parameters.AddWithValue("@website", userinfo.Website);
                         parameters.AddWithValue("@icq", userinfo.Icq);
                         parameters.AddWithValue("@qq", userinfo.Qq);
                         parameters.AddWithValue("@yahoo", userinfo.Yahoo);
                         parameters.AddWithValue("@msn", userinfo.Msn);
                         parameters.AddWithValue("@skype", userinfo.Skype);
                         parameters.AddWithValue("@location", userinfo.Location);
                         parameters.AddWithValue("@customstatus", userinfo.Customstatus);

                         parameters.AddWithValue("@avatar", userinfo.Avatar);
                         parameters.AddWithValue("@avatarwidth", userinfo.Avatarwidth);
                         parameters.AddWithValue("@avatarheight", userinfo.Avatarheight);
                         parameters.AddWithValue("@medals", userinfo.Medals);
                         parameters.AddWithValue("@bio", userinfo.Bio);
                         parameters.AddWithValue("@signature", userinfo.Signature);
                         parameters.AddWithValue("@sightml", userinfo.Sightml);
                         parameters.AddWithValue("@authstr", userinfo.Authstr);
                         parameters.AddWithValue("@realname", userinfo.Realname);
                         parameters.AddWithValue("@idcard", userinfo.Idcard);

                         parameters.AddWithValue("@mobile", userinfo.Mobile);
                         parameters.AddWithValue("@phone", userinfo.Phone);

                     });
            if (resultId!=null)
                uid = (int)resultId;
            
            return uid;
        }

        internal static DiscuzPasswordAuthInfo GetPasswordAuthInfo(int uid, string password, bool originalpassword)
        {
            DiscuzPasswordAuthInfo p = new DiscuzPasswordAuthInfo();
            SafeProcedure.ExecuteAndMapRecords(
                     Database.GetDatabase(D4DDefine.JaneBBSDBInstanceName),
                    "newbbs.dnt_checkpasswordbyuid",
                    delegate(IRecord record)
                    {
                        p.Uid = record.GetInt32OrDefault(0, 0);
                        p.Groupid = record.GetInt16OrDefault(1, 0);
                        p.Adminid = record.GetInt32OrDefault(2, 0);
                    },
                    uid,
                    originalpassword ? Utils.MD5(password) : password);

            return p;
        }

        internal static DiscuzPasswordAuthInfo GetPasswordAuthInfo(string username, string password, bool originalpassword)
        {
            DiscuzPasswordAuthInfo p = new DiscuzPasswordAuthInfo();
            SafeProcedure.ExecuteAndMapRecords(
                     Database.GetDatabase(D4DDefine.JaneBBSDBInstanceName),
                    "newbbs.dnt_checkpasswordbyusername",
                    delegate(IRecord record)
                    {
                        p.Uid = record.GetInt32OrDefault(0, 0);
                        p.Groupid = record.GetInt16OrDefault(1, 0);
                        p.Adminid = record.GetInt32OrDefault(2, 0);
                    },
                    username,
                    originalpassword ? Utils.MD5(password) : password);

            return p;
        }

        internal static DiscuzShortUserInfo GetShortUserInfo(int uid)
        {
            DiscuzShortUserInfo m = new DiscuzShortUserInfo();

            if (uid > 0)
            {
                m.Uid = uid;
                SafeProcedure.ExecuteAndMapRecords(
                        Database.GetDatabase(D4DDefine.JaneBBSDBInstanceName),
                     "newbbs.dnt_getshortuserinfo",
                     delegate(IRecord record)
                     {
                         MapShortUserInfo(record, m);
                     },
                     uid);
            }
            return m;
        }

        internal static DiscuzUserInfo GetUserInfo(int uid)
        {
            DiscuzUserInfo m = new DiscuzUserInfo();

            if (uid > 0)
            {
                m.Uid = uid;
                SafeProcedure.ExecuteAndMapRecords(
                        Database.GetDatabase(D4DDefine.JaneBBSDBInstanceName),
                     "newbbs.dnt_getuserinfo",
                     delegate(IRecord record)
                     {
                         MapUserInfo(record, m);
                     },
                     uid);
            }
            return m;
        }

        internal static void MapUserInfo(IRecord record, DiscuzUserInfo userinfo)
        {
            int offset = 0;
            userinfo.Uid = record.GetInt32(offset++);// Int32.Parse(reader["uid"].ToString());
            userinfo.Username = record.GetStringOrEmpty(offset++);// reader["username"].ToString();
            userinfo.Nickname = record.GetStringOrEmpty(offset++);//reader["nickname"].ToString();
            userinfo.Password = record.GetStringOrEmpty(offset++);//reader["password"].ToString();
            userinfo.Secques = record.GetStringOrEmpty(offset++);//reader["secques"].ToString();
            userinfo.Gender = record.GetInt32OrDefault(offset++, 0);// Int32.Parse(reader["gender"].ToString());
            userinfo.Adminid = record.GetInt32OrDefault(offset++, 0);// Int32.Parse(reader["adminid"].ToString());
            userinfo.Groupid = record.GetInt16OrDefault(offset++, 0);// Int16.Parse(reader["groupid"].ToString());
            userinfo.Groupexpiry = record.GetInt32OrDefault(offset++, 0);//  Int32.Parse(reader["groupexpiry"].ToString());
            userinfo.Extgroupids = record.GetStringOrEmpty(offset++);// reader["extgroupids"].ToString();
            userinfo.Regip = record.GetStringOrEmpty(offset++);// reader["regip"].ToString();
            userinfo.Joindate = record.GetDateTimeOrEmpty(offset++);// reader["joindate"].ToString();
            userinfo.Lastip = record.GetStringOrEmpty(offset++);// reader["lastip"].ToString();
            userinfo.Lastvisit = record.GetDateTimeOrEmpty(offset++);//reader["lastvisit"].ToString();
            userinfo.Lastactivity = record.GetDateTimeOrEmpty(offset++);//reader["lastactivity"].ToString();
            userinfo.Lastpost = record.GetDateTimeOrEmpty(offset++);//reader["lastpost"].ToString();
            userinfo.Lastpostid = record.GetInt32OrDefault(offset++, 0);// Int32.Parse(reader["lastpostid"].ToString());
            userinfo.Lastposttitle = record.GetStringOrEmpty(offset++);// reader["lastposttitle"].ToString();
            userinfo.Posts = record.GetInt32OrDefault(offset++, 0);// Int32.Parse(reader["posts"].ToString());
            userinfo.Digestposts = record.GetInt16OrDefault(offset++, 0);//Int16.Parse(reader["digestposts"].ToString());
            userinfo.Oltime = record.GetInt32OrDefault(offset++, 0);// Int32.Parse(reader["oltime"].ToString());
            userinfo.Pageviews = record.GetInt32OrDefault(offset++, 0);// Int32.Parse(reader["pageviews"].ToString());
            userinfo.Credits = record.GetDecimal(offset++); //Int32.Parse(reader["credits"].ToString());
            userinfo.Extcredits1 = record.GetDecimal(offset++);// float.Parse(reader["extcredits1"].ToString());
            userinfo.Extcredits2 = record.GetDecimal(offset++);//float.Parse(reader["extcredits2"].ToString());
            userinfo.Extcredits3 = record.GetDecimal(offset++);//float.Parse(reader["extcredits3"].ToString());
            userinfo.Extcredits4 = record.GetDecimal(offset++);//float.Parse(reader["extcredits4"].ToString());
            userinfo.Extcredits5 = record.GetDecimal(offset++);//float.Parse(reader["extcredits5"].ToString());
            userinfo.Extcredits6 = record.GetDecimal(offset++);//float.Parse(reader["extcredits6"].ToString());
            userinfo.Extcredits7 = record.GetDecimal(offset++);//float.Parse(reader["extcredits7"].ToString());
            userinfo.Extcredits8 = record.GetDecimal(offset++);// float.Parse(reader["extcredits8"].ToString());
            userinfo.Avatarshowid = record.GetInt32OrDefault(offset++, 0); //Int32.Parse(reader["avatarshowid"].ToString());
            userinfo.Email = record.GetStringOrEmpty(offset++);// reader["email"].ToString();
            userinfo.Bday = record.GetStringOrEmpty(offset++);// reader["bday"].ToString();
            userinfo.Sigstatus = record.GetInt32OrDefault(offset++, 0); //Int32.Parse(reader["sigstatus"].ToString());
            userinfo.Tpp = record.GetInt32OrDefault(offset++, 0); //Int32.Parse(reader["tpp"].ToString());
            userinfo.Ppp = record.GetInt32OrDefault(offset++, 0); //Int32.Parse(reader["ppp"].ToString());
            userinfo.Templateid = record.GetInt16OrDefault(offset++, 0); // Int16.Parse(reader["templateid"].ToString());
            userinfo.Pmsound = record.GetInt32OrDefault(offset++, 0); //Int32.Parse(reader["pmsound"].ToString());
            userinfo.Showemail = record.GetInt32OrDefault(offset++, 0); //Int32.Parse(reader["showemail"].ToString());
            userinfo.Invisible = record.GetInt32OrDefault(offset++, 0); // Int32.Parse(reader["invisible"].ToString());      
            userinfo.Newpm = record.GetInt32OrDefault(offset++, 0); //Int32.Parse(reader["newpm"].ToString());
            userinfo.Newpmcount = record.GetInt32OrDefault(offset++, 0); //Int32.Parse(reader["newpmcount"].ToString());
            userinfo.Accessmasks = record.GetInt32OrDefault(offset++, 0); //Int32.Parse(reader["accessmasks"].ToString());
            userinfo.Onlinestate = record.GetInt32OrDefault(offset++, 0); //Int32.Parse(reader["onlinestate"].ToString());
            userinfo.Spaceid = record.GetInt32OrDefault(offset++, 0);// Int32.Parse(reader["spaceid"].ToString());
            userinfo.Newsletter = record.GetInt32OrDefault(offset++, 0); //(ReceivePMSettingType)Int32.Parse(reader["newsletter"].ToString());
            offset++;//fields.userid
            userinfo.Website = record.GetStringOrEmpty(offset++);
            userinfo.Icq = record.GetStringOrEmpty(offset++);
            userinfo.Qq = record.GetStringOrEmpty(offset++);
            userinfo.Yahoo = record.GetStringOrEmpty(offset++);
            userinfo.Msn = record.GetStringOrEmpty(offset++);
            userinfo.Skype = record.GetStringOrEmpty(offset++);
            userinfo.Location = record.GetStringOrEmpty(offset++);
            userinfo.Customstatus = record.GetStringOrEmpty(offset++); 

            userinfo.Avatar = record.GetStringOrEmpty(offset++);
            userinfo.Avatarwidth = record.GetInt32OrDefault(offset++, 0);
            userinfo.Avatarheight = record.GetInt32OrDefault(offset++, 0);

            userinfo.Medals = record.GetStringOrEmpty(offset++);
            userinfo.Authstr = record.GetStringOrEmpty(offset++);
            userinfo.Authtime = record.GetDateTimeOrEmpty(offset++);
            userinfo.Authflag = record.GetByteOrDefault(offset++,0);
            userinfo.Bio = record.GetStringOrEmpty(offset++);
            userinfo.Signature = record.GetStringOrEmpty(offset++);
            userinfo.Sightml = record.GetStringOrEmpty(offset++); 
            userinfo.Realname = record.GetStringOrEmpty(offset++);
            userinfo.Idcard = record.GetStringOrEmpty(offset++);
            userinfo.Mobile = record.GetStringOrEmpty(offset++);
            userinfo.Phone = record.GetStringOrEmpty(offset++);


        
        }

        internal static void MapShortUserInfo(IRecord record, DiscuzShortUserInfo userinfo)
        {
            int offset = 0;
            userinfo.Uid = record.GetInt32(offset++);// Int32.Parse(reader["uid"].ToString());
            userinfo.Username = record.GetStringOrEmpty(offset++);// reader["username"].ToString();
            userinfo.Nickname = record.GetStringOrEmpty(offset++);//reader["nickname"].ToString();
            userinfo.Password = record.GetStringOrEmpty(offset++);//reader["password"].ToString();
            userinfo.Secques = record.GetStringOrEmpty(offset++);//reader["secques"].ToString();
            userinfo.Gender = record.GetInt32OrDefault(offset++, 0);// Int32.Parse(reader["gender"].ToString());
            userinfo.Adminid = record.GetInt32OrDefault(offset++, 0);// Int32.Parse(reader["adminid"].ToString());
            userinfo.Groupid = record.GetInt16OrDefault(offset++, 0);// Int16.Parse(reader["groupid"].ToString());
            userinfo.Groupexpiry = record.GetInt32OrDefault(offset++, 0);//  Int32.Parse(reader["groupexpiry"].ToString());
            userinfo.Extgroupids = record.GetStringOrEmpty(offset++);// reader["extgroupids"].ToString();
            userinfo.Regip = record.GetStringOrEmpty(offset++);// reader["regip"].ToString();
            userinfo.Joindate = record.GetDateTimeOrEmpty(offset++);// reader["joindate"].ToString();
            userinfo.Lastip = record.GetStringOrEmpty(offset++);// reader["lastip"].ToString();
            userinfo.Lastvisit = record.GetDateTimeOrEmpty(offset++);//reader["lastvisit"].ToString();
            userinfo.Lastactivity = record.GetDateTimeOrEmpty(offset++);//reader["lastactivity"].ToString();
            userinfo.Lastpost = record.GetDateTimeOrEmpty(offset++);//reader["lastpost"].ToString();
            userinfo.Lastpostid = record.GetInt32OrDefault(offset++, 0);// Int32.Parse(reader["lastpostid"].ToString());
            userinfo.Lastposttitle = record.GetStringOrEmpty(offset++);// reader["lastposttitle"].ToString();
            userinfo.Posts = record.GetInt32OrDefault(offset++, 0);// Int32.Parse(reader["posts"].ToString());
            userinfo.Digestposts = record.GetInt16OrDefault(offset++, 0);//Int16.Parse(reader["digestposts"].ToString());
            userinfo.Oltime = record.GetInt32OrDefault(offset++, 0);// Int32.Parse(reader["oltime"].ToString());
            userinfo.Pageviews = record.GetInt32OrDefault(offset++, 0);// Int32.Parse(reader["pageviews"].ToString());
            userinfo.Credits = record.GetDecimal(offset++); //Int32.Parse(reader["credits"].ToString());
            userinfo.Extcredits1 = record.GetDecimal(offset++);// float.Parse(reader["extcredits1"].ToString());
            userinfo.Extcredits2 = record.GetDecimal(offset++);//float.Parse(reader["extcredits2"].ToString());
            userinfo.Extcredits3 = record.GetDecimal(offset++);//float.Parse(reader["extcredits3"].ToString());
            userinfo.Extcredits4 = record.GetDecimal(offset++);//float.Parse(reader["extcredits4"].ToString());
            userinfo.Extcredits5 = record.GetDecimal(offset++);//float.Parse(reader["extcredits5"].ToString());
            userinfo.Extcredits6 = record.GetDecimal(offset++);//float.Parse(reader["extcredits6"].ToString());
            userinfo.Extcredits7 = record.GetDecimal(offset++);//float.Parse(reader["extcredits7"].ToString());
            userinfo.Extcredits8 = record.GetDecimal(offset++);// float.Parse(reader["extcredits8"].ToString());
            userinfo.Avatarshowid = record.GetInt32OrDefault(offset++, 0); //Int32.Parse(reader["avatarshowid"].ToString());
            userinfo.Email = record.GetStringOrEmpty(offset++);// reader["email"].ToString();
            userinfo.Bday = record.GetStringOrEmpty(offset++);// reader["bday"].ToString();
            userinfo.Sigstatus = record.GetInt32OrDefault(offset++, 0); //Int32.Parse(reader["sigstatus"].ToString());
            userinfo.Tpp = record.GetInt32OrDefault(offset++, 0); //Int32.Parse(reader["tpp"].ToString());
            userinfo.Ppp = record.GetInt32OrDefault(offset++, 0); //Int32.Parse(reader["ppp"].ToString());
            userinfo.Templateid = record.GetInt16OrDefault(offset++, 0); // Int16.Parse(reader["templateid"].ToString());
            userinfo.Pmsound = record.GetInt32OrDefault(offset++, 0); //Int32.Parse(reader["pmsound"].ToString());
            userinfo.Showemail = record.GetInt32OrDefault(offset++, 0); //Int32.Parse(reader["showemail"].ToString());
            userinfo.Invisible = record.GetInt32OrDefault(offset++, 0); // Int32.Parse(reader["invisible"].ToString());      
            userinfo.Newpm = record.GetInt32OrDefault(offset++, 0); //Int32.Parse(reader["newpm"].ToString());
            userinfo.Newpmcount = record.GetInt32OrDefault(offset++, 0); //Int32.Parse(reader["newpmcount"].ToString());
            userinfo.Accessmasks = record.GetInt32OrDefault(offset++, 0); //Int32.Parse(reader["accessmasks"].ToString());
            userinfo.Onlinestate = record.GetInt32OrDefault(offset++, 0); //Int32.Parse(reader["onlinestate"].ToString());
            userinfo.Spaceid = record.GetInt32OrDefault(offset++, 0);// Int32.Parse(reader["spaceid"].ToString());
            userinfo.Newsletter = record.GetInt32OrDefault(offset++, 0); //(ReceivePMSettingType)Int32.Parse(reader["newsletter"].ToString());
        

            
        }
    }
}
