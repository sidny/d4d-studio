using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;
using log4net;
using D4D.Platform.Domain;

namespace D4D.Web.admin.Controls
{
    public partial class FileUpload : System.Web.UI.UserControl
    {
        private static readonly ILog log = LogManager.GetLogger("d4d");

        public string UploadResult
        {
            get
            {
                return txtUploadResult.Text;
            }
        }
       
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnUpload_Click(object sender, EventArgs e)
        {
            if (fileUpload.HasFile && !string.IsNullOrEmpty(fileUpload.FileName))
            {
                FileInfo info = new FileInfo(fileUpload.FileName);
                try
                {
                    if (info != null)
                    {
                        UploadInfo uinfo = new UploadInfo(Guid.NewGuid());
                        uinfo.FileExtension = info.Extension;
                        fileUpload.SaveAs(uinfo.FileServerPath);
                        fileUpload.Visible = false;
                        txtUploadResult.Visible = true;
                        txtUploadResult.Text = uinfo.FileHttpPath;
                    }
                }
                catch (Exception ex)
                {
                    log.Error("GetFileInfo Error", ex);
                    ShowInfo("上传文件信息错误");
                }
            }
            else
                ShowInfo("请选择上传的文件");
        }

        protected void btnShowResult_Click(object sender, EventArgs e)
        {
            txtUploadResult.Text = string.Empty;
            if (fileUpload.Visible)
            {
                fileUpload.Visible = false;
                txtUploadResult.Visible = true;              
                btnShowResult.Text = "通过选择上传";
            }
            else
            {
                fileUpload.Visible = true;
                txtUploadResult.Visible = false;
                btnShowResult.Text = "直接输入地址";
            }
        }

        private void ShowInfo(string msg)
        {
            labInfo.Text = msg;
        }
    }
}