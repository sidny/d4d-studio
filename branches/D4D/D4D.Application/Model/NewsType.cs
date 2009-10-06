using System;
namespace D4D.Model
{
	/// <summary>
	/// 实体类NewsType 。(属性说明自动提取数据库字段的描述信息)
	/// </summary>
	public class NewsType
	{
		public NewsType()
		{}
		#region Model
		private int _id;
		private string _name;
		private int _type;
		private int _parent;
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
		public int Type
		{
			set{ _type=value;}
			get{return _type;}
		}
		/// <summary>
		/// 
		/// </summary>
		public int Parent
		{
			set{ _parent=value;}
			get{return _parent;}
		}
		#endregion Model

	}
}

