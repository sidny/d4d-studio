using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace JANE.Shop.Domain
{


    public class JaneDefine
    {
        public const string JaneBBSDBInstanceName = "janebbs";
        public const string DBInstanceName = "jane";
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
