using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using D4D.Platform.Domain;
using Core.Data;
namespace D4D.Platform.Persistence
{
    internal static class BandInfoDao
    {

        #region BandInfo
        internal static int SetBandInfo(BandInfo info)
        {
            if (info == null) return -1;

            SafeProcedure.ExecuteNonQuery(
             Database.GetDatabase(D4DDefine.DBInstanceName),
             "dbo.BandInfo_Set",
             delegate(IParameterSet parameters)
             {
                 parameters.AddWithValue("@BandId", info.BandId);
                 parameters.AddWithValue("@BandName", info.BandName);
                 parameters.AddWithValue("@Info1", info.Info1);
                 parameters.AddWithValue("@Info2", info.Info2);
                 parameters.AddWithValue("@Info3", info.Info3);
                 parameters.AddWithValue("@Remark", info.Remark);
                 parameters.AddWithValue("@DeleteFlag", info.DeleteFlag);             
                 parameters.AddWithValue("@RetVal", DBNull.Value, ParameterDirectionWrap.ReturnValue);

             },
             delegate(IParameterSet outputParameters)
             {
                 info.BandId = Convert.ToInt32(outputParameters.GetValue("@RetVal"));
             });

            return info.BandId;
        }

        internal static void MapImageList(IRecord record, List<BandInfo> list)
        {
            BandInfo m = new BandInfo();

            m.BandId = record.GetInt32OrDefault(0, 0);
            m.BandName = record.GetStringOrEmpty(1);
            m.Info1 = record.GetStringOrEmpty(2);
            m.Info2 = record.GetStringOrEmpty(3);
            m.Info3 = record.GetStringOrEmpty(4);
            m.Remark = record.GetStringOrEmpty(5);           

            list.Add(m);
        }
        internal static List<BandInfo> GetAllBandInfo(int minIndex)
        {
            List<BandInfo> list = new List<BandInfo>();
        
                SafeProcedure.ExecuteAndMapRecords(
                        Database.GetDatabase(D4DDefine.DBInstanceName),
                     "dbo.BandInfo_GetAll",
                     delegate(IRecord record)
                     {
                         MapImageList(record, list);
                     },
                     minIndex);
            
            return list;
        }        
        #endregion
    }
}
