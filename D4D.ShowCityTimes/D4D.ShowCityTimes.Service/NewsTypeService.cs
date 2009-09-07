/* =====================================================
    作    者 : YangFan
    创建时间 : 2009-09-07 14:00:07
    修 改 者 : 
    修改时间 : 
    描    述 : news_type
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
    public class NewsTypeService
    {
        #region 私有字段

        private static NewsTypeService _instance = new NewsTypeService();
        private IDaoManager _daoManager = null;
        private INewsTypeDao _iNewsTypeDao = null;
        private INewsDao _iNewsDao = null;

        #endregion

        #region 构造函数

        private NewsTypeService() 
        {
            _daoManager = ServiceConfig.GetInstance().DaoManager;
            _iNewsTypeDao = _daoManager.GetDao(typeof(INewsTypeDao)) as INewsTypeDao;
            _iNewsDao = _daoManager.GetDao(typeof(INewsDao)) as INewsDao;
        }

        #endregion

        #region 公共方法

        public static NewsTypeService GetInstance()
        {
            return _instance;
        }

        /// <summary>
        /// 获取news_type列表(不包含父对象,仅返回对象本身)
        /// </summary>
        /// <param name="newstype">news_type</param>
        /// <returns>news_type集合</returns>
        public IList<NewsType> GetBaseNewsType(NewsType newstype)
        {
            return _iNewsTypeDao.GetBaseNewsType(newstype);
        }

        /// <summary>
        /// 获取news_type列表(不包含父对象,仅返回对象本身)
        /// </summary>
        /// <param name="id"></param>
        /// <returns>news_type集合</returns>
        public IList<NewsType> GetBaseNewsTypeById(string id)
        {
            return _iNewsTypeDao.GetBaseNewsTypeById(id);
        }

        /// <summary>
        /// 获取news_type列表(包含父对象)
        /// </summary>
        /// <param name="newstype">news_type</param>
        /// <returns>news_type集合</returns>
        public IList<NewsType> GetNewsType(NewsType newstype)
        {
            return _iNewsTypeDao.GetNewsType(newstype);
        }

        /// <summary>
        /// 获取news_type列表(包含父对象)
        /// </summary>
        /// <param name="id"></param>
        /// <returns>news_type集合</returns>
        public IList<NewsType> GetNewsTypeById(string id)
        {
            return _iNewsTypeDao.GetNewsTypeById(id);
        }

        /// <summary>
        /// 插入news_type
        /// </summary>
        /// <param name="newstype">news_type</param>
        public void InsertNewsType(NewsType newstype)
        {
            try
            {
                _daoManager.BeginTransaction();
                _iNewsTypeDao.InsertNewsType(newstype);
                if (newstype.News != null)
                {
                    foreach (News news in newstype.News)
                    {
                        _iNewsDao.InsertNews(news);
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
        /// 更新news_type
        /// </summary>
        /// <param name="newstype">news_type</param>
        public int UpdateNewsType(NewsType newstype)
        {
            return _iNewsTypeDao.UpdateNewsType(newstype);
        }

        /// <summary>
        /// 删除news_type
        /// </summary>
        /// <param name="id"></param>
        public int DeleteNewsTypeById(string id)
        {
            return _iNewsTypeDao.DeleteNewsTypeById(id);
        }

        #endregion
    }
}
