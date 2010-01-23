﻿<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="comment.ascx.cs" Inherits="D4D.Web.Control.comment" %>
<div class="commend_input">
    <div>发表评论：</div>
    <div class="spacer4"></div>
    <div class="commend_input_con">
	    <div class="floatleft" style="width:426px">
	      <textarea rows="5" style="width:424px;border:1px #B6BBB0 solid"></textarea>
	    </div>
        <div class="floatright" style="width:60px">
	    <div class="spacer" style="height:25px"></div>
	    <a href="#" class="btn_gray01 floatright"><span>发表</span></a>
	    </div>
    </div>
</div>
<script type="text/javascript">
$(document).ready(function() {
    $(".commend_input a span").click(function() {
        if ($("#btnLogin").length > 0) {
            $("#btnLogin").click();
            return false;
        } else {
            var str = $(".commend_input textarea").val();
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
                        location.reload();
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
            });
        }
    });
});
 </script>