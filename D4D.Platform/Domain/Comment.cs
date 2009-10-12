using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace D4D.Platform.Domain
{
    public class Comment:BaseD4DDomain
    {
        public int CommentId
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

        public int UserId
        {
            get;
            set;
        }

        public string UserName
        {
            get;
            set;
        }

        public DateTime AddDate
        {
            get;
            set;
        }

        public string Body
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
