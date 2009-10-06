using System;
namespace D4D.Model
{
	/// <summary>
	/// 实体类UserLogin 。(属性说明自动提取数据库字段的描述信息)
	/// </summary>
	[Serializable]
	public class UserLogin
	{
		public UserLogin()
		{}
		#region Model
		private int _id;
		private byte[] _username;
		private byte[] _password;
		private byte[] _email;
		private DateTime? _adddate;
		/// <summary>
		/// 
		/// </summary>
		public int Id
		{
			set{ _id=value;}
			get{return _id;}
		}
		/// <summary>
		/// 
		/// </summary>
		public byte[] UserName
		{
			set{ _username=value;}
			get{return _username;}
		}
		/// <summary>
		/// 
		/// </summary>
		public byte[] PassWord
		{
			set{ _password=value;}
			get{return _password;}
		}
		/// <summary>
		/// 
		/// </summary>
		public byte[] Email
		{
			set{ _email=value;}
			get{return _email;}
		}
		/// <summary>
		/// 
		/// </summary>
		public DateTime? AddDate
		{
			set{ _adddate=value;}
			get{return _adddate;}
		}
		#endregion Model

	}
}

