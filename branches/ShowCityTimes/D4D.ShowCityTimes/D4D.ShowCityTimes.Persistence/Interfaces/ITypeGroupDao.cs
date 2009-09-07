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

namespace D4D.ShowCityTimes.Persistence.Interfaces
{
    /// <summary>
    /// TypeGroup: type_group的数据库操作接口.
    /// </summary>
    public interface ITypeGroupDao
    {
        /// <summary>
        /// 获取type_group列表(不包含父对象,仅返回对象本身)
        /// </summary>
        /// <param name="typegroup">type_group</param>
        /// <returns>type_group集合</returns>
        IList<TypeGroup> GetBaseTypeGroup(TypeGroup typegroup);

        /// <summary>
        /// 获取type_group列表(不包含父对象,仅返回对象本身)
        /// </summary>
        /// <param name="id"></param>
        /// <returns>type_group集合</returns>
        IList<TypeGroup> GetBaseTypeGroupById(string id);

        /// <summary>
        /// 获取type_group列表(包含父对象)
        /// </summary>
        /// <param name="typegroup">type_group</param>
        /// <returns>type_group集合</returns>
        IList<TypeGroup> GetTypeGroup(TypeGroup typegroup);

        /// <summary>
        /// 获取type_group列表(包含父对象)
        /// </summary>
        /// <param name="id"></param>
        /// <returns>type_group集合</returns>
        IList<TypeGroup> GetTypeGroupById(string id);

        /// <summary>
        /// 插入type_group
        /// </summary>
        /// <param name="typegroup">type_group</param>
        void InsertTypeGroup(TypeGroup typegroup);

        /// <summary>
        /// 更新type_group
        /// </summary>
        /// <param name="typegroup">type_group</param>
        int UpdateTypeGroup(TypeGroup typegroup);

        /// <summary>
        /// 删除type_group
        /// </summary>
        /// <param name="id"></param>
        int DeleteTypeGroupById(string id);

    }
}
