using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace D4D.Platform.Domain
{
    public class Image : BaseD4DDomain
    {
         public Image() { }
         public Image(int imageId)
        {
            ImageId = imageId;
        }
         public int ImageId
        {
            get;
            set;
        }

         public int AlbumId
         {
             get;
             set;
         }

         public string ImageName
        {
            get;
            set;
        }

         public string ImageFile
        {
            get;
            set;
        }

         public string SImageFile
        {
            get;
            set;
        }

         public PublishStatus Status
        {
            get;
            set;
        }
    }
}
