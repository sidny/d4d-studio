using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using D4D.Platform.Domain;
using Core.Data;
namespace D4D.Platform.Persistence
{
    internal static class AddInfoDao
    {
        internal static void SetAddInfo(AddInfo info)
        {
            if (info == null) return;

            SafeProcedure.ExecuteNonQuery(
             Database.GetDatabase(D4DDefine.DBInstanceName),
             "dbo.Add_infos_Set",
             info.ObjectId, info.ObjectType,
             info.Info1,info.Info2,
             info.Info3, info.Info4);
        }

        internal static void DeleteAddInfo(int objectId, int objectType)
        {

            SafeProcedure.ExecuteNonQuery(
             Database.GetDatabase(D4DDefine.DBInstanceName),
             "dbo.Add_infos_Delete",
            objectType, objectId );
        }

        internal static AddInfo GetAddInfo(int objectId, int objectType)
        {
            AddInfo info = new AddInfo();

            SafeProcedure.ExecuteAndMapRecords(
                    Database.GetDatabase(D4DDefine.DBInstanceName),
                 "dbo.Add_infos_Get",
                 delegate(IRecord record)
                 {
                  
                     info.ObjectId = record.GetInt32OrDefault(0, 0);
                     info.ObjectType =record.GetInt32OrDefault(1, 0);
                     info.Info1 = record.GetStringOrEmpty(2);
                     info.Info2 = record.GetStringOrEmpty(3);
                     info.Info3 = record.GetStringOrEmpty(4);
                     info.Info4 = record.GetStringOrEmpty(5);
                 },
                 objectId, objectType);

            return info;
        }

        internal static Dictionary<int, AddInfo> GetAddInfos20(List<int> ids, int objectType)
        {

            Dictionary<int, AddInfo> dic = new Dictionary<int, AddInfo>();

            if (ids != null && ids.Count > 0)
            {
                SafeProcedure.ExecuteAndMapRecords(Database.GetDatabase(D4DDefine.DBInstanceName),
               "dbo.Add_infos_GetTags20",
               delegate(IParameterSet parameters)
               {
                   parameters.AddWithValue("@objecttype", objectType);
                   int maxCount = ids.Count > 20 ? 20 : ids.Count;
                   for (int i = 0; i < maxCount; i++)
                   {
                       parameters.AddWithValue("@tid" + (i + 1).ToString(), ids[i]);
                   }
               },
               delegate(IRecord record)
               {
                   AddInfo info = new AddInfo();
                   info.ObjectId = record.GetInt32OrDefault(0, 0);
                   info.ObjectType = record.GetInt32OrDefault(1, 0);
                   info.Info1 = record.GetStringOrEmpty(2);
                   info.Info2 = record.GetStringOrEmpty(3);
                   info.Info3 = record.GetStringOrEmpty(4);
                   info.Info4 = record.GetStringOrEmpty(5);
                   if (!dic.ContainsKey(info.ObjectId))
                       dic.Add(info.ObjectId, info);
               }
           );
            }

            return dic;
        }
    }
}
