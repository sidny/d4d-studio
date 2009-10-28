using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace D4D.Platform.Domain
{
   public class News : BaseD4DDomain
    {
         public News() { }
         public News(int newsId)
        {
            NewsId = newsId;
        }
         public int NewsId
        {
            get;
            set;
        }

        public string Title
        {
            get;
            set;
        }

        public string Body
        {
            get;
            set;
        }

        public string Preview
        {
            get;
            set;
        }


        public string SImage
        {
            get;
            set;
        }

        public string LImage
        {
            get;
            set;
        }
       /// <summary>
       /// bandid or company
       /// </summary>
        public int NewsType
        {
            get;
            set;
        }

        public int Hits
        {
            get;
            set;
        }


        public DateTime PublishDate
        {
            get;
            set;
        }

        public string Remark
        {
            get;
            set;
        }    

        public PublishStatus Status
        {
            get;
            set;
        }
    }
}
