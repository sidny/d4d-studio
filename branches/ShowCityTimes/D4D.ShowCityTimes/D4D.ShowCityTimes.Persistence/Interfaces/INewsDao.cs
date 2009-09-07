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

namespace D4D.ShowCityTimes.Persistence.Interfaces
{
    /// <summary>
    /// News: news的数据库操作接口.
    /// </summary>
    public interface INewsDao
    {
        /// <summary>
        /// 获取news列表(不包含父对象,仅返回对象本身)
        /// </summary>
        /// <param name="news">news</param>
        /// <returns>news集合</returns>
        IList<News> GetBaseNews(News news);

        /// <summary>
        /// 获取news列表(不包含父对象,仅返回对象本身)
        /// </summary>
        /// <param name="id"></param>
        /// <returns>news集合</returns>
        IList<News> GetBaseNewsById(string id);

        /// <summary>
        /// 获取news列表(包含父对象)
        /// </summary>
        /// <param name="news">news</param>
        /// <returns>news集合</returns>
        IList<News> GetNews(News news);

        /// <summary>
        /// 获取news列表(包含父对象)
        /// </summary>
        /// <param name="id"></param>
        /// <returns>news集合</returns>
        IList<News> GetNewsById(string id);

        /// <summary>
        /// 插入news
        /// </summary>
        /// <param name="news">news</param>
        void InsertNews(News news);

        /// <summary>
        /// 更新news
        /// </summary>
        /// <param name="news">news</param>
        int UpdateNews(News news);

        /// <summary>
        /// 删除news
        /// </summary>
        /// <param name="id"></param>
        int DeleteNewsById(string id);

    }
}
