<%@ WebHandler Language="C#" Class="JANE.Web.payment.paynotify" %>
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
    /// alipay notify
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    public class paynotify : IHttpHandler
    {
        private static readonly ILog log = LogManager.GetLogger("d4d");
        const string strSuccess = "success";
        const string strFail = "fail";
        public void ProcessRequest(HttpContext context)
        {
            HttpRequest req = context.Request;
            log.Warn("alipay url:" + req.Url.ToString());
           
            //string paymentGateway =
            //   req.QueryString["gateway"];

            string strSuccess = string.Empty;
            string strFail = string.Empty;

            //if (string.IsNullOrEmpty(paymentGateway)) paymentGateway = "alipay"; //default

                NameValueCollection nvc = new NameValueCollection(req.QueryString);
                 
               
                  //check                 
                  nvc.Add(req.Form);
                  ShopOrder shopOrder =
                      JaneShopGateway.AliPayProvider.VerifyAndGetResult(nvc);

                  string resultStr = string.Empty;
                  if (shopOrder == null)
                  {
                   
                      resultStr=strFail;
                  }
                  else if (shopOrder.Id <= 0)
                  {
                      resultStr = strFail;
                  }
                  else if (shopOrder.Payresult == PayResult.HasPay)
                  {
                      resultStr = strSuccess;
                       
                  }
                  else if (shopOrder.Payresult == PayResult.PayTradeSuccess)                        
                  {
                     shopOrder.Payresult = PayResult.HasPay;
                     int resultId = JaneShopGateway.JaneShopProvier.SetShopOrder(shopOrder);
                      if (resultId>0)
                          resultStr = strSuccess;
                      else
                          resultStr = strFail;
                         
                  }else
                      resultStr = strFail;

                  log.Warn("alipay result:"+resultStr);
                 context.Response.Write(resultStr);             

         

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
