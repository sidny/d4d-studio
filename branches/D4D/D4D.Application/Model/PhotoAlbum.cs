using System;
namespace D4D.Model
{
	/// <summary>
	/// 实体类PhotoAlbum 。(属性说明自动提取数据库字段的描述信息)
	/// </summary>
	[Serializable]
	public class PhotoAlbum
	{
		public PhotoAlbum()
		{}
		#region Model
		private int _id;
		private string _name;
		private string _picsmall;
		private string _picbig;
		private DateTime? _adddate;
		private bool _publish;
		private int _totalcount;
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
		public string PicSmall
		{
			set{ _picsmall=value;}
			get{return _picsmall;}
		}
		/// <summary>
		/// 
		/// </summary>
		public string PicBig
		{
			set{ _picbig=value;}
			get{return _picbig;}
		}
		/// <summary>
		/// 
		/// </summary>
		public DateTime? AddDate
		{
			set{ _adddate=value;}
			get{return _adddate;}
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
		public int TotalCount
		{
			set{ _totalcount=value;}
			get{return _totalcount;}
		}
		#endregion Model

	}
}

