﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using JANE.Shop.Domain;
using Core.Data;
using D4D.Platform.Domain;
namespace JANE.Shop.Persistence
{
    /// <summary>
    /// 订单信息
    /// </summary>
     internal static class JaneShopOrdersDao
    {
         internal static int SetShopOrder(ShopOrder item)
        {
            if (item == null) return -1;

            SafeProcedure.ExecuteNonQuery(
             Database.GetDatabase(JaneDefine.DBInstanceName),
             "dbo.Shop_orders_Set",
             delegate(IParameterSet parameters)
             {
                 parameters.AddWithValue("@Id", item.Id);
                 parameters.AddWithValue("@userid", item.UserId);
                 parameters.AddWithValue("@addDate", item.AddDate);
                 parameters.AddWithValue("@ordertype", (int)(item.Ordertype));
                 parameters.AddWithValue("@address", item.Address);
                 parameters.AddWithValue("@email", item.Email);
                 parameters.AddWithValue("@mobile", item.Mobile);
                 parameters.AddWithValue("@paymoney", item.Paymoney);
                 parameters.AddWithValue("@paytype", (int)(item.Paytype));
                 parameters.AddWithValue("@payresult",  (int)(item.Payresult));
                 parameters.AddWithValue("@payremark", item.Payremark);
                 parameters.AddWithValue("@paythirdnum", item.Paythirdnum);
                 parameters.AddWithValue("@paydate", item.Paydate);
                 parameters.AddWithValue("@zipcode", item.ZipCode);
                 parameters.AddWithValue("@username", item.UserName);
                 parameters.AddWithValue("@RegionId", item.RegionId);
                 parameters.AddWithValue("@Freight", item.Freight);
                 parameters.AddWithValue("@RegionStr", item.RegionStr);
                 parameters.AddWithValue("@RetVal", DBNull.Value, ParameterDirectionWrap.ReturnValue);

             },
             delegate(IParameterSet outputParameters)
             {
                 item.Id = Convert.ToInt32(outputParameters.GetValue("@RetVal"));
             });

            return item.Id;
        }

         internal static void DeleteShopOrder(int id)
        {
            if (id > 0)
            {
                SafeProcedure.ExecuteNonQuery(
             Database.GetDatabase(JaneDefine.DBInstanceName),
             "dbo.Shop_orders_Delete",
             id);
            }
        }

         internal static ShopOrder GetShopOrder(int id)
        {
            ShopOrder m = new ShopOrder(id);
            if (id > 0)
            {
                SafeProcedure.ExecuteAndMapRecords(
                        Database.GetDatabase(JaneDefine.DBInstanceName),
                     "dbo.Shop_orders_Get",
                     delegate(IRecord record)
                     {
                         m.Id = record.GetInt32OrDefault(0, 0);
                         m.UserId = record.GetInt32OrDefault(1,0);
                         m.AddDate = record.GetDateTimeOrEmpty(2);
                         m.Ordertype =(OrderType)(record.GetInt32OrDefault(3,0));
                         m.Address = record.GetStringOrEmpty(4);
                         m.Email = record.GetStringOrEmpty(5);
                         m.Mobile = record.GetStringOrEmpty(6);
                         m.Paymoney = record.GetDouble(7);
                         m.Paytype =(PayType)( record.GetInt32OrDefault(8,0));
                         m.Payresult = (PayResult)(record.GetInt32OrDefault(9, 0));
                         m.Payremark = record.GetStringOrEmpty(10);
                         m.Paythirdnum = record.GetStringOrEmpty(11);
                         m.Paydate = record.GetDateTime(12);
                         m.ZipCode = record.GetStringOrEmpty(13);
                         m.UserName = record.GetStringOrEmpty(14);
                         m.RegionId = record.GetInt32OrDefault(15, 0);
                         m.Freight = record.GetDouble(16);
                         m.RegionStr = record.GetStringOrEmpty(17);
                     },
                     id);
            }
            return m;
        }

         internal static ShopOrder GetUserShopCar(int userId)
         {
             ShopOrder m = new ShopOrder();
             if (userId > 0)
             {
                 SafeProcedure.ExecuteAndMapRecords(
                         Database.GetDatabase(JaneDefine.DBInstanceName),
                      "dbo.Shop_orders_ShopCarGet",
                      delegate(IRecord record)
                      {
                          m.Id = record.GetInt32OrDefault(0, 0);
                          m.UserId = record.GetInt32OrDefault(1, 0);
                          m.AddDate = record.GetDateTimeOrEmpty(2);
                          m.Ordertype = (OrderType)(record.GetInt32OrDefault(3, 0));
                          m.Address = record.GetStringOrEmpty(4);
                          m.Email = record.GetStringOrEmpty(5);
                          m.Mobile = record.GetStringOrEmpty(6);
                          m.Paymoney = record.GetDouble(7);
                          m.Paytype = (PayType)(record.GetInt32OrDefault(8, 0));
                          m.Payresult = (PayResult)(record.GetInt32OrDefault(9, 0));
                          m.Payremark = record.GetStringOrEmpty(10);
                          m.Paythirdnum = record.GetStringOrEmpty(11);
                          m.Paydate = record.GetDateTime(12);
                          m.ZipCode = record.GetStringOrEmpty(13);
                          m.UserName = record.GetStringOrEmpty(14);
                          m.RegionId = record.GetInt32OrDefault(15, 0);
                          m.Freight = record.GetDouble(16);
                          m.RegionStr = record.GetStringOrEmpty(17);
                      },
                      userId);
             }
             return m;
         }

         internal static void MapList(IRecord record, List<ShopOrder> list)
        {
            ShopOrder m = new ShopOrder();
            m.Id = record.GetInt32OrDefault(0, 0);
            m.UserId = record.GetInt32OrDefault(1, 0);
            m.AddDate = record.GetDateTimeOrEmpty(2);
            m.Ordertype = (OrderType)(record.GetInt32OrDefault(3, 0));
            m.Address = record.GetStringOrEmpty(4);
            m.Email = record.GetStringOrEmpty(5);
            m.Mobile = record.GetStringOrEmpty(6);
            m.Paymoney = record.GetDouble(7);
            m.Paytype = (PayType)(record.GetInt32OrDefault(8, 0));
            m.Payresult = (PayResult)(record.GetInt32OrDefault(9, 0));
            m.Payremark = record.GetStringOrEmpty(10);
            m.Paythirdnum = record.GetStringOrEmpty(11);
            m.Paydate = record.GetDateTime(12);
            m.ZipCode = record.GetStringOrEmpty(13);
            m.UserName = record.GetStringOrEmpty(14);
            m.RegionId = record.GetInt32OrDefault(15, 0);
            m.Freight = record.GetDouble(16);
             m.RegionStr = record.GetStringOrEmpty(17);
            list.Add(m);
        }
         internal static List<ShopOrder> GetPagedShopOrder(PagingContext pager, int ordertype)
        {
            List<ShopOrder> list = new List<ShopOrder>(pager.RecordsPerPage);

            SafeProcedure.ExecuteAndMapRecords(Database.GetDatabase(JaneDefine.DBInstanceName),
               "dbo.Shop_orders_GetPaged",
               delegate(IParameterSet parameters)
               {
                   parameters.AddWithValue("@ordertype", ordertype);
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

         internal static List<ShopOrder> GetPagedShopOrderbyUser(PagingContext pager,int userid, int ordertype)
         {
             List<ShopOrder> list = new List<ShopOrder>(pager.RecordsPerPage);

             SafeProcedure.ExecuteAndMapRecords(Database.GetDatabase(JaneDefine.DBInstanceName),
                "dbo.Shop_orders_GetPagedByUser",
                delegate(IParameterSet parameters)
                {
                    parameters.AddWithValue("@userid", userid);
                    parameters.AddWithValue("@ordertype", ordertype);
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
