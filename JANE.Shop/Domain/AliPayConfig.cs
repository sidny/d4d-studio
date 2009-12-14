using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Configuration;

namespace JANE.Shop.Domain
{
    public class AliPayConfig
    {
        public AliPayConfig()
        {
            //get fromConfig
            string gatewayUrl = ConfigurationManager.AppSettings["AliPay_GatewayUrl"];
            if (!string.IsNullOrEmpty(gatewayUrl))
            {
                _gatewayUrl = gatewayUrl;
            }
            string encodingName = ConfigurationManager.AppSettings["AliPay_EncodingName"];
            if (!string.IsNullOrEmpty(encodingName))
            {
                _encodingName = encodingName;
            }
            string partnerID = ConfigurationManager.AppSettings["AliPay_PartnerID"];
            if (!string.IsNullOrEmpty(partnerID))
            {
                _partnerID = partnerID;
            }
            string partnerKey = ConfigurationManager.AppSettings["AliPay_PartnerKey"];
            if (!string.IsNullOrEmpty(partnerKey))
            {
                _partnerKey = partnerKey;
            }
            string returnUrl = ConfigurationManager.AppSettings["AliPay_ReturnUrl"];
            if (!string.IsNullOrEmpty(returnUrl))
            {
                _returnUrl = returnUrl;
            }
            string notifyUrl = ConfigurationManager.AppSettings["AliPay_NotifyUrl"];
            if (!string.IsNullOrEmpty(notifyUrl))
            {
                _notifyUrl = notifyUrl;
            }

        }

        #region Property
        private string _gatewayUrl = AliPayDefinition.DEFAULT_GATEWAYURL;
        public string GatewayUrl
        {
            get
            {
                return _gatewayUrl;
            }
            set
            {
                _gatewayUrl = value;
            }
        }
        private string _encodingName = AliPayDefinition.DEFAULT_ENCODINGNAME;
        public string EncodingName
        {
            get
            {
                return _encodingName;
            }
            set
            {
                _encodingName = value;
            }
        }

        private string _partnerID = AliPayDefinition.DEFAULT_PARTNERID;
        public string PartnerID
        {
            get
            {
                return _partnerID;
            }
            set
            {
                _partnerID = value;
            }
        }

        private string _partnerKey = AliPayDefinition.DEFAULT_PARTNERKEY;
        public string PartnerKey
        {
            get
            {
                return _partnerKey;
            }
            set
            {
                _partnerKey = value;
            }
        }
        private string _returnUrl = AliPayDefinition.DEFAULT_RETURNURL;
        public string ReturnUrl
        {
            get
            {
                return _returnUrl;
            }
            set
            {
                _returnUrl = value;
            }
        }
        private string _notifyUrl = AliPayDefinition.DEFAULT_NOTIFYURL;
        public string NotifyUrl
        {
            get
            {
                return _notifyUrl;
            }
            set
            {
                _notifyUrl = value;
            }
        }

        
        #endregion
    }
}
