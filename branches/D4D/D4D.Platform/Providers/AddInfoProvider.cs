using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using D4D.Platform.Domain;
using D4D.Platform.Persistence;

namespace D4D.Platform.Providers
{
   
    /// <summary>
    ///  附加信息表
    ///  张靓颖唱片信息的joyo和dangdang购买链接
    /// </summary>
    public class AddInfoProvider
    {
        #region instance
        private static readonly AddInfoProvider instance = new AddInfoProvider();

        internal static AddInfoProvider Instance
        {
            get
            {
                return instance;
            }
        }
        #endregion

        public void SetAddInfo(AddInfo info)
        {
            AddInfoDao.SetAddInfo(info);
        }

        public void DeleteAddInfo(int objectId, int objectType)
        {
            AddInfoDao.DeleteAddInfo(objectId, objectType);
        }

        public AddInfo GetAddInfo(int objectId, int objectType)
        {
            return AddInfoDao.GetAddInfo(objectId, objectType);
        }

        public Dictionary<int, AddInfo> GetAddInfos20(List<int> ids, int objectType)
        {
            return AddInfoDao.GetAddInfos20(ids, objectType);
        }

    }
}
