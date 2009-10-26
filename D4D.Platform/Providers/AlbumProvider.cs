using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using D4D.Platform.Domain;
using D4D.Platform.Persistence;
namespace D4D.Platform.Providers
{
    public class AlbumProvider
    {
        #region instance
        private static readonly AlbumProvider instance = new AlbumProvider();

        internal static AlbumProvider Instance
        {
            get
            {
                return instance;
            }
        }
        #endregion

        #region Album
        public int SetAlbum(Album album)
        {
            if (album == null) return -1;

            if (album.PublishDate != null)
            {
                if (album.PublishYear <= 1900)
                    album.PublishYear = album.PublishDate.Year;

                if (album.PublishMonth <= 0 || album.PublishMonth > 12)
                    album.PublishMonth = album.PublishDate.Month;
            }

            if (album.PublishMonth <= 0) album.PublishMonth = 1;
          
            return AlbumDao.SetAlbum(album);
        }

        public void DeleteAlbum(int albumId)
        {
            AlbumDao.DeleteAlbum(albumId);
        }

        public Album GetAlbum(int albumId)
        {
            return AlbumDao.GetAlbum(albumId);
        }

        public List<Album> GetPagedAlbums(PagingContext pager, PublishStatus publishStatus)
        {
            return AlbumDao.GetPagedAlbums(pager, (int)publishStatus);
        }

        public List<Album> GetPagedAlbumsByBandAndPublishYearMonth(PagingContext pager, PublishStatus publishStatus,
            int bandId, int pulishYear, int publishMonth)
        {
            return AlbumDao.GetPagedAlbumsByBandAndPublishYearMonth(pager, (int)publishStatus,
                bandId, pulishYear, publishMonth);
        }

        public List<Album> GetPagedAlbumsByBandId(PagingContext pager, PublishStatus publishStatus, int bandId)
        {
            return AlbumDao.GetPagedAlbumsByBandId(pager, (int)publishStatus,
               bandId); 
        }

        public List<Album> GetPagedAlbumsByPublishYearMonth(PagingContext pager, PublishStatus publishStatus
            , int pulishYear, int publishMonth)
        {
            return AlbumDao.GetPagedAlbumsByPublishYearMonth(pager, (int)publishStatus,
                pulishYear, publishMonth);
        }

        public List<Album> GetPagedAlbumsByTag(PagingContext pager, PublishStatus publishStatus, int tagId)
        {
            return AlbumDao.GetPagedAlbumsByTag(pager, (int)publishStatus,
               tagId); 
        }

        public List<Album> GetPagedAlbumsByTagAndBand(PagingContext pager, PublishStatus publishStatus, int tagId, int bandId)
        {
            return AlbumDao.GetPagedAlbumsByTagAndBand(pager, (int)publishStatus,
              tagId, bandId); 
        }

        #endregion

        #region Image
        public int SetImage(Image image)
        {
            return AlbumDao.SetImage(image);
        }

        public void DeleteImagesByAlbumId(int albumId)
        {
            AlbumDao.DeleteImagesByAlbumId(albumId);
        }

        public void DeleteImage(int imageId)
        {
            AlbumDao.DeleteImage(imageId);
        }

        public  Image GetImage(int imageId)
        {
            return AlbumDao.GetImage(imageId);
        }
        public List<Image> GetImagesByAlbumId(int albumId, PublishStatus publishStatus)
        {
            return AlbumDao.GetImagesByAlbumId(albumId, (int)publishStatus);
        }

        public List<Image> GetPagedImagesByAlbumId(PagingContext pager, int albumId, PublishStatus publishStatus)
        {
            return AlbumDao.GetPagedImagesByAlbumId(pager, albumId, (int)publishStatus);
        }


        public List<Image> GetPagedImagesByBandAndPublishYearMonth(PagingContext pager, PublishStatus publishStatus,
    int bandId, int pulishYear, int publishMonth)
        {
            return AlbumDao.GetPagedImagesByBandAndPublishYearMonth(pager, (int)publishStatus,
                bandId, pulishYear, publishMonth);
        }

        public List<Image> GetPagedImagesByBandId(PagingContext pager, PublishStatus publishStatus, int bandId)
        {
            return AlbumDao.GetPagedImagesByBandId(pager, (int)publishStatus,
               bandId);
        }

        public List<Image> GetPagedImagesByPublishYearMonth(PagingContext pager, PublishStatus publishStatus
            , int pulishYear, int publishMonth)
        {
            return AlbumDao.GetPagedImagesByPublishYearMonth(pager, (int)publishStatus,
                pulishYear, publishMonth);
        }

        public List<Image> GetPagedImagesByTag(PagingContext pager, PublishStatus publishStatus, int tagId)
        {
            return AlbumDao.GetPagedImagesByTag(pager, (int)publishStatus,
               tagId);
        }

        public List<Image> GetPagedImagesByTagAndBand(PagingContext pager, PublishStatus publishStatus, int tagId, int bandId)
        {
            return AlbumDao.GetPagedImagesByTagAndBand(pager, (int)publishStatus,
              tagId, bandId);
        }

        #endregion
    }
}
