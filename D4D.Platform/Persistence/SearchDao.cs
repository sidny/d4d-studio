using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using D4D.Platform.Domain;
using Core.Data;
namespace D4D.Platform.Persistence
{
    internal static class SearchDao
    {

        internal static void MapSeachResultList(IRecord record, List<SearchResult> list,ObjectTypeDefine objectType)
        {
            SearchResult m = new SearchResult();
            m.ObjectType = objectType;
            m.ObjectId = record.GetInt32OrDefault(0, 0);
            m.Title = record.GetStringOrEmpty(1);
            m.Body = record.GetStringOrEmpty(2);
            m.SImage = record.GetStringOrEmpty(3);           

            list.Add(m);
        }


        internal static List<SearchResult> GetPagedSearch(PagingContext pager, 
            string searchText,ObjectTypeDefine objectType)
        {
            List<SearchResult> list = new List<SearchResult>(pager.RecordsPerPage);

            string SearchSp = string.Empty;
            switch (objectType)
            {
                case ObjectTypeDefine.Show:
                    SearchSp = "dbo.Search_GetPagedShow";
                    break;
                case ObjectTypeDefine.MusicTitle:
                case ObjectTypeDefine.Song:
                    SearchSp = "dbo.Search_GetPagedMusic";
                    break;
                case ObjectTypeDefine.Album:
                case ObjectTypeDefine.Image:
                    SearchSp = "dbo.Search_GetPagedAlbum";
                    break;
                case ObjectTypeDefine.Video:
                    SearchSp = "dbo.Search_GetPagedVideoNews";
                    break;
                case ObjectTypeDefine.News:
                    SearchSp = "dbo.Search_GetPagedNews";
                    break;
                default:
                    return list;
                    
            }

            SafeProcedure.ExecuteAndMapRecords(Database.GetDatabase(D4DDefine.DBInstanceName),
               SearchSp,
               delegate(IParameterSet parameters)
               {
                   parameters.AddWithValue("@SearchTxt", searchText);
                   parameters.AddWithValue("@PageIndex", pager.CurrentPageNumber);
                   parameters.AddWithValue("@PageSize", pager.RecordsPerPage);
                   parameters.AddWithValue("@NumberOfCount", 0, ParameterDirectionWrap.Output);
               },
               delegate(IRecord record)
               {
                   MapSeachResultList(record, list, objectType);
               },
               delegate(IParameterSet outputParameters)
               {
                   pager.TotalRecordCount = outputParameters.GetValue("@NumberOfCount") == DBNull.Value ? 0 : (int)outputParameters.GetValue("@NumberOfCount");
               }
           );

            return list;
        }
    }
}
