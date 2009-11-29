using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace JANE.Shop.Domain
{


    public class JaneDefine
    {
        public const string JaneBBSDBInstanceName = "janebbs";
        public const string DBInstanceName = "d4d";
    }

    public enum OrderType : int
    {
        ShopCar = 0,//购物车
        Order =1,//订单
        ALL = 2
    }

    public enum PayType : int
    {
        None = 0,
        AliPay = 1,//支付宝
        BankCard =2,//银行卡
        QuickMonty =3 ,//快钱
        ALL = 9
    }

    public enum PayResult : int
    {
        None = 0,//未发布,创建未支付
        HasPay = 1,//已支付
        PayFaild = 2,//支付失败
        ALL = 9
    }
    

    /// <summary>
    /// 发布状态
    /// </summary>
    public enum ShopStatus : int
    {
        None = 0,//未发布,下架？
        Publish = 1,//发布 
        ALL = 2
    }

}
