/* =====================================================
    作    者 : YangFan
    创建时间 : 2009-09-07 14:00:07
    修 改 者 : 
    修改时间 : 
    描    述 : news
===================================================== */

using System;
using System.Collections.Generic;
using System.Text;

namespace D4D.ShowCityTimes.Domain
{
    /// <summary>
    /// 针对 news 为IBatisNet创建的类型.
    /// </summary>
    [Serializable]
    public sealed class News
    {
        #region 私有变量
        private bool _isChanged;
        private bool _isDeleted;
        private int? _idold; // 
        private int? _id; // 
        private string _title; // 
        private string _detail; // 
        private DateTime? _adddate; // 
        private string _tags; // 
        private int? _newtype; // 
        private bool? _publish; // 
        private NewsType _newstype; // news
        #endregion

        #region 构造函数
        /// <summary>
        /// 构造函数
        /// </summary>
        public News()
        {
            
        }

        /// <summary>
        /// 构造函数
        /// </summary>
        /// <param name="id"></param>
        /// <param name="title"></param>
        /// <param name="detail"></param>
        /// <param name="adddate"></param>
        /// <param name="tags"></param>
        /// <param name="newtype"></param>
        /// <param name="publish"></param>
        public News(int id, string title, string detail, DateTime adddate, string tags, int newtype, bool publish)
        {
            this.Id = id;
            this.Title = title;
            this.Detail = detail;
            this.Adddate = adddate;
            this.Tags = tags;
            this.Newtype = newtype;
            this.Publish = publish;
        }

        #endregion

        #region 公共属性

        /// <summary>
        /// 
        /// </summary> 
        public int? IdOld
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
        public int? Id
        {
            get
            {
                return _id;
            }
            set
            {
                if (value != null && Encoding.Default.GetByteCount(value.ToString()) > 4)
                    throw new ArgumentOutOfRangeException("Id", value.ToString(), "_长度超出限制(4)!");

                _isChanged |= (_id != value); 
                _id = value;
                if (_idold == null)
                    _idold = _id;
            }
        }

        /// <summary>
        /// 
        /// </summary> 
        public string Title
        {
            get
            {
                return _title;
            }
            set
            {
                if (value != null && Encoding.Default.GetByteCount(value.ToString()) > 400)
                    throw new ArgumentOutOfRangeException("Title", value.ToString(), "_长度超出限制(400)!");

                _isChanged |= (_title != value); 
                _title = value;
            }
        }

        /// <summary>
        /// 
        /// </summary> 
        public string Detail
        {
            get
            {
                return _detail;
            }
            set
            {
                
                _isChanged |= (_detail != value); 
                _detail = value;
            }
        }

        /// <summary>
        /// 
        /// </summary> 
        public DateTime? Adddate
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
        /// 
        /// </summary> 
        public string Tags
        {
            get
            {
                return _tags;
            }
            set
            {
                if (value != null && Encoding.Default.GetByteCount(value.ToString()) > 50)
                    throw new ArgumentOutOfRangeException("Tags", value.ToString(), "_长度超出限制(50)!");

                _isChanged |= (_tags != value); 
                _tags = value;
            }
        }

        /// <summary>
        /// 
        /// </summary> 
        public int? Newtype
        {
            get
            {
                return _newtype;
            }
            set
            {
                if (value != null && Encoding.Default.GetByteCount(value.ToString()) > 4)
                    throw new ArgumentOutOfRangeException("Newtype", value.ToString(), "_长度超出限制(4)!");

                _isChanged |= (_newtype != value); 
                _newtype = value;
            }
        }

        /// <summary>
        /// 
        /// </summary> 
        public Boolean? Publish
        {
            get
            {
                return _publish;
            }
            set
            {
                _isChanged |= (_publish != value); 
                _publish = value;
            }
        }

        /// <summary>
        /// news
        /// </summary> 
        public NewsType NewsType
        {
            get
            {
                return _newstype;
            }
            set
            {
                _isChanged |= (_newstype != value); _newstype = value;
            }
        }

        /// <summary>
        /// 
        /// </summary> 
        public int? NewsType_Id
        {
            get
            {
                if(this._newstype == null)
                    this._newstype = new NewsType();
                return this._newstype.Id;
            }
        }

        /// <summary>
        /// 
        /// </summary> 
        public string NewsType_Name
        {
            get
            {
                if(this._newstype == null)
                    this._newstype = new NewsType();
                return this._newstype.Name;
            }
        }

        /// <summary>
        /// 
        /// </summary> 
        public int? NewsType_Type
        {
            get
            {
                if(this._newstype == null)
                    this._newstype = new NewsType();
                return this._newstype.Type;
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
