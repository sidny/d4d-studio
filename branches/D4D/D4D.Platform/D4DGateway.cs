using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using D4D.Platform.Providers;

namespace D4D.Platform
{
    public static class D4DGateway
    {
        public static TagsProvider TagsProvider
        {           
            get
            {
                return TagsProvider.Instance;
            }
        }

        public static AlbumProvider AlbumProvider
        {
            get
            {
                return AlbumProvider.Instance;
            }
        }

        public static CommentProvider CommentProvider
        {
            get
            {
                return CommentProvider.Instance;
            }
        }

        public static MusicProvider MusicProvider
        {
            get
            {
                return MusicProvider.Instance;
            }
        }

        public static ShowProvider ShowProvider
        {
            get
            {
                return ShowProvider.Instance;
            }
        }


        public static NewsProvider NewsProvider
        {
            get
            {
                return NewsProvider.Instance;
            }
        }

        public static UserProvider UserProvider
        {
            get
            {
                return UserProvider.Instance;
            }
        }

        public static BandInfoProvider BandInfoProvider
        {
            get
            {
                return BandInfoProvider.Instance;
            }
        }

        public static SearchProvider SearchProvider
        {
            get
            {
                return SearchProvider.Instance;
            }
        }
        public static CorpInfoProvider CorpInfoProvider
        {
            get
            {
                return CorpInfoProvider.Instance;
            }
        }

        public static SpamKeywordProvider SpamKeywordProvider
        {
            get
            {
                return SpamKeywordProvider.Instance;
            }
        }
       
       
    }
}
