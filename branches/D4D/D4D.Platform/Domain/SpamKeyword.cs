using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace D4D.Platform.Domain
{
    public class SpamKeyword : BaseD4DDomain
    {
        public SpamKeyword() { }
        public SpamKeyword(int id)
        {
            Id = id;
        }
        public int Id
        {
            get;
            set;
        }

        public string Keyword
        {
            get;
            set;
        }    

        public int Status
        {
            get;
            set;
        }
    }
}
