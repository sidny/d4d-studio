using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using JANE.Shop;
using JANE.Shop.Domain;
using System.Collections.Specialized;
namespace TestWeb
{
    public partial class _Default : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            //string h =
            //D4D.ResourceManager.ResourceManager.Instance.GetResourceValue(D4D.ResourceManager.CultureType.ZHCN, "hello");
            // litInfo.Text = h+"<br/>";
            //D4D.ResourceManager.ResourceConfig config = D4D.ResourceManager.ResourceManager.Instance.GetConfig();

            //foreach (KeyValuePair<string, string> kvp in config.ResourceDatas)
            //    litInfo.Text += "name:" + kvp.Key + " value:" + kvp.Value + "<br/>";
           AliPayConfig aliPayConfig = new AliPayConfig();
            /*
           string urlPay = JaneShopGateway.AliPayProvider.CreatUrl(aliPayConfig.GatewayUrl,
               AliPayDefinition.SERVICE_CREATE_DIRECT_PAY_BY_USER,
               aliPayConfig.PartnerID,
               AliPayDefinition.DEFAULT_SIGNTYPE,
               Guid.NewGuid().ToString(),
               "张靓颖商品测试",
               "张靓颖商品测试说明",
               ((int)AliPaymentType.BuyProduct).ToString(),//1
               "0.01",
               "http://cn.janezhang.com",//商品展示链接
               aliPayConfig.SellerEmail, //"bd@showcitytimes.net",
               aliPayConfig.PartnerKey,
               aliPayConfig.ReturnUrl,
               aliPayConfig.EncodingName,
               aliPayConfig.ReturnUrl);

           Response.Redirect(urlPay);
             */
           NameValueCollection nvc = new NameValueCollection(Request.QueryString);
           if (nvc.Count > 0)
           {
               AliPayConfig alipayConfig = new AliPayConfig();
               bool vResult = JaneShopGateway.AliPayProvider.VerifyNotifyValue(nvc, alipayConfig.PartnerKey,
                   JaneShopGateway.AliPayProvider.CreateNotifyVerifyUrl(nvc["notify_id"],
               alipayConfig.GatewayUrl, AliPayDefinition.SERVICE_NOTIFY_VERIFY, alipayConfig.PartnerID),
                alipayConfig.EncodingName);
           }




        }
    }
}
