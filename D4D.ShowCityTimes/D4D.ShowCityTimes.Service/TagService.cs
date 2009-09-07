/* =====================================================
    作    者 : YangFan
    创建时间 : 2009-09-07 14:00:06
    修 改 者 : 
    修改时间 : 
    描    述 : tag
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
    public class TagService
    {
        #region 私有字段

        private static TagService _instance = new TagService();
        private IDaoManager _daoManager = null;
        private ITagDao _iTagDao = null;

        #endregion

        #region 构造函数

        private TagService() 
        {
            _daoManager = ServiceConfig.GetInstance().DaoManager;
            _iTagDao = _daoManager.GetDao(typeof(ITagDao)) as ITagDao;
        }

        #endregion

        #region 公共方法

        public static TagService GetInstance()
        {
            return _instance;
        }

        /// <summary>
        /// 获取tag列表(不包含父对象,仅返回对象本身)
        /// </summary>
        /// <param name="tag">tag</param>
        /// <returns>tag集合</returns>
        public IList<Tag> GetBaseTag(Tag tag)
        {
            return _iTagDao.GetBaseTag(tag);
        }

        /// <summary>
        /// 获取tag列表(不包含父对象,仅返回对象本身)
        /// </summary>
        /// <param name="id"></param>
        /// <returns>tag集合</returns>
        public IList<Tag> GetBaseTagById(string id)
        {
            return _iTagDao.GetBaseTagById(id);
        }

        /// <summary>
        /// 获取tag列表(包含父对象)
        /// </summary>
        /// <param name="tag">tag</param>
        /// <returns>tag集合</returns>
        public IList<Tag> GetTag(Tag tag)
        {
            return _iTagDao.GetTag(tag);
        }

        /// <summary>
        /// 获取tag列表(包含父对象)
        /// </summary>
        /// <param name="id"></param>
        /// <returns>tag集合</returns>
        public IList<Tag> GetTagById(string id)
        {
            return _iTagDao.GetTagById(id);
        }

        /// <summary>
        /// 插入tag
        /// </summary>
        /// <param name="tag">tag</param>
        public void InsertTag(Tag tag)
        {
            try
            {
                _daoManager.BeginTransaction();
                _iTagDao.InsertTag(tag);
                _daoManager.CommitTransaction();
            }
            catch (Exception ex)
            {
                _daoManager.RollBackTransaction();
                throw ex;
            }
        }

        /// <summary>
        /// 更新tag
        /// </summary>
        /// <param name="tag">tag</param>
        public int UpdateTag(Tag tag)
        {
            return _iTagDao.UpdateTag(tag);
        }

        /// <summary>
        /// 删除tag
        /// </summary>
        /// <param name="id"></param>
        public int DeleteTagById(string id)
        {
            return _iTagDao.DeleteTagById(id);
        }

        #endregion
    }
}
