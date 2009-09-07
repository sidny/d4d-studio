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

using D4D.ShowCityTimes.Domain;
using D4D.ShowCityTimes.Persistence.Interfaces;
using D4D.IbatisNet;

namespace D4D.ShowCityTimes.Persistence.MapperDao
{
    /// <summary>
    /// News数据库持久化处理类
    /// </summary>
    public class NewsSqlMapDao : BaseSqlMapDao, INewsDao
    {
        /// <summary>
        /// 获取news列表(不包含父对象,仅返回对象本身)
        /// </summary>
        /// <param name="news">news</param>
        /// <returns>news集合</returns>
        public IList<News> GetBaseNews(News news)
        {
            return ExecuteQueryForList<News>("GetBaseNews", news);
        }

        /// <summary>
        /// 获取news列表,不包含父对象,仅返回对象本身。
        /// </summary>
        /// <param name="id"></param>
        /// <returns>news集合</returns>
        public IList<News> GetBaseNewsById(string id)
        {
            return ExecuteQueryForList<News>("GetBaseNewsById", id);
        }

        /// <summary>
        /// 获取news列表(包含父对象)
        /// </summary>
        /// <param name="news">news</param>
        /// <returns>news集合</returns>
        public IList<News> GetNews(News news)
        {
            return ExecuteQueryForList<News>("GetNews", news);
        }

        /// <summary>
        /// 获取news列表(包含父对象)
        /// </summary>
        /// <param name="id"></param>
        /// <returns>news集合</returns>
        public IList<News> GetNewsById(string id)
        {
            return ExecuteQueryForList<News>("GetNewsById", id);
        }

        /// <summary>
        /// 插入News
        /// </summary>
        /// <param name="News">news</param>
        public void InsertNews(News news)
        {
            ExecuteInsert("InsertNews", news);
            news.IdOld = news.Id;
        }

        /// <summary>
        /// 更新News
        /// </summary>
        /// <param name="News">news</param>
        public int UpdateNews(News news)
        {
            int i = ExecuteUpdate("UpdateNews", news);
            news.IdOld = news.Id;
            return i;
        }

        /// <summary>
        /// 删除news
        /// </summary>
        /// <param name="id"></param>
        public int DeleteNewsById(string id)
        {
            return ExecuteDelete("DeleteNewsById", id);
        }
    }
}
