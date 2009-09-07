/* =====================================================
    作    者 : YangFan
    创建时间 : 2009-09-07 14:00:07
    修 改 者 : 
    修改时间 : 
    描    述 : type_group
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
    /// TypeGroup数据库持久化处理类
    /// </summary>
    public class TypeGroupSqlMapDao : BaseSqlMapDao, ITypeGroupDao
    {
        /// <summary>
        /// 获取type_group列表(不包含父对象,仅返回对象本身)
        /// </summary>
        /// <param name="typegroup">type_group</param>
        /// <returns>type_group集合</returns>
        public IList<TypeGroup> GetBaseTypeGroup(TypeGroup typegroup)
        {
            return ExecuteQueryForList<TypeGroup>("GetBaseTypeGroup", typegroup);
        }

        /// <summary>
        /// 获取type_group列表,不包含父对象,仅返回对象本身。
        /// </summary>
        /// <param name="id"></param>
        /// <returns>type_group集合</returns>
        public IList<TypeGroup> GetBaseTypeGroupById(string id)
        {
            return ExecuteQueryForList<TypeGroup>("GetBaseTypeGroupById", id);
        }

        /// <summary>
        /// 获取type_group列表(包含父对象)
        /// </summary>
        /// <param name="typegroup">type_group</param>
        /// <returns>type_group集合</returns>
        public IList<TypeGroup> GetTypeGroup(TypeGroup typegroup)
        {
            return ExecuteQueryForList<TypeGroup>("GetTypeGroup", typegroup);
        }

        /// <summary>
        /// 获取type_group列表(包含父对象)
        /// </summary>
        /// <param name="id"></param>
        /// <returns>type_group集合</returns>
        public IList<TypeGroup> GetTypeGroupById(string id)
        {
            return ExecuteQueryForList<TypeGroup>("GetTypeGroupById", id);
        }

        /// <summary>
        /// 插入TypeGroup
        /// </summary>
        /// <param name="TypeGroup">type_group</param>
        public void InsertTypeGroup(TypeGroup typegroup)
        {
            ExecuteInsert("InsertTypeGroup", typegroup);
            typegroup.IdOld = typegroup.Id;
        }

        /// <summary>
        /// 更新TypeGroup
        /// </summary>
        /// <param name="TypeGroup">type_group</param>
        public int UpdateTypeGroup(TypeGroup typegroup)
        {
            int i = ExecuteUpdate("UpdateTypeGroup", typegroup);
            typegroup.IdOld = typegroup.Id;
            return i;
        }

        /// <summary>
        /// 删除type_group
        /// </summary>
        /// <param name="id"></param>
        public int DeleteTypeGroupById(string id)
        {
            return ExecuteDelete("DeleteTypeGroupById", id);
        }
    }
}
