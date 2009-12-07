using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using JANE.Shop.Domain;
using JANE.Shop;
using D4D.Platform.Domain;

namespace JANE.Web.channel.shop
{
    /// <summary>
    /// Summary description for $codebehindclassname$
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    public class shoporderHandler : IHttpHandler
    {

        public void ProcessRequest(HttpContext context)
        {
            string handlerType = context.Request.QueryString["t"];
            if (!string.IsNullOrEmpty(handlerType))
            {
                if (D4D.Web.Helper.Helper.IsDizLogin)
                {
                    string strOrderId = context.Request.QueryString["id"];
                    int orderId;
                    int.TryParse(strOrderId, out orderId);
                    if (orderId > 0)
                    {
                        int userId = D4D.Web.Helper.Helper.GetCookieUserId();
                        if (userId > 0)
                        {
                            ShopOrder sOrder = JaneShopGateway.JaneShopProvier.GetShopOrder(orderId);
                            if (sOrder != null && sOrder.UserId == userId)
                            {
                                //get returnUrl
                                string returnUrl = context.Request.QueryString["rurl"];
                                if (!string.IsNullOrEmpty(returnUrl))
                                {
                                    switch (handlerType.ToLower())
                                    {
                                        case "cleartradelist":
                                            if (sOrder.Ordertype == OrderType.ShopCar)//只有购物车状态才能清空
                                            {
                                                //get orderid
                                                JaneShopGateway.JaneShopProvier.DeleteShopTradelistByOrderId(orderId);
                                            }
                                            context.Response.Redirect(returnUrl);
                                            break;
                                        case "delonetradelist":
                                            if (sOrder.Ordertype == OrderType.ShopCar)//只有购物车状态才能删除
                                            {
                                                string strTid = context.Request.QueryString["tid"];
                                                int tid;
                                                int.TryParse(strTid, out tid);
                                                if (tid > 0)
                                                {
                                                    ShopTradelist tradeList = JaneShopGateway.JaneShopProvier.GetShopTradelist(tid);
                                                    if (tradeList != null && tradeList.OrderId == orderId)
                                                    {
                                                        JaneShopGateway.JaneShopProvier.DeleteShopTradelist(tid);
                                                    }
                                                }
                                            }
                                            context.Response.Redirect(returnUrl);
                                            break;
                                        default:
                                            break;
                                    }
                                }
                            }
                        }
                    }
                }
            }
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
