using System;
using System.Collections.Generic;
using System.Text;
using System.Data.SqlClient;
using Core.Data.MapperDelegates;
using System.Data;
using System.Diagnostics;
using System.Threading;
using Core.Data.Exceptions;

namespace Core.Data.MapperDelegates
{
    public delegate void AsyncNonQueryCallback();

}

namespace Core.Data
{
    public class SafeProcedureAsync
	{
		#region Async Begin/End Procedures
		// Function which return results
		/// //////////////////////////////////
		/// <summary>
		/// Call async BeginExecuteReader
		/// </summary>
		/// <param name="AsyncCallback "></param>
		/// <param name="Database "></param>
		/// <param name="procName"></param>
		/// <param name="parameterValues"></param>
		/// <returns>IAsyncResult</returns>
		public static IAsyncResult BeginExecuteReader(AsyncCallback callback, Database db, string procName, params object[] parameterValues)
		{
			SqlConnection connection = db.GetAsyncConnection();
			SqlCommand command = CommandFactory.CreateCommand(connection, db.InstanceName, procName, parameterValues);
			IAsyncResult result;

			try
			{
				connection.Open();
				result = command.BeginExecuteReader(callback, command, CommandBehavior.CloseConnection);				
			}
            catch (Core.Data.Exceptions.DataException) // Procedure class already wrapped all necessary data
			{
				CloseAsyncConnection(command);
				throw;
			}

			return result;
		}
		/// <summary>
		/// Async returns a ResultMapper 
		/// </summary>
		/// <param name="IAsyncResult "></param>
		/// <param name="result"></param>
		/// <returns>void</returns>
		public static void EndExecuteAndMapResults(IAsyncResult ar, ResultMapper result)
		{
			SqlCommand command = (SqlCommand)ar.AsyncState;
			try 
			{
				SqlDataReader reader = command.EndExecuteReader(ar);

				result(new DataRecord(reader));

			}
            catch (Core.Data.Exceptions.DataException) // Procedure class already wrapped all necessary data
			{
				throw;
			}
			finally
			{
				CloseAsyncConnection(ar);
			}
		}
		/// <summary>
		/// Async returns a RecordMapper<T> 
		/// </summary>
		/// <param name="IAsyncResult "></param>
		/// <param name="result"></param>
		/// <returns>void</returns>
		public static T EndExecuteAndGetInstance<T>(IAsyncResult ar, RecordMapper<T> recordMapper) where T : new()
		{
			T objectInstance = new T();
			SqlCommand command = (SqlCommand)ar.AsyncState;
			using (SqlDataReader reader = command.EndExecuteReader(ar))
			{
				recordMapper(new DataRecord(reader), objectInstance);
			}
			return objectInstance;
		}
		// Function which don't return results
		/// //////////////////////////////////
		/// <summary>
		/// Call async BeginExecuteNonQuery
		/// </summary>
		/// <param name="AsyncCallback "></param>
		/// <param name="Database "></param>
		/// <param name="procName"></param>
		/// <param name="parameterValues"></param>
		/// <returns>IAsyncResult</returns>
		public static IAsyncResult BeginExecuteNonQuery(AsyncCallback callback, Database db, string procName, params object[] parameterValues)
		{
			SqlConnection connection = db.GetAsyncConnection();
			SqlCommand command = CommandFactory.CreateCommand(connection, db.InstanceName, procName, parameterValues);
			IAsyncResult result;

			try
			{
				connection.Open();
				result = command.BeginExecuteNonQuery(callback, command);				
			}
			catch (Core.Data.Exceptions.DataException) 
			{
				CloseAsyncConnection(command);
				throw;
			}

			return result;
		}
		/// <summary>
		/// Async returns a status of NonQuery execution
		/// </summary>
		/// <param name="IAsyncResult "></param>
		/// <returns>int</returns>
		public static int EndExecuteNonQuery(IAsyncResult ar)
		{
			SqlCommand command = (SqlCommand)ar.AsyncState;
			int result = 0;
			try 
			{
				result = command.EndExecuteNonQuery(ar);
			}
            catch (Core.Data.Exceptions.DataException) // Procedure class already wrapped all necessary data
			{
				throw;
			}
			finally
			{
				CloseAsyncConnection(ar);
			}
			return result;
		}

		// Close ADO.NET async connection
		/// //////////////////////////////////
		/// <summary>
		/// Call CloseAsyncConnection
		/// </summary>
		/// <param name="SqlCommand "></param>
		/// <returns>void</returns>
		public static void CloseAsyncConnection(SqlCommand command)
		{
			command.Connection.Close();
			command.Connection.Dispose();
		}
		/// <summary>
		/// Call CloseAsyncConnection
		/// </summary>
		/// <param name="AsyncCallback "></param>
		/// <returns>void</returns>
		public static void CloseAsyncConnection(IAsyncResult ar)
		{
			CloseAsyncConnection((SqlCommand)ar.AsyncState);
		}

		#endregion

		#region Pseudo Async functions
		/// <summary>
        /// Assembly-scoped class for returning a DataReader.
        /// </summary>
        /// <param name="database"></param>
        /// <param name="procedureName"></param>
        /// <param name="parameterMapper"></param>
        /// <param name="resultMapper"></param>
        /// <returns></returns>
        public static void ExecuteAndMapResults(Database database, string procedureName, ParameterMapper parameterMapper, ResultMapper resultMapper)
        {

            SqlConnection connection = database.GetAsyncConnection();
            SqlCommand command = CommandFactory.CreateParameterMappedCommand(connection, procedureName, parameterMapper);
			bool isCompleted = false;

            try
            {
                command.Connection.Open();

				command.BeginExecuteReader(
                delegate(IAsyncResult result)
                {
                    try
                    {
                        SqlDataReader reader = command.EndExecuteReader(result);

                        resultMapper(new DataRecord(reader));

                        Debug.WriteLine("ExecuteAndMapResults async callback on thread: " + Thread.CurrentThread.ManagedThreadId);

                    }
                    finally
                    {
						CloseAsyncConnection(command);
						isCompleted = true;
					}

                }
                , command
                    );

               
            }
            catch
            {
				CloseAsyncConnection(command);
				throw;
            }

			while (!isCompleted) Thread.Sleep(200);

        }
		/// <summary>
		/// Call pseudo async NonQuery execution
		/// </summary>
		/// <param name="database"></param>
		/// <param name="procedureName"></param>
		/// <param name="parameterMapper"></param>
		/// <param name="resultMapper"></param>
		/// <returns></returns>
		public static int ExecuteNonQuery(Database database, string procedureName, ParameterMapper parameterMapper)
        {
            SqlConnection connection = database.GetAsyncConnection();
            SqlCommand command = CommandFactory.CreateParameterMappedCommand(connection, procedureName, parameterMapper);
			bool isCompleted = false;
			int result = 0;

            try
            {

                connection.Open();

				command.BeginExecuteNonQuery(
                    //Begin delegate
				   delegate(IAsyncResult ar)
                   {
                       SqlCommand locCommand = ar.AsyncState as SqlCommand;

                       try
                       {

						   result = locCommand.EndExecuteNonQuery(ar);

                       }
                       finally
                       {
						   CloseAsyncConnection(locCommand);
						   isCompleted = true;
					   }

                   }
                   //End delegate
                   , command);

            }
            catch //If an exception is thrown during the connection
            {
				CloseAsyncConnection(command);
				throw;
			}
			while (!isCompleted) Thread.Sleep(200);

			return result;
		}
		#endregion

	}
}
