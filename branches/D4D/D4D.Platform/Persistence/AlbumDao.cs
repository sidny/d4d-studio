using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using D4D.Platform.Domain;
using Core.Data;
namespace D4D.Platform.Persistence
{
    internal static class AlbumDao
    {
        #region Album
        internal static int SetAlbum(Album album)
        {
            if (album == null) return -1;

            SafeProcedure.ExecuteNonQuery(
             Database.GetDatabase(D4DDefine.DBInstanceName),
             "dbo.Album_Set",
             delegate(IParameterSet parameters)
             {
                 parameters.AddWithValue("@AlbumId", album.AlbumId);
                 parameters.AddWithValue("@Title", album.Title);
                 parameters.AddWithValue("@SImage", album.SImage);
                 parameters.AddWithValue("@LImage", album.LImage);
                 parameters.AddWithValue("@BandId", album.BandId);
                 parameters.AddWithValue("@PublishDate", album.PublishDate);
                 parameters.AddWithValue("@PublishYear", album.PublishYear);
                 parameters.AddWithValue("@PublishMonth", album.PublishMonth);
                 parameters.AddWithValue("@AddUserId", album.AddUserID);
                 parameters.AddWithValue("@Status", (int)(album.Status));
                 parameters.AddWithValue("@TotalCount", album.TotalCount);
                 parameters.AddWithValue("@RetVal", DBNull.Value, ParameterDirectionWrap.ReturnValue);

             },
             delegate(IParameterSet outputParameters)
             {
                 album.AlbumId = Convert.ToInt32(outputParameters.GetValue("@RetVal"));
             });

            return album.AlbumId;
        }

        internal static void DeleteAlbum(int albumId)
        {
            if (albumId > 0)
            {
                SafeProcedure.ExecuteNonQuery(
             Database.GetDatabase(D4DDefine.DBInstanceName),
             "dbo.Album_Delete",
             albumId);
            }
        }

        internal static Album GetAlbum(int albumId)
        {
            Album m = new Album(albumId);
            if (albumId > 0)
            {
                SafeProcedure.ExecuteAndMapRecords(
                        Database.GetDatabase(D4DDefine.DBInstanceName),
                     "dbo.Album_Get",
                     delegate(IRecord record)
                     {
                         m.Title = record.GetStringOrEmpty(1);
                         m.BandId = record.GetInt32OrDefault(2,0);
                         m.PublishDate = record.GetDateTime(3);
                         m.PublishYear = record.GetInt32OrDefault(4,0);
                         m.PublishMonth = record.GetInt32OrDefault(5, 0);
                         m.AddUserID= record.GetInt32OrDefault(6,0);
                         m.AddDate = record.GetDateTime(7);
                         m.Status = (PublishStatus)(record.GetInt32OrDefault(8, 0));
                         m.TotalCount = record.GetInt32OrDefault(9,0);
                         m.SImage = record.GetStringOrEmpty(10);
                         m.LImage = record.GetStringOrEmpty(11);
                     },
                     albumId);
            }
            return m;
        }

        internal static void MapAlbumList(IRecord record, List<Album> list)
        {
            Album m = new Album();
            m.AlbumId = record.GetInt32OrDefault(0, 0);
            m.Title = record.GetStringOrEmpty(1);
            m.BandId = record.GetInt32OrDefault(2, 0);
            m.PublishDate = record.GetDateTime(3);
            m.PublishYear = record.GetInt32OrDefault(4, 0);
            m.PublishMonth = record.GetInt32OrDefault(5, 0);
            m.AddUserID = record.GetInt32OrDefault(6, 0);
            m.AddDate = record.GetDateTime(7);
            m.Status = (PublishStatus)(record.GetInt32OrDefault(8, 0));
            m.TotalCount = record.GetInt32OrDefault(9, 0);
            m.SImage = record.GetStringOrEmpty(10);
            m.LImage = record.GetStringOrEmpty(11);

            list.Add(m);
        }
        internal static List<Album> GetPagedAlbums(PagingContext pager, int publishStatus)
        {
            List<Album> list = new List<Album>(pager.RecordsPerPage);

            SafeProcedure.ExecuteAndMapRecords(Database.GetDatabase(D4DDefine.DBInstanceName),
               "dbo.Album_GetPaged",
               delegate(IParameterSet parameters)
               {
                   parameters.AddWithValue("@PublishStatus", publishStatus);
                   parameters.AddWithValue("@PageIndex", pager.CurrentPageNumber);
                   parameters.AddWithValue("@PageSize", pager.RecordsPerPage);
                   parameters.AddWithValue("@NumberOfCount", 0, ParameterDirectionWrap.Output);
               },
               delegate(IRecord record)
               {
                   MapAlbumList(record, list);
               },
               delegate(IParameterSet outputParameters)
               {
                   pager.TotalRecordCount = outputParameters.GetValue("@NumberOfCount") == DBNull.Value ? 0 : (int)outputParameters.GetValue("@NumberOfCount");
               }
           );

            return list;
        }

        internal static List<Album> GetPagedAlbumsByBandAndPublishYearMonth(PagingContext pager, int publishStatus,
            int bandId,int pulishYear,int publishMonth)
        {
            List<Album> list = new List<Album>(pager.RecordsPerPage);

            SafeProcedure.ExecuteAndMapRecords(Database.GetDatabase(D4DDefine.DBInstanceName),
               "dbo.Album_GetPagedByBandAndPublishYearMonth",
               delegate(IParameterSet parameters)
               {
                   parameters.AddWithValue("@BandId", bandId);
                   parameters.AddWithValue("@PublishYear", pulishYear);
                   parameters.AddWithValue("@PublishMonth", publishMonth);
                   parameters.AddWithValue("@PublishStatus", publishStatus);
                   parameters.AddWithValue("@PageIndex", pager.CurrentPageNumber);
                   parameters.AddWithValue("@PageSize", pager.RecordsPerPage);
                   parameters.AddWithValue("@NumberOfCount", 0, ParameterDirectionWrap.Output);
               },
               delegate(IRecord record)
               {
                   MapAlbumList(record, list);
               },
               delegate(IParameterSet outputParameters)
               {
                   pager.TotalRecordCount = outputParameters.GetValue("@NumberOfCount") == DBNull.Value ? 0 : (int)outputParameters.GetValue("@NumberOfCount");
               }
           );

            return list;
        }

        internal static List<Album> GetPagedAlbumsByBandId(PagingContext pager, int publishStatus, int bandId)
        {
            List<Album> list = new List<Album>(pager.RecordsPerPage);

            SafeProcedure.ExecuteAndMapRecords(Database.GetDatabase(D4DDefine.DBInstanceName),
               "dbo.Album_GetPagedByBandId",
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
                   MapAlbumList(record, list);
               },
               delegate(IParameterSet outputParameters)
               {
                   pager.TotalRecordCount = outputParameters.GetValue("@NumberOfCount") == DBNull.Value ? 0 : (int)outputParameters.GetValue("@NumberOfCount");
               }
           );

            return list;
        }

        internal static List<Album> GetPagedAlbumsByPublishYearMonth(PagingContext pager, int publishStatus
            , int pulishYear, int publishMonth)
        {
            List<Album> list = new List<Album>(pager.RecordsPerPage);

            SafeProcedure.ExecuteAndMapRecords(Database.GetDatabase(D4DDefine.DBInstanceName),
               "dbo.Album_GetPagedByPublishYearMonth",
               delegate(IParameterSet parameters)
               {
                   parameters.AddWithValue("@PublishYear", pulishYear);
                   parameters.AddWithValue("@PublishMonth", publishMonth);
                   parameters.AddWithValue("@PublishStatus", publishStatus);
                   parameters.AddWithValue("@PageIndex", pager.CurrentPageNumber);
                   parameters.AddWithValue("@PageSize", pager.RecordsPerPage);
                   parameters.AddWithValue("@NumberOfCount", 0, ParameterDirectionWrap.Output);
               },
               delegate(IRecord record)
               {
                   MapAlbumList(record, list);
               },
               delegate(IParameterSet outputParameters)
               {
                   pager.TotalRecordCount = outputParameters.GetValue("@NumberOfCount") == DBNull.Value ? 0 : (int)outputParameters.GetValue("@NumberOfCount");
               }
           );

            return list;
        }

        internal static List<Album> GetPagedAlbumsByTag(PagingContext pager, int publishStatus,int tagId)
        {
            List<Album> list = new List<Album>(pager.RecordsPerPage);

            SafeProcedure.ExecuteAndMapRecords(Database.GetDatabase(D4DDefine.DBInstanceName),
               "dbo.Album_GetPagedByTag",
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
                   MapAlbumList(record, list);
               },
               delegate(IParameterSet outputParameters)
               {
                   pager.TotalRecordCount = outputParameters.GetValue("@NumberOfCount") == DBNull.Value ? 0 : (int)outputParameters.GetValue("@NumberOfCount");
               }
           );

            return list;
        }


        internal static List<Album> GetPagedAlbumsByTagAndBand(PagingContext pager, int publishStatus, int tagId,int bandId)
        {
            List<Album> list = new List<Album>(pager.RecordsPerPage);

            SafeProcedure.ExecuteAndMapRecords(Database.GetDatabase(D4DDefine.DBInstanceName),
               "dbo.Album_GetPagedByTagANDBand",
               delegate(IParameterSet parameters)
               {
                   parameters.AddWithValue("@BandId", bandId);
                   parameters.AddWithValue("@TagId", tagId);
                   parameters.AddWithValue("@PublishStatus", publishStatus);
                   parameters.AddWithValue("@PageIndex", pager.CurrentPageNumber);
                   parameters.AddWithValue("@PageSize", pager.RecordsPerPage);
                   parameters.AddWithValue("@NumberOfCount", 0, ParameterDirectionWrap.Output);
               },
               delegate(IRecord record)
               {
                   MapAlbumList(record, list);
               },
               delegate(IParameterSet outputParameters)
               {
                   pager.TotalRecordCount = outputParameters.GetValue("@NumberOfCount") == DBNull.Value ? 0 : (int)outputParameters.GetValue("@NumberOfCount");
               }
           );

            return list;
        }


        #endregion 

        #region Image
        internal static int SetImage(Image image)
        {
            if (image == null) return -1;

            SafeProcedure.ExecuteNonQuery(
             Database.GetDatabase(D4DDefine.DBInstanceName),
             "dbo.Image_Set",
             delegate(IParameterSet parameters)
             {
                 parameters.AddWithValue("@ImageId", image.ImageId);
                 parameters.AddWithValue("@AlbumId", image.AlbumId);
                 parameters.AddWithValue("@ImageName", image.ImageName);
                 parameters.AddWithValue("@ImageFile", image.ImageFile);
                 parameters.AddWithValue("@SImageFile", image.SImageFile);
                 parameters.AddWithValue("@AddUserId", image.AddUserID);
                 parameters.AddWithValue("@Status",(int)(image.Status));              
                 parameters.AddWithValue("@RetVal", DBNull.Value, ParameterDirectionWrap.ReturnValue);

             },
             delegate(IParameterSet outputParameters)
             {
                 image.ImageId = Convert.ToInt32(outputParameters.GetValue("@RetVal"));
             });

            return image.ImageId;
        }


        internal static void DeleteImagesByAlbumId(int albumId)
        {
            if (albumId > 0)
            {
                SafeProcedure.ExecuteNonQuery(
             Database.GetDatabase(D4DDefine.DBInstanceName),
             "dbo.Image_DeleteByAlbumId",
             albumId);
            }
        }

        internal static void DeleteImage(int imageId)
        {
            if (imageId > 0)
            {
                SafeProcedure.ExecuteNonQuery(
             Database.GetDatabase(D4DDefine.DBInstanceName),
             "dbo.Image_Delete",
             imageId);
            }
        }


        internal static Image GetImage(int imageId)
        {
            Image m = new Image(imageId);
            if (imageId > 0)
            {
                SafeProcedure.ExecuteAndMapRecords(
                        Database.GetDatabase(D4DDefine.DBInstanceName),
                     "dbo.Image_Get",
                     delegate(IRecord record)
                     {                      
                         m.AlbumId = record.GetInt32OrDefault(1,0);
                         m.ImageName = record.GetStringOrEmpty(2);
                         m.ImageFile = record.GetStringOrEmpty(3);
                         m.AddUserID = record.GetInt32OrDefault(4, 0);
                         m.AddDate = record.GetDateTime(5);
                         m.Status = (PublishStatus)(record.GetInt32OrDefault(6, 0));
                         m.SImageFile = record.GetStringOrEmpty(7);
                     },
                     imageId);
            }
            return m;
        }

        internal static void MapImageList(IRecord record, List<Image> list)
        {
            Image m = new Image();

            m.ImageId = record.GetInt32OrDefault(0, 0);
            m.AlbumId = record.GetInt32OrDefault(1, 0);
            m.ImageName = record.GetStringOrEmpty(2);
            m.ImageFile = record.GetStringOrEmpty(3);
            m.AddUserID = record.GetInt32OrDefault(4, 0);
            m.AddDate = record.GetDateTime(5);
            m.Status = (PublishStatus)(record.GetInt32OrDefault(6, 0));
            m.SImageFile = record.GetStringOrEmpty(7);

            list.Add(m);
        }
        internal static List<Image> GetImagesByAlbumId(int albumId, int publishStatus)
        {
            List<Image> list = new List<Image>();
            if (albumId > 0)
            {
                SafeProcedure.ExecuteAndMapRecords(
                        Database.GetDatabase(D4DDefine.DBInstanceName),
                     "dbo.Image_GetByAlbumId",
                     delegate(IRecord record)
                     {
                         MapImageList(record, list);
                     },
                     publishStatus, albumId);
            }
            return list;
        }

        internal static List<Image> GetPagedImagesByAlbumId(PagingContext pager, int albumId, int publishStatus)
        {
            List<Image> list = new List<Image>(pager.RecordsPerPage);

            SafeProcedure.ExecuteAndMapRecords(Database.GetDatabase(D4DDefine.DBInstanceName),
               "dbo.Image_GetPagedByAlbumId",
               delegate(IParameterSet parameters)
               {
                   parameters.AddWithValue("@PublishStatus", publishStatus);
                   parameters.AddWithValue("@AlbumId", albumId);
                   parameters.AddWithValue("@PageIndex", pager.CurrentPageNumber);
                   parameters.AddWithValue("@PageSize", pager.RecordsPerPage);
                   parameters.AddWithValue("@NumberOfCount", 0, ParameterDirectionWrap.Output);
               },
               delegate(IRecord record)
               {
                   MapImageList(record, list);
               },
               delegate(IParameterSet outputParameters)
               {
                   pager.TotalRecordCount = outputParameters.GetValue("@NumberOfCount") == DBNull.Value ? 0 : (int)outputParameters.GetValue("@NumberOfCount");
               }
           );

            return list;
        }


        internal static List<Image> GetPagedImagesByBandAndPublishYearMonth(PagingContext pager, int publishStatus,
            int bandId, int pulishYear, int publishMonth)
        {
            List<Image> list = new List<Image>(pager.RecordsPerPage);

            SafeProcedure.ExecuteAndMapRecords(Database.GetDatabase(D4DDefine.DBInstanceName),
               "dbo.Image_GetPagedByBandAndPublishYearMonth",
               delegate(IParameterSet parameters)
               {
                   parameters.AddWithValue("@BandId", bandId);
                   parameters.AddWithValue("@PublishYear", pulishYear);
                   parameters.AddWithValue("@PublishMonth", publishMonth);
                   parameters.AddWithValue("@PublishStatus", publishStatus);
                   parameters.AddWithValue("@PageIndex", pager.CurrentPageNumber);
                   parameters.AddWithValue("@PageSize", pager.RecordsPerPage);
                   parameters.AddWithValue("@NumberOfCount", 0, ParameterDirectionWrap.Output);
               },
               delegate(IRecord record)
               {
                   MapImageList(record, list);
               },
               delegate(IParameterSet outputParameters)
               {
                   pager.TotalRecordCount = outputParameters.GetValue("@NumberOfCount") == DBNull.Value ? 0 : (int)outputParameters.GetValue("@NumberOfCount");
               }
           );

            return list;
        }

        internal static List<Image> GetPagedImagesByBandId(PagingContext pager, int publishStatus, int bandId)
        {
            List<Image> list = new List<Image>(pager.RecordsPerPage);

            SafeProcedure.ExecuteAndMapRecords(Database.GetDatabase(D4DDefine.DBInstanceName),
               "dbo.Image_GetPagedByBandId",
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
                   MapImageList(record, list);
               },
               delegate(IParameterSet outputParameters)
               {
                   pager.TotalRecordCount = outputParameters.GetValue("@NumberOfCount") == DBNull.Value ? 0 : (int)outputParameters.GetValue("@NumberOfCount");
               }
           );

            return list;
        }

        internal static List<Image> GetPagedImagesByPublishYearMonth(PagingContext pager, int publishStatus
            , int pulishYear, int publishMonth)
        {
            List<Image> list = new List<Image>(pager.RecordsPerPage);

            SafeProcedure.ExecuteAndMapRecords(Database.GetDatabase(D4DDefine.DBInstanceName),
               "dbo.Image_GetPagedByPublishYearMonth",
               delegate(IParameterSet parameters)
               {
                   parameters.AddWithValue("@PublishYear", pulishYear);
                   parameters.AddWithValue("@PublishMonth", publishMonth);
                   parameters.AddWithValue("@PublishStatus", publishStatus);
                   parameters.AddWithValue("@PageIndex", pager.CurrentPageNumber);
                   parameters.AddWithValue("@PageSize", pager.RecordsPerPage);
                   parameters.AddWithValue("@NumberOfCount", 0, ParameterDirectionWrap.Output);
               },
               delegate(IRecord record)
               {
                   MapImageList(record, list);
               },
               delegate(IParameterSet outputParameters)
               {
                   pager.TotalRecordCount = outputParameters.GetValue("@NumberOfCount") == DBNull.Value ? 0 : (int)outputParameters.GetValue("@NumberOfCount");
               }
           );

            return list;
        }

        internal static List<Image> GetPagedImagesByTag(PagingContext pager, int publishStatus, int tagId)
        {
            List<Image> list = new List<Image>(pager.RecordsPerPage);

            SafeProcedure.ExecuteAndMapRecords(Database.GetDatabase(D4DDefine.DBInstanceName),
               "dbo.Image_GetPagedByTag",
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
                   MapImageList(record, list);
               },
               delegate(IParameterSet outputParameters)
               {
                   pager.TotalRecordCount = outputParameters.GetValue("@NumberOfCount") == DBNull.Value ? 0 : (int)outputParameters.GetValue("@NumberOfCount");
               }
           );

            return list;
        }


        internal static List<Image> GetPagedImagesByTagAndBand(PagingContext pager, int publishStatus, int tagId, int bandId)
        {
            List<Image> list = new List<Image>(pager.RecordsPerPage);

            SafeProcedure.ExecuteAndMapRecords(Database.GetDatabase(D4DDefine.DBInstanceName),
               "dbo.Image_GetPagedByTagANDBand",
               delegate(IParameterSet parameters)
               {
                   parameters.AddWithValue("@BandId", bandId);
                   parameters.AddWithValue("@TagId", tagId);
                   parameters.AddWithValue("@PublishStatus", publishStatus);
                   parameters.AddWithValue("@PageIndex", pager.CurrentPageNumber);
                   parameters.AddWithValue("@PageSize", pager.RecordsPerPage);
                   parameters.AddWithValue("@NumberOfCount", 0, ParameterDirectionWrap.Output);
               },
               delegate(IRecord record)
               {
                   MapImageList(record, list);
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
