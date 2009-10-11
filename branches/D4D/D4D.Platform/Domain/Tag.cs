using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace D4D.Platform.Domain
{
    public class Tag : BaseD4DDomain
    {

        public Tag() { }
        public Tag(int tagId)
        {
            TagId = tagId;
        }
        public int TagId
        {
            get;
            set;
        }
        public string TagName
        {
            get;
            set;
        }
        public int Hits
        {
            get;
            set;
        }
        //public int AddUserID
        //{
        //    get;
        //    set;
        //}
        //public DateTime AddDate
        //{
        //    get;
        //    set;
        //}
    }
}
