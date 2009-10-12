using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using D4D.Platform.Domain;
using D4D.Platform.Persistence;
namespace D4D.Platform.Providers
{
    public class TagsProvider
    {
        #region instance
        private static readonly TagsProvider instance = new TagsProvider();

        internal static TagsProvider Instance
        {
            get
            {
                return instance;
            }
        }
        #endregion

        #region tag
        /// <summary>
        /// tagid<0 表示新增
        /// >0 则为更新
        /// </summary>
        /// <param name="tag"></param>
        /// <returns></returns>
        public int SetTag(Tag tag)
        {
            return TagsDao.SetTag(tag);
        }
        /// <summary>
        /// 删除tag
        /// </summary>
        /// <param name="tagId"></param>
        public void DeleteTag(int tagId)
        {
            TagsDao.DeleteTag(tagId);
        }
        /// <summary>
        /// tag 计数+1
        /// </summary>
        /// <param name="tagId"></param>
        public void AddTagHit(int tagId)
        {
            TagsDao.AddTagHit(tagId);
        }
        /// <summary>
        /// 获取OneTag
        /// </summary>
        /// <param name="tagId"></param>
        /// <returns></returns>
        public Tag GetTag(int tagId)
        {
            return TagsDao.GetTag(tagId);
        }
        /// <summary>
        /// 获取tag的top列表
        /// </summary>
        /// <param name="maxCount"></param>
        /// <returns></returns>
        public List<Tag> GetTopTags(int maxCount)
        {
            return TagsDao.GetTopTags(maxCount);
        }
        /// <summary>
        /// 获取带分页的Tags
        /// </summary>
        /// <param name="pager"></param>
        /// <returns></returns>
        public List<Tag> GetPagedTags(PagingContext pager)
        {
            return TagsDao.GetPagedTags(pager);
        }

        public Dictionary<int, Tag> GetTags20(List<int> tagIds)
        {
            return TagsDao.GetTags20(tagIds);
        }

        #endregion

        #region tagrelation

        public void SetTagRelation(TagRelation tagRelation)
        {
            TagsDao.SetTagRelation(tagRelation);
        }

        public void DeleteTagRelation(int tagId, int objectId, ObjectTypeDefine objectType)
        {
            TagsDao.DeleteTagRelation(tagId, objectId, (int)objectType);
        }

        public void DeleteTagRelationByObject(int objectId, ObjectTypeDefine objectType)
        {
            TagsDao.DeleteTagRelationByObject(objectId, (int)objectType);
        }

        public void DeleteTagRelationByTagId(int tagId)
        {
            TagsDao.DeleteTagRelationByTagId(tagId);
        }

        public TagRelation GetTagRelation(int tagId, int objectId, ObjectTypeDefine objectType)
        {
            return TagsDao.GetTagRelation(tagId, objectId, (int)objectType);
        }

        public List<TagRelation> GetTagRelationByObject(int objectId, ObjectTypeDefine objectType)
        {
            return TagsDao.GetTagRelationByObject(objectId, (int)objectType);
        }

        public List<TagRelation> GetTagRelationByTagId(int tagId)
        {
            return TagsDao.GetTagRelationByTagId(tagId);
        }
        #endregion
    }
}
