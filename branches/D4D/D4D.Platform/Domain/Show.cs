using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace D4D.Platform.Domain
{
    public class Show : BaseD4DDomain
    {
         public Show() { }
         public Show(int showId)
        {
            ShowId = showId;
        }
         public int ShowId
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

        public int BandId
        {
            get;
            set;
        }

        public DateTime ShowDate
        {
            get;
            set;
        }

        public DateTime EndDate
        {
            get;
            set;
        }

        public string ShowPlace
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
