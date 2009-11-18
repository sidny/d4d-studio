using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using D4D.Platform.Domain;
using D4D.Platform.Persistence;
namespace D4D.Platform.Providers
{
    public class DiscuzAccountProvider
    {
        #region instance
        private static readonly DiscuzAccountProvider instance = new DiscuzAccountProvider();

        internal static DiscuzAccountProvider Instance
        {
            get
            {
                return instance;
            }
        }
        #endregion


    }
}
