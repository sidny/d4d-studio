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

using D4D.ShowCityTimes.Domain;

namespace D4D.ShowCityTimes.Persistence.Interfaces
{
    /// <summary>
    /// NewsType: news_type的数据库操作接口.
    /// </summary>
    public interface INewsTypeDao
    {
        /// <summary>
        /// 获取news_type列表(不包含父对象,仅返回对象本身)
        /// </summary>
        /// <param name="newstype">news_type</param>
        /// <returns>news_type集合</returns>
        IList<NewsType> GetBaseNewsType(NewsType newstype);

        /// <summary>
        /// 获取news_type列表(不包含父对象,仅返回对象本身)
        /// </summary>
        /// <param name="id"></param>
        /// <returns>news_type集合</returns>
        IList<NewsType> GetBaseNewsTypeById(string id);

        /// <summary>
        /// 获取news_type列表(包含父对象)
        /// </summary>
        /// <param name="newstype">news_type</param>
        /// <returns>news_type集合</returns>
        IList<NewsType> GetNewsType(NewsType newstype);

        /// <summary>
        /// 获取news_type列表(包含父对象)
        /// </summary>
        /// <param name="id"></param>
        /// <returns>news_type集合</returns>
        IList<NewsType> GetNewsTypeById(string id);

        /// <summary>
        /// 插入news_type
        /// </summary>
        /// <param name="newstype">news_type</param>
        void InsertNewsType(NewsType newstype);

        /// <summary>
        /// 更新news_type
        /// </summary>
        /// <param name="newstype">news_type</param>
        int UpdateNewsType(NewsType newstype);

        /// <summary>
        /// 删除news_type
        /// </summary>
        /// <param name="id"></param>
        int DeleteNewsTypeById(string id);

    }
}
