using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using JANE.Shop.Domain;
using JANE.Shop.Persistence;
using D4D.Platform.Domain;
using System.Web;
using JANE.Shop.Helper;
using System.Collections.Specialized;
using System.Net;
using System.IO;
using log4net;
namespace JANE.Shop.Providers
{
    public class AliPayProvider
    {
        #region instance
        private static readonly AliPayProvider instance = new AliPayProvider();

        internal static AliPayProvider Instance
        {
            get
            {
                return instance;
            }
        }
        #endregion

        #region alipay
        /// <summary>
        /// 创建支付宝URL
        /// </summary>
        /// <param name="gateway">支付接口</param>
        /// <param name="service">接口类型</param>
        /// <param name="partner">合作伙伴ID</param>
        /// <param name="sign_type">签名类型</param>
        /// <param name="out_trade_no">订单号</param>
        /// <param name="subject">商品名称</param>
        /// <param name="body">商品描述</param>
        /// <param name="payment_type">支付类型</param>
        /// <param name="total_fee">总金额0.01～50000.00</param>
        /// <param name="show_url">展示地址</param>
        /// <param name="seller_email">卖家账号</param>
        /// <param name="key">partner账户的支付宝安全校验码</param>
        /// <param name="return_url">服务器通知返回页面,注意url不能带任何querysting(f**k ALIPay)</param>
        /// <param name="encoding">partner账户的支付宝安全校验码</param>
        /// <param name="notify_url">服务器通知接口,注意url不能带任何querysting(f**k ALIPay)</param>
        /// <returns>跳转的URL</returns>
        public string CreatUrl(
         string gateway,
         string service,
         string partner,
         string sign_type,
         string out_trade_no,
         string subject,
         string body,
         string payment_type,
         string total_fee,
         string show_url,
         string seller_email,
         string key,
         string return_url,
         string encoding,
         string notify_url
         )
        {
            int i;

            //构造数组；
            string[] Oristr ={ 
                "service="+service, 
                "partner=" + partner, 
                "subject=" + subject, 
                "body=" + body, 
                "out_trade_no=" + out_trade_no, 
                "total_fee=" + total_fee, 
                "show_url=" + show_url,  
                "payment_type=" + payment_type, 
                "seller_email=" + seller_email, 
                "notify_url=" + notify_url,
                "_input_charset="+encoding,          
                "return_url=" + return_url
                };

            //进行排序；
            string[] Sortedstr = PaymentHelper.BubbleSort(Oristr);


            //构造待md5摘要字符串 ；

            StringBuilder prestr = new StringBuilder(2048);

            for (i = 0; i < Sortedstr.Length; i++)
            {
                if (i == Sortedstr.Length - 1)
                {
                    prestr.Append(Sortedstr[i]);

                }
                else
                {

                    prestr.Append(Sortedstr[i] + "&");
                }

            }

            prestr.Append(key);

            //生成Md5摘要；
            string sign = PaymentHelper.GetMD5(prestr.ToString(), encoding);

            //构造支付Url；
            char[] delimiterChars = { '=' };
            StringBuilder parameter = new StringBuilder(2048);
            parameter.Append(gateway);
            parameter.Append("?");
            for (i = 0; i < Sortedstr.Length; i++)
            {
                parameter.Append(Sortedstr[i].Split(delimiterChars)[0] + "=" +
                    HttpUtility.UrlEncode(Sortedstr[i].Split(delimiterChars)[1]) + "&");
            }

            parameter.Append("sign=" + sign + "&sign_type=" + sign_type);


            //返回支付Url；
            return parameter.ToString();

        }

        public string CreateNotifyVerifyUrl(string notify_id, string gateWayUrl, string serviceNotifyVerify,
         string partnerId)
        {
            StringBuilder sb = new StringBuilder(256);
            sb.Append(gateWayUrl);
            sb.Append("?service=");
            sb.Append(serviceNotifyVerify);
            sb.Append("&partner=");
            sb.Append(partnerId);
            sb.Append("&notify_id=");
            sb.Append(notify_id);

            return sb.ToString();

        }

        public bool VerifyNotifyValue(NameValueCollection nvc, 
            string partnerKey, string notifyUrl,string encoding)
        {
            //进行排序；
            string[] Sortedstr = PaymentHelper.BubbleSort(nvc.AllKeys);

            //构造待md5摘要字符串 ；
            StringBuilder presb = new StringBuilder(1024);
            for (int i = 0; i < Sortedstr.Length; i++)
            {
                if (!string.IsNullOrEmpty(nvc[Sortedstr[i]]) &&
                    Sortedstr[i] != "sign"
                    && Sortedstr[i] != "sign_type")
                {

                    presb.Append(Sortedstr[i]);
                    presb.Append("=");
                    presb.Append(nvc[Sortedstr[i]]);

                    if (i != Sortedstr.Length - 1)
                    {
                        presb.Append("&");
                    }
                }

            }
            presb.Append(partnerKey);
            bool md5Check = (PaymentHelper.GetMD5
                (presb.ToString(), encoding) == nvc["sign"]);

            string notifyId = nvc["notify_id"];

            if (!string.IsNullOrEmpty(notifyId) && md5Check)
                return VerifyNotifyRequest(notifyId, notifyUrl);
            else //如果不需要向支付宝验证通知是否合法，直接返回md5check结果
                return md5Check;
        }

        public bool VerifyNotifyRequest(string notify_id, string notifyUrl)
        {
            bool bResult = false;
            if (string.IsNullOrEmpty(notify_id)) return bResult;
            try
            {
                HttpWebRequest myReq = (HttpWebRequest)HttpWebRequest.Create(notifyUrl);
                myReq.Timeout = AliPayDefinition.DEFAULT_HTTPTIMEOUT;
                HttpWebResponse HttpWResp = (HttpWebResponse)myReq.GetResponse();
                Stream myStream = HttpWResp.GetResponseStream();
                StreamReader sr = new StreamReader(myStream, Encoding.Default);
                StringBuilder strBuilder = new StringBuilder(5);
                while (-1 != sr.Peek())
                {
                    strBuilder.Append(sr.ReadLine());
                }

                if (strBuilder.ToString().ToLower() == AliPayDefinition.HANDLER_TRUE)
                    bResult = true;

            }
            catch (Exception ex)
            {         
                ILog log = LogManager.GetLogger("d4d");
                log.Error("VerifyNotifyRequest->notify_id:" + notify_id.ToString(), ex);
                bResult = false;
            }

            return bResult;

        }

        /// <summary>
        /// 获取交易结果。如果没有验证通过，直接返回交易不存在
        /// </summary>
        /// <param name="nvc">Request.Params</param>     
        /// <returns></returns>
        public ShopOrder GetShopOrderResult(NameValueCollection nvc, bool isVerify)
        {
           

            if (nvc == null) return null;

            if (!isVerify) return null;

            //Set MySpaceOrderNo
            string out_trade_no = nvc["out_trade_no"];
            int shopOrderId = 0;
            int.TryParse(out_trade_no, out shopOrderId);

            if (shopOrderId <= 0) return null;

            //try get shopOrder
            ShopOrder order = 
                JaneShopOrdersDao.GetShopOrder(shopOrderId);

            if (order == null || order.Id <= 0) return null;

            if (order.Payresult == PayResult.HasPay)//已经支付直接返回
                return order;            

                       
            //Set ThirdPartyTradeStatus
            if (isVerify)
            {
                string trade_status = nvc["trade_status"];
                if (!string.IsNullOrEmpty(trade_status))
                {
                    trade_status = trade_status.ToUpper();
                    switch (trade_status)
                    {
                        case "TRADE_FINISHED":
                            //case "WAIT_SELLER_SEND_GOODS"://支付宝收到买家付款，请卖家发货
                            //case "WAIT_BUYER_CONFIRM_GOODS"://卖家已发货，买家确认中
                            //case "WAIT_SYS_PAY_SELLER"://买家确认收到货，等待支付宝付款给卖家
                            order.Payresult = PayResult.PayTradeSuccess;
                            break;
                        case "TRADE_CLOSED"://交易中途关闭
                            order.Payresult = PayResult.PayFaild;
                            break;
                        default://处理中
                            order.Payresult = PayResult.None;
                            break;
                    }
                }
            }
          

            //Set  TotalFee 
            string total_fee = nvc["total_fee"];
            double totalFee;
            if (double.TryParse(total_fee, out totalFee))
                order.Paymoney= totalFee;

           // cr.ThirdPartyOrderNo = nvc["trade_no"];
           // cr.AccountPaymentMedium = nvc["payment_type"];
            order.Paytype = PayType.AliPay;
            order.Paythirdnum = nvc["trade_no"];
            order.Paydate = DateTime.Now; 
            order.Payremark = PaymentHelper.GetDataString(nvc);


            return order;
        }

        /// <summary>
        /// 校验交易，同时返回结果
        /// </summary>
        /// <param name="nvc"></param>
        /// <returns></returns>
        public ShopOrder VerifyAndGetResult(NameValueCollection nvc)
        {
            AliPayConfig alipayConfig = new AliPayConfig();
            return GetShopOrderResult(nvc,
                VerifyNotifyValue(nvc, alipayConfig.PartnerKey, alipayConfig.NotifyUrl,
                alipayConfig.EncodingName));
        }
        #endregion


    }
}
