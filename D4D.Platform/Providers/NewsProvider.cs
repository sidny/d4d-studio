using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using D4D.Platform.Domain;
using D4D.Platform.Persistence;
namespace D4D.Platform.Providers
{
    public  class NewsProvider
    {
        #region instance
        private static readonly NewsProvider instance = new NewsProvider();

        internal static NewsProvider Instance
        {
            get
            {
                return instance;
            }
        }
        #endregion

        public int SetNews(News m)
        {
            return NewsDao.SetNews(m);
        }

        public void DeleteNews(int newsId)
        {
            NewsDao.DeleteNews(newsId);
        }

        public News GetNews(int newsId)
        {
            return NewsDao.GetNews(newsId);
        }

        public List<News> GetPagedNews(PagingContext pager, PublishStatus publishStatus)
        {
            return NewsDao.GetPagedNews(pager, (int)publishStatus);
        }

        public List<News> GetPagedNewsByNewsType(PagingContext pager, BandType newsType, PublishStatus publishStatus)
        {
            return NewsDao.GetPagedNewsByNewsType(pager, (int)newsType, (int)publishStatus);
        }

        public List<News> GetPagedNewsByTypeANDPublishDate(PagingContext pager, BandType newsType, DateTime sTime,
            DateTime eTime, PublishStatus publishStatus)
        {
            return NewsDao.GetPagedNewsByTypeANDPublishDate(pager, (int)newsType, sTime,eTime,(int)publishStatus);
        }

        public List<News> GetPagedShowByShowDate(PagingContext pager,  DateTime sTime,
            DateTime eTime, PublishStatus publishStatus)
        {
            return NewsDao.GetPagedShowByShowDate(pager,  sTime, eTime, (int)publishStatus);
        }

        public List<News> GetPagedNewsByTag(PagingContext pager, PublishStatus publishStatus, int tagId)
        {
            return NewsDao.GetPagedNewsByTag(pager, (int)publishStatus, tagId);
        }

        public List<News> GetPagedNewsByTagAndNewsType(PagingContext pager, PublishStatus publishStatus, int tagId,
            BandType newsType)
        {
            return NewsDao.GetPagedNewsByTagAndNewsType(pager, (int)publishStatus, tagId, (int)newsType);
        }
        /// <summary>
        /// 获取新闻上一条下一条
        /// </summary>
        /// <param name="currentNewsId"></param>
        /// <returns></returns>
        public List<News> GetNewsPreviousNext(int currentNewsId)
        {
            return NewsDao.GetNewsPreviousNext(currentNewsId);
        }
        /// <summary>
        /// 获取相关新闻
        /// </summary>
        /// <param name="currentId">当前新闻id</param>
        /// <param name="maxCount">最大数量</param>
        /// <returns></returns>
        public List<News> GetNewsTagRelation(int currentId, int maxCount)
        {
            return NewsDao.GetNewsTagRelation(currentId, maxCount);
        }
    }
}
