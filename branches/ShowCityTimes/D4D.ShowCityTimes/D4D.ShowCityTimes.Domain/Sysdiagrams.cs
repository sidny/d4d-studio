/* =====================================================
    作    者 : YangFan
    创建时间 : 2009-09-07 14:00:07
    修 改 者 : 
    修改时间 : 
    描    述 : sysdiagrams
===================================================== */

using System;
using System.Collections.Generic;
using System.Text;

namespace D4D.ShowCityTimes.Domain
{
    /// <summary>
    /// 针对 sysdiagrams 为IBatisNet创建的类型.
    /// </summary>
    [Serializable]
    public sealed class Sysdiagrams
    {
        #region 私有变量
        private bool _isChanged;
        private bool _isDeleted;
        private string _name; // 
        private string _principalid; // 
        private string _diagramidold; // 
        private string _diagramid; // 
        private string _version; // 
        private string _definition; // 
        #endregion

        #region 构造函数
        /// <summary>
        /// 构造函数
        /// </summary>
        public Sysdiagrams()
        {
            
        }

        /// <summary>
        /// 构造函数
        /// </summary>
        /// <param name="name"></param>
        /// <param name="principalid"></param>
        /// <param name="diagramid"></param>
        /// <param name="version"></param>
        /// <param name="definition"></param>
        public Sysdiagrams(string name, string principalid, string diagramid, string version, string definition)
        {
            this.Name = name;
            this.PrincipalId = principalid;
            this.DiagramId = diagramid;
            this.Version = version;
            this.Definition = definition;
        }

        #endregion

        #region 公共属性

        /// <summary>
        /// 
        /// </summary> 
        public string DiagramIdOld
        {
            get
            {
                    return _diagramidold;
            }
            set
            {
                _diagramidold = value;
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
                if (value != null && Encoding.Default.GetByteCount(value.ToString()) > 256)
                    throw new ArgumentOutOfRangeException("Name", value.ToString(), "_长度超出限制(256)!");

                _isChanged |= (_name != value); 
                _name = value;
            }
        }

        /// <summary>
        /// 
        /// </summary> 
        public string PrincipalId
        {
            get
            {
                return _principalid;
            }
            set
            {
                if (value != null && Encoding.Default.GetByteCount(value.ToString()) > 4)
                    throw new ArgumentOutOfRangeException("PrincipalId", value.ToString(), "_长度超出限制(4)!");

                _isChanged |= (_principalid != value); 
                _principalid = value;
            }
        }

        /// <summary>
        /// 
        /// </summary> 
        public string DiagramId
        {
            get
            {
                return _diagramid;
            }
            set
            {
                if (value != null && Encoding.Default.GetByteCount(value.ToString()) > 4)
                    throw new ArgumentOutOfRangeException("DiagramId", value.ToString(), "_长度超出限制(4)!");

                _isChanged |= (_diagramid != value); 
                _diagramid = value;
                if (_diagramidold == null)
                    _diagramidold = _diagramid;
            }
        }

        /// <summary>
        /// 
        /// </summary> 
        public string Version
        {
            get
            {
                return _version;
            }
            set
            {
                if (value != null && Encoding.Default.GetByteCount(value.ToString()) > 4)
                    throw new ArgumentOutOfRangeException("Version", value.ToString(), "_长度超出限制(4)!");

                _isChanged |= (_version != value); 
                _version = value;
            }
        }

        /// <summary>
        /// 
        /// </summary> 
        public string Definition
        {
            get
            {
                return _definition;
            }
            set
            {
                if (value != null && Encoding.Default.GetByteCount(value.ToString()) > -1)
                    throw new ArgumentOutOfRangeException("Definition", value.ToString(), "_长度超出限制(-1)!");

                _isChanged |= (_definition != value); 
                _definition = value;
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
