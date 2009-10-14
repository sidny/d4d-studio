using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
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
        #endregion
    }
}
