using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using D4D.Platform.Domain;
using Core.Data;
namespace D4D.Platform.Persistence
{
    internal static class UserDao
    {
        #region UserLogin
        internal static void SetUserLogin(UserLogin u)
        {
            if (u == null) return;
            SafeProcedure.ExecuteNonQuery(
                        Database.GetDatabase(D4DDefine.DBInstanceName),
                        "dbo.UserLogin_Set",
                        u.UserId, 
                        u.UserName,
                       u.Password,
                       u.Email);
        }

        internal static void DeleteUserLogin(int userId)
        {
            if (userId > 0)
            {
                SafeProcedure.ExecuteNonQuery(
             Database.GetDatabase(D4DDefine.DBInstanceName),
             "dbo.UserLogin_Delete",
             userId);
            }
        }

        internal static UserLogin GetUserLoginFromEmail(string email)
        {
            UserLogin u = new UserLogin();
            if (!string.IsNullOrEmpty(email))
            {
                SafeProcedure.ExecuteAndMapRecords(
                        Database.GetDatabase(D4DDefine.DBInstanceName),
                     "dbo.UserLogin_GetFromEmail",
                     delegate(IRecord record)
                     {
                         u.UserId = record.GetInt32OrDefault(0,0);
                         u.UserName = record.GetStringOrEmpty(1);
                         u.Password = record.GetStringOrEmpty(2);
                         u.Email = record.GetStringOrEmpty(3);
                     },
                     email);
            }
            return u;
        }
        #endregion

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
                 parameters.AddWithValue("@RetVal", DBNull.Value, ParameterDirectionWrap.ReturnValue);

             },
             delegate(IParameterSet outputParameters)
             {
                 info.BandId = Convert.ToInt32(outputParameters.GetValue("@RetVal"));
             });

            return info.BandId;
        }

        internal static void MapBandInfoList(IRecord record, List<BandInfo> list)
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
        internal static List<BandInfo> GetAllBandInfos(int minIndex)
        {
            List<BandInfo> list = new List<BandInfo>();

            SafeProcedure.ExecuteAndMapRecords(Database.GetDatabase(D4DDefine.DBInstanceName),
               "dbo.BandInfo_GetAll",
               delegate(IParameterSet parameters)
               {
                   parameters.AddWithValue("@MinIndex", minIndex);           
               },
               delegate(IRecord record)
               {
                   MapBandInfoList(record, list);
               }              
           );

            return list;
        }

        #endregion

    }
}
