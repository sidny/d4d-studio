using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace D4D.Platform.Domain
{
    public class TagRelation : BaseD4DDomain
    {
        public int Id
        {
            get;
            set;
        }

        public int TagId
        {
            get;
            set;
        }

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
    }
}
