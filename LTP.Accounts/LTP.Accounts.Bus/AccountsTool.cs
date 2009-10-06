namespace LTP.Accounts.Bus
{
    using LTP.Accounts.Data;
    using System;
    using System.Data;

    public class AccountsTool
    {
        public static DataSet GetAllCategories()
        {
            PermissionCategory category = new PermissionCategory();
            return category.GetCategoryList();
        }

        public static DataSet GetAllPermissions()
        {
            Permission permission = new Permission();
            return permission.GetPermissionList();
        }

        public static DataSet GetPermissionsByCategory(int categoryID)
        {
            PermissionCategory category = new PermissionCategory();
            return category.GetPermissionsInCategory(categoryID);
        }

        public static DataSet GetRoleList()
        {
            LTP.Accounts.Data.Role role = new LTP.Accounts.Data.Role();
            return role.GetRoleList();
        }
    }
}

