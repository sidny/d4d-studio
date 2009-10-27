using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using D4D.Platform.Domain;
using Core.Data;
namespace D4D.Platform.Persistence
{
    internal static class CommentDao
    {

        internal static int InsertComment(Comment comment)
        {
            if (comment == null) return -1;

            SafeProcedure.ExecuteNonQuery(
             Database.GetDatabase(D4DDefine.DBInstanceName),
             "dbo.Comment_Insert",
             delegate(IParameterSet parameters)
             {
                 parameters.AddWithValue("@ObjectId", comment.ObjectId);
                 parameters.AddWithValue("@ObjectType", (int)(comment.ObjectType));
                 parameters.AddWithValue("@UserId", comment.UserId);
                 parameters.AddWithValue("@UserName", comment.UserName);
                 parameters.AddWithValue("@AddDate", comment.AddDate);
                 parameters.AddWithValue("@Body", comment.Body);
                 parameters.AddWithValue("@Remark", comment.Remark);
                 parameters.AddWithValue("@Status",(int)(comment.Status));             
                 parameters.AddWithValue("@RetVal", DBNull.Value, ParameterDirectionWrap.ReturnValue);

             },
             delegate(IParameterSet outputParameters)
             {
                 comment.CommentId = Convert.ToInt32(outputParameters.GetValue("@RetVal"));
             });

            return comment.CommentId;
        }

        internal static void DeleteComment(int commentId)
        {
            if (commentId > 0)
            {
                SafeProcedure.ExecuteNonQuery(
             Database.GetDatabase(D4DDefine.DBInstanceName),
             "dbo.Comment_Delete",
             commentId);
            }
        }

        internal static void DeleteCommentByObject(int objectId,int objectType)
        {
            if (objectId > 0)
            {
                SafeProcedure.ExecuteNonQuery(
             Database.GetDatabase(D4DDefine.DBInstanceName),
             "dbo.Comment_DeleteByObject",
             objectId, objectType);
            }
        }

        internal static Comment GetComment(int commentId)
        {
            Comment c = new Comment();
            if (commentId > 0)
            {
                SafeProcedure.ExecuteAndMapRecords(
                        Database.GetDatabase(D4DDefine.DBInstanceName),
                     "dbo.Comment_Get",
                     delegate(IRecord record)
                     {
                         c.CommentId = record.GetInt32OrDefault(0, 0);
                         c.ObjectId = record.GetInt32OrDefault(1, 0);
                         c.ObjectType =(ObjectTypeDefine)(record.GetInt32OrDefault(2, 0));
                         c.UserId = record.GetInt32OrDefault(3, 0);
                         c.UserName = record.GetStringOrEmpty(4);
                         c.AddDate = record.GetDateTime(5);
                         c.Body =  record.GetStringOrEmpty(6);
                         c.Remark =record.GetStringOrEmpty(7);
                         c.Status = (PublishStatus)(record.GetInt32OrDefault(8, 0));
                      
                     },
                     commentId);
            }
            return c;
        }

        internal static List<Comment> GetPagedComments(PagingContext pager, int publishStatus,int objectId,int objectType)
        {
            List<Comment> list = new List<Comment>(pager.RecordsPerPage);

            SafeProcedure.ExecuteAndMapRecords(Database.GetDatabase(D4DDefine.DBInstanceName),
               "dbo.Comment_GetPaged",
               delegate(IParameterSet parameters)
               {
                   parameters.AddWithValue("@PublishStatus", publishStatus);
                   parameters.AddWithValue("@ObjectId", objectId);
                   parameters.AddWithValue("@ObjectType", objectType);
                   parameters.AddWithValue("@PageIndex", pager.CurrentPageNumber);
                   parameters.AddWithValue("@PageSize", pager.RecordsPerPage);
                   parameters.AddWithValue("@NumberOfCount", 0, ParameterDirectionWrap.Output);
               },
               delegate(IRecord record)
               {
                 Comment c = new Comment();
                        c.CommentId = record.GetInt32OrDefault(0, 0);
                         c.ObjectId = record.GetInt32OrDefault(1, 0);
                         c.ObjectType =(ObjectTypeDefine)(record.GetInt32OrDefault(2, 0));
                         c.UserId = record.GetInt32OrDefault(3, 0);
                         c.UserName = record.GetStringOrEmpty(4);
                         c.AddDate = record.GetDateTime(5);
                         c.Body =  record.GetStringOrEmpty(6);
                         c.Remark =record.GetStringOrEmpty(7);
                         c.Status = (PublishStatus)(record.GetInt32OrDefault(8, 0));

                   list.Add(c);
               },
               delegate(IParameterSet outputParameters)
               {
                   pager.TotalRecordCount = outputParameters.GetValue("@NumberOfCount") == DBNull.Value ? 0 : (int)outputParameters.GetValue("@NumberOfCount");
               }
           );

            return list;
        }

        internal static Dictionary<int, int> GetComments20(List<int> oIds,int objectType)
        {

            Dictionary<int, int> dic = new Dictionary<int, int>();

            if (oIds != null && oIds.Count > 0)
            {
                SafeProcedure.ExecuteAndMapRecords(Database.GetDatabase(D4DDefine.DBInstanceName),
               "dbo.Comment_GetCmments20",
               delegate(IParameterSet parameters)
               {
                   parameters.AddWithValue("@ObjectType", objectType);
                   int maxCount = oIds.Count > 20 ? 20 : oIds.Count;
                   for (int i = 0; i < maxCount; i++)
                   {
                       parameters.AddWithValue("@id" + (i + 1).ToString(), oIds[i]);
                   }
               },
               delegate(IRecord record)
               {
                   int commentCount = record.GetInt32OrDefault(0, 0);
                   int objectId = record.GetInt32OrDefault(1, 0);


                   if (!dic.ContainsKey(objectId))
                       dic.Add(objectId, commentCount);
               }
           );
            }

            return dic;
        }


    }
}
