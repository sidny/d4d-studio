using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Diagnostics;
using Core.Data;

namespace Core.Data.Test
{
    class Program
    {
        static void Main(string[] args)
        {
            SafeProcedure.ExecuteAndMapRecords(Database.GetDatabase("MyTest"),
                "dbo.GetMyTest",
                delegate(IRecord record)
                {
                    Trace.WriteLine(record.GetStringOrEmpty(0));
                    Trace.WriteLine(record.GetInt32(1));
                    Trace.WriteLine(record.GetStringOrEmpty(2));
                    Trace.WriteLine("---------------record-----------------");

                },
                "test");//Copy conn.config to build path
            
        }
    }
}
