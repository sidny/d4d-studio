using System;
namespace D4D.Model
{
	/// <summary>
	/// 实体类Comment 。(属性说明自动提取数据库字段的描述信息)
	/// </summary>
	public class Comment
	{
		public Comment()
		{}
		#region Model
		private int _id;
		private int? _userid;
		private int? _newsid;
		private string _detail;
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
		public int? UserId
		{
			set{ _userid=value;}
			get{return _userid;}
		}
		/// <summary>
		/// 
		/// </summary>
		public int? NewsId
		{
			set{ _newsid=value;}
			get{return _newsid;}
		}
		/// <summary>
		/// 
		/// </summary>
		public string Detail
		{
			set{ _detail=value;}
			get{return _detail;}
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

