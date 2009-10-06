using System;
namespace D4D.Model
{
	/// <summary>
	/// 实体类Image 。(属性说明自动提取数据库字段的描述信息)
	/// </summary>
	public class Image
	{
		public Image()
		{}
		#region Model
		private int _id;
		private int _albumid;
		private string _url;
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
		public int AlbumId
		{
			set{ _albumid=value;}
			get{return _albumid;}
		}
		/// <summary>
		/// 
		/// </summary>
		public string Url
		{
			set{ _url=value;}
			get{return _url;}
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

