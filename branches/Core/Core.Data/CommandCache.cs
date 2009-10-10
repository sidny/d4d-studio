using System;
using System.Collections.Generic;
using System.Text;
using System.Data.SqlClient;
using System.Data;

namespace Core.Data
{
    class CommandCache : Dictionary<string, SqlCommand>
    {
		internal SqlCommand GetCommandCopy(SqlConnection connection, string databaseInstanceName, string procedureName)
        {
            SqlCommand copiedCommand;
			string commandCacheKey = databaseInstanceName + procedureName;

			if (!this.ContainsKey(commandCacheKey))
            {
                SqlCommand command = connection.CreateCommand();
                command.CommandType = CommandType.StoredProcedure;
                command.CommandText = procedureName;

                connection.Open();
                SqlCommandBuilder.DeriveParameters(command);
                connection.Close();

                lock (this)
                {
					this[commandCacheKey] = command;
                }
            }

			copiedCommand = this[commandCacheKey].Clone();
            copiedCommand.Connection = connection;
            return copiedCommand;
        }
    }
}
