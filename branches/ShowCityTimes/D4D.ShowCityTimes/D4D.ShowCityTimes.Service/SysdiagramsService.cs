/* =====================================================
    作    者 : YangFan
    创建时间 : 2009-09-07 14:00:07
    修 改 者 : 
    修改时间 : 
    描    述 : sysdiagrams
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
    public class SysdiagramsService
    {
        #region 私有字段

        private static SysdiagramsService _instance = new SysdiagramsService();
        private IDaoManager _daoManager = null;
        private ISysdiagramsDao _iSysdiagramsDao = null;

        #endregion

        #region 构造函数

        private SysdiagramsService() 
        {
            _daoManager = ServiceConfig.GetInstance().DaoManager;
            _iSysdiagramsDao = _daoManager.GetDao(typeof(ISysdiagramsDao)) as ISysdiagramsDao;
        }

        #endregion

        #region 公共方法

        public static SysdiagramsService GetInstance()
        {
            return _instance;
        }

        /// <summary>
        /// 获取sysdiagrams列表(不包含父对象,仅返回对象本身)
        /// </summary>
        /// <param name="sysdiagrams">sysdiagrams</param>
        /// <returns>sysdiagrams集合</returns>
        public IList<Sysdiagrams> GetBaseSysdiagrams(Sysdiagrams sysdiagrams)
        {
            return _iSysdiagramsDao.GetBaseSysdiagrams(sysdiagrams);
        }

        /// <summary>
        /// 获取sysdiagrams列表(不包含父对象,仅返回对象本身)
        /// </summary>
        /// <param name="diagramid"></param>
        /// <returns>sysdiagrams集合</returns>
        public IList<Sysdiagrams> GetBaseSysdiagramsByDiagramId(string diagramid)
        {
            return _iSysdiagramsDao.GetBaseSysdiagramsByDiagramId(diagramid);
        }

        /// <summary>
        /// 获取sysdiagrams列表(不包含父对象,仅返回对象本身)
        /// </summary>
        /// <param name="principalid"></param>
        /// <param name="name"></param>
        /// <returns>sysdiagrams集合</returns>
        public IList<Sysdiagrams> GetBaseSysdiagramsByPrincipalIdName(string principalid, string name)
        {
            return _iSysdiagramsDao.GetBaseSysdiagramsByPrincipalIdName(principalid, name);
        }

        /// <summary>
        /// 获取sysdiagrams列表(包含父对象)
        /// </summary>
        /// <param name="sysdiagrams">sysdiagrams</param>
        /// <returns>sysdiagrams集合</returns>
        public IList<Sysdiagrams> GetSysdiagrams(Sysdiagrams sysdiagrams)
        {
            return _iSysdiagramsDao.GetSysdiagrams(sysdiagrams);
        }

        /// <summary>
        /// 获取sysdiagrams列表(包含父对象)
        /// </summary>
        /// <param name="diagramid"></param>
        /// <returns>sysdiagrams集合</returns>
        public IList<Sysdiagrams> GetSysdiagramsByDiagramId(string diagramid)
        {
            return _iSysdiagramsDao.GetSysdiagramsByDiagramId(diagramid);
        }

        /// <summary>
        /// 获取sysdiagrams列表(包含父对象)
        /// </summary>
        /// <param name="principalid"></param>
        /// <param name="name"></param>
        /// <returns>sysdiagrams集合</returns>
        public IList<Sysdiagrams> GetSysdiagramsByPrincipalIdName(string principalid, string name)
        {
            return _iSysdiagramsDao.GetSysdiagramsByPrincipalIdName(principalid, name);
        }

        /// <summary>
        /// 插入sysdiagrams
        /// </summary>
        /// <param name="sysdiagrams">sysdiagrams</param>
        public void InsertSysdiagrams(Sysdiagrams sysdiagrams)
        {
            try
            {
                _daoManager.BeginTransaction();
                _iSysdiagramsDao.InsertSysdiagrams(sysdiagrams);
                _daoManager.CommitTransaction();
            }
            catch (Exception ex)
            {
                _daoManager.RollBackTransaction();
                throw ex;
            }
        }

        /// <summary>
        /// 更新sysdiagrams
        /// </summary>
        /// <param name="sysdiagrams">sysdiagrams</param>
        public int UpdateSysdiagrams(Sysdiagrams sysdiagrams)
        {
            return _iSysdiagramsDao.UpdateSysdiagrams(sysdiagrams);
        }

        /// <summary>
        /// 删除sysdiagrams
        /// </summary>
        /// <param name="diagramid"></param>
        public int DeleteSysdiagramsByDiagramId(string diagramid)
        {
            return _iSysdiagramsDao.DeleteSysdiagramsByDiagramId(diagramid);
        }

        /// <summary>
        /// 删除sysdiagrams
        /// </summary>
        /// <param name="principalid"></param>
        /// <param name="name"></param>
        public int DeleteSysdiagramsByPrincipalIdName(string principalid, string name)
        {
            return _iSysdiagramsDao.DeleteSysdiagramsByPrincipalIdName(principalid, name);
        }

        #endregion
    }
}
