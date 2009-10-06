using System;
namespace D4D.Model
{
	/// <summary>
	/// 实体类Tag 。(属性说明自动提取数据库字段的描述信息)
	/// </summary>
	[Serializable]
	public class Tag
	{
		public Tag()
		{}
		#region Model
		private int _id;
		private string _name;
		private int _hits;
		private DateTime _adddate;
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
		public string Name
		{
			set{ _name=value;}
			get{return _name;}
		}
		/// <summary>
		/// 
		/// </summary>
		public int Hits
		{
			set{ _hits=value;}
			get{return _hits;}
		}
		/// <summary>
		/// 
		/// </summary>
		public DateTime AddDate
		{
			set{ _adddate=value;}
			get{return _adddate;}
		}
		#endregion Model

	}
}

