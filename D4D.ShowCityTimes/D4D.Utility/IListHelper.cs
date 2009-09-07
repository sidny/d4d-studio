/* =====================================================
    作    者 : YangFan
    创建时间 : 2009-09-07 14:00:06
    修 改 者 : 
    修改时间 : 
    描    述 : IListHelper类
===================================================== */

using System;
using System.Collections.Generic;
using System.Text;
using System.Data;

namespace D4D.Utility
{
    public class IListHelper
    {
        /// <summary>
        /// Ilist<T> 转换成 DataSet
        /// </summary>
        /// <param name="list">Ilist<T></param>
        /// <returns>DataSet</returns>

        public static DataSet ConvertToDataSet<T>(IList<T> list)
        {
            if (list == null || list.Count <= 0)
            {
                return null;
            }
 
            DataSet ds = new DataSet();
            DataTable dt = new DataTable(typeof(T).Name);
            DataColumn column;
            DataRow row;
 
            System.Reflection.PropertyInfo[] myPropertyInfo = typeof(T).GetProperties(System.Reflection.BindingFlags.Public | System.Reflection.BindingFlags.Instance);

            foreach (T t in list)
            {
                if (t == null)
                {
                    continue;
                }

                row = dt.NewRow();

                for (int i = 0, j = myPropertyInfo.Length; i < j; i++)
                {
                    System.Reflection.PropertyInfo pi = myPropertyInfo[i];

                    string name = pi.Name;

                    if (dt.Columns[name] == null)
                    {
                        column = new DataColumn(name, pi.PropertyType);
                        dt.Columns.Add(column);
                    }

                    row[name] = pi.GetValue(t, null);
                }

                dt.Rows.Add(row);
            }

            ds.Tables.Add(dt);

            return ds;
        }
    }
}
