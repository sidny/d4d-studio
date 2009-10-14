using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using D4D.Platform.Domain;
using D4D.Platform.Persistence;
namespace D4D.Platform.Providers
{
   public  class ShowProvider
    {
        #region instance
       private static readonly ShowProvider instance = new ShowProvider();

        internal static ShowProvider Instance
        {
            get
            {
                return instance;
            }
        }
        #endregion
        public int SetShow(Show m)
        {
            return ShowDao.SetShow(m);
        }

       public void DeleteShow(int showId)
       {
           ShowDao.DeleteShow(showId);
       }
       public  Show GetShow(int showId)
       {
           return ShowDao.GetShow(showId);
       }

      
       public List<Show> GetPagedShow(PagingContext pager, PublishStatus publishStatus)
       {
           return ShowDao.GetPagedShow(pager, (int)publishStatus);
       }
       public List<Show> GetPagedShowByBandId(PagingContext pager, int bandId, PublishStatus publishStatus)
       {
           return ShowDao.GetPagedShowByBandId(pager, bandId,(int)publishStatus);
       }
       public List<Show> GetPagedShowByBandANDShowDate(PagingContext pager, int bandId, DateTime sTime,
            DateTime eTime, PublishStatus publishStatus)
       {
           return ShowDao.GetPagedShowByBandANDShowDate(pager, bandId, sTime,eTime,(int)publishStatus);
       }

       public List<Show> GetPagedShowByShowDate(PagingContext pager, DateTime sTime,
        DateTime eTime, PublishStatus publishStatus)
       {
           return ShowDao.GetPagedShowByShowDate(pager,  sTime, eTime, (int)publishStatus);
       }

       public List<Show> GetPagedShowByTag(PagingContext pager, PublishStatus publishStatus, int tagId)
       {
           return ShowDao.GetPagedShowByTag(pager,(int)publishStatus,tagId);
       }

       public List<Show> GetPagedShowByTagAndBand(PagingContext pager, PublishStatus publishStatus, int tagId, int bandId)
       {
           return ShowDao.GetPagedShowByTagAndBand(pager, (int)publishStatus, tagId, bandId);
       }
    }
}
