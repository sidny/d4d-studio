using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace D4D.Platform.Domain
{
    public class MusicTitle : BaseD4DDomain
    {

        public MusicTitle() { }
        public MusicTitle(int musicId)
        {
            MusicId = musicId;
        }
        public int MusicId
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

        //public int AddUserId
        //{
        //    get;
        //    set;
        //}

        //public DateTime AddDate
        //{
        //    get;
        //    set;
        //}

        public int Status
        {
            get;
            set;
        }

    }
}
