<<<<<<< .mine
﻿<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="comment.ascx.cs" Inherits="D4D.Web.Control.comment" %>
<div class="comments-area">
    <div class="comments-control">
        <a href="#" id="btnComments">我也要说两句</a> <a href="<%=CommentUrl %>">评论（<%=CommentsCount%>）</a>
    </div>
    
   <div class="input-area clearfix" style="display:none">
        <textarea></textarea>
        <button>发表</button>
    </div>
</div>
<script type="text/javascript">
$(document).ready(function() {
    $("#btnComments").click(function() {
        if ($("#btnLogin").length > 0) {
            $("#btnLogin").click();
            return false;
        } else {
           $(".input-area").show();
           return false;
        }
    });
    $(".input-area button").click(function() {
        var str = $(".input-area textarea").val();
        if(str.length < 10) {
            alert("评论内容过短");
            return;
        }
        $.ajax({
            contentType: "application/json",
            url: "/svc/comments.svc/create",
            data: JSON2.stringify({ content: str, id: <%=ObjectId %>, type: <%=ObjectType %> }),
            type: "POST", processData: false,
            dataType:"json",
            success:function(response){
                if(response.d>0){
                    alert("发送成功");
                    $(".input-area textarea").val("");
                }else if(response.d==-1){
                    alert("请先登录");
                }else if(response.d==-2){
                    alert("该用户被禁言,请联系管理员");
                }else if(response.d==0){
                    alert("发送失败，请联系管理员");
                }else{
                    alert(JSON2.stringify(response));
                }
            }
        })
    });
});
 </script>=======
﻿<%@ Control Language="C#" AutoEventWireup="true" %>
<div class="comments-area">
    <div class="comments-control">
        <a href="#" id="btnComments">我也要说两句</a> <a href="<%=CommentUrl %>">评论（<%=CommentsCount%>）</a>
    </div>
    
   <div class="input-area clearfix" style="display:none">
        <textarea></textarea>
        <button>发表</button>
    </div>
</div>
<script type="text/javascript">
$(document).ready(function() {
    $("#btnComments").click(function() {
        if ($("#btnLogin").length > 0) {
            $("#btnLogin").click();
            return false;
        } else {
           $(".input-area").show();
           return false;
        }
    });
    $(".input-area button").click(function() {
        var str = $(".input-area textarea").val();
        if(str.length < 10) {
            alert("评论内容过短");
            return;
        }
        $.ajax({
            contentType: "application/json",
            url: "/svc/comments.svc/create",
            data: JSON2.stringify({ content: str, id: <%=ObjectId %>, type: <%=ObjectType %> }),
            type: "POST", processData: false,
            dataType:"json",
            success:function(response){
                if(response.d>0){
                    alert("发送成功");
                    $(".input-area textarea").val("");
                }else if(response.d==-1){
                    alert("请先登录");
                }else if(response.d==-2){
                    alert("该用户被禁言,请联系管理员");
                }else if(response.d==0){
                    alert("发送失败，请联系管理员");
                }else{
                    alert(JSON2.stringify(response));
                }
            }
        })
    });
});
 </script>
 <script runat="server">
     public int CommentsCount { get; set; }
     public string CommentUrl { get; set; }
     public int ObjectId { get; set; }
     public int ObjectType { get; set; } 

   

     protected void Page_Load(object sender, EventArgs e)
     {
     }

 

 </script>>>>>>>> .r275
