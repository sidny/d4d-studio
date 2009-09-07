/* =====================================================
    作    者 : YangFan
    创建时间 : 2009-09-07 14:00:07
    修 改 者 : 
    修改时间 : 
    描    述 : news
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
    public class NewsService
    {
        #region 私有字段

        private static NewsService _instance = new NewsService();
        private IDaoManager _daoManager = null;
        private INewsDao _iNewsDao = null;

        #endregion

        #region 构造函数

        private NewsService() 
        {
            _daoManager = ServiceConfig.GetInstance().DaoManager;
            _iNewsDao = _daoManager.GetDao(typeof(INewsDao)) as INewsDao;
        }

        #endregion

        #region 公共方法

        public static NewsService GetInstance()
        {
            return _instance;
        }

        /// <summary>
        /// 获取news列表(不包含父对象,仅返回对象本身)
        /// </summary>
        /// <param name="news">news</param>
        /// <returns>news集合</returns>
        public IList<News> GetBaseNews(News news)
        {
            return _iNewsDao.GetBaseNews(news);
        }

        /// <summary>
        /// 获取news列表(不包含父对象,仅返回对象本身)
        /// </summary>
        /// <param name="id"></param>
        /// <returns>news集合</returns>
        public IList<News> GetBaseNewsById(string id)
        {
            return _iNewsDao.GetBaseNewsById(id);
        }

        /// <summary>
        /// 获取news列表(包含父对象)
        /// </summary>
        /// <param name="news">news</param>
        /// <returns>news集合</returns>
        public IList<News> GetNews(News news)
        {
            return _iNewsDao.GetNews(news);
        }

        /// <summary>
        /// 获取news列表(包含父对象)
        /// </summary>
        /// <param name="id"></param>
        /// <returns>news集合</returns>
        public IList<News> GetNewsById(string id)
        {
            return _iNewsDao.GetNewsById(id);
        }

        /// <summary>
        /// 插入news
        /// </summary>
        /// <param name="news">news</param>
        public void InsertNews(News news)
        {
            try
            {
                _daoManager.BeginTransaction();
                _iNewsDao.InsertNews(news);
                _daoManager.CommitTransaction();
            }
            catch (Exception ex)
            {
                _daoManager.RollBackTransaction();
                throw ex;
            }
        }

        /// <summary>
        /// 更新news
        /// </summary>
        /// <param name="news">news</param>
        public int UpdateNews(News news)
        {
            return _iNewsDao.UpdateNews(news);
        }

        /// <summary>
        /// 删除news
        /// </summary>
        /// <param name="id"></param>
        public int DeleteNewsById(string id)
        {
            return _iNewsDao.DeleteNewsById(id);
        }

        #endregion
    }
}
