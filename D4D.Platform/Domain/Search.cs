using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace D4D.Platform.Domain
{
    public  class SearchResult
    {
        public int ObjectId
        {
            get;
            set;
        }

        public ObjectTypeDefine ObjectType
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
    }
}
