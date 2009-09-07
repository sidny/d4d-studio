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

using D4D.ShowCityTimes.Domain;

namespace D4D.ShowCityTimes.Persistence.Interfaces
{
    /// <summary>
    /// Tag: tag的数据库操作接口.
    /// </summary>
    public interface ITagDao
    {
        /// <summary>
        /// 获取tag列表(不包含父对象,仅返回对象本身)
        /// </summary>
        /// <param name="tag">tag</param>
        /// <returns>tag集合</returns>
        IList<Tag> GetBaseTag(Tag tag);

        /// <summary>
        /// 获取tag列表(不包含父对象,仅返回对象本身)
        /// </summary>
        /// <param name="id"></param>
        /// <returns>tag集合</returns>
        IList<Tag> GetBaseTagById(string id);

        /// <summary>
        /// 获取tag列表(包含父对象)
        /// </summary>
        /// <param name="tag">tag</param>
        /// <returns>tag集合</returns>
        IList<Tag> GetTag(Tag tag);

        /// <summary>
        /// 获取tag列表(包含父对象)
        /// </summary>
        /// <param name="id"></param>
        /// <returns>tag集合</returns>
        IList<Tag> GetTagById(string id);

        /// <summary>
        /// 插入tag
        /// </summary>
        /// <param name="tag">tag</param>
        void InsertTag(Tag tag);

        /// <summary>
        /// 更新tag
        /// </summary>
        /// <param name="tag">tag</param>
        int UpdateTag(Tag tag);

        /// <summary>
        /// 删除tag
        /// </summary>
        /// <param name="id"></param>
        int DeleteTagById(string id);

    }
}
