using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.IO;
using System.Web;
using System.Configuration;
using D4D.Platform.Domain;

namespace D4D.Platform.Providers
{
    public class CorpInfoProvider
    {

        #region instance
        private static readonly CorpInfoProvider instance = new CorpInfoProvider();

        internal static CorpInfoProvider Instance
        {
            get
            {
                return instance;
            }
        }
        #endregion

        public void SetProfileContent(string position, string content)
        {
            if (string.IsNullOrEmpty(content))
                return;

            string path = GetProfileContentFilePath(position);
             using (StreamWriter sw = File.CreateText(path)) 
            {
                

                sw.Write(HttpUtility.HtmlEncode(content));
            }    
        }

        public string GetProfileContentFilePath(string position)
        {
              string  rootPath = ConfigurationSettings.AppSettings["UploadProfilePath"];

           if (string.IsNullOrEmpty(rootPath))
               rootPath = D4DDefine.DEFAULT_PROFILEPATH;

          return string.Format("{0}corpinfo_{1}.txt", rootPath, position);


        }

        public string ReadProfileContent(string position)
        {
            string path = GetProfileContentFilePath(position);
            if (File.Exists(path))
            {
                return HttpUtility.HtmlDecode( File.ReadAllText(path));
            }
            else
                return string.Empty;
        }
        

    }
    
}
