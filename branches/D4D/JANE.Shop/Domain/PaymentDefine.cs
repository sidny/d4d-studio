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

        public const string DEFAULT_SELLER_ALIPAYEMAIL = "bd@showcitytimes.net";//wait real account

    }
    /// <summary>
    /// 支付类型
    /// </summary>
    public enum AliPaymentType : byte
    {
        /// <summary>
        /// 商品购买
        /// </summary>
        BuyProduct = 1,
        /// <summary>
        /// 服务购买
        /// </summary>
        BuyService = 2,
        /// <summary>
        /// 网络拍卖
        /// </summary>
        Auction = 3,
        /// <summary>
        /// 捐赠
        /// </summary>
        Contribute = 4,
        /// <summary>
        /// 邮费补偿
        /// </summary>
        RecoupPostage = 5,
        /// <summary>
        /// 奖金
        /// </summary>
        Bonus = 6
    }

    /// <summary>
    /// 交易动作
    /// </summary>
    public enum AliTradeAction : byte
    {
        //买家动作
        /// <summary>
        /// 付款
        /// </summary>
        PAY,
        /// <summary>
        /// 退款
        /// </summary>
        REFUND,
        /// <summary>
        /// 确认收货
        /// </summary>
        CONFIRM_GOODS,
        /// <summary>
        /// 付款方取消快速支付
        /// </summary>
        CANCEL_FAST_PAY,
        /// <summary>
        /// 快速支付付款
        /// </summary>
        WAIT_BUYER_CONFIRM_GOODS,
        /// <summary>
        /// 买家确认收到货，等待支付宝大款给卖家
        /// </summary>
        FP_PAY,
        /// <summary>
        /// 催款中还钱
        /// </summary>
        RM_PAY,
        /// <summary>
        /// 买家修改收货地址
        /// </summary>
        MODIFY_DELIVER_ADDRESS,

        //卖家动作
        /// <summary>
        /// 发货
        /// </summary>
        SEND_GOODS,
        /// <summary>
        /// 拒绝交易
        /// </summary>
        REFUSE_TRADE,
        /// <summary>
        /// 修改交易
        /// </summary>
        MODIFY_TRADE,
        /// <summary>
        /// 收款方拒绝收款
        /// </summary>
        REFUSE_FAST_PAY,

        //买家卖家共有动作
        /// <summary>
        /// 查看物流状态
        /// </summary>
        QUERY_LOGISTICS,
        /// <summary>
        /// 查看退款状态
        /// </summary>
        QUERY_REFUND,
        /// <summary>
        /// 延长对方超时时间
        /// </summary>
        EXTEND_TIMEOUT,
        /// <summary>
        /// 查看明细
        /// </summary>
        VIEW_DETAIL
    }
    /// <summary>
    /// 交易状态
    /// </summary>
    public enum AliTradeState : byte
    {
        /// <summary>
        /// 等待买家付款
        /// </summary>
        WAIT_BUYER_PAY,
        /// <summary>
        /// 交易已创建，等待卖家确认
        /// </summary>
        WAIT_SELLER_CONFIRM_TRADE,
        /// <summary>
        /// 确认买家付款中，暂勿发货
        /// </summary>
        WAIT_SYS_CONFIRM_PAY,
        /// <summary>
        /// 支付宝收到买家付款，请卖家发货
        /// </summary>
        WAIT_SELLER_SEND_GOODS,
        /// <summary>
        /// 卖家已发货，买家确认中
        /// </summary>
        WAIT_BUYER_CONFIRM_GOODS,
        /// <summary>
        /// 买家确认收到货，等待支付宝付款给卖家
        /// </summary>
        WAIT_SYS_PAY_SELLER,
        /// <summary>
        /// 交易成功结束
        /// </summary>
        TRADE_FINISHED,
        /// <summary>
        /// 交易中途关闭（未完成）
        /// </summary>
        TRADE_CLOSED
    }

    /// <summary>
    /// 错误代码
    /// </summary>
    public enum AliErrorCode : byte
    {
        //协议层错误代码
        /// <summary>
        /// 签名验证出错
        /// </summary>
        ILLEGAL_SIGN,
        /// <summary>
        /// 参数格式有问题
        /// </summary>
        ILLEGAL_ARGUMENT,
        /// <summary>
        /// 无效接口名称
        /// </summary>
        ILLEGAL_SERVICE,
        /// <summary>
        /// 无效合作伙伴id
        /// </summary>
        ILLEGAL_PARTNER,
        /// <summary>
        /// 无效签名方式
        /// </summary>
        ILLEGAL_SIGN_TYPE,
        /// <summary>
        /// 无效字符集
        /// </summary>
        ILLEGAL_CHARSET,
        /// <summary>
        /// 没有上传公钥
        /// </summary>
        HAS_NO_PUBLICKEY,
        /// <summary>
        /// 没有权限访问该服务
        /// </summary>
        HASH_NO_PRIVILEGE,
        /// <summary>
        /// 支付宝系统出错
        /// </summary>
        SYSTEM_ERROR,

        //会员接口错误代码
        /// <summary>
        /// 会员不存在
        /// </summary>
        USER_NOT_EXIST,

        //交易接口错误代码
        /// <summary>
        /// 外部交易号已经存在
        /// </summary>
        OUT_TRADE_NO_EXIST,
        /// <summary>
        /// 交易不存在
        /// </summary>
        TRADE_NOT_EXIST,
        /// <summary>
        /// 无效支付类型
        /// </summary>
        ILLEGAL_PAYMENT_TYPE,
        /// <summary>
        /// 买家不存在
        /// </summary>
        BUYER_NOT_EXIST,
        /// <summary>
        /// 卖家不存在
        /// </summary>
        SELLER_NOT_EXIT,
        /// <summary>
        /// 佣金收取账户不存在
        /// </summary>
        COMMISION_ID_NOT_EXIST,
        /// <summary>
        /// 收取佣金账户和卖家是同一账户
        /// </summary>
        COMMISION_SELLER_DUPLICATE,
        /// <summary>
        /// 佣金金额超出范围
        /// </summary>
        COMMISION_FEE_OUT_OF_RANGE,
        /// <summary>
        /// 买家卖家同一账户
        /// </summary>
        BUYER_SELLER_EQUAL,
        /// <summary>
        /// 无效物流格式
        /// </summary>
        ILLEGAL_LOGISTICS_FORMAT,
        /// <summary>
        /// 交易总金额小于等于0
        /// </summary>
        TOTAL_FEE_LESSEQUAL_ZERO,
        /// <summary>
        /// 交易总金额超出范围
        /// </summary>
        TOTAL_FEE_OUT_OF_RANGE,
        /// <summary>
        /// 非法交易金额格式
        /// </summary>
        ILLEGAL_FEE_PARAM,
        /// <summary>
        /// 小额捐赠总金额超出最大值限制
        /// </summary>
        DONATE_GREATER_THAN_MAX,
        /// <summary>
        /// 快速付款交易总金额超出最大值限制
        /// </summary>
        DIRECT_PAY_AMOUNT_OUT_OF_RANGE,
        /// <summary>
        /// 虚拟物品交易总金额超出最大值限制
        /// </summary>
        DIGITAL_FEE_GREATER_THAN_MAX,
        /// <summary>
        /// 不支持自定义超时
        /// </summary>
        SELF_TIMEOUT_NOT_SUPPORT,
        /// <summary>
        /// 不支持佣金
        /// </summary>
        COMMISION_NOT_SUPPORT,
        /// <summary>
        /// 不支持虚拟发货方式
        /// </summary>
        VIRTUAL_NOT_SUPPORT


    }

}
