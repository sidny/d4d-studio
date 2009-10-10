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
    }
}
