using System;
namespace D4D.Model
{
	/// <summary>
	/// 实体类NewsTag 。(属性说明自动提取数据库字段的描述信息)
	/// </summary>
	[Serializable]
	public class NewsTag
	{
		public NewsTag()
		{}
		#region Model
		private int _id;
		private int _newsid;
		private int _tagid;
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
		public int NewsId
		{
			set{ _newsid=value;}
			get{return _newsid;}
		}
		/// <summary>
		/// 
		/// </summary>
		public int TagId
		{
			set{ _tagid=value;}
			get{return _tagid;}
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

