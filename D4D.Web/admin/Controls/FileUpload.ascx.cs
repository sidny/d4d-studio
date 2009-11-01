using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;
using log4net;
using D4D.Platform.Domain;
using D4D.Platform.Helper;

namespace D4D.Web.admin.Controls
{
    public partial class FileUpload : System.Web.UI.UserControl
    {
        private static readonly ILog log = LogManager.GetLogger("d4d");

        private bool autoCreateThumbnailImage = true;
        /// <summary>
        /// 是否自动生成缩略图
        /// </summary>
        public bool AutoCreateThumbnailImage
        {
            get
            {
                return autoCreateThumbnailImage;
            }
            set
            {
                autoCreateThumbnailImage = value;
            }
        }

        private int maxWidth = 150;
        public int MaxWidth
        {
            get
            {
                return maxWidth;
            }
            set
            {
                maxWidth = value;
            }
        }

        private int maxHeight=100;
        public int MaxHeight
        {
            get
            {
                return maxHeight;
            }
            set
            {
                maxHeight = value;
            }
        }

        public string UploadResult
        {
            get
            {
                return txtUploadResult.Text;
            }
            set
            {
                txtUploadResult.Text = value;
                fileUpload.Visible = false;
                txtUploadResult.Visible = true;
                btnShowResult.Text = "通过选择上传";
            }
        }

        public string ThumbnailImage
        {
            get
            {
                return hiddenThumbnailImage.Text;
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

                        if (autoCreateThumbnailImage)
                        {
                             UploadInfo uThumbnailinfo = new UploadInfo(Guid.NewGuid());
                            uThumbnailinfo.FileExtension = info.Extension;
                            ImageHelper.MakeThumbnailImage(uinfo.FileServerPath, uThumbnailinfo.FileServerPath,
                                 maxWidth,maxHeight  );

                            hiddenThumbnailImage.Text = uThumbnailinfo.FileHttpPath;
                        }
                        //addWaterMark
                        if (cbAddWaterMark.Checked)
                        {

                            UploadInfo waterremarkInfo = new UploadInfo(Guid.NewGuid());
                            waterremarkInfo.FileExtension = info.Extension;

                            ImageHelper.AddImageSignPic(System.Drawing.Image.FromFile(uinfo.FileServerPath),
                                waterremarkInfo.FileServerPath, ImageHelper.GetWaterMarkFilePath(), 9, 100, 90);
                            txtUploadResult.Text = waterremarkInfo.FileHttpPath;

                        }
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
            hiddenThumbnailImage.Text = string.Empty;
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