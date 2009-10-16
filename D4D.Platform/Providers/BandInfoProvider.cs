using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using D4D.Platform.Domain;
using D4D.Platform.Persistence;
using System.Configuration;
using System.IO;
namespace D4D.Platform.Providers
{
    public class BandInfoProvider
    {
        #region instance
        private static readonly BandInfoProvider instance = new BandInfoProvider();

        internal static BandInfoProvider Instance
        {
            get
            {
                return instance;
            }
        }
        #endregion

        public int SetBandInfo(BandInfo info)
        {
            return BandInfoDao.SetBandInfo(info);
        }

        public List<BandInfo> GetBandInfoList(bool needCompany)
        {
             List<BandInfo> list =  BandInfoDao.GetAllBandInfo(0);

             if (list == null)
                 list = new List<BandInfo>();

             if (needCompany)
             {
                 BandInfo bInfo = new BandInfo();
                 bInfo.BandId = 0;
                 bInfo.BandName = "¹«Ë¾";
                 list.Add(bInfo);
             }

             return list;
        }

        public List<BandInfo> GetBandInfoList()
        {
            return GetBandInfoList(false);
        }
        public List<BandInfo> GetAllBandInfo(int minIndex)
        {
            return BandInfoDao.GetAllBandInfo(minIndex);
        }

        public void SetProfileContent(int bandid, int extType, string content)
        {
            if (string.IsNullOrEmpty(content))
                return;

            string path = GetProfileContentFilePath(bandid, extType);
             using (StreamWriter sw = File.CreateText(path)) 
            {
                sw.Write(content);
            }    
        }

        public string GetProfileContentFilePath(int bandid, int extType)
        {
              string  rootPath = ConfigurationSettings.AppSettings["UploadProfilePath"];

           if (string.IsNullOrEmpty(rootPath))
               rootPath = D4DDefine.DEFAULT_PROFILEPATH;

          return string.Format("{0}bandprofile_{1}_{2}.txt", rootPath, bandid, extType);


        }

        public string ReadProfileContent(int bandid, int extType)
        {
            string path = GetProfileContentFilePath(bandid, extType);
            if (File.Exists(path))
            {
                return File.ReadAllText(path);
            }
            else
                return string.Empty;
        }
        

    }
}
