namespace LTP.Accounts.Data
{
    using LTP.Accounts;
    using System;
    using System.Collections;
    using System.Data;
    using System.Data.SqlClient;
    using System.Text;

    [Serializable]
    public class User
    {
        public void AddAssignRole(int UserID, int RoleID)
        {
            StringBuilder builder = new StringBuilder();
            builder.Append("insert into Accounts_UserAssignmentRoles(");
            builder.Append("UserID,RoleID)");
            builder.Append(" values (");
            builder.Append("@UserID,@RoleID)");
            SqlParameter[] cmdParms = new SqlParameter[] { new SqlParameter("@UserID", SqlDbType.Int, 4), new SqlParameter("@RoleID", SqlDbType.Int, 4) };
            cmdParms[0].Value = UserID;
            cmdParms[1].Value = RoleID;
            DbHelperSQL.ExecuteSql(builder.ToString(), cmdParms);
        }

        public bool AddRole(int userId, int roleId)
        {
            int num;
            SqlParameter[] parameters = new SqlParameter[] { new SqlParameter("@UserID", SqlDbType.Int, 4), new SqlParameter("@RoleID", SqlDbType.Int, 4) };
            parameters[0].Value = userId;
            parameters[1].Value = roleId;
            DbHelperSQL.RunProcedure("sp_Accounts_AddUserToRole", parameters, out num);
            return (num == 1);
        }

        public bool AssignRoleExists(int UserID, int RoleID)
        {
            StringBuilder builder = new StringBuilder();
            builder.Append("select count(1) from Accounts_UserAssignmentRoles");
            builder.Append(" where UserID= @UserID and RoleID=@RoleID ");
            SqlParameter[] cmdParms = new SqlParameter[] { new SqlParameter("@UserID", SqlDbType.Int, 4), new SqlParameter("@RoleID", SqlDbType.Int, 4) };
            cmdParms[0].Value = UserID;
            cmdParms[1].Value = RoleID;
            return DbHelperSQL.Exists(builder.ToString(), cmdParms);
        }

        public int Create(string userName, byte[] password, string trueName, string sex, string phone, string email, int employeeID, string departmentID, bool activity, string userType, int style)
        {
            SqlParameter[] parameters = new SqlParameter[] { new SqlParameter("@UserName", SqlDbType.VarChar, 50), new SqlParameter("@Password", SqlDbType.Binary, 20), new SqlParameter("@TrueName", SqlDbType.VarChar, 50), new SqlParameter("@Sex", SqlDbType.Char, 1), new SqlParameter("@Phone", SqlDbType.VarChar, 20), new SqlParameter("@Email", SqlDbType.VarChar, 100), new SqlParameter("@EmployeeID", SqlDbType.Int, 4), new SqlParameter("@DepartmentID", SqlDbType.VarChar, 15), new SqlParameter("@Activity", SqlDbType.Bit, 1), new SqlParameter("@UserType", SqlDbType.Char, 2), new SqlParameter("@UserID", SqlDbType.Int, 4), new SqlParameter("@Style", SqlDbType.Int, 4) };
            parameters[0].Value = userName;
            parameters[1].Value = password;
            parameters[2].Value = trueName;
            parameters[3].Value = sex;
            parameters[4].Value = phone;
            parameters[5].Value = email;
            parameters[6].Value = employeeID;
            parameters[7].Value = departmentID;
            parameters[8].Value = activity ? 1 : 0;
            parameters[9].Value = userType;
            parameters[10].Direction = ParameterDirection.Output;
            parameters[11].Value = style;
            try
            {
                int num;
                DbHelperSQL.RunProcedure("sp_Accounts_CreateUser", parameters, out num);
            }
            catch (SqlException exception)
            {
                if (exception.Number == 0xa29)
                {
                    return -100;
                }
            }
            return (int) parameters[10].Value;
        }

        public bool Delete(int userID)
        {
            int num;
            SqlParameter[] parameters = new SqlParameter[] { new SqlParameter("@UserID", SqlDbType.Int, 4) };
            parameters[0].Value = userID;
            DbHelperSQL.RunProcedure("sp_Accounts_DeleteUser", parameters, out num);
            return (num == 1);
        }

        public void DeleteAssignRole(int UserID, int RoleID)
        {
            StringBuilder builder = new StringBuilder();
            builder.Append("delete Accounts_UserAssignmentRoles ");
            builder.Append(" where UserID= @UserID and RoleID=@RoleID ");
            SqlParameter[] cmdParms = new SqlParameter[] { new SqlParameter("@UserID", SqlDbType.Int, 4), new SqlParameter("@RoleID", SqlDbType.Int, 4) };
            cmdParms[0].Value = UserID;
            cmdParms[1].Value = RoleID;
            DbHelperSQL.ExecuteSql(builder.ToString(), cmdParms);
        }

        public DataSet GetAssignRolesByUser(int UserID)
        {
            StringBuilder builder = new StringBuilder();
            builder.Append("select * from Accounts_Roles where RoleID in ");
            builder.Append("(select RoleID from Accounts_UserAssignmentRoles ");
            builder.Append(" where UserID= @UserID) ");
            builder.Append(" ORDER BY Description ASC ");
            SqlParameter[] cmdParms = new SqlParameter[] { new SqlParameter("@UserID", SqlDbType.Int, 4) };
            cmdParms[0].Value = UserID;
            return DbHelperSQL.Query(builder.ToString(), cmdParms);
        }

        public ArrayList GetEffectivePermissionList(int userID)
        {
            ArrayList list = new ArrayList();
            SqlParameter[] parameters = new SqlParameter[] { new SqlParameter("@UserID", SqlDbType.Int, 4) };
            parameters[0].Value = userID;
            SqlDataReader reader = DbHelperSQL.RunProcedure("sp_Accounts_GetEffectivePermissionList", parameters);
            while (reader.Read())
            {
                list.Add(reader.GetString(0));
            }
            reader.Close();
            return list;
        }

        public ArrayList GetEffectivePermissionListID(int userID)
        {
            ArrayList list = new ArrayList();
            SqlParameter[] parameters = new SqlParameter[] { new SqlParameter("@UserID", SqlDbType.Int, 4) };
            parameters[0].Value = userID;
            SqlDataReader reader = DbHelperSQL.RunProcedure("sp_Accounts_GetEffectivePermissionListID", parameters);
            while (reader.Read())
            {
                list.Add(reader.GetInt32(0));
            }
            reader.Close();
            return list;
        }

        public DataSet GetNoAssignRolesByUser(int UserID)
        {
            StringBuilder builder = new StringBuilder();
            builder.Append("select * from Accounts_Roles where RoleID not in ");
            builder.Append("(select RoleID from Accounts_UserAssignmentRoles ");
            builder.Append(" where UserID= @UserID) ");
            builder.Append(" ORDER BY Description ASC ");
            SqlParameter[] cmdParms = new SqlParameter[] { new SqlParameter("@UserID", SqlDbType.Int, 4) };
            cmdParms[0].Value = UserID;
            return DbHelperSQL.Query(builder.ToString(), cmdParms);
        }

        public DataSet GetUserList(string key)
        {
            SqlParameter[] parameters = new SqlParameter[] { new SqlParameter("@key", SqlDbType.VarChar, 50) };
            parameters[0].Value = key;
            return DbHelperSQL.RunProcedure("sp_Accounts_GetUsers", parameters, "Users");
        }

        public DataSet GetUserList(string UserType, string DepartmentID, string Key)
        {
            StringBuilder builder = new StringBuilder();
            builder.Append("select * from Accounts_Users ");
            builder.Append("where (1=1)");
            builder.Append(" and UserID in ( @UserType )");
            builder.Append(" and DepartmentID= @DepartmentID ");
            builder.Append(" and (UserName like '%'+@Key+'%' or TrueName like '%'+@Key+'%')  ");
            builder.Append(" order by UserName ");
            SqlParameter[] cmdParms = new SqlParameter[] { new SqlParameter("@UserType", SqlDbType.Char, 2), new SqlParameter("@DepartmentID", SqlDbType.VarChar, 30), new SqlParameter("@Key", SqlDbType.VarChar, 50) };
            cmdParms[0].Value = UserType;
            cmdParms[1].Value = DepartmentID;
            cmdParms[2].Value = Key;
            return DbHelperSQL.Query(builder.ToString(), cmdParms);
        }

        public ArrayList GetUserRoles(int userID)
        {
            ArrayList list = new ArrayList();
            SqlParameter[] parameters = new SqlParameter[] { new SqlParameter("@UserID", SqlDbType.Int, 4) };
            parameters[0].Value = userID;
            SqlDataReader reader = DbHelperSQL.RunProcedure("sp_Accounts_GetUserRoles", parameters);
            while (reader.Read())
            {
                list.Add(reader.GetString(1));
            }
            reader.Close();
            return list;
        }

        public DataSet GetUsersByDepart(string DepartmentID, string Key)
        {
            SqlParameter[] parameters = new SqlParameter[] { new SqlParameter("@DepartmentID", SqlDbType.VarChar, 30), new SqlParameter("@key", SqlDbType.VarChar, 50) };
            parameters[0].Value = DepartmentID;
            parameters[1].Value = Key;
            return DbHelperSQL.RunProcedure("sp_Accounts_GetUsersByDepart", parameters, "Users");
        }

        public DataSet GetUsersByRole(int RoleID)
        {
            StringBuilder builder = new StringBuilder();
            builder.Append("select * from Accounts_Users where UserID in ");
            builder.Append("(select UserID from Accounts_UserRoles ");
            builder.Append(" where RoleID= @RoleID) ");
            SqlParameter[] cmdParms = new SqlParameter[] { new SqlParameter("@RoleID", SqlDbType.Int, 4) };
            cmdParms[0].Value = RoleID;
            return DbHelperSQL.Query(builder.ToString(), cmdParms);
        }

        public DataSet GetUsersByType(string UserType, string Key)
        {
            SqlParameter[] parameters = new SqlParameter[] { new SqlParameter("@UserType", SqlDbType.Char, 2), new SqlParameter("@key", SqlDbType.VarChar, 50) };
            parameters[0].Value = UserType;
            parameters[1].Value = Key;
            return DbHelperSQL.RunProcedure("sp_Accounts_GetUsersByType", parameters, "Users");
        }

        public bool HasUser(string userName)
        {
            SqlParameter[] parameters = new SqlParameter[] { new SqlParameter("@UserName", SqlDbType.VarChar, 50) };
            parameters[0].Value = userName;
            using (DataSet set = DbHelperSQL.RunProcedure("sp_Accounts_GetUserDetailsByUserName", parameters, "Users"))
            {
                if (set.Tables[0].Rows.Count == 0)
                {
                    return false;
                }
                return true;
            }
        }

        public bool RemoveRole(int userId, int roleId)
        {
            int num;
            SqlParameter[] parameters = new SqlParameter[] { new SqlParameter("@UserID", SqlDbType.Int, 4), new SqlParameter("@RoleID", SqlDbType.Int, 4) };
            parameters[0].Value = userId;
            parameters[1].Value = roleId;
            DbHelperSQL.RunProcedure("sp_Accounts_RemoveUserFromRole", parameters, out num);
            return (num == 1);
        }

        public DataRow Retrieve(int userID)
        {
            SqlParameter[] parameters = new SqlParameter[] { new SqlParameter("@UserID", SqlDbType.Int, 4) };
            parameters[0].Value = userID;
            using (DataSet set = DbHelperSQL.RunProcedure("sp_Accounts_GetUserDetails", parameters, "Users"))
            {
                if (set.Tables[0].Rows.Count > 0)
                {
                    return set.Tables[0].Rows[0];
                }
                return null;
            }
        }

        public DataRow Retrieve(string userName)
        {
            SqlParameter[] parameters = new SqlParameter[] { new SqlParameter("@UserName", SqlDbType.VarChar, 50) };
            parameters[0].Value = userName;
            using (DataSet set = DbHelperSQL.RunProcedure("sp_Accounts_GetUserDetailsByUserName", parameters, "Users"))
            {
                if (set.Tables[0].Rows.Count == 0)
                {
                    throw new Exception("无此用户或用户已过期：" + userName);
                }
                return set.Tables[0].Rows[0];
            }
        }

        public bool SetPassword(string UserName, byte[] encPassword)
        {
            int num;
            SqlParameter[] parameters = new SqlParameter[] { new SqlParameter("@UserName", SqlDbType.VarChar), new SqlParameter("@EncryptedPassword", SqlDbType.Binary, 20) };
            parameters[0].Value = UserName;
            parameters[1].Value = encPassword;
            DbHelperSQL.RunProcedure("sp_Accounts_SetPassword", parameters, out num);
            return (num == 1);
        }

        public int TestPassword(int userID, byte[] encPassword)
        {
            int num;
            SqlParameter[] parameters = new SqlParameter[] { new SqlParameter("@UserID", SqlDbType.Int, 4), new SqlParameter("@EncryptedPassword", SqlDbType.Binary, 20) };
            parameters[0].Value = userID;
            parameters[1].Value = encPassword;
            return DbHelperSQL.RunProcedure("sp_Accounts_TestPassword", parameters, out num);
        }

        public bool Update(int userID, string userName, byte[] password, string trueName, string sex, string phone, string email, int employeeID, string departmentID, bool activity, string userType, int style)
        {
            int num;
            SqlParameter[] parameters = new SqlParameter[] { new SqlParameter("@UserName", SqlDbType.VarChar, 50), new SqlParameter("@Password", SqlDbType.Binary, 20), new SqlParameter("@TrueName", SqlDbType.VarChar, 50), new SqlParameter("@Sex", SqlDbType.Char, 2), new SqlParameter("@Phone", SqlDbType.VarChar, 20), new SqlParameter("@Email", SqlDbType.VarChar, 100), new SqlParameter("@EmployeeID", SqlDbType.Int, 4), new SqlParameter("@DepartmentID", SqlDbType.VarChar, 15), new SqlParameter("@Activity", SqlDbType.Bit, 1), new SqlParameter("@UserType", SqlDbType.Char, 2), new SqlParameter("@UserID", SqlDbType.BigInt, 8), new SqlParameter("@Style", SqlDbType.BigInt, 8) };
            parameters[0].Value = userName;
            parameters[1].Value = password;
            parameters[2].Value = trueName;
            parameters[3].Value = sex;
            parameters[4].Value = phone;
            parameters[5].Value = email;
            parameters[6].Value = employeeID;
            parameters[7].Value = departmentID;
            parameters[8].Value = activity;
            parameters[9].Value = userType;
            parameters[10].Value = userID;
            parameters[11].Value = style;
            DbHelperSQL.RunProcedure("sp_Accounts_UpdateUser", parameters, out num);
            return (num == 1);
        }

        public int ValidateLogin(string userName, byte[] encPassword)
        {
            int num;
            SqlParameter[] parameters = new SqlParameter[] { new SqlParameter("@UserName", SqlDbType.VarChar, 50), new SqlParameter("@EncryptedPassword", SqlDbType.Binary, 20) };
            parameters[0].Value = userName;
            parameters[1].Value = encPassword;
            return DbHelperSQL.RunProcedure("sp_Accounts_ValidateLogin", parameters, out num);
        }
    }
}

