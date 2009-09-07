/* =====================================================
    作    者 : YangFan
    创建时间 : 2009-09-07 14:00:07
    修 改 者 : 
    修改时间 : 
    描    述 : news_type
===================================================== */

using System;
using System.Collections.Generic;
using System.Text;

namespace D4D.ShowCityTimes.Domain
{
    /// <summary>
    /// 针对 news_type 为IBatisNet创建的类型.
    /// </summary>
    [Serializable]
    public sealed class NewsType
    {
        #region 私有变量
        private bool _isChanged;
        private bool _isDeleted;
        private int _idold; // 
        private int _id; // 
        private string _name; // 
        private int _type; // 
        private TypeGroup _typegroup; // news_type
        private IList<News> _news; // news_type
        #endregion

        #region 构造函数
        /// <summary>
        /// 构造函数
        /// </summary>
        public NewsType()
        {
            
        }

        /// <summary>
        /// 构造函数
        /// </summary>
        /// <param name="id"></param>
        /// <param name="name"></param>
        /// <param name="type"></param>
        public NewsType(int id, string name, int type)
        {
            this.Id = id;
            this.Name = name;
            this.Type = type;
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
        public string Name
        {
            get
            {
                return _name;
            }
            set
            {
                if (value != null && Encoding.Default.GetByteCount(value.ToString()) > 400)
                    throw new ArgumentOutOfRangeException("Name", value.ToString(), "_长度超出限制(400)!");

                _isChanged |= (_name != value); 
                _name = value;
            }
        }

        /// <summary>
        /// 
        /// </summary> 
        public int Type
        {
            get
            {
                return _type;
            }
            set
            {
                if (value != null && Encoding.Default.GetByteCount(value.ToString()) > 4)
                    throw new ArgumentOutOfRangeException("Type", value.ToString(), "_长度超出限制(4)!");

                _isChanged |= (_type != value); 
                _type = value;
            }
        }

        /// <summary>
        /// news_type
        /// </summary> 
        public TypeGroup TypeGroup
        {
            get
            {
                return _typegroup;
            }
            set
            {
                _isChanged |= (_typegroup != value); _typegroup = value;
            }
        }

        /// <summary>
        /// news_type
        /// </summary> 
        public IList<News> News
        {
            get
            {
                return _news;
            }
            set
            {
                if (value != null)
                {
                    foreach (News prt in value)
                    {
                        prt.NewsType = this;
                    }
                }
                _isChanged |= (_news != value); _news = value;
            }
        }

        /// <summary>
        /// 
        /// </summary> 
        public int TypeGroup_Id
        {
            get
            {
                if(this._typegroup == null)
                    this._typegroup = new TypeGroup();
                return this._typegroup.Id;
            }
        }

        /// <summary>
        /// 
        /// </summary> 
        public string TypeGroup_Name
        {
            get
            {
                if(this._typegroup == null)
                    this._typegroup = new TypeGroup();
                return this._typegroup.Name;
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
