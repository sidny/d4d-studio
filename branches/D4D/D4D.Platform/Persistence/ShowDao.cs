using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using D4D.Platform.Domain;
using Core.Data;
namespace D4D.Platform.Persistence
{
     internal static class ShowDao
    {
        #region Show
        internal static int SetShow(Show m)
        {
            if (m == null) return -1;

            SafeProcedure.ExecuteNonQuery(
             Database.GetDatabase(D4DDefine.DBInstanceName),
             "dbo.Show_Set",
             delegate(IParameterSet parameters)
             {
                 parameters.AddWithValue("@ShowId", m.ShowId);
                 parameters.AddWithValue("@Title", m.Title);
                 parameters.AddWithValue("@Body", m.Body);
                 parameters.AddWithValue("@SImage", m.SImage);
                 parameters.AddWithValue("@LImage", m.LImage);
                 parameters.AddWithValue("@BandId", m.BandId);
                 parameters.AddWithValue("@ShowDate", m.ShowDate);
                 parameters.AddWithValue("@ShowPlace", m.ShowPlace);
                 parameters.AddWithValue("@AddUserId", m.AddUserID);
                 parameters.AddWithValue("@Status", (int)(m.Status));
                 parameters.AddWithValue("@RetVal", DBNull.Value, ParameterDirectionWrap.ReturnValue);

             },
             delegate(IParameterSet outputParameters)
             {
                 m.ShowId = Convert.ToInt32(outputParameters.GetValue("@RetVal"));
             });

            return m.ShowId;
        }

        internal static void DeleteShow(int showId)
        {
            if (showId > 0)
            {
                SafeProcedure.ExecuteNonQuery(
             Database.GetDatabase(D4DDefine.DBInstanceName),
             "dbo.Show_Delete",
             showId);
            }
        }

        internal static Show GetShow(int showId)
        {
            Show m = new Show(showId);
            if (showId > 0)
            {
                SafeProcedure.ExecuteAndMapRecords(
                        Database.GetDatabase(D4DDefine.DBInstanceName),
                     "dbo.Show_Get",
                     delegate(IRecord record)
                     {
                         m.Title = record.GetStringOrEmpty(1);
                         m.Body = record.GetStringOrEmpty(2);
                         m.SImage = record.GetStringOrEmpty(3);
                         m.LImage = record.GetStringOrEmpty(4);
                         m.BandId = record.GetInt32OrDefault(5, 0);
                         m.ShowDate = record.GetDateTime(6);
                         m.ShowPlace = record.GetStringOrEmpty(7);
                         m.AddUserID = record.GetInt32OrDefault(8, 0);
                         m.AddDate = record.GetDateTime(9);
                         m.Status = (PublishStatus)(record.GetInt32OrDefault(10, 0));
                     },
                     showId);
            }
            return m;
        }

        internal static List<Show> GetPagedShow(PagingContext pager, int publishStatus)
        {
            List<Show> list = new List<Show>(pager.RecordsPerPage);

            SafeProcedure.ExecuteAndMapRecords(Database.GetDatabase(D4DDefine.DBInstanceName),
               "dbo.Show_GetPaged",
               delegate(IParameterSet parameters)
               {
                   parameters.AddWithValue("@PublishStatus", publishStatus);
                   parameters.AddWithValue("@PageIndex", pager.CurrentPageNumber);
                   parameters.AddWithValue("@PageSize", pager.RecordsPerPage);
                   parameters.AddWithValue("@NumberOfCount", 0, ParameterDirectionWrap.Output);
               },
               delegate(IRecord record)
               {
                   Show m = new Show();
                   m.ShowId = record.GetInt32OrDefault(0, 0);
                   m.Title = record.GetStringOrEmpty(1);
                   m.Body = record.GetStringOrEmpty(2);
                   m.SImage = record.GetStringOrEmpty(3);
                   m.LImage = record.GetStringOrEmpty(4);
                   m.BandId = record.GetInt32OrDefault(5, 0);
                   m.ShowDate = record.GetDateTime(6);
                   m.ShowPlace = record.GetStringOrEmpty(7);
                   m.AddUserID = record.GetInt32OrDefault(8, 0);
                   m.AddDate = record.GetDateTime(9);
                   m.Status = (PublishStatus)(record.GetInt32OrDefault(10, 0));

                   list.Add(m);
               },
               delegate(IParameterSet outputParameters)
               {
                   pager.TotalRecordCount = outputParameters.GetValue("@NumberOfCount") == DBNull.Value ? 0 : (int)outputParameters.GetValue("@NumberOfCount");
               }
           );

            return list;
        }

        internal static List<Show> GetPagedShowByBandId(PagingContext pager, int bandId, int publishStatus)
        {
            List<Show> list = new List<Show>(pager.RecordsPerPage);

            SafeProcedure.ExecuteAndMapRecords(Database.GetDatabase(D4DDefine.DBInstanceName),
               "dbo.Show_GetPagedByBandId",
               delegate(IParameterSet parameters)
               {
                   parameters.AddWithValue("@BandId", bandId);
                   parameters.AddWithValue("@PublishStatus", publishStatus);
                   parameters.AddWithValue("@PageIndex", pager.CurrentPageNumber);
                   parameters.AddWithValue("@PageSize", pager.RecordsPerPage);
                   parameters.AddWithValue("@NumberOfCount", 0, ParameterDirectionWrap.Output);
               },
               delegate(IRecord record)
               {
                   Show m = new Show();
                   m.ShowId = record.GetInt32OrDefault(0, 0);
                   m.Title = record.GetStringOrEmpty(1);
                   m.Body = record.GetStringOrEmpty(2);
                   m.SImage = record.GetStringOrEmpty(3);
                   m.LImage = record.GetStringOrEmpty(4);
                   m.BandId = record.GetInt32OrDefault(5, 0);
                   m.ShowDate = record.GetDateTime(6);
                   m.ShowPlace = record.GetStringOrEmpty(7);
                   m.AddUserID = record.GetInt32OrDefault(8, 0);
                   m.AddDate = record.GetDateTime(9);
                   m.Status = (PublishStatus)(record.GetInt32OrDefault(10, 0));

                   list.Add(m);
               },
               delegate(IParameterSet outputParameters)
               {
                   pager.TotalRecordCount = outputParameters.GetValue("@NumberOfCount") == DBNull.Value ? 0 : (int)outputParameters.GetValue("@NumberOfCount");
               }
           );

            return list;
        }

        internal static List<Show> GetPagedShowByBandANDShowDate(PagingContext pager, int bandId, DateTime sTime,
            DateTime eTime,int publishStatus)
        {
            List<Show> list = new List<Show>(pager.RecordsPerPage);

            SafeProcedure.ExecuteAndMapRecords(Database.GetDatabase(D4DDefine.DBInstanceName),
               "dbo.Show_GetPagedByBandAndShowDate",
               delegate(IParameterSet parameters)
               {
                 
                   parameters.AddWithValue("@BandId", bandId);
                   parameters.AddWithValue("@STime", sTime);
                   parameters.AddWithValue("@ETime", eTime);
                   parameters.AddWithValue("@PublishStatus", publishStatus);
                   parameters.AddWithValue("@PageIndex", pager.CurrentPageNumber);
                   parameters.AddWithValue("@PageSize", pager.RecordsPerPage);
                   parameters.AddWithValue("@NumberOfCount", 0, ParameterDirectionWrap.Output);
               },
               delegate(IRecord record)
               {
                   Show m = new Show();
                   m.ShowId = record.GetInt32OrDefault(0, 0);
                   m.Title = record.GetStringOrEmpty(1);
                   m.Body = record.GetStringOrEmpty(2);
                   m.SImage = record.GetStringOrEmpty(3);
                   m.LImage = record.GetStringOrEmpty(4);
                   m.BandId = record.GetInt32OrDefault(5, 0);
                   m.ShowDate = record.GetDateTime(6);
                   m.ShowPlace = record.GetStringOrEmpty(7);
                   m.AddUserID = record.GetInt32OrDefault(8, 0);
                   m.AddDate = record.GetDateTime(9);
                   m.Status = (PublishStatus)(record.GetInt32OrDefault(10, 0));

                   list.Add(m);
               },
               delegate(IParameterSet outputParameters)
               {
                   pager.TotalRecordCount = outputParameters.GetValue("@NumberOfCount") == DBNull.Value ? 0 : (int)outputParameters.GetValue("@NumberOfCount");
               }
           );

            return list;
        }

        internal static List<Show> GetPagedShowByShowDate(PagingContext pager, DateTime sTime,
        DateTime eTime, int publishStatus)
        {
            List<Show> list = new List<Show>(pager.RecordsPerPage);

            SafeProcedure.ExecuteAndMapRecords(Database.GetDatabase(D4DDefine.DBInstanceName),
               "dbo.Show_GetPagedByShowDate",
               delegate(IParameterSet parameters)
               {
                   parameters.AddWithValue("@STime", sTime);
                   parameters.AddWithValue("@ETime", eTime);
                   parameters.AddWithValue("@PublishStatus", publishStatus);
                   parameters.AddWithValue("@PageIndex", pager.CurrentPageNumber);
                   parameters.AddWithValue("@PageSize", pager.RecordsPerPage);
                   parameters.AddWithValue("@NumberOfCount", 0, ParameterDirectionWrap.Output);
               },
               delegate(IRecord record)
               {
                   Show m = new Show();
                   m.ShowId = record.GetInt32OrDefault(0, 0);
                   m.Title = record.GetStringOrEmpty(1);
                   m.Body = record.GetStringOrEmpty(2);
                   m.SImage = record.GetStringOrEmpty(3);
                   m.LImage = record.GetStringOrEmpty(4);
                   m.BandId = record.GetInt32OrDefault(5, 0);
                   m.ShowDate = record.GetDateTime(6);
                   m.ShowPlace = record.GetStringOrEmpty(7);
                   m.AddUserID = record.GetInt32OrDefault(8, 0);
                   m.AddDate = record.GetDateTime(9);
                   m.Status = (PublishStatus)(record.GetInt32OrDefault(10, 0));

                   list.Add(m);
               },
               delegate(IParameterSet outputParameters)
               {
                   pager.TotalRecordCount = outputParameters.GetValue("@NumberOfCount") == DBNull.Value ? 0 : (int)outputParameters.GetValue("@NumberOfCount");
               }
           );

            return list;
        }
        #endregion
    }
}
