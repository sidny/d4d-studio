namespace LTP.Accounts.Data
{
    using LTP.Accounts;
    using System;
    using System.Data;
    using System.Data.SqlClient;

    public class Role
    {
        public void AddPermission(int roleId, int permissionId)
        {
            int num;
            SqlParameter[] parameters = new SqlParameter[] { new SqlParameter("@RoleID", SqlDbType.Int, 4), new SqlParameter("@PermissionID", SqlDbType.Int, 4) };
            parameters[0].Value = roleId;
            parameters[1].Value = permissionId;
            DbHelperSQL.RunProcedure("sp_Accounts_AddPermissionToRole", parameters, out num);
        }

        public void ClearPermissions(int roleId)
        {
            int num;
            SqlParameter[] parameters = new SqlParameter[] { new SqlParameter("@RoleID", SqlDbType.Int, 4) };
            parameters[0].Value = roleId;
            DbHelperSQL.RunProcedure("sp_Accounts_ClearPermissionsFromRole", parameters, out num);
        }

        public int Create(string description)
        {
            int num;
            SqlParameter[] parameters = new SqlParameter[] { new SqlParameter("@Description", SqlDbType.VarChar, 50) };
            parameters[0].Value = description;
            return DbHelperSQL.RunProcedure("sp_Accounts_CreateRole", parameters, out num);
        }

        public bool Delete(int roleId)
        {
            int num;
            SqlParameter[] parameters = new SqlParameter[] { new SqlParameter("@RoleID", SqlDbType.Int, 4) };
            parameters[0].Value = roleId;
            DbHelperSQL.RunProcedure("sp_Accounts_DeleteRole", parameters, out num);
            return (num == 1);
        }

        public DataSet GetRoleList()
        {
            using (DataSet set = DbHelperSQL.RunProcedure("sp_Accounts_GetAllRoles", new IDataParameter[0], "Roles"))
            {
                return set;
            }
        }

        public void RemovePermission(int roleId, int permissionId)
        {
            int num;
            SqlParameter[] parameters = new SqlParameter[] { new SqlParameter("@RoleID", SqlDbType.Int, 4), new SqlParameter("@PermissionID", SqlDbType.Int, 4) };
            parameters[0].Value = roleId;
            parameters[1].Value = permissionId;
            DbHelperSQL.RunProcedure("sp_Accounts_RemovePermissionFromRole", parameters, out num);
        }

        public DataRow Retrieve(int roleId)
        {
            SqlParameter[] parameters = new SqlParameter[] { new SqlParameter("@RoleID", SqlDbType.Int, 4) };
            parameters[0].Value = roleId;
            using (DataSet set = DbHelperSQL.RunProcedure("sp_Accounts_GetRoleDetails", parameters, "Roles"))
            {
                return set.Tables[0].Rows[0];
            }
        }

        public bool Update(int roleId, string description)
        {
            int num;
            SqlParameter[] parameters = new SqlParameter[] { new SqlParameter("@RoleID", SqlDbType.Int, 4), new SqlParameter("@Description", SqlDbType.VarChar, 50) };
            parameters[0].Value = roleId;
            parameters[1].Value = description;
            DbHelperSQL.RunProcedure("sp_Accounts_UpdateRole", parameters, out num);
            return (num == 1);
        }
    }
}

