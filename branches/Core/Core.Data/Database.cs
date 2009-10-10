using System;
using System.Collections.Generic;
using System.Text;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;
//using IBatisNet.DataMapper;
using Core.Data.Mapping;
using Core.Data.Exceptions;

namespace Core.Data
{
    internal class DatabaseCollection : System.Collections.ObjectModel.KeyedCollection<string, Database>
    {
        /// <summary>
        /// Returns the database instance name.
        /// </summary>
        protected override string GetKeyForItem(Database item)
        {
            return item.InstanceName;
        }

    }

  


    /// <summary>
    /// Encapsulates information about a particular database and its connectivity.
    /// </summary>
    [Serializable]
    public class Database
    {
        private string connectionString;
        
        private string connectionStringAsync;


        internal void SetConnectionString(string connString)
        {
            this.connectionString = connString;
            this.connectionStringAsync = connString + ";async=true;";
        }

        internal Database(string instanceName)
        {
            this.instanceName = instanceName;

            try
            {
               // SetConnectionString(ConnectionStringProvider.GetConnectionString(instanceName));
                SetConnectionString(ConfigurationManager.ConnectionStrings[instanceName].ConnectionString);
               

            }
            catch
            {
                throw new DatabaseNotConfiguredException(instanceName);
            }

        }

        private Database()
        {

        }

        private long lastTimeout;
        private int timeoutCount;
               
     

        private int totalTimeoutCount;
    

        private string exceptionLog = string.Empty;

		private object padLock = new object();

		/// <summary>
		/// Register an exception thrown by a sql connection.
		/// </summary>
		public void RegisterSqlTimeout(Exception e)
		{
            exceptionLog = e.ToString() + " : " + e.Message + " : " + e.StackTrace;
            if ((e is InvalidOperationException && e.Message.StartsWith("Timeout expired.")) ||
                (e.InnerException != null && e.InnerException is SqlException && (e.Message.StartsWith("SQL Server does not exist or access denied.") || e.InnerException.Message.StartsWith("An error has occurred while establishing a connection to the server."))) ||
                    (e is SqlException && (e.Message.StartsWith("SQL Server does not exist or access denied.") || e.Message.StartsWith("An error has occurred while establishing a connection to the server."))))
    		{
				lock (padLock)
				{
					lastTimeout = DateTime.Now.Ticks;
					timeoutCount++;
                    totalTimeoutCount++;

                    //if (this.InstanceName.StartsWith("Shared"))
                    //    DatabaseManager.Instance.ResetShared();
                    //      else if(this.InstanceName.StartsWith("SecurityTracking"))
                    //          DatabaseManager.Instance.ResetSecurityTracking();
                    //else
                        SqlConnection.ClearPool(new SqlConnection(GetConnectionString()));                    
				}
              
                throw new DatabaseDownException("Database " + instanceName + " is down.");
			}          
		}
	
		/// <summary>
        /// The name of the database.
        /// </summary>
        private string instanceName;

        ///// <summary>
        ///// The IBatis SQL Mapper for the database (reference to singleton)
        ///// </summary>
        //public ISqlMapper SqlMapper
        //{
        //    get
        //    {
           
        //        return MapperProvider.Instance.GetInstanceMapper(InstanceName);
        //    }
        //}	

      
        /// <summary>
        /// The name of the database
        /// </summary>
        public string InstanceName
        {
            get
            {
                return instanceName;
            }
           
        }

        /// <summary>
        /// Resets the state tracking of the database.
        /// </summary>
        public void ResetState()
        {
			timeoutCount = 0;
            //connectionsDenied = 0;
        }

        /// <summary>
        /// Retrieves the connection string.
        /// </summary>
        /// <returns></returns>
        public string GetConnectionString()
        {
            return connectionString;
        }

        public string GetAsyncConnectionString()
        {
            return connectionStringAsync;
        }

        public SqlConnection GetAsyncConnection()
        {
         
            return new SqlConnection(GetAsyncConnectionString());
        }

        /// <summary>
        /// Returns a closed SQL connection.
        /// </summary>
        public SqlConnection GetConnection()
        {           

            return new SqlConnection(GetConnectionString());
        }

		public SqlConnection GetOpenConnection()
		{
			
			SqlConnection connection = new SqlConnection(GetConnectionString());
			connection.Open();
			return connection;
		}

        /// <summary>
        /// Returns a Database instance.
        /// </summary>
        /// <param name="instanceName">The name of the database (reflected in the ConnectionStrings section of the app config)</param>
        /// <example>  
        /// Database db = Database.GetDatabase("Films");
		///	</example>
        public static Database GetDatabase(string instanceName)
        {
            //最好方式是把所有Database缓存的datamanager的instance里面，不用每次都new
            //懒得做config reload了
            return new Database(instanceName);
        }

        ///// <summary>
        ///// Get all registered Database instances (one per database).
        ///// </summary>
        ///// <returns></returns>
        //public static List<Database> GetDatabases()
        //{
        //    return new List<Database>(DatabaseManager.Instance.Databases);
        //}

        /// <summary>
        /// Retrieve a CLOSED SqlConnection object via an instance name.
        /// </summary>
        /// <param name="instanceName"></param>
        /// <returns></returns>
        public static SqlConnection GetConnection(string instanceName)
        {
            return GetDatabase(instanceName).GetConnection();
        }


        ///// <summary>
        ///// Get an IBatis mapper based on instance name.
        ///// </summary>
        ///// <param name="instanceName"></param>
        ///// <returns></returns>
        //public static ISqlMapper GetMapper(string instanceName)
        //{
        //    return GetDatabase(instanceName).SqlMapper;
        //} 

    }

    /// <summary>
    /// The state of the database as understood by the client.
    /// </summary>
    public enum ConnectivityState
    {
        /// <summary>
        /// The database can be connected to
        /// </summary>
        Up = 0,
        /// <summary>
        /// The database cannot be connected to.
        /// </summary>
        Down = 1,
    }

}
