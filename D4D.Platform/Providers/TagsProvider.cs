using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using D4D.Platform.Domain;
using D4D.Platform.Persistence;
using D4D.Platform.Helper;
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
            List<int> list = new List<int>();
            list.Add(tagId);
            AddTagHit(list);
        }
        public void AddTagHit(List<int> tagId)
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
        const int FilterGetMaxCount = 1000;
        public List<Tag> GetTopTagsEN(int maxCount)
        {
            List<Tag> list = TagsDao.GetTopTags(FilterGetMaxCount);
            if (list != null && list.Count > 0)
            {
                int nowCount = 0;
                List<Tag> listResult = new List<Tag>(maxCount);
                foreach (Tag tag in list)
                {
                    if (nowCount == maxCount) 
                        break;

                    if (StringHelper.IsNatural_Number(tag.TagName))
                    {
                        listResult.Add(tag);
                        nowCount++;
                    }
                }

                return listResult;
            }
            else
                return list;
        }

        public List<Tag> GetTopTagsCN(int maxCount)
        {
            List<Tag> list = TagsDao.GetTopTags(FilterGetMaxCount);
            if (list != null && list.Count > 0)
            {
                int nowCount = 0;
                List<Tag> listResult = new List<Tag>(maxCount);
                foreach (Tag tag in list)
                {
                    if (nowCount == maxCount)
                        break;

                    if (string.IsNullOrEmpty(tag.TagName))
                        continue;

                    if (!StringHelper.IsNatural_Number(tag.TagName))
                    {
                        listResult.Add(tag);
                        nowCount++;
                    }
                }

                return listResult;
            }
            else
                return list;
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
