﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace JANE.Shop.Domain
{
    public class ShopOrder
    {
          public ShopOrder() { }
          public ShopOrder(int id)
        {
            Id = id;
        }
         public int Id
        {
            get;
            set;
        }

        public int UserId
        {
            get;
            set;
        }

        public DateTime AddDate
        {
            get;
            set;
        }

        public OrderType Ordertype
        {
            get;
            set;
        }


        public string Address
        {
            get;
            set;
        }


        public string Email
        {
            get;
            set;
        }

        public string Mobile
        {
            get;
            set;
        }


        public decimal Paymoney
        {
            get;
            set;
        }

        public PayType Paytype
        {
            get;
            set;
        }

        public PayResult Payresult
        {
            get;
            set;
        }


        public string Payremark
        {
            get;
            set;
        }

        public string Paythirdnum
        {
            get;
            set;
        }

        public DateTime Paydate
        {
            get;
            set;
        }
    }
}
