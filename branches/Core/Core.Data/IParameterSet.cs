using System;
using System.Data.SqlClient;

namespace Core.Data
{
    public enum ParameterDirectionWrap
    {
        Input = 1,
        Output =2,
        InputOutput =3,
        ReturnValue =6
    }

    public interface IParameterSet
    {
        /// <summary>
        /// Adds parameter to <see cref="IParameterSet"/>
        /// </summary>
        /// <param name="key">
        /// Unique key corresponding to stored procedure parameter
        /// </param>
        /// <param name="value">
        /// Value for stored procedure parameter. 
        /// If null, the DBNull value will be used as parameter value for stored procedure
        /// </param>
        void AddWithValue(string key, object value);

        /// <summary>
        /// Adds parameter to <see cref="IParameterSet"/>
        /// </summary>
        /// <param name="key">
        /// Unique key corresponding to stored procedure parameter
        /// </param>
        /// <param name="value">
        /// Value for stored procedure parameter. 
        /// If null, the DBNull value will be used as parameter value for stored procedure
        /// </param>
        /// <param name="direction">
        /// Parameter direction (Input, InputOutput, Output, ReturnValue)
        /// For output parameters of sizeable types (varchar, etc) use overload with proper data size
        /// </param>
        void AddWithValue(string key, object value, ParameterDirectionWrap direction);

        /// <summary>
        /// Adds parameter to <see cref="IParameterSet"/>
        /// </summary>
        /// <param name="key">
        /// Unique key corresponding to stored procedure parameter
        /// </param>
        /// <param name="value">
        /// Value for stored procedure parameter. 
        /// If null, the DBNull value will be used as parameter value for stored procedure
        /// </param>
        /// <param name="direction">
        /// Parameter direction (Input, InputOutput, Output, ReturnValue)
        /// For output parameters of sizeable types (varchar, etc) use overload with proper data size
        /// </param>
        /// <param name="size">
        /// Size of parameter. Will override inferred parameter size
        /// </param>
        void AddWithValue(string key, object value, ParameterDirectionWrap direction, int? size);

        /// <summary>
        /// Get value of specified parameter 
        /// </summary>
        /// <param name="key">Unique parameter key</param>
        /// <returns>Value of parameter</returns>
        object GetValue(string key);
    }

    internal class ParameterSet : Core.Data.IParameterSet
    {
        private SqlParameterCollection pm;

        internal ParameterSet(SqlParameterCollection sqlParameterCollection)
        {
       
            pm = sqlParameterCollection;
        }

        public object GetValue(string key)
        {
            return pm[key].Value;
        }

        public void AddWithValue(string key, object value)
        {
			
				if ( value == null )
					value = DBNull.Value;

            pm.AddWithValue(key, value);
        }

        public void AddWithValue(string key, object value, ParameterDirectionWrap direction)
        {
            AddWithValue(key, value, direction, null);
        }

        public void AddWithValue(string key, object value, ParameterDirectionWrap direction, int? size)
        {
		
				if (value == null)
					value = DBNull.Value;

            SqlParameter sp = new SqlParameter(key, value);

            System.Data.ParameterDirection pDir;

            switch (direction)
            {
                case ParameterDirectionWrap.Input:
                    pDir = System.Data.ParameterDirection.Input;
                    break;
                case ParameterDirectionWrap.InputOutput:
                    pDir = System.Data.ParameterDirection.InputOutput;
                    break;
                case ParameterDirectionWrap.Output:
                    pDir = System.Data.ParameterDirection.Output;
                    break;
                case ParameterDirectionWrap.ReturnValue:
                    pDir = System.Data.ParameterDirection.ReturnValue;
                    break;
                default:
                    pDir = System.Data.ParameterDirection.Input;
                    break;
            }

            sp.Direction = pDir;

            if (size.HasValue)
                sp.Size = size.Value;

            this.pm.Add(sp);

        }
    }

}
