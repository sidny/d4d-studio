using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using D4D.Platform;
using D4D.Platform.Domain;
namespace D4D.Web.Test
{
    public partial class TagsTestPage : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            
        }
        private void ShowInfo(string msg)
        {
            labInfo.Text = msg +"<br/>" + labInfo.Text;
        }
        protected void btnSetTag_Click(object sender, EventArgs e)
        {
            int tagid = 0;
            if (int.TryParse(txtTagId.Text, out tagid))
            {

                Tag tag = new Tag(tagid);
                tag.TagName = txtTagName.Text;

                int result =D4DGateway.TagsProvider.SetTag(tag);
                txtTagId.Text = result.ToString();

                ShowInfo("SetTag Result = " + result.ToString());
            }


        }

        protected void btnDeleteTag_Click(object sender, EventArgs e)
        {
             int tagid = 0;
             if (int.TryParse(txtTagId.Text, out tagid))
            {
                D4DGateway.TagsProvider.DeleteTag(tagid);
                ShowInfo("Delete TagID = " + txtTagId.Text);
            }
        }

        protected void btnAddTagHits_Click(object sender, EventArgs e)
        {
            int tagid = 0;
            if (int.TryParse(txtTagId.Text, out tagid))
            {
                D4DGateway.TagsProvider.AddTagHit(tagid);
                ShowInfo("AddTagHit TagID = " + txtTagId.Text);
            }
        }

        protected void btnGetOneTag_Click(object sender, EventArgs e)
        {
            int tagid = 0;
            if (int.TryParse(txtTagId.Text, out tagid))
            {
                Tag tag = 
                D4DGateway.TagsProvider.GetTag(tagid);
                ShowInfo(string.Format("GetTage[Name={0},Hits={1},AddUserId={2},AddDate={3}]",
                    tag.TagName,tag.Hits,tag.AddUserID,tag.AddDate.ToLongDateString()));
            }
        }

        protected void btnGetTopTag_Click(object sender, EventArgs e)
        {
            List<Tag> tagList = D4DGateway.TagsProvider.GetTopTags(10);
            ShowInfo("GetTagList!");
            foreach (Tag tag in tagList)
            {
                ShowInfo(string.Format("GetTage[Name={0},Hits={1},AddUserId={2},AddDate={3}]",
                 tag.TagName, tag.Hits, tag.AddUserID, tag.AddDate.ToLongDateString()));
            }
        }

        protected void btnGetPagedTags_Click(object sender, EventArgs e)
        {
            PagingContext pager = new PagingContext();
            pager.RecordsPerPage = 5;
            pager.CurrentPageNumber = 1;
            List<Tag> tagList = D4DGateway.TagsProvider.GetPagedTags(pager);
            ShowInfo("GetPageTagsList! TotalRecord:"+pager.TotalRecordCount.ToString());
            foreach (Tag tag in tagList)
            {
                ShowInfo(string.Format("GetTage[Name={0},Hits={1},AddUserId={2},AddDate={3}]",
                 tag.TagName, tag.Hits, tag.AddUserID, tag.AddDate.ToLongDateString()));
            }
            
        }
    }
}
