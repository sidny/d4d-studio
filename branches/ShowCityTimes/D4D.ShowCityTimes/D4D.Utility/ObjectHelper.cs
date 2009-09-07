/* =====================================================
    作    者 : YangFan
    创建时间 : 2009-09-07 14:00:06
    修 改 者 : 
    修改时间 : 
    描    述 : ObjectHelper<T>类
===================================================== */

using System;
using System.IO;
using System.Runtime.Serialization;
using System.Collections.Generic;
using System.Runtime.Serialization.Formatters.Binary;

namespace D4D.Utility
{
    public class ObjectHelper<T>
    {

       /// <summary>
       /// 采用序列化的方式对对象进行深层克隆
       /// </summary>
       /// <param name="o">需要克隆的对象</param>
       /// <returns>返回克隆对象</returns>
        public static T Clone(T o)
        {
            if (o == null) return o;
            System.IO.MemoryStream _memory = new System.IO.MemoryStream();
            BinaryFormatter formatter = new BinaryFormatter();
            formatter.Serialize(_memory, o);
            _memory.Position = 0;
            T _newOjb = (T)formatter.Deserialize(_memory);
            _memory.Close();
            return _newOjb;
        }
    }
}
