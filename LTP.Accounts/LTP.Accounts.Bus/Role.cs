namespace LTP.Accounts.Bus
{
    using LTP.Accounts.Data;
    using System;
    using System.Data;

    [Serializable]
    public class Role
    {
        private LTP.Accounts.Data.Role dataRole;
        private string description;
        private DataSet nopermissions;
        private DataSet permissions;
        private int roleId;
        private DataSet users;

        public Role()
        {
            this.dataRole = new LTP.Accounts.Data.Role();
        }

        public Role(int currentRoleId)
        {
            this.dataRole = new LTP.Accounts.Data.Role();
            DataRow row = this.dataRole.Retrieve(currentRoleId);
            this.roleId = currentRoleId;
            if (row["Description"] != null)
            {
                this.description = (string) row["Description"];
            }
            Permission permission = new Permission();
            this.permissions = permission.GetPermissionList(currentRoleId);
            this.nopermissions = permission.GetNoPermissionList(currentRoleId);
            this.users = new LTP.Accounts.Data.User().GetUsersByRole(currentRoleId);
        }

        public void AddPermission(int permissionId)
        {
            this.dataRole.AddPermission(this.roleId, permissionId);
        }

        public void ClearPermissions()
        {
            this.dataRole.ClearPermissions(this.roleId);
        }

        public int Create()
        {
            this.roleId = this.dataRole.Create(this.description);
            return this.roleId;
        }

        public bool Delete()
        {
            return this.dataRole.Delete(this.roleId);
        }

        public DataSet GetRoleList()
        {
            return this.dataRole.GetRoleList();
        }

        public void RemovePermission(int permissionId)
        {
            this.dataRole.RemovePermission(this.roleId, permissionId);
        }

        public bool Update()
        {
            return this.dataRole.Update(this.roleId, this.description);
        }

        public string Description
        {
            get
            {
                return this.description;
            }
            set
            {
                this.description = value;
            }
        }

        public DataSet NoPermissions
        {
            get
            {
                return this.nopermissions;
            }
        }

        public DataSet Permissions
        {
            get
            {
                return this.permissions;
            }
        }

        public int RoleID
        {
            get
            {
                return this.roleId;
            }
        }

        public DataSet Users
        {
            get
            {
                return this.users;
            }
        }
    }
}

