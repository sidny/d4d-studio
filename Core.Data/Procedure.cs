using System;
using System.Collections.Generic;
using System.Text;
using System.Data.SqlClient;
using System.Data;
using Core.Data.MapperDelegates;


namespace Core.Data
{
   

    /// <summary>
    /// Wraps the execution of a stored procedure.
    /// </summary>
    public static class Procedure
    {

      
        /// <summary>
        /// Executes and returns an open IRecordSet, which encapsulates an OPEN DATAREADER.  DISPOSE IN FINALLY CLAUSE.
        /// </summary>
        /// <param name="database"></param>
        /// <param name="procedureName"></param>
        /// <param name="parameterMapper"></param>
        /// <returns></returns>
        public static IRecordSet Execute(Database database, string procedureName, ParameterMapper parameterMapper)
        {

            SqlConnection connection = database.GetConnection();
            SqlCommand command = CommandFactory.CreateParameterMappedCommand(connection, procedureName, parameterMapper);

    
            try
            {

                command.Connection.Open();
                IRecordSet record = new DataRecord(command.ExecuteReader(CommandBehavior.CloseConnection));
                return record;
            }
            catch(Exception exc)
            {
                command.Connection.Close();

                throw new Core.Data.Exceptions.DatabaseExecutionException(database, procedureName, command, exc);

            }
        }



        /// <summary>
        /// Executes and returns an open IRecordSet, which encapsulates an OPEN DATAREADER.  DISPOSE IN FINALLY CLAUSE.
        /// </summary>
        /// <param name="database"></param>
        /// <param name="procedureName"></param>
        /// <param name="parameters"></param>
        /// <returns></returns>
        public static IRecordSet Execute(Database database, string procedureName, params object[] parameters)
        {

            IRecordSet recordSet;



            SqlConnection connection = database.GetConnection();

			SqlCommand command = CommandFactory.CreateCommand(connection, database.InstanceName, procedureName, parameters);

            try
            {

                connection.Open();
                recordSet = new DataRecord(command.ExecuteReader(CommandBehavior.CloseConnection));
                return recordSet;
            }
            catch(Exception exc)
            {
                connection.Close();

                throw new Core.Data.Exceptions.DatabaseExecutionException(database, procedureName, command, exc);
            }
        }

    
        /// <summary>
        /// Assembly-scoped class for returning a DataReader
        /// </summary>
        /// <param name="database"></param>
        /// <param name="procedureName"></param>
        /// <param name="parameters"></param>
        /// <returns></returns>
        internal static IDataReader ExecuteReader(Database database, string procedureName, params object[] parameters)
        {
            IDataReader reader;

            SqlConnection connection = database.GetConnection();
			SqlCommand command = CommandFactory.CreateCommand(connection, database.InstanceName, procedureName, parameters);

            try
            {

                connection.Open();
                reader = command.ExecuteReader(CommandBehavior.CloseConnection);
                return reader;
            }
            catch(Exception exc)
            {
                connection.Close();

                throw new Core.Data.Exceptions.DatabaseExecutionException(database, procedureName, command, exc);
            }
        }


        /// <summary>
        /// Assembly-scoped class for returning a DataReader.
        /// </summary>
        /// <param name="database"></param>
        /// <param name="procedureName"></param>
        /// <param name="parameterMapper"></param>
        /// <returns></returns>
           internal static IDataReader ExecuteReader(Database database, string procedureName, ParameterMapper parameterMapper)
           {

               SqlConnection connection = database.GetConnection();
               SqlCommand command = CommandFactory.CreateParameterMappedCommand(connection, procedureName, parameterMapper);

         
               try
               {

                   command.Connection.Open();
                   IDataReader record = command.ExecuteReader(CommandBehavior.CloseConnection);
                   return record;
               }
               catch(Exception exc)
               {
                   command.Connection.Close();

                   throw new Core.Data.Exceptions.DatabaseExecutionException(database, procedureName, command, exc);
               }
           }
    }
}
