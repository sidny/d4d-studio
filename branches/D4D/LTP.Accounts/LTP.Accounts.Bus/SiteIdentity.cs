namespace LTP.Accounts.Bus
{
    using LTP.Accounts.Data;
    using System;
    using System.Data;
    using System.Security.Cryptography;
    using System.Security.Principal;
    using System.Text;

    [Serializable]
    public class SiteIdentity : IIdentity
    {
        private LTP.Accounts.Data.User dataUser;
        private string email;
        private byte[] password;
        private string sex;
        private string trueName;
        private int userID;
        private string userName;

        public SiteIdentity(int currentUserID)
        {
            this.dataUser = new LTP.Accounts.Data.User();
            DataRow row = this.dataUser.Retrieve(currentUserID);
            if (row != null)
            {
                this.userName = (string) row["UserName"];
                this.trueName = (string) row["TrueName"];
                this.email = (string) row["Email"];
                this.userID = currentUserID;
                this.password = (byte[]) row["Password"];
                this.sex = (string) row["Sex"];
            }
        }

        public SiteIdentity(string currentUserName)
        {
            this.dataUser = new LTP.Accounts.Data.User();
            DataRow row = this.dataUser.Retrieve(currentUserName);
            if (row != null)
            {
                this.userName = currentUserName;
                this.trueName = (string) row["TrueName"];
                this.email = (string) row["Email"];
                this.userID = (int) row["UserID"];
                this.password = (byte[]) row["Password"];
                this.sex = (string) row["Sex"];
            }
        }

        public int TestPassword(string password)
        {
            byte[] bytes = new UnicodeEncoding().GetBytes(password);
            byte[] encPassword = new SHA1CryptoServiceProvider().ComputeHash(bytes);
            return this.dataUser.TestPassword(this.userID, encPassword);
        }

        public string AuthenticationType
        {
            get
            {
                return "Custom Authentication";
            }
            set
            {
            }
        }

        public string Email
        {
            get
            {
                return this.email;
            }
        }

        public bool IsAuthenticated
        {
            get
            {
                return true;
            }
        }

        public string Name
        {
            get
            {
                return this.userName;
            }
        }

        public byte[] Password
        {
            get
            {
                return this.password;
            }
        }

        public string Sex
        {
            get
            {
                return this.sex;
            }
        }

        public string TrueName
        {
            get
            {
                return this.trueName;
            }
        }

        public int UserID
        {
            get
            {
                return this.userID;
            }
        }

        public string UserName
        {
            get
            {
                return this.userName;
            }
        }
    }
}

