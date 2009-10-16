using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace D4D.Platform.Domain
{
    public class D4DDefine
    {
        public const string DBInstanceName = "d4d";
        public const string DEFAULT_PROFILEPATH = @"d:\sitefiles\profile\";
        public const string DEFAULT_UPLOADROOTPATH = @"d:\sitefiles\upload\";
        public const string DEFAULT_UPLOADROOTHTTPPATH = "http://www.showcitytimes.net/upload/";
    }

    public enum ObjectTypeDefine:int
    {
        None = 0,
        News = 1,
        MusicTitle = 2,
        Song = 3,
        Album=4,
        Image=5,
        Show = 6
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
        Company = 0,
        ZLY =1,
        WZL=2
    }
}
