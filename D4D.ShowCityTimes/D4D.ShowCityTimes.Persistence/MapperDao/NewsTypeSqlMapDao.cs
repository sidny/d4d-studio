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
using D4D.ShowCityTimes.Persistence.Interfaces;
using D4D.IbatisNet;

namespace D4D.ShowCityTimes.Persistence.MapperDao
{
    /// <summary>
    /// NewsType数据库持久化处理类
    /// </summary>
    public class NewsTypeSqlMapDao : BaseSqlMapDao, INewsTypeDao
    {
        /// <summary>
        /// 获取news_type列表(不包含父对象,仅返回对象本身)
        /// </summary>
        /// <param name="newstype">news_type</param>
        /// <returns>news_type集合</returns>
        public IList<NewsType> GetBaseNewsType(NewsType newstype)
        {
            return ExecuteQueryForList<NewsType>("GetBaseNewsType", newstype);
        }

        /// <summary>
        /// 获取news_type列表,不包含父对象,仅返回对象本身。
        /// </summary>
        /// <param name="id"></param>
        /// <returns>news_type集合</returns>
        public IList<NewsType> GetBaseNewsTypeById(string id)
        {
            return ExecuteQueryForList<NewsType>("GetBaseNewsTypeById", id);
        }

        /// <summary>
        /// 获取news_type列表(包含父对象)
        /// </summary>
        /// <param name="newstype">news_type</param>
        /// <returns>news_type集合</returns>
        public IList<NewsType> GetNewsType(NewsType newstype)
        {
            return ExecuteQueryForList<NewsType>("GetNewsType", newstype);
        }

        /// <summary>
        /// 获取news_type列表(包含父对象)
        /// </summary>
        /// <param name="id"></param>
        /// <returns>news_type集合</returns>
        public IList<NewsType> GetNewsTypeById(string id)
        {
            return ExecuteQueryForList<NewsType>("GetNewsTypeById", id);
        }

        /// <summary>
        /// 插入NewsType
        /// </summary>
        /// <param name="NewsType">news_type</param>
        public void InsertNewsType(NewsType newstype)
        {
            ExecuteInsert("InsertNewsType", newstype);
            newstype.IdOld = newstype.Id;
        }

        /// <summary>
        /// 更新NewsType
        /// </summary>
        /// <param name="NewsType">news_type</param>
        public int UpdateNewsType(NewsType newstype)
        {
            int i = ExecuteUpdate("UpdateNewsType", newstype);
            newstype.IdOld = newstype.Id;
            return i;
        }

        /// <summary>
        /// 删除news_type
        /// </summary>
        /// <param name="id"></param>
        public int DeleteNewsTypeById(string id)
        {
            return ExecuteDelete("DeleteNewsTypeById", id);
        }
    }
}
