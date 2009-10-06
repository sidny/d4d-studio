namespace LTP.Accounts.Bus
{
    using LTP.Accounts.Data;
    using System;

    public class PermissionCategories
    {
        private PermissionCategory dalpc = new PermissionCategory();

        public int Create(string description)
        {
            return this.dalpc.Create(description);
        }

        public bool Delete(int pID)
        {
            return this.dalpc.Delete(pID);
        }
    }
}

