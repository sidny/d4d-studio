using System;
using System.IO;
using System.Reflection;

using IBatisNet.Common.Utilities;
using IBatisNet.DataAccess;
using IBatisNet.DataAccess.Configuration;
using IBatisNet.DataAccess.Interfaces;
using log4net;

namespace D4D.IbatisNet
{
    /// <summary>
    /// Summary description for ServiceConfig.
    /// </summary>
    public class ServiceConfig
    {
        static private object _synRoot = new Object();
        static private ServiceConfig _instance;

        private IDaoManager _daoManager = null;

        /// <summary>
        /// Remove public constructor. prevent instantiation.
        /// </summary>
        private ServiceConfig() { }

        static public ServiceConfig GetInstance()
        {
            try
            {
                if (_instance == null)
                {
                    lock (_synRoot)
                    {
                        if (_instance == null)
                        {
                            try
                            {
                                // 读取dao.config
                                Assembly thisExe = Assembly.GetExecutingAssembly();
                                Stream stream = thisExe.GetManifestResourceStream(thisExe.GetName().Name + ".dao.config");
                                ConfigureHandler handler = new ConfigureHandler(ServiceConfig.Reset);
                                // ibatis 读取配置
                                DomDaoManagerBuilder builder = new DomDaoManagerBuilder();
                                builder.Configure(stream);
                                // builder.ConfigureAndWatch(handler);

                                _instance = new ServiceConfig();
                                // TODO:默认为sqlMapDao指定的Context, 要提供对多个Context的支持.
                                _instance._daoManager = IBatisNet.DataAccess.DaoManager.GetInstance("SqlMapDao");
                                // 转换到配置文件的数据库连接。
                                string connectionString = System.Configuration.ConfigurationManager.ConnectionStrings["connectionString"].ConnectionString;
                                _instance._daoManager.LocalDataSource.ConnectionString = connectionString;
                            }
                            catch (Exception e)
                            {
                                ILog log =  log4net.LogManager.GetLogger("TraceAppender");
                                log.Error(e);
                            }
                        }
                    }
                }
            }
            catch(Exception ex)
            {
                Console.WriteLine(ex.Message);
            }
            return _instance;
        }

        /// <summary>
        /// Reset the singleton
        /// </summary>
        /// <remarks>
        /// Must verify ConfigureHandler signature.
        /// </remarks>
        /// <param name="obj">
        /// </param>
        static public void Reset(object obj)
        {
            _instance = null;
        }

        public IDaoManager DaoManager
        {
            get
            {
                return _daoManager;
            }
        }

        public IDaoManager GetDaoManager(string contextName)
        {
            return IBatisNet.DataAccess.DaoManager.GetInstance(contextName);
        }
    }
}
