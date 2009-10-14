using System;
using System.Configuration;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.IO;
using D4D.Platform.Domain;
using D4D.Platform.Persistence;
namespace D4D.Platform.Providers
{
    public class UserProvider
    {
        #region instance
        private static readonly UserProvider instance = new UserProvider();

        internal static UserProvider Instance
        {
            get
            {
                return instance;
            }
        }
        #endregion

        #region UserLogin
        public void SetUserLogin(UserLogin u)
        {
            UserDao.SetUserLogin(u);
        }

        public void DeleteUserLogin(int userId)
        {
            UserDao.DeleteUserLogin(userId);
        }

        public UserLogin GetUserLoginFromEmail(string email)
        {
            return UserDao.GetUserLoginFromEmail(email);
        }

        #endregion 

        #region BandInfo
        public int  SetBandInfo(BandInfo info)
        {
            return UserDao.SetBandInfo(info);
        }

        public List<BandInfo> GetAllBandInfos(int minIndex)
        {
            return UserDao.GetAllBandInfos(minIndex);
        }

        //艺人profile保存为文件
        public void SetBandProfile(int bandId,int profileType, string content)
        {
            if (string.IsNullOrEmpty(content)) return;

            string path = GetBandProfilePath(bandId,profileType);
            
            // Create a file to write to.
            using (StreamWriter sw = File.CreateText(path))
            {
                sw.Write(content);
            }    

        }

        public string GetBandProfileContent(int bandId, int profileType)
        {
            string path = GetBandProfilePath(bandId, profileType);

            if (!File.Exists(path)) return string.Empty;

            return File.ReadAllText(path);

        }

        private string GetBandProfilePath(int bandId, int profileType)
        {
            string configProfilePath = ConfigurationSettings.AppSettings["ProfilePath"];

            if (string.IsNullOrEmpty(configProfilePath))
                configProfilePath = D4DDefine.DEFAULT_PROFILEPATH;

            return string.Format("{0}bandprofile_{1}_{2}.txt", configProfilePath, bandId, profileType);
        }
        #endregion
    }
}
