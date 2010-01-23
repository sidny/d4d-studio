<%@ WebHandler Language="C#"  Class="JANE.Web.payment.payreturn" %>

using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using JANE.Shop;
using JANE.Shop.Domain;
using JANE.Shop.Helper;
using log4net;
using System.Collections.Specialized;
namespace JANE.Web.payment
{
    /// <summary>
    /// Summary description for $codebehindclassname$
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    public class payreturn : IHttpHandler
    {
        private static readonly ILog log = LogManager.GetLogger("d4d");
   
        public void ProcessRequest(HttpContext context)
        {
            HttpRequest req = context.Request;
            log.Warn("alipay url:" + req.Url.ToString());


            NameValueCollection nvc = new NameValueCollection(req.QueryString);
         

                //check                 
                nvc.Add(req.Form);                
          
                ShopOrder shopOrder =
                    JaneShopGateway.AliPayProvider.VerifyAndGetResult(nvc);

                string janeOrderID = string.Empty;

                bool bResult = true;
                if (shopOrder == null)
                {
                    context.Response.Write("订单返回参数错误!");
                    bResult = false;
                }
                else if (shopOrder.Id <= 0)
                {
                    bResult = false;
                }
                else if (shopOrder.Payresult == PayResult.HasPay)
                {
                    janeOrderID = shopOrder.Id.ToString();
                    bResult = true;

                }
                else if (shopOrder.Payresult == PayResult.PayTradeSuccess)
                {
                    shopOrder.Payresult = PayResult.HasPay;
                    int resultId = JaneShopGateway.JaneShopProvier.SetShopOrder(shopOrder);
                    if (resultId > 0)
                    {
                        janeOrderID = shopOrder.Id.ToString();
                        bResult = true;
                    }
                    else
                        bResult = false;

                }
                else
                    bResult = false;

                log.Warn("alipay result:" + bResult.ToString());

                if (bResult)
                    context.Response.Redirect("/channel/shop/order_userorder.aspx?id=" + janeOrderID);//这里是否跳转到哪里要待定
                else
                    context.Response.Redirect("/channel/shop/order_userorderlist.aspx");

         
        }

        public bool IsReusable
        {
            get
            {
                return false;
            }
        }
    }
}
