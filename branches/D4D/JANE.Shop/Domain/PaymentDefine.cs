using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace JANE.Shop.Domain
{
    public class AliPayDefinition
    {
        public const string DEFAULT_GATEWAYURL = "https://www.alipay.com/cooperate/gateway.do";
        public const string HANDLER_SUCCESS = "success";
        public const string HANDLER_FAIL = "fail";
        public const string HANDLER_TRUE = "true";
        public const string HANDLER_FALSE = "false";


        public const string DEFAULT_ENCODINGNAME = "utf-8";

        public const string DEFAULT_RETURNURL = "http://cn.janezhang.com/payment/payreturn.ashx";
        public const string DEFAULT_NOTIFYURL = "http://cn.janezhang.com/payment/paynotify.ashx";

        public const string DEFAULT_PARTNERID = "2088002452393183";
        public const string DEFAULT_PARTNERKEY = "zvbfijqmxli60uwdzdyt6rc9w28knofk";

        public const string DEFAULT_SIGNTYPE = "MD5";     
        public const int DEFAULT_HTTPTIMEOUT = 120000;
        public const string SERVICE_CREATE_DIRECT_PAY_BY_USER = "create_direct_pay_by_user";
        public const string SERVICE_NOTIFY_VERIFY = "notify_verify";

    }
}
