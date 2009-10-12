using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using D4D.Platform.Domain;
using Core.Data;
namespace D4D.Platform.Persistence
{
    internal static class TagsDao
    {

        #region Tag
        /// <summary>
        /// tagid<0 表示新增
        /// >0 则为更新
        /// </summary>
        /// <param name="tag"></param>
        /// <returns></returns>
        internal static int SetTag(Tag tag)
        {
              if (tag == null) return -1;

               SafeProcedure.ExecuteNonQuery(
                Database.GetDatabase(D4DDefine.DBInstanceName),
                "dbo.Tags_AddTag",
                delegate(IParameterSet parameters)
                {
                    parameters.AddWithValue("@TagID", tag.TagId);
                    parameters.AddWithValue("@Name", tag.TagName);
                    parameters.AddWithValue("@AddUserID", tag.AddUserID);                   
                    parameters.AddWithValue("@RetVal", DBNull.Value, ParameterDirectionWrap.ReturnValue);
                 
                },
                delegate(IParameterSet outputParameters)
                {
                    tag.TagId = Convert.ToInt32(outputParameters.GetValue("@RetVal"));
                });

               return tag.TagId;
        }
        /// <summary>
        /// 删除tag
        /// </summary>
        /// <param name="tagId"></param>
        internal static void DeleteTag(int tagId)
        {
            if (tagId > 0)
            {
                SafeProcedure.ExecuteNonQuery(
             Database.GetDatabase(D4DDefine.DBInstanceName),
             "dbo.Tags_DeleteTag",
             tagId);
            }
        }
        /// <summary>
        /// tag 计数+1
        /// </summary>
        /// <param name="tagId"></param>
        internal static void AddTagHit(int tagId)
        {
            if (tagId > 0)
            {
                SafeProcedure.ExecuteNonQuery(
             Database.GetDatabase(D4DDefine.DBInstanceName),
             "dbo.Tags_AddTagHits",
             tagId);
            }
        }
        /// <summary>
        /// 获取OneTag
        /// </summary>
        /// <param name="tagId"></param>
        /// <returns></returns>
        internal static Tag GetTag(int tagId)
        {
            Tag tag = new Tag(tagId);
            if (tagId > 0)
            {
                SafeProcedure.ExecuteAndMapRecords(
                        Database.GetDatabase(D4DDefine.DBInstanceName),
                     "dbo.Tags_GetTag",
                     delegate(IRecord record)
                     {
                         tag.TagName = record.GetStringOrEmpty(1);
                         tag.Hits = record.GetInt32OrDefault(2,0);
                         tag.AddUserID = record.GetInt32OrDefault(3,0);
                         tag.AddDate = record.GetDateTime(4);
                     },
                     tagId);
            }
            return tag;
        }
        /// <summary>
        /// 获取tag的top列表
        /// </summary>
        /// <param name="maxCount"></param>
        /// <returns></returns>
        internal static List<Tag> GetTopTags(int maxCount)
        {
            List<Tag> list = new List<Tag>(maxCount);

            SafeProcedure.ExecuteAndMapRecords(
                        Database.GetDatabase(D4DDefine.DBInstanceName),
                     "dbo.Tags_GetTopTag",
                     delegate(IRecord record)
                     {
                         Tag tag = new Tag();
                         tag.TagId = record.GetInt32OrDefault(0, 0);
                         tag.TagName = record.GetStringOrEmpty(1);
                         tag.Hits = record.GetInt32OrDefault(2, 0);
                         tag.AddUserID = record.GetInt32OrDefault(3, 0);
                         tag.AddDate = record.GetDateTime(4);

                         list.Add(tag);
                     },
                     maxCount);

            return list;
        }

        internal static List<Tag> GetPagedTags(PagingContext pager)
        {
            List<Tag> list = new List<Tag>(pager.RecordsPerPage);

            SafeProcedure.ExecuteAndMapRecords(Database.GetDatabase(D4DDefine.DBInstanceName),
               "dbo.GetPagedTags",
               delegate(IParameterSet parameters)
               {
                   parameters.AddWithValue("@PageIndex", pager.CurrentPageNumber);
                   parameters.AddWithValue("@PageSize", pager.RecordsPerPage);                  
                   parameters.AddWithValue("@NumberOfCount", 0, ParameterDirectionWrap.Output);
               },
               delegate(IRecord record)
               {
                   Tag tag = new Tag();
                   tag.TagId = record.GetInt32OrDefault(0, 0);
                   tag.TagName = record.GetStringOrEmpty(1);
                   tag.Hits = record.GetInt32OrDefault(2, 0);
                   tag.AddUserID = record.GetInt32OrDefault(3, 0);
                   tag.AddDate = record.GetDateTime(4);

                   list.Add(tag);
               },
               delegate(IParameterSet outputParameters)
               {
                   pager.TotalRecordCount = outputParameters.GetValue("@NumberOfCount") == DBNull.Value ? 0 : (int)outputParameters.GetValue("@NumberOfCount");
               }
           );      

            return list;
        }
        internal static Dictionary<int, Tag> GetTags20(List<int> tagIds)
        {

            Dictionary<int, Tag> dic = new Dictionary<int, Tag>();

            if (tagIds != null && tagIds.Count > 0)
            {
                SafeProcedure.ExecuteAndMapRecords(Database.GetDatabase(D4DDefine.DBInstanceName),
               "dbo.Tags_GetTags20",
               delegate(IParameterSet parameters)
               {
                   int maxCount = tagIds.Count > 20 ? 20 : tagIds.Count;
                   for (int i = 0; i < maxCount; i++)
                   {
                       parameters.AddWithValue("@tid" + (i + 1).ToString(), tagIds[i]);
                   }
               },
               delegate(IRecord record)
               {
                   Tag tag = new Tag();
                   tag.TagId = record.GetInt32OrDefault(0, 0);
                   tag.TagName = record.GetStringOrEmpty(1);
                   tag.Hits = record.GetInt32OrDefault(2, 0);
                   tag.AddUserID = record.GetInt32OrDefault(3, 0);
                   tag.AddDate = record.GetDateTime(4);

                   if (!dic.ContainsKey(tag.TagId))
                       dic.Add(tag.TagId, tag);
               }
           );      
            }

            return dic;
        }
        #endregion

        #region tag relation

        internal static void SetTagRelation(TagRelation tagRelation)
        {
            if (tagRelation == null) return;

            SafeProcedure.ExecuteNonQuery(
             Database.GetDatabase(D4DDefine.DBInstanceName),
             "dbo.TagRelation_SetRelation",
             tagRelation.TagId,tagRelation.ObjectId,
             (int)tagRelation.ObjectType,
             tagRelation.AddUserID );
        }

        internal static void DeleteTagRelation(int tagId,int objectId,int objectType)
        {        

            SafeProcedure.ExecuteNonQuery(
             Database.GetDatabase(D4DDefine.DBInstanceName),
             "dbo.TagRelation_Delete",
             tagId, objectId, objectType);
        }

        internal static void DeleteTagRelationByObject(int objectId, int objectType)
        {

            SafeProcedure.ExecuteNonQuery(
             Database.GetDatabase(D4DDefine.DBInstanceName),
             "dbo.TagRelation_DeleteByObject",
              objectId, objectType);
        }

        internal static void DeleteTagRelationByTagId(int tagId)
        {
            SafeProcedure.ExecuteNonQuery(
             Database.GetDatabase(D4DDefine.DBInstanceName),
             "dbo.TagRelation_DeleteByTagId",
             tagId);
        }
        internal static TagRelation GetTagRelation(int tagId, int objectId, int objectType)
        {
            TagRelation tag = new TagRelation();
            
                SafeProcedure.ExecuteAndMapRecords(
                        Database.GetDatabase(D4DDefine.DBInstanceName),
                     "dbo.TagRelation_Get",
                     delegate(IRecord record)
                     {
                         tag.Id = record.GetInt32OrDefault(0,0);
                         tag.TagId = record.GetInt32OrDefault(1, 0);
                         tag.ObjectId = record.GetInt32OrDefault(2, 0);
                         tag.ObjectType =(ObjectTypeDefine)(record.GetInt32OrDefault(3, 0));
                         tag.AddUserID = record.GetInt32OrDefault(4, 0);
                         tag.AddDate = record.GetDateTime(5);
                     },
                     tagId, objectId, objectType);
            
            return tag;
        }

        internal static List<TagRelation> GetTagRelationByObject(int objectId, int objectType)
        {
            List<TagRelation> list = new List<TagRelation>();

            SafeProcedure.ExecuteAndMapRecords(
                        Database.GetDatabase(D4DDefine.DBInstanceName),
                     "dbo.TagRelation_GetByObject",
                     delegate(IRecord record)
                     {
                         TagRelation tag = new TagRelation();
                         tag.Id = record.GetInt32OrDefault(0, 0);
                         tag.TagId = record.GetInt32OrDefault(1, 0);
                         tag.ObjectId = record.GetInt32OrDefault(2, 0);
                         tag.ObjectType = (ObjectTypeDefine)(record.GetInt32OrDefault(3, 0));
                         tag.AddUserID = record.GetInt32OrDefault(4, 0);
                         tag.AddDate = record.GetDateTime(5);
                         list.Add(tag);
                     },
                     objectId, objectType);

            return list;
        }

        internal static List<TagRelation> GetTagRelationByTagId(int tagId)
        {
            List<TagRelation> list = new List<TagRelation>();

            SafeProcedure.ExecuteAndMapRecords(
                        Database.GetDatabase(D4DDefine.DBInstanceName),
                     "dbo.TagRelation_GetByTagId",
                     delegate(IRecord record)
                     {
                         TagRelation tag = new TagRelation();
                         tag.Id = record.GetInt32OrDefault(0, 0);
                         tag.TagId = record.GetInt32OrDefault(1, 0);
                         tag.ObjectId = record.GetInt32OrDefault(2, 0);
                         tag.ObjectType = (ObjectTypeDefine)(record.GetInt32OrDefault(3, 0));
                         tag.AddUserID = record.GetInt32OrDefault(4, 0);
                         tag.AddDate = record.GetDateTime(5);
                         list.Add(tag);
                     },
                     tagId);

            return list;
        }

        #endregion
    }
}
