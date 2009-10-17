namespace LTP.Accounts.Bus
{
    using LTP.Accounts.Data;
    using System;
    using System.Data;
    using D4D.Platform;
    using D4D.Platform.Domain;

    [Serializable]
    public class User
    {
        private bool activity;
        private LTP.Accounts.Data.User dataUser;
        private string departmentID;
        private string email;
        private int employeeID;
        private byte[] password;
        private string phone;
        private string sex;
        private int style;
        private string trueName;
        private int userID;
        private string userName;
        private string userType;

        private string nonEncryptPasswordPassword;
        public string NonEncryptPasswordPassword
        {
            get
            {
                return nonEncryptPasswordPassword;
            }
            set
            {
                nonEncryptPasswordPassword = value;
                password = AccountsPrincipal.EncryptPassword(nonEncryptPasswordPassword);
            }
        }

        public User()
        {
            this.dataUser = new LTP.Accounts.Data.User();
            this.departmentID = "-1";
        }

        public User(AccountsPrincipal existingPrincipal)
        {
            this.dataUser = new LTP.Accounts.Data.User();
            this.departmentID = "-1";
            this.userID = ((SiteIdentity) existingPrincipal.Identity).UserID;
            this.LoadFromID();
        }

        public User(int existingUserID)
        {
            this.dataUser = new LTP.Accounts.Data.User();
            this.departmentID = "-1";
            this.userID = existingUserID;
            this.LoadFromID();
        }

        public User(string UserName)
        {
            this.dataUser = new LTP.Accounts.Data.User();
            this.departmentID = "-1";
            DataRow row = this.dataUser.Retrieve(UserName);
            if (row != null)
            {
                this.userID = (int) row["UserID"];
                this.trueName = (string) row["TrueName"];
                this.sex = (string) row["Sex"];
                this.phone = (string) row["Phone"];
                this.email = (string) row["Email"];
                this.employeeID = (int) row["EmployeeID"];
                this.departmentID = (string) row["DepartmentID"];
                this.activity = (bool) row["Activity"];
                this.userType = (string) row["UserType"];
                this.password = (byte[]) row["Password"];
                this.style = (int) row["Style"];
            }
        }

        public void AddAssignRole(int UserID, int RoleID)
        {
            if (!this.AssignRoleExists(UserID, RoleID))
            {
                this.dataUser.AddAssignRole(UserID, RoleID);
            }
        }

        public bool AddToRole(int roleId)
        {
            return this.dataUser.AddRole(this.userID, roleId);
        }

        public bool AssignRoleExists(int UserID, int RoleID)
        {
            return this.dataUser.AssignRoleExists(UserID, RoleID);
        }

        public int Create()
        {
            this.userID = this.dataUser.Create(this.userName, this.password, this.trueName, this.sex, this.phone, this.email, this.employeeID, this.departmentID, this.activity, this.userType, this.style);
            //add nonsavenonEncryptPasswordPassword;
            if (userID > 0)
            {
                UserLogin u = new UserLogin();
                u.UserId = userID;
                u.UserName = this.userName;
                u.Password = this.nonEncryptPasswordPassword;
                u.Email = this.email;
                D4DGateway.UserProvider.SetUserLogin(u);
            }
            return this.userID;
        }

        public bool Delete()
        {
            bool result = this.dataUser.Delete(this.userID);
            if (result)
                D4DGateway.UserProvider.DeleteUserLogin(this.userID);

            return result;
        }

        public void DeleteAssignRole(int UserID, int RoleID)
        {
            this.dataUser.DeleteAssignRole(UserID, RoleID);
        }

        public DataSet GetAssignRolesByUser(int UserID)
        {
            return this.dataUser.GetAssignRolesByUser(UserID);
        }

        public DataSet GetNoAssignRolesByUser(int UserID)
        {
            return this.dataUser.GetNoAssignRolesByUser(UserID);
        }

        public DataSet GetUserList(string key)
        {
            return this.dataUser.GetUserList(key);
        }

        public DataSet GetUserList(string UserType, string DepartmentID, string Key)
        {
            return this.dataUser.GetUserList(UserType, DepartmentID, Key);
        }

        public DataSet GetUsersByDepart(string DepartmentID, string Key)
        {
            return this.dataUser.GetUsersByDepart(DepartmentID, Key);
        }

        public DataSet GetUsersByRole(int RoleID)
        {
            return this.dataUser.GetUsersByRole(RoleID);
        }

        public DataSet GetUsersByType(string usertype, string key)
        {
            return this.dataUser.GetUsersByType(usertype, key);
        }
        public DataSet GetUserList(UserType.Type type)
        {
            return GetUsersByType(((int)type).ToString(), string.Empty);
        }

        public bool HasUser(string userName)
        {
            return this.dataUser.HasUser(userName);
        }

        private void LoadFromID()
        {
            DataRow row = this.dataUser.Retrieve(this.userID);
            if (row != null)
            {
                this.userName = (string) row["UserName"];
                this.trueName = (string) row["TrueName"];
                this.sex = (string) row["Sex"];
                this.phone = (string) row["Phone"];
                this.email = (string) row["Email"];
                this.employeeID = (int) row["EmployeeID"];
                this.departmentID = (string) row["DepartmentID"];
                this.activity = (bool) row["Activity"];
                this.userType = (string) row["UserType"];
                this.password = (byte[]) row["Password"];
                this.style = (int) row["Style"];
            }
        }

        public bool RemoveRole(int roleId)
        {
            return this.dataUser.RemoveRole(this.userID, roleId);
        }

        public bool SetPassword(string UserName, string password)
        {
            
            byte[] encPassword = AccountsPrincipal.EncryptPassword(password);
            bool result =  this.dataUser.SetPassword(UserName, encPassword);

            if (result)
            {
                User nu = new User(UserName);

                UserLogin u = new UserLogin();
                u.UserId = nu.UserID;
                u.UserName = nu.UserName;
                u.Password = nu.NonEncryptPasswordPassword;
                u.Email = nu.Email;
                D4DGateway.UserProvider.SetUserLogin(u);
            }

            return result;
        }

        public bool Update()
        {
            bool result = this.dataUser.Update(this.userID, this.userName, this.password, this.trueName, this.sex, this.phone, this.email, this.employeeID, this.departmentID, this.activity, this.userType, this.style);

            //add nonsavenonEncryptPasswordPassword;
            if (result)
            {
                UserLogin u = new UserLogin();
                u.UserId = userID;
                u.UserName = this.userName;
                u.Password = this.nonEncryptPasswordPassword;
                u.Email = this.email;
                D4DGateway.UserProvider.SetUserLogin(u);
            }
            return result;
        }

        public bool Activity
        {
            get
            {
                return this.activity;
            }
            set
            {
                this.activity = value;
            }
        }

        public string DepartmentID
        {
            get
            {
                return this.departmentID;
            }
            set
            {
                this.departmentID = value;
            }
        }

        public string Email
        {
            get
            {
                return this.email;
            }
            set
            {
                this.email = value;
            }
        }

        public int EmployeeID
        {
            get
            {
                return this.employeeID;
            }
            set
            {
                this.employeeID = value;
            }
        }

        public byte[] Password
        {
            get
            {
                return this.password;
            }
            //set
            //{
            //    this.password = value;
            //}
        }

        public string Phone
        {
            get
            {
                return this.phone;
            }
            set
            {
                this.phone = value;
            }
        }

        public string Sex
        {
            get
            {
                return this.sex;
            }
            set
            {
                this.sex = value;
            }
        }

        public int Style
        {
            get
            {
                return this.style;
            }
            set
            {
                this.style = value;
            }
        }

        public string TrueName
        {
            get
            {
                return this.trueName;
            }
            set
            {
                this.trueName = value;
            }
        }

        public int UserID
        {
            get
            {
                return this.userID;
            }
            set
            {
                this.userID = value;
            }
        }

        public string UserName
        {
            get
            {
                return this.userName;
            }
            set
            {
                this.userName = value;
            }
        }

        public string UserType
        {
            get
            {
                return this.userType;
            }
            set
            {
                this.userType = value;
            }
        }

       
    }
}

