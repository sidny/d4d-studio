using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using D4D.Platform.Domain;
using Core.Data;
namespace D4D.Platform.Persistence
{
    internal static class MusicDao
    {

        #region Music Title
        internal static int SetMusicTitle(MusicTitle m)
        {
            if (m == null) return -1;

            SafeProcedure.ExecuteNonQuery(
             Database.GetDatabase(D4DDefine.DBInstanceName),
             "dbo.Music_SetMusicTitle",
             delegate(IParameterSet parameters)
             {
                 parameters.AddWithValue("@MusicId", m.MusicId);
                 parameters.AddWithValue("@Title", m.Title);
                 parameters.AddWithValue("@Body", m.Body);
                 parameters.AddWithValue("@SImage", m.SImage);
                 parameters.AddWithValue("@LImage", m.LImage);
                 parameters.AddWithValue("@BandId", m.BandId);
                 parameters.AddWithValue("@PublishDate", m.PublishDate);
                 parameters.AddWithValue("@PublishYear", m.PublishYear);
                 parameters.AddWithValue("@AddUserId", m.AddUserID);
                 parameters.AddWithValue("@Status", (int)(m.Status));
                 parameters.AddWithValue("@RetVal", DBNull.Value, ParameterDirectionWrap.ReturnValue);

             },
             delegate(IParameterSet outputParameters)
             {
                 m.MusicId = Convert.ToInt32(outputParameters.GetValue("@RetVal"));
             });

            return m.MusicId;
        }

        internal static void DeleteMusicTitle(int musicId)
        {
            if (musicId > 0)
            {
                SafeProcedure.ExecuteNonQuery(
             Database.GetDatabase(D4DDefine.DBInstanceName),
             "dbo.Music_DeleteMusicTitle",
             musicId);
            }
        }

        internal static MusicTitle GetMusicTitle(int musicId)
        {
            MusicTitle m = new MusicTitle(musicId);
            if (musicId > 0)
            {
                SafeProcedure.ExecuteAndMapRecords(
                        Database.GetDatabase(D4DDefine.DBInstanceName),
                     "dbo.Music_GetMusicTitle",
                     delegate(IRecord record)
                     {
                         m.Title = record.GetStringOrEmpty(1);
                         m.Body = record.GetStringOrEmpty(2);
                         m.SImage = record.GetStringOrEmpty(3);
                         m.LImage = record.GetStringOrEmpty(4);
                         m.BandId = record.GetInt32OrDefault(5, 0);
                         m.PublishDate = record.GetDateTime(6);
                         m.PublishYear = record.GetInt32OrDefault(7, 0);
                         m.AddUserID = record.GetInt32OrDefault(8, 0);
                         m.AddDate = record.GetDateTime(9);
                         m.Status = (PublishStatus)(record.GetInt32OrDefault(10, 0));
                     },
                     musicId);
            }
            return m;
        }
        internal static void MapMusicTitleList(IRecord record, List<MusicTitle> list)
        {
            MusicTitle m = new MusicTitle();
            m.MusicId = record.GetInt32OrDefault(0, 0);
            m.Title = record.GetStringOrEmpty(1);
            m.Body = record.GetStringOrEmpty(2);
            m.SImage = record.GetStringOrEmpty(3);
            m.LImage = record.GetStringOrEmpty(4);
            m.BandId = record.GetInt32OrDefault(5, 0);
            m.PublishDate = record.GetDateTime(6);
            m.PublishYear = record.GetInt32OrDefault(7, 0);
            m.AddUserID = record.GetInt32OrDefault(8, 0);
            m.AddDate = record.GetDateTime(9);
            m.Status = (PublishStatus)(record.GetInt32OrDefault(10, 0));

            list.Add(m);
        }
        internal static List<MusicTitle> GetPagedMusicTitles(PagingContext pager,int publishStatus)
        {
            List<MusicTitle> list = new List<MusicTitle>(pager.RecordsPerPage);

            SafeProcedure.ExecuteAndMapRecords(Database.GetDatabase(D4DDefine.DBInstanceName),
               "dbo.Music_GetPagedMusicTitle",
               delegate(IParameterSet parameters)
               {
                   parameters.AddWithValue("@PublishStatus", publishStatus);
                   parameters.AddWithValue("@PageIndex", pager.CurrentPageNumber);
                   parameters.AddWithValue("@PageSize", pager.RecordsPerPage);
                   parameters.AddWithValue("@NumberOfCount", 0, ParameterDirectionWrap.Output);
               },
               delegate(IRecord record)
               {
                   MapMusicTitleList(record, list);
               },
               delegate(IParameterSet outputParameters)
               {
                   pager.TotalRecordCount = outputParameters.GetValue("@NumberOfCount") == DBNull.Value ? 0 : (int)outputParameters.GetValue("@NumberOfCount");
               }
           );

            return list;
        }

        internal static List<MusicTitle> GetPagedMusicTitlesByBandId(PagingContext pager, int bandId, int publishStatus)
        {
            List<MusicTitle> list = new List<MusicTitle>(pager.RecordsPerPage);

            SafeProcedure.ExecuteAndMapRecords(Database.GetDatabase(D4DDefine.DBInstanceName),
               "dbo.Music_GetPagedMusicTitleByBandId",
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
                   MapMusicTitleList(record, list);
               },
               delegate(IParameterSet outputParameters)
               {
                   pager.TotalRecordCount = outputParameters.GetValue("@NumberOfCount") == DBNull.Value ? 0 : (int)outputParameters.GetValue("@NumberOfCount");
               }
           );

            return list;
        }

        internal static List<MusicTitle> GetPagedMusicTitlesByBandIdANDPublishYear(PagingContext pager, int bandId, int publishYear, int publishStatus)
        {
            List<MusicTitle> list = new List<MusicTitle>(pager.RecordsPerPage);

            SafeProcedure.ExecuteAndMapRecords(Database.GetDatabase(D4DDefine.DBInstanceName),
               "dbo.Music_GetPagedMusicTitleByBandIdANDPublishYear",
               delegate(IParameterSet parameters)
               {
                   parameters.AddWithValue("@PublishYear", publishYear);
                   parameters.AddWithValue("@BandId", bandId);
                   parameters.AddWithValue("@PublishStatus", publishStatus);
                   parameters.AddWithValue("@PageIndex", pager.CurrentPageNumber);
                   parameters.AddWithValue("@PageSize", pager.RecordsPerPage);
                   parameters.AddWithValue("@NumberOfCount", 0, ParameterDirectionWrap.Output);
               },
               delegate(IRecord record)
               {
                   MapMusicTitleList(record, list);
               },
               delegate(IParameterSet outputParameters)
               {
                   pager.TotalRecordCount = outputParameters.GetValue("@NumberOfCount") == DBNull.Value ? 0 : (int)outputParameters.GetValue("@NumberOfCount");
               }
           );

            return list;
        }

        internal static List<MusicTitle> GetPagedMusicTitlesByPublishYear(PagingContext pager, int publishYear, int publishStatus)
        {
            List<MusicTitle> list = new List<MusicTitle>(pager.RecordsPerPage);

            SafeProcedure.ExecuteAndMapRecords(Database.GetDatabase(D4DDefine.DBInstanceName),
               "dbo.Music_GetPagedMusicTitleByPublishYear",
               delegate(IParameterSet parameters)
               {
                   parameters.AddWithValue("@PublishYear", publishYear);
                   parameters.AddWithValue("@PublishStatus", publishStatus);
                   parameters.AddWithValue("@PageIndex", pager.CurrentPageNumber);
                   parameters.AddWithValue("@PageSize", pager.RecordsPerPage);
                   parameters.AddWithValue("@NumberOfCount", 0, ParameterDirectionWrap.Output);
               },
               delegate(IRecord record)
               {
                   MapMusicTitleList(record, list);
               },
               delegate(IParameterSet outputParameters)
               {
                   pager.TotalRecordCount = outputParameters.GetValue("@NumberOfCount") == DBNull.Value ? 0 : (int)outputParameters.GetValue("@NumberOfCount");
               }
           );

            return list;
        }
        #endregion

        #region Music SongList
        internal static int SetMusicSongList(MusicSongList m)
        {
            if (m == null) return -1;

            SafeProcedure.ExecuteNonQuery(
             Database.GetDatabase(D4DDefine.DBInstanceName),
             "dbo.Music_SetMusicSongList",
             delegate(IParameterSet parameters)
             {
                 parameters.AddWithValue("@ListId", m.ListId);
                 parameters.AddWithValue("@MusicId", m.MusicId);
                 parameters.AddWithValue("@SongName", m.SongName);
                 parameters.AddWithValue("@SongFile", m.SongFile);
                 parameters.AddWithValue("@SongTime", m.SongTime);                
                 parameters.AddWithValue("@AddUserId", m.AddUserID);
                 parameters.AddWithValue("@Status",(int)(m.Status));
                 parameters.AddWithValue("@RetVal", DBNull.Value, ParameterDirectionWrap.ReturnValue);

             },
             delegate(IParameterSet outputParameters)
             {
                 m.ListId = Convert.ToInt32(outputParameters.GetValue("@RetVal"));
             });

            return m.ListId;
        }

        internal static void DeleteMusicSongList(int listId)
        {
            if (listId > 0)
            {
                SafeProcedure.ExecuteNonQuery(
             Database.GetDatabase(D4DDefine.DBInstanceName),
             "dbo.Music_DeleteSongList",
             listId);
            }
        }

        internal static void DeleteMusicSongListByMusicId(int musicId)
        {
            if (musicId > 0)
            {
                SafeProcedure.ExecuteNonQuery(
             Database.GetDatabase(D4DDefine.DBInstanceName),
             "dbo.Music_DeleteSongListByMusicId",
             musicId);
            }
        }


        internal static MusicSongList GetMusicSongList(int listId)
        {
            MusicSongList m = new MusicSongList(listId);
            if (listId > 0)
            {
                SafeProcedure.ExecuteAndMapRecords(
                        Database.GetDatabase(D4DDefine.DBInstanceName),
                     "dbo.Music_GetMusicSongList",
                     delegate(IRecord record)
                     {
                         m.MusicId = record.GetInt32OrDefault(1,0);
                         m.SongName = record.GetStringOrEmpty(2);
                         m.SongFile = record.GetStringOrEmpty(3);
                         m.SongTime = record.GetStringOrEmpty(4);                        
                         m.AddUserID = record.GetInt32OrDefault(5, 0);
                         m.AddDate = record.GetDateTime(6);
                         m.Status = (PublishStatus)(record.GetInt32OrDefault(7, 0));
                     },
                     listId);
            }
            return m;
        }

        internal static void MapMusicSongList(IRecord record, List<MusicSongList> list)
        {
            MusicSongList m = new MusicSongList();
            m.ListId = record.GetInt32OrDefault(0, 0);
            m.MusicId = record.GetInt32OrDefault(1, 0);
            m.SongName = record.GetStringOrEmpty(2);
            m.SongFile = record.GetStringOrEmpty(3);
            m.SongTime = record.GetStringOrEmpty(4);
            m.AddUserID = record.GetInt32OrDefault(5, 0);
            m.AddDate = record.GetDateTime(6);
            m.Status = (PublishStatus)(record.GetInt32OrDefault(7, 0));

            list.Add(m);
        }
        internal static List<MusicSongList> GetMusicSongListByMusicId(int musicId, int publishStatus)
        {
            List<MusicSongList> list = new List<MusicSongList>();
            if (musicId > 0)
            {
                SafeProcedure.ExecuteAndMapRecords(
                        Database.GetDatabase(D4DDefine.DBInstanceName),
                     "dbo.Music_GetMusicSongListByMusicId",
                     delegate(IRecord record)
                     {
                         MapMusicSongList(record, list);
                     },
                     publishStatus,musicId);
            }
            return list;
        }
        #endregion
    }
}
