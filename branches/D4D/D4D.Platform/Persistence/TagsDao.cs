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
        internal static List<Tag> GetTopTag(int maxCount)
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
    }
}
