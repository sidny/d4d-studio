using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using JANE.Shop.Domain;
using Core.Data;
using D4D.Platform.Domain;
namespace JANE.Shop.Persistence
{
    /// <summary>
    /// 商品信息
    /// </summary>
    internal static class JaneShopItemsDao
    {
        internal static int SetShopItem(ShopItem item)
        {
            if (item == null) return -1;

            SafeProcedure.ExecuteNonQuery(
             Database.GetDatabase(JaneDefine.DBInstanceName),
             "dbo.Shop_items_Set",
             delegate(IParameterSet parameters)
             {
                 parameters.AddWithValue("@Id", item.Id);
                 parameters.AddWithValue("@name", item.Name);
                 parameters.AddWithValue("@description", item.Description);
                 parameters.AddWithValue("@body", item.Body);
                 parameters.AddWithValue("@price", item.Price);
                 parameters.AddWithValue("@SImage", item.SImage);
                 parameters.AddWithValue("@LImage", item.LImage);
                 parameters.AddWithValue("@PublishDate", item.PublishDate);            
                 parameters.AddWithValue("@AddUserId", item.AddUserID);
                 parameters.AddWithValue("@Status", (int)(item.Status));                
                 parameters.AddWithValue("@RetVal", DBNull.Value, ParameterDirectionWrap.ReturnValue);

             },
             delegate(IParameterSet outputParameters)
             {
                 item.Id = Convert.ToInt32(outputParameters.GetValue("@RetVal"));
             });

            return item.Id;
        }

        internal static void DeleteShopItem(int id)
        {
            if (id > 0)
            {
                SafeProcedure.ExecuteNonQuery(
             Database.GetDatabase(JaneDefine.DBInstanceName),
             "dbo.Shop_items__Delete",
             id);
            }
        }

        internal static ShopItem GetShopItem(int id)
        {
            ShopItem m = new ShopItem(id);
            if (id > 0)
            {
                SafeProcedure.ExecuteAndMapRecords(
                        Database.GetDatabase(JaneDefine.DBInstanceName),
                     "dbo.Shop_items_Get",
                     delegate(IRecord record)
                     {
                         m.Id = record.GetInt32OrDefault(0, 0);
                         m.Name = record.GetStringOrEmpty(1);
                         m.Description = record.GetStringOrEmpty(2);
                         m.Price = record.GetDouble(3);
                         m.SImage = record.GetStringOrEmpty(4);
                         m.LImage = record.GetStringOrEmpty(5);
                         m.PublishDate = record.GetDateTimeOrEmpty(6);
                         m.AddUserID = record.GetInt32OrDefault(7, 0);
                         m.AddDate = record.GetDateTime(8);
                         m.Status = (PublishStatus)(record.GetInt32OrDefault(9, 0));
                         m.Body = record.GetStringOrEmpty(10);
                     
                     },
                     id);
            }
            return m;
        }

        internal static void MapList(IRecord record, List<ShopItem> list)
        {
            ShopItem m = new ShopItem();
            m.Id = record.GetInt32OrDefault(0, 0);
            m.Name = record.GetStringOrEmpty(1);
            m.Description = record.GetStringOrEmpty(2);
            m.Price = record.GetDouble(3);
            m.SImage = record.GetStringOrEmpty(4);
            m.LImage = record.GetStringOrEmpty(5);
            m.PublishDate = record.GetDateTimeOrEmpty(6);
            m.AddUserID = record.GetInt32OrDefault(7, 0);
            m.AddDate = record.GetDateTime(8);
            m.Status = (PublishStatus)(record.GetInt32OrDefault(9, 0));                

            list.Add(m);
        }
        internal static List<ShopItem> GetPagedShopItem(PagingContext pager, int publishStatus)
        {
            List<ShopItem> list = new List<ShopItem>(pager.RecordsPerPage);

            SafeProcedure.ExecuteAndMapRecords(Database.GetDatabase(JaneDefine.DBInstanceName),
               "dbo.Shop_items_GetPaged",
               delegate(IParameterSet parameters)
               {
                   parameters.AddWithValue("@PublishStatus", publishStatus);
                   parameters.AddWithValue("@PageIndex", pager.CurrentPageNumber);
                   parameters.AddWithValue("@PageSize", pager.RecordsPerPage);
                   parameters.AddWithValue("@NumberOfCount", 0, ParameterDirectionWrap.Output);
               },
               delegate(IRecord record)
               {
                   MapList(record, list);
               },
               delegate(IParameterSet outputParameters)
               {
                   pager.TotalRecordCount = outputParameters.GetValue("@NumberOfCount") == DBNull.Value ? 0 : (int)outputParameters.GetValue("@NumberOfCount");
               }
           );

            return list;
        }

        internal static List<ShopItem> GetPagedShopItemByPublishDate(PagingContext pager, int publishStatus,
            DateTime sTime,DateTime eTime)
        {
            List<ShopItem> list = new List<ShopItem>(pager.RecordsPerPage);

            SafeProcedure.ExecuteAndMapRecords(Database.GetDatabase(JaneDefine.DBInstanceName),
               "dbo.Shop_items_GetPagedByPublishDate",
               delegate(IParameterSet parameters)
               {
                   parameters.AddWithValue("@STime", sTime);
                   parameters.AddWithValue("@ETime", eTime);               
                   parameters.AddWithValue("@PublishStatus", publishStatus);
                   parameters.AddWithValue("@PageIndex", pager.CurrentPageNumber);
                   parameters.AddWithValue("@PageSize", pager.RecordsPerPage);
                   parameters.AddWithValue("@NumberOfCount", 0, ParameterDirectionWrap.Output);
               },
               delegate(IRecord record)
               {
                   MapList(record, list);
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
