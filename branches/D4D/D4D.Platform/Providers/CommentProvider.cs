using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using D4D.Platform.Domain;
using D4D.Platform.Persistence;
namespace D4D.Platform.Providers
{
    public class CommentProvider
    {
        #region instance
        private static readonly CommentProvider instance = new CommentProvider();

        internal static CommentProvider Instance
        {
            get
            {
                return instance;
            }
        }
        #endregion

        public int InsertComment(Comment comment)
        {
            return CommentDao.InsertComment(comment);
        }

        public void DeleteComment(int commentId)
        {
            CommentDao.DeleteComment(commentId);
        }

        public void DeleteCommentByObject(int objectId, ObjectTypeDefine objectType)
        {
            CommentDao.DeleteCommentByObject(objectId, (int)objectType);
        }

        public Comment GetComment(int commentId)
        {
            return CommentDao.GetComment(commentId);
        }

        public List<Comment> GetPagedComments(PagingContext pager, PublishStatus publishStatus, int objectId, ObjectTypeDefine objectType)
        {
            return CommentDao.GetPagedComments(pager, (int)publishStatus, objectId, (int)objectType);
        }
    }
}
