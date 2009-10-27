using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using D4D.Platform.Domain;
using Core.Data;
namespace D4D.Platform.Persistence
{
    internal static class NewsDao
    {
        #region News
        internal static int SetNews(News m)
        {
            if (m == null) return -1;

            SafeProcedure.ExecuteNonQuery(
             Database.GetDatabase(D4DDefine.DBInstanceName),
             "dbo.News_Set",
             delegate(IParameterSet parameters)
             {
                 parameters.AddWithValue("@NewsId", m.NewsId);
                 parameters.AddWithValue("@Title", m.Title);
                 parameters.AddWithValue("@Body", m.Body);
                 parameters.AddWithValue("@Preview", m.Preview);
                 parameters.AddWithValue("@SImage", m.SImage);
                 parameters.AddWithValue("@LImage", m.LImage);
                 parameters.AddWithValue("@NewsType", m.NewsType);
                 parameters.AddWithValue("@Hits", m.Hits);
                 parameters.AddWithValue("@PublishDate", m.PublishDate);                
                 parameters.AddWithValue("@AddUserId", m.AddUserID);
                 parameters.AddWithValue("@Status", (int)(m.Status));
                 parameters.AddWithValue("@Remark", m.Remark);
                 parameters.AddWithValue("@RetVal", DBNull.Value, ParameterDirectionWrap.ReturnValue);

             },
             delegate(IParameterSet outputParameters)
             {
                 m.NewsId = Convert.ToInt32(outputParameters.GetValue("@RetVal"));
             });

            return m.NewsId;
        }

        internal static void DeleteNews(int newsId)
        {
            if (newsId > 0)
            {
                SafeProcedure.ExecuteNonQuery(
             Database.GetDatabase(D4DDefine.DBInstanceName),
             "dbo.News_Delete",
             newsId);
            }
        }

        internal static News GetNews(int newsId)
        {
            News m = new News(newsId);
            if (newsId > 0)
            {
                SafeProcedure.ExecuteAndMapRecords(
                        Database.GetDatabase(D4DDefine.DBInstanceName),
                     "dbo.News_Get",
                     delegate(IRecord record)
                     {
                         m.Title = record.GetStringOrEmpty(1);
                         m.Body = record.GetStringOrEmpty(2);
                         m.Preview = record.GetStringOrEmpty(3);
                         m.SImage = record.GetStringOrEmpty(4);
                         m.LImage = record.GetStringOrEmpty(5);
                         m.NewsType = record.GetInt32OrDefault(6, 0);
                         m.Hits = record.GetInt32OrDefault(7, 0);
                         m.PublishDate = record.GetDateTime(8);                         
                         m.AddUserID = record.GetInt32OrDefault(9, 0);
                         m.AddDate = record.GetDateTime(10);
                         m.Status = (PublishStatus)(record.GetInt32OrDefault(11, 0));
                         m.Remark = record.GetStringOrEmpty(12);
                     },
                     newsId);
            }
            return m;
        }

        internal static void MapList(IRecord record, List<News> list)
        {
            News m = new News();
            m.NewsId = record.GetInt32OrDefault(0, 0);
            m.Title = record.GetStringOrEmpty(1);
            m.Body = record.GetStringOrEmpty(2);
            m.Preview = record.GetStringOrEmpty(3);
            m.SImage = record.GetStringOrEmpty(4);
            m.LImage = record.GetStringOrEmpty(5);
            m.NewsType = record.GetInt32OrDefault(6, 0);
            m.Hits = record.GetInt32OrDefault(7, 0);
            m.PublishDate = record.GetDateTime(8);
            m.AddUserID = record.GetInt32OrDefault(9, 0);
            m.AddDate = record.GetDateTime(10);
            m.Status = (PublishStatus)(record.GetInt32OrDefault(11, 0));
            m.Remark = record.GetStringOrEmpty(12);

            list.Add(m);
        }

        internal static List<News> GetPagedNews(PagingContext pager, int publishStatus)
        {
            List<News> list = new List<News>(pager.RecordsPerPage);

            SafeProcedure.ExecuteAndMapRecords(Database.GetDatabase(D4DDefine.DBInstanceName),
               "dbo.News_GetPaged",
               delegate(IParameterSet parameters)
               {
                   parameters.AddWithValue("@PublishStatus", publishStatus);
                   parameters.AddWithValue("@PageIndex", pager.CurrentPageNumber);
                   parameters.AddWithValue("@PageSize", pager.RecordsPerPage);
                   parameters.AddWithValue("@NumberOfCount", 0, ParameterDirectionWrap.Output);
               },
               delegate(IRecord record)
               {
                   MapList(record, list);

               },
               delegate(IParameterSet outputParameters)
               {
                   pager.TotalRecordCount = outputParameters.GetValue("@NumberOfCount") == DBNull.Value ? 0 : (int)outputParameters.GetValue("@NumberOfCount");
               }
           );

            return list;
        }

        internal static List<News> GetPagedNewsByNewsType(PagingContext pager, int newsType, int publishStatus)
        {
            List<News> list = new List<News>(pager.RecordsPerPage);

            SafeProcedure.ExecuteAndMapRecords(Database.GetDatabase(D4DDefine.DBInstanceName),
               "dbo.News_GetPagedByNewsType",
               delegate(IParameterSet parameters)
               {
                   parameters.AddWithValue("@NewsType", newsType);
                   parameters.AddWithValue("@PublishStatus", publishStatus);
                   parameters.AddWithValue("@PageIndex", pager.CurrentPageNumber);
                   parameters.AddWithValue("@PageSize", pager.RecordsPerPage);
                   parameters.AddWithValue("@NumberOfCount", 0, ParameterDirectionWrap.Output);
               },
               delegate(IRecord record)
               {
                   MapList(record, list);
               },
               delegate(IParameterSet outputParameters)
               {
                   pager.TotalRecordCount = outputParameters.GetValue("@NumberOfCount") == DBNull.Value ? 0 : (int)outputParameters.GetValue("@NumberOfCount");
               }
           );

            return list;
        }

        internal static List<News> GetPagedNewsByTypeANDPublishDate(PagingContext pager, int newsType, DateTime sTime,
            DateTime eTime, int publishStatus)
        {
            List<News> list = new List<News>(pager.RecordsPerPage);

            SafeProcedure.ExecuteAndMapRecords(Database.GetDatabase(D4DDefine.DBInstanceName),
               "dbo.News_GetPagedByNewsTypeAndPublishDate",
               delegate(IParameterSet parameters)
               {

                   parameters.AddWithValue("@NewsType", newsType);
                   parameters.AddWithValue("@STime", sTime);
                   parameters.AddWithValue("@ETime", eTime);
                   parameters.AddWithValue("@PublishStatus", publishStatus);
                   parameters.AddWithValue("@PageIndex", pager.CurrentPageNumber);
                   parameters.AddWithValue("@PageSize", pager.RecordsPerPage);
                   parameters.AddWithValue("@NumberOfCount", 0, ParameterDirectionWrap.Output);
               },
               delegate(IRecord record)
               {
                   MapList(record, list);
               },
               delegate(IParameterSet outputParameters)
               {
                   pager.TotalRecordCount = outputParameters.GetValue("@NumberOfCount") == DBNull.Value ? 0 : (int)outputParameters.GetValue("@NumberOfCount");
               }
           );

            return list;
        }

        internal static List<News> GetPagedShowByShowDate(PagingContext pager, DateTime sTime,
        DateTime eTime, int publishStatus)
        {
            List<News> list = new List<News>(pager.RecordsPerPage);

            SafeProcedure.ExecuteAndMapRecords(Database.GetDatabase(D4DDefine.DBInstanceName),
               "dbo.News_GetPagedByPublishDate",
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
                   MapList(record, list);
               },
               delegate(IParameterSet outputParameters)
               {
                   pager.TotalRecordCount = outputParameters.GetValue("@NumberOfCount") == DBNull.Value ? 0 : (int)outputParameters.GetValue("@NumberOfCount");
               }
           );

            return list;
        }


        internal static List<News> GetPagedNewsByTag(PagingContext pager, int publishStatus, int tagId)
        {
            List<News> list = new List<News>(pager.RecordsPerPage);

            SafeProcedure.ExecuteAndMapRecords(Database.GetDatabase(D4DDefine.DBInstanceName),
               "dbo.News_GetPagedByTag",
               delegate(IParameterSet parameters)
               {
                   parameters.AddWithValue("@TagId", tagId);
                   parameters.AddWithValue("@PublishStatus", publishStatus);
                   parameters.AddWithValue("@PageIndex", pager.CurrentPageNumber);
                   parameters.AddWithValue("@PageSize", pager.RecordsPerPage);
                   parameters.AddWithValue("@NumberOfCount", 0, ParameterDirectionWrap.Output);
               },
               delegate(IRecord record)
               {
                   MapList(record, list);

               },
               delegate(IParameterSet outputParameters)
               {
                   pager.TotalRecordCount = outputParameters.GetValue("@NumberOfCount") == DBNull.Value ? 0 : (int)outputParameters.GetValue("@NumberOfCount");
               }
           );

            return list;
        }

        internal static List<News> GetPagedNewsByTagAndNewsType(PagingContext pager, int publishStatus, int tagId, int newsType)
        {
            List<News> list = new List<News>(pager.RecordsPerPage);

            SafeProcedure.ExecuteAndMapRecords(Database.GetDatabase(D4DDefine.DBInstanceName),
               "dbo.News_GetPagedByTagAndNewsType",
               delegate(IParameterSet parameters)
               {
                   parameters.AddWithValue("@NewsType", newsType);
                   parameters.AddWithValue("@TagId", tagId);
                   parameters.AddWithValue("@PublishStatus", publishStatus);
                   parameters.AddWithValue("@PageIndex", pager.CurrentPageNumber);
                   parameters.AddWithValue("@PageSize", pager.RecordsPerPage);
                   parameters.AddWithValue("@NumberOfCount", 0, ParameterDirectionWrap.Output);
               },
               delegate(IRecord record)
               {
                   MapList(record, list);

               },
               delegate(IParameterSet outputParameters)
               {
                   pager.TotalRecordCount = outputParameters.GetValue("@NumberOfCount") == DBNull.Value ? 0 : (int)outputParameters.GetValue("@NumberOfCount");
               }
           );

            return list;
        }


        internal static List<News> GetNewsPreviousNext(int currentNewsId)
        {
            List<News> list = new List<News>(2);

            SafeProcedure.ExecuteAndMapRecords(Database.GetDatabase(D4DDefine.DBInstanceName),
               "dbo.News_GetPreviousNext",              
               delegate(IRecord record)
               {
                   MapList(record, list);

               }, currentNewsId        
           );

            return list;
        }

        internal static List<News> GetNewsTagRelation(int currentId,int maxCount)
        {
            List<News> list = new List<News>(maxCount);

            SafeProcedure.ExecuteAndMapRecords(Database.GetDatabase(D4DDefine.DBInstanceName),
               "dbo.News_GetTagRelation",
               delegate(IRecord record)
               {
                   MapList(record, list);

               }, currentId,maxCount
           );

            return list;
        }
        #endregion
    }
}
