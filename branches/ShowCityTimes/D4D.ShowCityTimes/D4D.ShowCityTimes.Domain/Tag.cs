/* =====================================================
    作    者 : YangFan
    创建时间 : 2009-09-07 14:00:06
    修 改 者 : 
    修改时间 : 
    描    述 : tag
===================================================== */

using System;
using System.Collections.Generic;
using System.Text;

namespace D4D.ShowCityTimes.Domain
{
    /// <summary>
    /// 针对 tag 为IBatisNet创建的类型.
    /// </summary>
    [Serializable]
    public sealed class Tag
    {
        #region 私有变量
        private bool _isChanged;
        private bool _isDeleted;
        private int _idold; // 
        private int _id; // 
        private string _name; // 
        private int _viewcount; // 
        private DateTime _adddate; // 
        #endregion

        #region 构造函数
        /// <summary>
        /// 构造函数
        /// </summary>
        public Tag()
        {
            
        }

        /// <summary>
        /// 构造函数
        /// </summary>
        /// <param name="id"></param>
        /// <param name="name"></param>
        /// <param name="viewcount"></param>
        /// <param name="adddate"></param>
        public Tag(int id, string name, int viewcount)
        {
            this.Id = id;
            this.Name = name;
            this.Viewcount = viewcount;
        }

        #endregion

        #region 公共属性

        /// <summary>
        /// 
        /// </summary> 
        public int IdOld
        {
            get
            {
                    return _idold;
            }
            set
            {
                _idold = value;
            }
        }

        /// <summary>
        /// 
        /// </summary> 
        public int Id
        {
            get
            {
                return _id;
            }
            set
            {
               
                _isChanged |= (_id != value); 
                _id = value;
                if (_idold == null)
                    _idold = _id;
            }
        }

        /// <summary>
        /// 
        /// </summary> 
        public string Name
        {
            get
            {
                return _name;
            }
            set
            {
                if (value != null && Encoding.Default.GetByteCount(value.ToString()) > 200)
                    throw new ArgumentOutOfRangeException("Name", value.ToString(), "_长度超出限制(200)!");

                _isChanged |= (_name != value); 
                _name = value;
            }
        }

        /// <summary>
        /// 
        /// </summary> 
        public int Viewcount
        {
            get
            {
                return _viewcount;
            }
            set
            {
               
                _isChanged |= (_viewcount != value); 
                _viewcount = value;
            }
        }

        /// <summary>
        /// 
        /// </summary> 
        public DateTime Adddate
        {
            get
            {
                return _adddate;
            }
            set
            {
               
                _isChanged |= (_adddate != value); 
                _adddate = value;
            }
        }

        /// <summary>
        /// 表示实例是否已经发生改变.
        /// </summary>
        public bool IsChanged
        {
            get { return _isChanged; }
        }

        /// <summary>
        /// 表示实例是否已经被删除.
        /// </summary>
        public bool IsDeleted
        {
            get { return _isDeleted; }
        }

        #endregion

        #region 公共方法

        /// <summary>
        /// 调用方法,标识实例已经被删除.
        /// </summary>
        public void MarkAsDeleted()
        {
            _isDeleted = true;
            _isChanged = true;
        }
        /// <summary>
        /// 清空状态,设置为未改动.
        /// </summary>
        public void ClearMarks()
        {
            _isDeleted = false;
            _isChanged = false;
        }

        /// <summary>
        /// 设置已改动.
        /// </summary>
        public void Changed()
        {
            _isChanged = true;
        }

        #endregion

    }
}
