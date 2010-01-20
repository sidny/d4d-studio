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
    /// 地域信息
    /// </summary>
     internal static class JaneShopRegionDao
    {
         internal static int SetShopRegion(ShopRegion item)
        {
            if (item == null) return -1;

            SafeProcedure.ExecuteNonQuery(
             Database.GetDatabase(JaneDefine.DBInstanceName),
             "dbo.Shop_region_Set",
             delegate(IParameterSet parameters)
             {
                 parameters.AddWithValue("@id", item.Id);
                 parameters.AddWithValue("@Name", item.Name);
                 parameters.AddWithValue("@ParentId", item.ParentId);
                 parameters.AddWithValue("@TransferPrice", item.TransferPrice);
                 parameters.AddWithValue("@TransferPrice1", item.TransferPrice1);
                 parameters.AddWithValue("@TransferPrice2", item.TransferPrice2);
                   parameters.AddWithValue("@RetVal", DBNull.Value, ParameterDirectionWrap.ReturnValue);

             },
             delegate(IParameterSet outputParameters)
             {
                 item.Id = Convert.ToInt32(outputParameters.GetValue("@RetVal"));
             });

            return item.Id;
        }

         internal static void DeleteShopRegion(int id)
        {
            if (id > 0)
            {
                SafeProcedure.ExecuteNonQuery(
             Database.GetDatabase(JaneDefine.DBInstanceName),
             "dbo.Shop_region_Delete",
             id);
            }
        }
         internal static ShopRegion GetShopRegion(int id)
        {
            ShopRegion m = new ShopRegion(id);
            if (id > 0)
            {
                SafeProcedure.ExecuteAndMapRecords(
                        Database.GetDatabase(JaneDefine.DBInstanceName),
                     "dbo.Shop_region_Get",
                     delegate(IRecord record)
                     {
                         m.Id = record.GetInt32OrDefault(0, 0);
                         m.Name = record.GetStringOrEmpty(1);
                         m.ParentId = record.GetInt32OrDefault(2,0);
                         m.TransferPrice = record.GetDouble(3);
                         m.TransferPrice1 = record.GetDouble(4);
                         m.TransferPrice2 = record.GetDouble(5);
                     
                     },
                     id);
            }
            return m;
        }

         internal static void MapList(IRecord record, List<ShopRegion> list)
        {
            ShopRegion m = new ShopRegion();
            m.Id = record.GetInt32OrDefault(0, 0);
            m.Name = record.GetStringOrEmpty(1);
            m.ParentId = record.GetInt32OrDefault(2, 0);
            m.TransferPrice = record.GetDouble(3);
            m.TransferPrice1 = record.GetDouble(4);
            m.TransferPrice2 = record.GetDouble(5);
            list.Add(m);
        }

         internal static List<ShopRegion> GetShopItemsByParentId(int parentId)
        {
            List<ShopRegion> list = new List<ShopRegion>();

            SafeProcedure.ExecuteAndMapRecords(Database.GetDatabase(JaneDefine.DBInstanceName),
               "dbo.Shop_region_GetByParentId",
               delegate(IParameterSet parameters)
               {
                   parameters.AddWithValue("@ParentId", parentId);

               },
               delegate(IRecord record)
               {
                   MapList(record, list);
               }
           );

            return list;
        }
    }
}
