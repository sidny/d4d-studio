using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace D4D.Platform.Domain
{
    public class D4DDefine
    {
        public const string DBInstanceName = "d4d";
        public const string JaneBBSDBInstanceName = "janebbs";
        public const string DEFAULT_PROFILEPATH = @"d:\sitefiles\profile\";
        public const string DEFAULT_UPLOADROOTPATH = @"d:\sitefiles\upload\";
        public const string DEFAULT_WATERMARKPATH=@"d:\webroot\showcitytimes\static\watermark\sct_logo2.png";
        public const string DEFAULT_UPLOADROOTHTTPPATH = "http://www.showcitytimes.net/upload/";
        public const string NEWS_VIDEO_REMARK = "video";
    }
    public enum NewsRemarkType : int
    {
        All = -1,
        Normal = 0,
        Video = 1
    }
    public enum ObjectTypeDefine:int
    {
        None = 0,
        News = 1,
        MusicTitle = 2,
        Song = 3,
        Album=4,
        Image=5,
        Show = 6,
        Video=7,
        //2000 is 商品订单
        //2100 订单用户录入备注
    }
    /// <summary>
    /// 发布状态
    /// </summary>
    public enum PublishStatus:int
    {
        None = 0,//未发布
        Publish = 1,//发布 
        ALL = 2
    }

    public enum BandType : int
    {
     
        All = -1,
        Company = 0,
        ZLY =1,
        WZL=2
    }
}
