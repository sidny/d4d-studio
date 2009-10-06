namespace LTP.Accounts.Bus
{
    using LTP.Accounts.Data;
    using System;

    [Serializable]
    public class Permissions
    {
        private Permission dalPermission = new Permission();
        /*
        public int Create(int pcID, string description)
        {
            return this.dalPermission.Create(pcID, description,string.Empty);
        }
         */
        public int Create(int pcID, string description, string url)
        {
            return this.dalPermission.Create(pcID, description, url);
        }
        public bool Delete(int pID)
        {
            return this.dalPermission.Delete(pID);
        }

        public string GetPermissionName(int pID)
        {
            return this.dalPermission.Retrieve(pID)["Description"].ToString();
        }

        public bool Update(int pcID, string description)
        {
            return this.dalPermission.Update(pcID, description);
        }
    }
}

