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
        public News GetNewsAddHits(int newsId)
        {
            return NewsDao.GetNews(newsId,1);
        }
        public List<News> GetPagedNews(PagingContext pager, PublishStatus publishStatus)
        {
            return GetPagedNews(pager, publishStatus, NewsRemarkType.Normal);
        }
        public List<News> GetPagedNews(PagingContext pager, PublishStatus publishStatus
            ,NewsRemarkType newsRemarkType)
        {
            return NewsDao.GetPagedNews(pager, (int)publishStatus, (int)newsRemarkType);
        }

        public List<News> GetPagedNewsByNewsType(PagingContext pager, BandType newsType,
            PublishStatus publishStatus)
        {
            return GetPagedNewsByNewsType(pager, newsType, publishStatus, NewsRemarkType.Normal);
        }

        public List<News> GetPagedNewsByNewsType(PagingContext pager, BandType newsType,
            PublishStatus publishStatus, NewsRemarkType newsRemarkType)
        {
            return NewsDao.GetPagedNewsByNewsType(pager, (int)newsType, (int)publishStatus, (int)newsRemarkType);
        }

        public List<News> GetPagedNewsByTypeANDPublishDate(PagingContext pager, BandType newsType, DateTime sTime,
            DateTime eTime, PublishStatus publishStatus)
        {
            return GetPagedNewsByTypeANDPublishDate(pager, newsType, sTime, eTime, publishStatus, 
                NewsRemarkType.Normal);
        }

        public List<News> GetPagedNewsByTypeANDPublishDate(PagingContext pager, BandType newsType, DateTime sTime,
            DateTime eTime, PublishStatus publishStatus, NewsRemarkType newsRemarkType)
        {
            return NewsDao.GetPagedNewsByTypeANDPublishDate(pager, (int)newsType, sTime,eTime,(int)publishStatus
                , (int)newsRemarkType);
        }

        public List<News> GetPagedNewsByPublishDate(PagingContext pager, DateTime sTime,
           DateTime eTime, PublishStatus publishStatus)
        {
            return GetPagedNewsByPublishDate(pager, sTime, eTime, publishStatus, NewsRemarkType.Normal);
        }

        public List<News> GetPagedNewsByPublishDate(PagingContext pager, DateTime sTime,
            DateTime eTime, PublishStatus publishStatus, NewsRemarkType newsRemarkType)
        {
            return NewsDao.GetPagedNewsByPublishDate(pager,  sTime, eTime, (int)publishStatus
                , (int)newsRemarkType);
        }

        public List<News> GetPagedNewsByTag(PagingContext pager, PublishStatus publishStatus, int tagId)
        {
            return GetPagedNewsByTag(pager, publishStatus, tagId, NewsRemarkType.Normal);
        }

        public List<News> GetPagedNewsByTag(PagingContext pager, PublishStatus publishStatus,
            int tagId, NewsRemarkType newsRemarkType)
        {
            return NewsDao.GetPagedNewsByTag(pager, (int)publishStatus, tagId, (int)newsRemarkType);
        }

        public List<News> GetPagedNewsByTagAndNewsType(PagingContext pager, PublishStatus publishStatus, int tagId,
          BandType newsType)
        {
            return GetPagedNewsByTagAndNewsType(pager, publishStatus, tagId, newsType, NewsRemarkType.Normal);
        }

        public List<News> GetPagedNewsByTagAndNewsType(PagingContext pager, PublishStatus publishStatus, int tagId,
            BandType newsType, NewsRemarkType newsRemarkType)
        {
            return NewsDao.GetPagedNewsByTagAndNewsType(pager, (int)publishStatus, tagId, (int)newsType
                , (int)newsRemarkType);
        }

        public List<News> GetNewsPreviousNext(int currentNewsId)
        {
            return GetNewsPreviousNext(currentNewsId, NewsRemarkType.Normal);
        }
        /// <summary>
        /// 获取新闻上一条下一条
        /// </summary>
        /// <param name="currentNewsId"></param>
        /// <returns></returns>
        public List<News> GetNewsPreviousNext(int currentNewsId, NewsRemarkType newsRemarkType)
        {
            return NewsDao.GetNewsPreviousNext(currentNewsId, (int)newsRemarkType);
        }

        public List<News> GetNewsPreviousNextWithBandType(int currentNewsId, NewsRemarkType newsRemarkType,int bandType)
        {
            return NewsDao.GetNewsPreviousNextWithBandType(currentNewsId, (int)newsRemarkType, bandType);
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


        #region GetTopImage
        public List<News> GetTopImageNews(int maxCount, NewsRemarkType newsRemarkType)
        {
            return NewsDao.GetTopImageNews(maxCount, (int)newsRemarkType);
        }

        public List<News> GetTopImageNewsByNewsType(BandType newsType, int maxCount, NewsRemarkType newsRemarkType)
        {
            return NewsDao.GetTopImageNewsByNewsType((int)newsType, maxCount, (int)newsRemarkType);

        }

        public List<News> GetTopImageNewsByNewsTypeANDPublishDate(BandType newsType,
            DateTime sTime, DateTime eTime, int maxCount, NewsRemarkType newsRemarkType)
        {
            return NewsDao.GetTopImageNewsByNewsTypeANDPublishDate((int)newsType,sTime,
                eTime,maxCount, (int)newsRemarkType);

      
        }

        public List<News> GetTopImageNewsByPublishDate(
           DateTime sTime, DateTime eTime, int maxCount, NewsRemarkType newsRemarkType)
        {
            return NewsDao.GetTopImageNewsByPublishDate(sTime, eTime, maxCount, (int)newsRemarkType);
        }

        public List<News> GetTopImageNewsByTag(
           int tagId, int maxCount, NewsRemarkType newsRemarkType)
        {
            return NewsDao.GetTopImageNewsByTag(tagId, maxCount, (int)newsRemarkType);
     
        }

        public List<News> GetTopImageNewsByTagANDNewsType(
           int tagId, BandType newsType, int maxCount, NewsRemarkType newsRemarkType)
        {
            return NewsDao.GetTopImageNewsByTagANDNewsType(tagId, (int)newsType,
                maxCount, (int)newsRemarkType);
        }
        #endregion
    }
}
