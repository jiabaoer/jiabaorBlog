<%--
  Created by IntelliJ IDEA.
  User: jiabaoer
  Date: 2019/9/8
  Time: 11:36
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=0">
    <title>黄文贵个人博客-留言</title>
    <meta name="keywords" content="黄文贵个人博客,个人博客,个人网站,个人主页,IT博客,技术博客">
    <meta name="description"
          content="此个人博客是致力于IT技术的学习交流型个人技术博客网站，包括网站开发、服务器运维、WEB设计等领域，创建该个人博客也是为了方便与志同道合的朋友一起学习交流，分享经验，感谢大家的支持。">
    <link rel="icon" type="image/x-icon, image/vnd.microsoft.icon"
          href="${pageContext.request.contextPath}/img/icon.ico">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/layui/css/layui.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/main.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/liuyan.css"/>
    <script src="${pageContext.request.contextPath}/js/jquery-2.1.0.min.js" type="text/javascript"
            charset="utf-8"></script>
    <script src="${pageContext.request.contextPath}/js/comm.js" type="text/javascript" charset="utf-8"></script>
    <script src="${pageContext.request.contextPath}/layui/layui.js" type="text/javascript" charset="utf-8"></script>
</head>
<style>
    .layui-container .layui-row {
        margin-bottom: 10px;
        box-shadow: 0 2px 6px 0 rgba(0, 0, 0, .17);
    }
</style>
<body>
<%@include file="pageHead.jsp" %>
<div class="layui-container">
    <div class="layui-row" style="background-color: white;">
        <div class="layui-col-md12 news_pl">
            <h2><i class="layui-icon layui-icon-dialogue"></i>留言</h2>
            <div class="comment-short" id="J_Short">
                <div class="box" id="J_Post">
                    <div class="box-content box-login">
                        <form action="" class="layui-form"
                              method="post">
                            <div class="layui-form-item">
                                <div class="box-textarea-block">
                                    <input type="text" class="chackUser" lay-verType="tips"
                                           value="<shiro:principal/>"
                                           lay-verify="chackUser" style="width: 0px;height: 0px;opacity: 0;">
                                    <textarea class="box-textarea J_Textarea" lay-verType="tips" name="leaveText"
                                              lay-verify="leaveText"
                                              placeholder="说两句吧..."></textarea>
                                </div>
                                <div class="box-info">
                                    <button class="box-commentBtn box-commentBtn--able" lay-submit=""
                                            lay-filter="LAY-user-leave-submit">发布评论
                                    </button>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
                <div id="J_ShortComment">
                </div>
                <div id="demo0" style="text-align: center;"></div>
            </div>
        </div>
    </div>
</div>
<%@include file="pageBottom.jsp" %>
<script>
    layui.use(['laypage', 'form', 'layer', 'jquery'], function () {
        var laypage = layui.laypage, layer = layui.layer, $ = layui.jquery, form = layui.form;
        form.verify({
            chackUser: function (value) {
                if (value == "" || value == "") {
                    return "请先登录！";
                }
            },
            leaveText: function (value) {
                if (value == "" || value == null) {
                    return "留言不能为空！";
                }
            }
        });
        form.on('submit(LAY-user-leave-submit)', function (data) {
            //监听提交
            $.ajax({
                url: '${pageContext.request.contextPath}/user/insertLeave',
                async: false, //改为同步请求
                dateType: 'json',
                data: data.field,
                type: "post",
                success: function (result) {
                    if (result == "留言失败！") {
                        layer.msg(result, {
                            icon: 5,
                            time: 1000
                        }, function () {
                            location.reload();
                        });
                    } else {
                        layer.msg(result, {
                            icon: 1,
                            time: 1000
                        }, function () {
                            location.reload();
                        });
                    }
                }
            });
        });
        var data = eval(${leaves});
        if (data.length > 10) {
            //调用分页
            laypage.render({
                elem: 'demo0',
                count: data.length,
                theme: '#1E9FFF',
                layout: ['count', 'prev', 'page', 'next', 'limit', 'refresh', 'skip'],
                jump: function (obj) {
                    //模拟渲染
                    document.getElementById('J_ShortComment').innerHTML = function () {
                        var arr = [],
                            thisData = data.concat().splice(obj.curr * obj.limit - obj.limit, obj.limit);
                        layui.each(thisData, function (index, item) {
                            arr.push('<div class="comment"><div class="common-avatar J_User"><img src="${pageContext.request.contextPath}' + item.user.headPictrue + '" width="100%" height="100%" /> </div> <div class="comment-block"> <p class="comment-user"><span class="comment-username J_User"> ' + item.user.nickname + ' </span><span class="comment-time">' + item.leaveTime + '</span> </p> <div class="comment-content J_CommentContent">' + item.leaveText + ' </div> </div> </div>');
                        });
                        return arr.join('');
                    }();
                }
            });
        } else if (data.length > 0) {
            $(data).each(function (index, item) {
                $("#J_ShortComment").append('<div class="comment"><div class="common-avatar J_User"><img src="${pageContext.request.contextPath}' + item.user.headPictrue + '" width="100%" height="100%" /> </div> <div class="comment-block"> <p class="comment-user"><span class="comment-username J_User"> ' + item.user.nickname + ' </span><span class="comment-time">' + item.leaveTime + '</span> </p> <div class="comment-content J_CommentContent">' + item.leaveText + ' </div> </div> </div>');
            });
        } else if (data.length == 0) {
            $("#J_ShortComment").append('<h3 style="text-align: center;">该博客暂时还没有人留言哦！</h3>');
        }
    });
</script>
</body>
</html>

