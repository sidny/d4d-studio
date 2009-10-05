using System;
namespace D4D.Model
{
	/// <summary>
	/// 实体类News 。(属性说明自动提取数据库字段的描述信息)
	/// </summary>
	public class News
	{
		public News()
		{}
		#region Model
		private int _id;
		private string _title;
		private string _detail;
		private string _preview;
		private DateTime _adddate;
		private int? _newtype;
		private bool _publish;
		private int _hits;
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
		public string Title
		{
			set{ _title=value;}
			get{return _title;}
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
		public string Preview
		{
			set{ _preview=value;}
			get{return _preview;}
		}
		/// <summary>
		/// 
		/// </summary>
		public DateTime AddDate
		{
			set{ _adddate=value;}
			get{return _adddate;}
		}
		/// <summary>
		/// 
		/// </summary>
		public int? NewType
		{
			set{ _newtype=value;}
			get{return _newtype;}
		}
		/// <summary>
		/// 
		/// </summary>
		public bool Publish
		{
			set{ _publish=value;}
			get{return _publish;}
		}
		/// <summary>
		/// 
		/// </summary>
		public int Hits
		{
			set{ _hits=value;}
			get{return _hits;}
		}
		#endregion Model

	}
}

