using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Configuration;
namespace D4D.Platform.Domain
{
    public class UploadInfo
    {
        public UploadInfo()
        {
            FileGuidName = Guid.NewGuid();
        }

        public UploadInfo(Guid guid)
        {
            FileGuidName = guid;
        }
        private Guid fileGuidName;
        public Guid FileGuidName
        {
            get
            {
                if (fileGuidName == null)
                    fileGuidName = Guid.NewGuid();
                return fileGuidName;
            }
            set
            {
                fileGuidName = value;
            }
        }
        public string FileExtension
        {
            get;
            set;
        }

        private string uploadRootPath;
        public string UploadRootPath
        {
            get
            {
                if (!string.IsNullOrEmpty(uploadRootPath)) return uploadRootPath;
 
                 uploadRootPath = ConfigurationSettings.AppSettings["UploadRootPath"];

                if (string.IsNullOrEmpty(uploadRootPath))
                    uploadRootPath = D4DDefine.DEFAULT_UPLOADROOTPATH;

                return uploadRootPath;
            }
        }

        private string uploadRootHttpPath;
        public string UploadRootHttpPath
        {
            get
            {
                if (!string.IsNullOrEmpty(uploadRootHttpPath)) return uploadRootHttpPath;

                uploadRootHttpPath = ConfigurationSettings.AppSettings["UploadRootHttpPath"];

                if (string.IsNullOrEmpty(uploadRootHttpPath))
                    uploadRootHttpPath = D4DDefine.DEFAULT_UPLOADROOTHTTPPATH;

                return uploadRootHttpPath;
            }
        }

        public string FileServerPath
        {
            get
            {
                return UploadRootPath + FileGuidName.ToString() + FileExtension;
            }
        }

        public string FileHttpPath
        {
            get
            {
                return UploadRootHttpPath + FileGuidName.ToString() + FileExtension;
            }
        }
    }
}
