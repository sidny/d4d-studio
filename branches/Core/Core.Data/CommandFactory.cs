using System;
using System.Collections.Generic;
using System.Text;
using System.Data.SqlClient;
using Core.Data.MapperDelegates;
using System.Data;
using Core.Data.Exceptions;
using System.Diagnostics;

namespace Core.Data
{
    internal class CommandFactory
    {
        private static CommandCache commandCache = new CommandCache();

		private static void MapParameters(SqlCommand command, object[] parameters)
		{
			int returnValueOffset = 1;
			if (parameters == null)
			{
				AssertParameterCount(command.Parameters.Count, 0, returnValueOffset, command.CommandText);
				return;
			}
			else
				AssertParameterCount(command.Parameters.Count, parameters.Length, returnValueOffset, command.CommandText);

			for ( int i = 0 + returnValueOffset, j = parameters.Length; i <= j; i++ )
			{
				object parameterValue = parameters[i - 1];				
					if (parameterValue == null)
						parameterValue = DBNull.Value;
				command.Parameters[i].Value = parameterValue;
			}
		}

		private static void MapParameters(SqlCommand command, StoredProcedureParameterList parameters)
		{
			int returnValueOffset = 1;

			AssertParameterCount(command.Parameters.Count, parameters.Count, returnValueOffset, command.CommandText);

			for (int i = 0 + returnValueOffset, j = parameters.Count; i <= j; i++)
			{
				StoredProcedureParameter spp = parameters[i - 1];
				SqlParameter sqlParameter;
				if (spp.Key != null)
					sqlParameter = command.Parameters[spp.Key];
				else
					sqlParameter = command.Parameters[i];

				sqlParameter.Value = spp.Value;				
			if (sqlParameter.Value == null)
						sqlParameter.Value = DBNull.Value;

				switch (spp.ParameterDirection)
				{
					case ParameterDirectionWrap.Input:
						sqlParameter.Direction = ParameterDirection.Input;
						break;
					case ParameterDirectionWrap.Output:
						sqlParameter.Direction = ParameterDirection.Output;
						break;
					case ParameterDirectionWrap.InputOutput:
						sqlParameter.Direction = ParameterDirection.InputOutput;
						break;
					case ParameterDirectionWrap.ReturnValue:
						sqlParameter.Direction = ParameterDirection.ReturnValue;
						break;
					default:
						throw new ArgumentException("Unknow parameter direction specified: " + spp.ParameterDirection.ToString());
				}

				if (spp.Size.HasValue)
					sqlParameter.Size = spp.Size.Value;
			}
		}

		private static void AssertParameterCount(int numProcedureParameters, int numPassedParameters, int returnValueOffset, string procedureName) 
		{
#if DEBUG
			if (numProcedureParameters != numPassedParameters + returnValueOffset)
				throw new ArgumentException(string.Format("The incorrect number of parameters were supplied to the procedure {0}.  The number supplied was: {1}.  The number expected is: {2}.",
					procedureName, numPassedParameters, numProcedureParameters - returnValueOffset));
#else
			if (numProcedureParameters < numPassedParameters + returnValueOffset)
				throw new ArgumentException(string.Format("Too many parameters parameters were supplied to the procedure {0}.  The number supplied was: {1}.  The number expected is: {2}.",
					procedureName, numPassedParameters, numProcedureParameters - returnValueOffset));
#endif
		}

        internal static SqlCommand CreateParameterizedCommand(SqlConnection connection, string databaseInstanceName, string commandName)
        {
            //if (commandName.IndexOf("dbo", StringComparison.OrdinalIgnoreCase) == -1)
            //    throw new NoDboException(connection.Database, commandName);

			SqlCommand command = commandCache.GetCommandCopy(connection, databaseInstanceName, commandName);
		
			return command;

        }

        /// <summary>
        /// Creates and prepares SqlCommand object and calls parameterMapper to populate command parameters
        /// </summary>
        /// <param name="connection"></param>
        /// <param name="procedureName"></param>
        /// <param name="parameterMapper"></param>
        /// <returns></returns>
		internal static SqlCommand CreateParameterMappedCommand(SqlConnection connection, string procedureName, ParameterMapper parameterMapper)
        {
            //if(procedureName.IndexOf("dbo",StringComparison.OrdinalIgnoreCase) == -1)
            //    throw new NoDboException(connection.Database, procedureName);

           SqlCommand command = connection.CreateCommand();
            command.CommandText = procedureName;
            command.CommandType = CommandType.StoredProcedure;

            if(parameterMapper != null)
            {
                ParameterSet pSet = new ParameterSet(command.Parameters);
                parameterMapper(pSet);
            }
		
            return command;
        }

        /// <summary>
        /// Creates and prepares SqlCommand object and calls strongly typed parameterMapper to populate command parameters
        /// </summary>
		internal static SqlCommand CreateParameterMappedCommand<T>(SqlConnection connection, string procedureName, ParameterMapper<T> parameterMapper, T objectInstance)
        {
            //if (procedureName.IndexOf("dbo", StringComparison.OrdinalIgnoreCase) == -1)
            //    throw new NoDboException(connection.Database, procedureName);

            SqlCommand command = connection.CreateCommand();
            command.CommandText = procedureName;
            command.CommandType = CommandType.StoredProcedure;

            if (parameterMapper != null)
            {
                ParameterSet pSet = new ParameterSet(command.Parameters);
                parameterMapper(pSet, objectInstance);
            }

		
            return command;
        }

		internal static SqlCommand CreateCommand(SqlConnection connection, string databaseInstanceName, string commandName, params object[] parameterValues)
		{
			SqlCommand command = CreateParameterizedCommand(connection, databaseInstanceName, commandName);
			MapParameters(command, parameterValues);

		
			return command;
		}

		/// <summary>
		/// Creates and prepares an SqlCommand object and sets parameters from the parameter list either by their index value or name.
		/// </summary>
		/// <returns></returns>
		internal static SqlCommand CreateCommand(SqlConnection connection, string databaseInstanceName, string commandName, StoredProcedureParameterList parameterList)
		{
			SqlCommand command = CreateParameterizedCommand(connection, databaseInstanceName, commandName);
			MapParameters(command, parameterList);
		
			return command;
		}

	
    }
}
