/* =====================================================
    作    者 : YangFan
    创建时间 : 2009-09-07 14:00:07
    修 改 者 : 
    修改时间 : 
    描    述 : type_group
===================================================== */

using System;
using System.Collections.Generic;
using System.Text;

using IBatisNet.DataAccess;

using D4D.ShowCityTimes.Persistence.Interfaces;
using D4D.ShowCityTimes.Persistence.MapperDao;
using D4D.ShowCityTimes.Domain;
using D4D.IbatisNet;

namespace D4D.ShowCityTimes.Service
{
    public class TypeGroupService
    {
        #region 私有字段

        private static TypeGroupService _instance = new TypeGroupService();
        private IDaoManager _daoManager = null;
        private ITypeGroupDao _iTypeGroupDao = null;
        private INewsTypeDao _iNewsTypeDao = null;

        #endregion

        #region 构造函数

        private TypeGroupService() 
        {
            _daoManager = ServiceConfig.GetInstance().DaoManager;
            _iTypeGroupDao = _daoManager.GetDao(typeof(ITypeGroupDao)) as ITypeGroupDao;
            _iNewsTypeDao = _daoManager.GetDao(typeof(INewsTypeDao)) as INewsTypeDao;
        }

        #endregion

        #region 公共方法

        public static TypeGroupService GetInstance()
        {
            return _instance;
        }

        /// <summary>
        /// 获取type_group列表(不包含父对象,仅返回对象本身)
        /// </summary>
        /// <param name="typegroup">type_group</param>
        /// <returns>type_group集合</returns>
        public IList<TypeGroup> GetBaseTypeGroup(TypeGroup typegroup)
        {
            return _iTypeGroupDao.GetBaseTypeGroup(typegroup);
        }

        /// <summary>
        /// 获取type_group列表(不包含父对象,仅返回对象本身)
        /// </summary>
        /// <param name="id"></param>
        /// <returns>type_group集合</returns>
        public IList<TypeGroup> GetBaseTypeGroupById(string id)
        {
            return _iTypeGroupDao.GetBaseTypeGroupById(id);
        }

        /// <summary>
        /// 获取type_group列表(包含父对象)
        /// </summary>
        /// <param name="typegroup">type_group</param>
        /// <returns>type_group集合</returns>
        public IList<TypeGroup> GetTypeGroup(TypeGroup typegroup)
        {
            return _iTypeGroupDao.GetTypeGroup(typegroup);
        }

        /// <summary>
        /// 获取type_group列表(包含父对象)
        /// </summary>
        /// <param name="id"></param>
        /// <returns>type_group集合</returns>
        public IList<TypeGroup> GetTypeGroupById(string id)
        {
            return _iTypeGroupDao.GetTypeGroupById(id);
        }

        /// <summary>
        /// 插入type_group
        /// </summary>
        /// <param name="typegroup">type_group</param>
        public void InsertTypeGroup(TypeGroup typegroup)
        {
            try
            {
                _daoManager.BeginTransaction();
                _iTypeGroupDao.InsertTypeGroup(typegroup);
                if (typegroup.NewsType != null)
                {
                    foreach (NewsType newstype in typegroup.NewsType)
                    {
                        _iNewsTypeDao.InsertNewsType(newstype);
                    }
                }
                _daoManager.CommitTransaction();
            }
            catch (Exception ex)
            {
                _daoManager.RollBackTransaction();
                throw ex;
            }
        }

        /// <summary>
        /// 更新type_group
        /// </summary>
        /// <param name="typegroup">type_group</param>
        public int UpdateTypeGroup(TypeGroup typegroup)
        {
            return _iTypeGroupDao.UpdateTypeGroup(typegroup);
        }

        /// <summary>
        /// 删除type_group
        /// </summary>
        /// <param name="id"></param>
        public int DeleteTypeGroupById(string id)
        {
            return _iTypeGroupDao.DeleteTypeGroupById(id);
        }

        #endregion
    }
}
