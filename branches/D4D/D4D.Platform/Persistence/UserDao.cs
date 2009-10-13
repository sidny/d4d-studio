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

    }
}
