using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using D4D.Platform.Providers;
namespace D4D.Platform
{
    public static class DiscuzGateway
    {
        public static DiscuzAccountProvider TagsProvider
        {
            get
            {
                return DiscuzAccountProvider.Instance;
            }
        }

    }
}
