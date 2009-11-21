using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.IO;
using System.Configuration;
using System.Xml;
using System.Xml.Serialization;
using System.Web;
using System.Threading;
namespace D4D.ResourceManager
{
    public class ResourceManager
    {
        #region instance
        private static readonly ResourceManager instance = new ResourceManager();

        public static ResourceManager Instance
        {
            get
            {
                return instance;
            }
        }
        #endregion 

        private Dictionary<CultureType, ResourceConfig> configs = new Dictionary<CultureType,ResourceConfig>();
        private FileSystemWatcher watcher = new FileSystemWatcher();
        private int TimeoutMillis = 2000; //定时器触发间隔
        System.Threading.Timer m_timer = null;
        List<String> files = new List<string>(); //记录待处理文件的队列

        public const string ResourceXmlPattern = "Resource*.xml";
        private ResourceManager()
        {
            string resourcePath = ConfigurationManager.AppSettings["ResourceFilesPath"];
            if (string.IsNullOrEmpty(resourcePath))
            {
                resourcePath = HttpContext.Current.Server.MapPath("/");
            }

           string[] resourceFiles =  System.IO.Directory.GetFiles(resourcePath, ResourceXmlPattern);
           if (resourceFiles != null && resourceFiles.Length > 0)
           {
               foreach (string f in resourceFiles)
                   LoadResourceConfig(f);
           }

            //add file watcher
            watcher.Path = resourcePath;
            watcher.NotifyFilter = NotifyFilters.LastWrite;
            // Only watch Resource.*.xml files.
            watcher.Filter =ResourceXmlPattern;
            watcher.IncludeSubdirectories = false;
            // Add event handlers.
            watcher.Changed += new FileSystemEventHandler(OnChanged);
          
          
            // Begin watching.
            watcher.EnableRaisingEvents = true;

            // Create the timer that will be used to deliver events. Set as disabled
            if (m_timer == null)
            {
                //设置定时器的回调函数。此时定时器未启动

                m_timer = new System.Threading.Timer(new TimerCallback(OnWatchedFileChange),

                 null, Timeout.Infinite, Timeout.Infinite);

            }

        }



        private void OnWatchedFileChange(object state)
        {

            List<String> backup = new List<string>();
            Mutex mutex = new Mutex(false, "FSW");
            mutex.WaitOne();
            backup.AddRange(files);
            files.Clear();

            mutex.ReleaseMutex();
            foreach (string file in backup)
            {
                LoadResourceConfig(file);        

            }
        }



        // Define the event handlers.
        private  void OnChanged(object source, FileSystemEventArgs e)
        {
            Mutex mutex = new Mutex(false, "FSW");
            mutex.WaitOne();
            if (!files.Contains(e.FullPath))
            {
                files.Add(e.FullPath);
            }

            mutex.ReleaseMutex();
            //重新设置定时器的触发间隔，并且仅仅触发一次
            m_timer.Change(TimeoutMillis, Timeout.Infinite);

            //LoadResourceConfig(e.FullPath);        
        }


        private void LoadResourceConfig(string configFile)
        {
            if (!string.IsNullOrEmpty(configFile))
            {
                ResourceConfig config = new ResourceConfig();
                XmlReader reader = XmlReader.Create(configFile);
                config.ReadXml(reader);
                reader.Close();

                lock (this)
                {
                    if (configs.ContainsKey(config.Culture))
                    {
                        configs[config.Culture] = config;
                    }
                    else
                    {
                        configs.Add(config.Culture, config);
                    }
                }
            }
        }

        public ResourceConfig GetConfig(CultureType culture)
        {
            if (configs.ContainsKey(culture))
                return configs[culture];
            else
                return null;
        }
        /// <summary>
        /// 根据当前线程的Culture获取
        /// </summary>
        /// <returns></returns>
        public ResourceConfig GetConfig()
        {
            return GetConfig(ResourceHelper.CultureTypeFromString(
                System.Threading.Thread.CurrentThread.CurrentCulture.Name));
        }

        public string GetResourceValue(string name)
        {
            return GetResourceValue(ResourceHelper.CultureTypeFromString(
                System.Threading.Thread.CurrentThread.CurrentCulture.Name), name);
        }

        public string GetResourceValue(CultureType culture, string name)
        {
            ResourceConfig rConfig = GetConfig(culture);
            if (rConfig != null)
            {
                if (rConfig.ResourceDatas.ContainsKey(name))
                    return rConfig.ResourceDatas[name];
                else
                    return string.Empty;
            }
            else
                return string.Empty;
        }
    }
}
