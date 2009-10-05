using System;
using System.Data;
using System.Text;
using System.Data.SqlClient;
using System.Collections.Generic;
using D4D.DBUtility;
using System.Collections;
namespace D4D.DAL
{
	/// <summary>
	/// 数据访问类News。
	/// </summary>
	public class NewsDAL : BaseSqlMapDao
	{
		public NewsDAL()
		{}
		#region  成员方法
		/// <summary>
		/// 是否存在该记录
		/// </summary>
		public bool Exists(object Id)
		{
			return ExecuteExists("Exists", Id);
		}


        /// <summary>
        /// 统计总数
        /// </summary>
        public int Count()
        {
            return ExecuteQueryForObject<int>("CountAllByPage", null);
        }

		/// <summary>
		/// 增加一条数据
		/// </summary>
		public int Add(D4D.Model.News model)
		{
			return ExecuteInsert("InsertNews", model);
		}
		/// <summary>
		/// 更新一条数据
		/// </summary>
		public void Update(D4D.Model.News model)
		{
			ExecuteUpdate("UpdateNews", model);
		}

		/// <summary>
		/// 删除一条数据
		/// </summary>
		public void Delete(D4D.Model.News model)
		{
			ExecuteDelete("DeleteNews", model);
		}


		/// <summary>
		/// 得到一个对象实体
		/// </summary>
		public D4D.Model.News GetModel(object Id)
		{
			D4D.Model.News model = ExecuteQueryForObject<D4D.Model.News>("SelectById", Id);
			return model;
		}

		/// <summary>
		/// 获得数据列表
		/// </summary>
        public IList<D4D.Model.News> GetList(D4D.Model.News model, int recodeRange,int pageSize)
		{
			IList<D4D.Model.News> list = null;
            list = ExecuteQueryForList<D4D.Model.News>("SelectAllNews", model,recodeRange,pageSize); 
			return list; 
		}


        public IList<D4D.Model.News> GetList(D4D.Model.News model)
        {
            return GetList(model, 0,-1);
        }

        public IList<D4D.Model.News> GetListByPage(D4D.Model.News model, int recordRange, int pageSize)
        {
            IList<D4D.Model.News> list = null;
            Hashtable map = new Hashtable();
            map.Add("recordRange", recordRange);
            map.Add("pageSize", pageSize);
            map.Add("totalCount", 0);
            list = ExecuteQueryForList<D4D.Model.News>("SelectAllNews", map);
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
			parameters[0].Value = "news";
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

