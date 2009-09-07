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
using D4D.ShowCityTimes.Persistence.Interfaces;
using D4D.IbatisNet;

namespace D4D.ShowCityTimes.Persistence.MapperDao
{
    /// <summary>
    /// Tag数据库持久化处理类
    /// </summary>
    public class TagSqlMapDao : BaseSqlMapDao, ITagDao
    {
        /// <summary>
        /// 获取tag列表(不包含父对象,仅返回对象本身)
        /// </summary>
        /// <param name="tag">tag</param>
        /// <returns>tag集合</returns>
        public IList<Tag> GetBaseTag(Tag tag)
        {
            return ExecuteQueryForList<Tag>("GetBaseTag", tag);
        }

        /// <summary>
        /// 获取tag列表,不包含父对象,仅返回对象本身。
        /// </summary>
        /// <param name="id"></param>
        /// <returns>tag集合</returns>
        public IList<Tag> GetBaseTagById(string id)
        {
            return ExecuteQueryForList<Tag>("GetBaseTagById", id);
        }

        /// <summary>
        /// 获取tag列表(包含父对象)
        /// </summary>
        /// <param name="tag">tag</param>
        /// <returns>tag集合</returns>
        public IList<Tag> GetTag(Tag tag)
        {
            return ExecuteQueryForList<Tag>("GetTag", tag);
        }

        /// <summary>
        /// 获取tag列表(包含父对象)
        /// </summary>
        /// <param name="id"></param>
        /// <returns>tag集合</returns>
        public IList<Tag> GetTagById(string id)
        {
            return ExecuteQueryForList<Tag>("GetTagById", id);
        }

        /// <summary>
        /// 插入Tag
        /// </summary>
        /// <param name="Tag">tag</param>
        public void InsertTag(Tag tag)
        {
            ExecuteInsert("InsertTag", tag);
            tag.IdOld = tag.Id;
        }

        /// <summary>
        /// 更新Tag
        /// </summary>
        /// <param name="Tag">tag</param>
        public int UpdateTag(Tag tag)
        {
            int i = ExecuteUpdate("UpdateTag", tag);
            tag.IdOld = tag.Id;
            return i;
        }

        /// <summary>
        /// 删除tag
        /// </summary>
        /// <param name="id"></param>
        public int DeleteTagById(string id)
        {
            return ExecuteDelete("DeleteTagById", id);
        }
    }
}
