/* =====================================================
    作    者 : YangFan
    创建时间 : 2009-09-07 14:00:07
    修 改 者 : 
    修改时间 : 
    描    述 : sysdiagrams
===================================================== */

using System;
using System.Collections.Generic;
using System.Text;

using D4D.ShowCityTimes.Domain;

namespace D4D.ShowCityTimes.Persistence.Interfaces
{
    /// <summary>
    /// Sysdiagrams: sysdiagrams的数据库操作接口.
    /// </summary>
    public interface ISysdiagramsDao
    {
        /// <summary>
        /// 获取sysdiagrams列表(不包含父对象,仅返回对象本身)
        /// </summary>
        /// <param name="sysdiagrams">sysdiagrams</param>
        /// <returns>sysdiagrams集合</returns>
        IList<Sysdiagrams> GetBaseSysdiagrams(Sysdiagrams sysdiagrams);

        /// <summary>
        /// 获取sysdiagrams列表(不包含父对象,仅返回对象本身)
        /// </summary>
        /// <param name="diagramid"></param>
        /// <returns>sysdiagrams集合</returns>
        IList<Sysdiagrams> GetBaseSysdiagramsByDiagramId(string diagramid);

        /// <summary>
        /// 获取sysdiagrams列表(不包含父对象,仅返回对象本身)
        /// </summary>
        /// <param name="principalid"></param>
        /// <param name="name"></param>
        /// <returns>sysdiagrams集合</returns>
        IList<Sysdiagrams> GetBaseSysdiagramsByPrincipalIdName(string principalid, string name);

        /// <summary>
        /// 获取sysdiagrams列表(包含父对象)
        /// </summary>
        /// <param name="sysdiagrams">sysdiagrams</param>
        /// <returns>sysdiagrams集合</returns>
        IList<Sysdiagrams> GetSysdiagrams(Sysdiagrams sysdiagrams);

        /// <summary>
        /// 获取sysdiagrams列表(包含父对象)
        /// </summary>
        /// <param name="diagramid"></param>
        /// <returns>sysdiagrams集合</returns>
        IList<Sysdiagrams> GetSysdiagramsByDiagramId(string diagramid);

        /// <summary>
        /// 获取sysdiagrams列表(包含父对象)
        /// </summary>
        /// <param name="principalid"></param>
        /// <param name="name"></param>
        /// <returns>sysdiagrams集合</returns>
        IList<Sysdiagrams> GetSysdiagramsByPrincipalIdName(string principalid, string name);

        /// <summary>
        /// 插入sysdiagrams
        /// </summary>
        /// <param name="sysdiagrams">sysdiagrams</param>
        void InsertSysdiagrams(Sysdiagrams sysdiagrams);

        /// <summary>
        /// 更新sysdiagrams
        /// </summary>
        /// <param name="sysdiagrams">sysdiagrams</param>
        int UpdateSysdiagrams(Sysdiagrams sysdiagrams);

        /// <summary>
        /// 删除sysdiagrams
        /// </summary>
        /// <param name="diagramid"></param>
        int DeleteSysdiagramsByDiagramId(string diagramid);

        /// <summary>
        /// 删除sysdiagrams
        /// </summary>
        /// <param name="principalid"></param>
        /// <param name="name"></param>
        int DeleteSysdiagramsByPrincipalIdName(string principalid, string name);

    }
}
