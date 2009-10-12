using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace D4D.Platform.Domain
{
   public class Album : BaseD4DDomain
    {
         public Album() { }
         public Album(int albumId)
        {
            AlbumId = albumId;
        }
         public int AlbumId
        {
            get;
            set;
        }

        public string Title
        {
            get;
            set;
        }

        public int BandId
        {
            get;
            set;
        }

        public DateTime PublishDate
        {
            get;
            set;
        }

        public int PublishYear
        {
            get;
            set;
        }

        public int PublishMonth
        {
            get;
            set;
        }

        public int TotalCount
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


        public PublishStatus Status
        {
            get;
            set;
        }
    }
}
