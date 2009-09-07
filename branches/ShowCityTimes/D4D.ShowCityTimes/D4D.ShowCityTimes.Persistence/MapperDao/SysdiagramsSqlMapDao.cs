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
using D4D.ShowCityTimes.Persistence.Interfaces;
using D4D.IbatisNet;

namespace D4D.ShowCityTimes.Persistence.MapperDao
{
    /// <summary>
    /// Sysdiagrams数据库持久化处理类
    /// </summary>
    public class SysdiagramsSqlMapDao : BaseSqlMapDao, ISysdiagramsDao
    {
        /// <summary>
        /// 获取sysdiagrams列表(不包含父对象,仅返回对象本身)
        /// </summary>
        /// <param name="sysdiagrams">sysdiagrams</param>
        /// <returns>sysdiagrams集合</returns>
        public IList<Sysdiagrams> GetBaseSysdiagrams(Sysdiagrams sysdiagrams)
        {
            return ExecuteQueryForList<Sysdiagrams>("GetBaseSysdiagrams", sysdiagrams);
        }

        /// <summary>
        /// 获取sysdiagrams列表,不包含父对象,仅返回对象本身。
        /// </summary>
        /// <param name="diagramid"></param>
        /// <returns>sysdiagrams集合</returns>
        public IList<Sysdiagrams> GetBaseSysdiagramsByDiagramId(string diagramid)
        {
            return ExecuteQueryForList<Sysdiagrams>("GetBaseSysdiagramsByDiagramId", diagramid);
        }

        /// <summary>
        /// 获取sysdiagrams列表,不包含父对象,仅返回对象本身。
        /// </summary>
        /// <param name="principalid"></param>
        /// <param name="name"></param>
        /// <returns>sysdiagrams集合</returns>
        public IList<Sysdiagrams> GetBaseSysdiagramsByPrincipalIdName(string principalid, string name)
        {
            Sysdiagrams sysdiagrams = new Sysdiagrams();
            sysdiagrams.PrincipalId = principalid;
            sysdiagrams.Name = name;
            return ExecuteQueryForList<Sysdiagrams>("GetSysdiagramsByPrincipalIdName", sysdiagrams);
        }

        /// <summary>
        /// 获取sysdiagrams列表(包含父对象)
        /// </summary>
        /// <param name="sysdiagrams">sysdiagrams</param>
        /// <returns>sysdiagrams集合</returns>
        public IList<Sysdiagrams> GetSysdiagrams(Sysdiagrams sysdiagrams)
        {
            return ExecuteQueryForList<Sysdiagrams>("GetSysdiagrams", sysdiagrams);
        }

        /// <summary>
        /// 获取sysdiagrams列表(包含父对象)
        /// </summary>
        /// <param name="diagramid"></param>
        /// <returns>sysdiagrams集合</returns>
        public IList<Sysdiagrams> GetSysdiagramsByDiagramId(string diagramid)
        {
            return ExecuteQueryForList<Sysdiagrams>("GetSysdiagramsByDiagramId", diagramid);
        }

        /// <summary>
        /// 获取sysdiagrams列表(包含父对象)
        /// </summary>
        /// <param name="principalid"></param>
        /// <param name="name"></param>
        /// <returns>sysdiagrams集合</returns>
        public IList<Sysdiagrams> GetSysdiagramsByPrincipalIdName(string principalid, string name)
        {
            Sysdiagrams sysdiagrams = new Sysdiagrams();
            sysdiagrams.PrincipalId = principalid;
            sysdiagrams.Name = name;
            return ExecuteQueryForList<Sysdiagrams>("GetSysdiagramsByPrincipalIdName", sysdiagrams);
        }

        /// <summary>
        /// 插入Sysdiagrams
        /// </summary>
        /// <param name="Sysdiagrams">sysdiagrams</param>
        public void InsertSysdiagrams(Sysdiagrams sysdiagrams)
        {
            ExecuteInsert("InsertSysdiagrams", sysdiagrams);
            sysdiagrams.DiagramIdOld = sysdiagrams.DiagramId;
        }

        /// <summary>
        /// 更新Sysdiagrams
        /// </summary>
        /// <param name="Sysdiagrams">sysdiagrams</param>
        public int UpdateSysdiagrams(Sysdiagrams sysdiagrams)
        {
            int i = ExecuteUpdate("UpdateSysdiagrams", sysdiagrams);
            sysdiagrams.DiagramIdOld = sysdiagrams.DiagramId;
            return i;
        }

        /// <summary>
        /// 删除sysdiagrams
        /// </summary>
        /// <param name="diagramid"></param>
        public int DeleteSysdiagramsByDiagramId(string diagramid)
        {
            return ExecuteDelete("DeleteSysdiagramsByDiagramId", diagramid);
        }
        /// <summary>
        /// 删除sysdiagrams
        /// </summary>
        /// <param name="principalid"></param>
        /// <param name="name"></param>
        public int DeleteSysdiagramsByPrincipalIdName(string principalid, string name)
        {
            Sysdiagrams sysdiagrams = new Sysdiagrams();
            sysdiagrams.PrincipalId = principalid;
            sysdiagrams.Name = name;
            return ExecuteDelete("DeleteSysdiagramsByPrincipalIdName", sysdiagrams);
        }
    }
}
