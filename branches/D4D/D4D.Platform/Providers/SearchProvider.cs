using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using D4D.Platform.Domain;
using D4D.Platform.Persistence;
namespace D4D.Platform.Providers
{
    public class SearchProvider
    {
        #region instance
        private static readonly SearchProvider instance = new SearchProvider();

        internal static SearchProvider Instance
        {
            get
            {
                return instance;
            }
        }
        #endregion

        public List<SearchResult> GetPagedSearch(PagingContext pager,
            string searchText, ObjectTypeDefine objectType)
        {
            if (string.IsNullOrEmpty(searchText)) return new List<SearchResult>();
            return SearchDao.GetPagedSearch(pager, searchText, objectType);
        }
    }
}
