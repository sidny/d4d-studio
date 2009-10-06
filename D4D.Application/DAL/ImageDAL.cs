using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Text;

using D4D.DBUtility;

//请先添加dll引用
namespace D4D.DAL
{
	/// <summary>
	/// 数据访问类Image。
	/// </summary>
	public class ImageDAL : BaseSqlMapDao 
	{
		public ImageDAL()
		{}
		#region  成员方法
		/// <summary>
		/// 是否存在该记录
		/// </summary>
		public bool Exists(object Id)
		{
			return ExecuteExists("Image.Exists", Id);
		}


		/// <summary>
		/// 增加一条数据
		/// </summary>
		public int Add(D4D.Model.Image model)
		{
			return ExecuteInsert("Image.InsertImage", model);
		}
		/// <summary>
		/// 更新一条数据
		/// </summary>
		public void Update(D4D.Model.Image model)
		{
			ExecuteUpdate("Image.UpdateImage", model);
		}

		/// <summary>
		/// 删除一条数据
		/// </summary>
		public void Delete(D4D.Model.Image model)
		{
			ExecuteDelete("Image.DeleteImage", model);
		}


		/// <summary>
		/// 得到一个对象实体
		/// </summary>
		public D4D.Model.Image GetModel(object Id)
		{
			D4D.Model.Image model = ExecuteQueryForObject<D4D.Model.Image>("Image.SelectById", Id);
			return model;
		}

		/// <summary>
		/// 获得数据列表
		/// </summary>
		public IList<D4D.Model.Image> GetList(D4D.Model.Image model)
		{
			IList<D4D.Model.Image> list = null; 
			list = ExecuteQueryForList<D4D.Model.Image>("Image.SelectImage", model); 
			return list; 
		}

		/*
		/// <summary>
		/// 分页获取数据列表
		/// </summary>
		public DataSet GetList(int PageSize,int PageIndex,string strWhere)
		{
			SqlParameter[] parameters = {
					new SqlParameter("@tblName", SqlDbType.VarChar, 255),
					new SqlParameter("@fldName", SqlDbType.VarChar, 255),
					new SqlParameter("@PageSize", SqlDbType.Int),
					new SqlParameter("@PageIndex", SqlDbType.Int),
					new SqlParameter("@IsReCount", SqlDbType.Bit),
					new SqlParameter("@OrderType", SqlDbType.Bit),
					new SqlParameter("@strWhere", SqlDbType.VarChar,1000),
					};
			parameters[0].Value = "image";
			parameters[1].Value = "ID";
			parameters[2].Value = PageSize;
			parameters[3].Value = PageIndex;
			parameters[4].Value = 0;
			parameters[5].Value = 0;
			parameters[6].Value = strWhere;	
			return DbHelperSQL.RunProcedure("UP_GetRecordByPage",parameters,"ds");
		}*/

		#endregion  成员方法
	}
}

