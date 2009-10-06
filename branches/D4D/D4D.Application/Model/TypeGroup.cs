using System;
namespace D4D.Model
{
	/// <summary>
	/// 实体类TypeGroup 。(属性说明自动提取数据库字段的描述信息)
	/// </summary>
	[Serializable]
	public class TypeGroup
	{
		public TypeGroup()
		{}
		#region Model
		private int _id;
		private string _name;
		/// <summary>
		/// 
		/// </summary>
		public int id
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
		#endregion Model

	}
}

