using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using D4D.Platform.Domain;
using D4D.Platform.Persistence;
namespace D4D.Platform.Providers
{
    public class MusicProvider
    {
        #region instance
        private static readonly MusicProvider instance = new MusicProvider();

        internal static MusicProvider Instance
        {
            get
            {
                return instance;
            }
        }
        #endregion

        #region Music Title
        public int SetMusicTitle(MusicTitle m)
        {
            if (m == null) return -1;
            if (m.PublishYear <= 1900 && m.PublishDate != null)
                m.PublishYear = m.PublishDate.Year;
            return MusicDao.SetMusicTitle(m);
        }

        public void DeleteMusicTitle(int musicId)
        {
            MusicDao.DeleteMusicTitle(musicId);
        }

        public MusicTitle GetMusicTitle(int musicId)
        {
            return MusicDao.GetMusicTitle(musicId);
        }

        public List<MusicTitle> GetPagedMusicTitles(PagingContext pager, PublishStatus publishStatus)
        {
            return MusicDao.GetPagedMusicTitles(pager, (int)publishStatus);
        }

        public List<MusicTitle> GetPagedMusicTitlesByBandId(PagingContext pager, int bandId, PublishStatus publishStatus)
        {
            return MusicDao.GetPagedMusicTitlesByBandId(pager, bandId, (int)publishStatus);
        }

        public List<MusicTitle> GetPagedMusicTitlesByBandIdANDPublishYear(PagingContext pager, int bandId, int publishYear, PublishStatus publishStatus)
        {
            return MusicDao.GetPagedMusicTitlesByBandIdANDPublishYear(pager, bandId, publishYear, (int)publishStatus);
        }

        public List<MusicTitle> GetPagedMusicTitlesByPublishYear(PagingContext pager, int publishYear, PublishStatus publishStatus)
        {
            return MusicDao.GetPagedMusicTitlesByPublishYear(pager, publishYear, (int)publishStatus);
        }
        #endregion

        #region Music SongList

        public int SetMusicSongList(MusicSongList m)
        {
            return MusicDao.SetMusicSongList(m);
        }

        public void DeleteMusicSongList(int listId)
        {
            MusicDao.DeleteMusicSongList(listId);
        }

        public void DeleteMusicSongListByMusicId(int musicId)
        {
            MusicDao.DeleteMusicSongListByMusicId(musicId);
        }

        public MusicSongList GetMusicSongList(int listId)
        {
            return MusicDao.GetMusicSongList(listId);
        }

        public List<MusicSongList> GetMusicSongListByMusicId(int musicId ,PublishStatus publishStatus)
        {
            return MusicDao.GetMusicSongListByMusicId(musicId, (int)publishStatus);
        }
        #endregion
    }
}
