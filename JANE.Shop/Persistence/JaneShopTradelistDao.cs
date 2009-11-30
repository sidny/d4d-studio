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
    /// 购物列表
    /// </summary>
    internal static class JaneShopTradelistDao
    {
        internal static int SetShopTradelist(ShopTradelist item)
        {
            if (item == null) return -1;

            SafeProcedure.ExecuteNonQuery(
             Database.GetDatabase(JaneDefine.DBInstanceName),
             "dbo.Shop_tradelist_Set",
             delegate(IParameterSet parameters)
             {
                 parameters.AddWithValue("@Id", item.Id);
                 parameters.AddWithValue("@orderid", item.OrderId);
                 parameters.AddWithValue("@itemid", item.ItemId);
                 parameters.AddWithValue("@itemcount", item.ItemCount);              
                 parameters.AddWithValue("@RetVal", DBNull.Value, ParameterDirectionWrap.ReturnValue);

             },
             delegate(IParameterSet outputParameters)
             {
                 item.Id = Convert.ToInt32(outputParameters.GetValue("@RetVal"));
             });

            return item.Id;
        }

        internal static void DeleteShopTradelist(int id)
        {
            if (id > 0)
            {
                SafeProcedure.ExecuteNonQuery(
             Database.GetDatabase(JaneDefine.DBInstanceName),
             "dbo.Shop_tradelist_Delete",
             id);
            }
        }

        internal static void DeleteShopTradelistByOrderId(int orderid)
        {
            if (orderid > 0)
            {
                SafeProcedure.ExecuteNonQuery(
             Database.GetDatabase(JaneDefine.DBInstanceName),
             "dbo.Shop_tradelist_Deletebyorderid",
             orderid);
            }
        }


        internal static ShopTradelist GetShopTradelist(int id)
        {
            ShopTradelist m = new ShopTradelist(id);
            if (id > 0)
            {
                SafeProcedure.ExecuteAndMapRecords(
                        Database.GetDatabase(JaneDefine.DBInstanceName),
                     "dbo.Shop_tradelist_Get",
                     delegate(IRecord record)
                     {
                         m.Id = record.GetInt32OrDefault(0, 0);
                         m.OrderId = record.GetInt32OrDefault(1, 0);
                         m.ItemId = record.GetInt32OrDefault(2,0);
                         m.ItemCount = record.GetInt32OrDefault(3,0);
                      
                     },
                     id);
            }
            return m;
        }

        internal static List<ShopTradelist> GetShopTradelistByOrderId(int orderid)
        {
            List<ShopTradelist> list = new List<ShopTradelist>();

            if (orderid > 0)
            {
                SafeProcedure.ExecuteAndMapRecords(
                        Database.GetDatabase(JaneDefine.DBInstanceName),
                     "dbo.Shop_tradelist_Getbyorderid",
                     delegate(IRecord record)
                     {
                         MapList(record, list);

                     },
                     orderid);
            }
            return list;
        }

        internal static void MapList(IRecord record, List<ShopTradelist> list)
        {
            ShopTradelist m = new ShopTradelist();
            m.Id = record.GetInt32OrDefault(0, 0);
            m.OrderId = record.GetInt32OrDefault(1, 0);
            m.ItemId = record.GetInt32OrDefault(2, 0);
            m.ItemCount = record.GetInt32OrDefault(3, 0);

            list.Add(m);
        }
        internal static List<ShopTradelist> GetPagedTradelist(PagingContext pager, int orderid)
        {
            List<ShopTradelist> list = new List<ShopTradelist>(pager.RecordsPerPage);

            SafeProcedure.ExecuteAndMapRecords(Database.GetDatabase(JaneDefine.DBInstanceName),
               "dbo.Shop_tradelist_GetPaged",
               delegate(IParameterSet parameters)
               {
                   parameters.AddWithValue("@orderid", orderid);
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
