using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using D4D.Platform.Domain;
using Core.Data;
namespace D4D.Platform.Persistence
{
    internal static class SpamKeywordDao
    {

      
       
        internal static int SetSpamKeyword(SpamKeyword keyword)
        {
            if (keyword == null) return -1;

            SafeProcedure.ExecuteNonQuery(
             Database.GetDatabase(D4DDefine.DBInstanceName),
             "dbo.SpamKeywords_Set",
             delegate(IParameterSet parameters)
             {
                 parameters.AddWithValue("@Id", keyword.Id);
                 parameters.AddWithValue("@Keyword", keyword.Keyword);
                 parameters.AddWithValue("@Status", keyword.Status);
                 parameters.AddWithValue("@AddUserId", keyword.AddUserID);
                 parameters.AddWithValue("@RetVal", DBNull.Value, ParameterDirectionWrap.ReturnValue);

             },
             delegate(IParameterSet outputParameters)
             {
                 keyword.Id = Convert.ToInt32(outputParameters.GetValue("@RetVal"));
             });

            return keyword.Id;
        }
      
        internal static void DeleteKeyword(int id)
        {
            if (id > 0)
            {
                SafeProcedure.ExecuteNonQuery(
             Database.GetDatabase(D4DDefine.DBInstanceName),
             "dbo.SpamKeywords_Delete",
             id);
            }
        }
     
        /// <summary>
        /// 获取tag的top列表
        /// </summary>
        /// <param name="maxCount"></param>
        /// <returns></returns>
        internal static List<SpamKeyword> GetAllSpamKeywords()
        {
            List<SpamKeyword> list = new List<SpamKeyword>();

            SafeProcedure.ExecuteAndMapRecords(
                        Database.GetDatabase(D4DDefine.DBInstanceName),
                     "dbo.SpamKeywords_GetAll",
                     delegate(IRecord record)
                     {
                         MapList(record, list);
                     },null);

            return list;
        }

        internal static void MapList(IRecord record, List<SpamKeyword> list)
        {
            SpamKeyword m = new SpamKeyword();
            m.Id = record.GetInt32OrDefault(0, 0);
            m.Keyword = record.GetStringOrEmpty(1);
            m.Status = record.GetInt32OrDefault(2, 0);
            m.AddUserID = record.GetInt32OrDefault(3, 0);
            m.AddDate = record.GetDateTime(4);  
            list.Add(m);
        }
    }
}
