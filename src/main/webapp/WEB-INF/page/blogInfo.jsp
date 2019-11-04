<%--
  Created by IntelliJ IDEA.
  User: jiabaoer
  Date: 2019/9/8
  Time: 11:34
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport"
          content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=0">
    <title>黄文贵个人博客-${newBlog.bgTitle}</title>
    <meta name="keywords" content="html,js,css,spring,mybatis,黄文贵个人博客,个人博客,个人网站,个人主页,IT博客,技术博客">
    <meta name="description"
          content="此个人博客是致力于IT技术的学习交流型个人技术博客网站，包括网站开发、服务器运维、WEB设计等领域，创建该个人博客也是为了方便与志同道合的朋友一起学习交流，分享经验，感谢大家的支持。">
    <meta name="shenma-site-verification" content="5a59773ab8077d4a62bf469ab966a63b_1497598848">
    <meta name="csdn-baidu-search" content='{"autorun":true,"install":true,"keyword":"${newBlog.bgTitle}}'>
    <link rel="icon" type="image/x-icon, image/vnd.microsoft.icon"
          href="${pageContext.request.contextPath}/img/icon.ico">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/info.css"/>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/layui/css/layui.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/main.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/liuyan.css">
    <script src="${pageContext.request.contextPath}/js/jquery-2.1.0.min.js" type="text/javascript"
            charset="utf-8"></script>
    <script src="${pageContext.request.contextPath}/js/comm.js" type="text/javascript" charset="utf-8"></script>
    <script src="${pageContext.request.contextPath}/layui/layui.js" type="text/javascript" charset="utf-8"></script>
    <style>
        .comment {
            padding: 0 0 20px 80px;
        }

        .common-avatar {
            left: 20px;
        }

        .r_box li {
            box-shadow: none;
            padding: inherit;
        }
    </style>
</head>
<body>
<%@include file="pageHead.jsp" %>
<div class="layui-container">
    <div class="layui-row">
        <div class="layui-col-md9">
            <main class="r_box">
                <div class="infosbox">
                    <div class="newsview">
                        <h3 class="news_title">${newBlog.bgTitle}</h3>
                        <div class="bloginfo">
                            <ul>
                                <li class="author">作者：<a
                                        href="${pageContext.request.contextPath}/about">${user.nickname}</a>
                                </li>
                                <li class="lmname">类别：<a
                                        href="${pageContext.request.contextPath}/selelctByIdBlog/${newBlog.blogType.btId}">${newBlog.blogType.btName}</a>
                                </li>
                                <li class="timer">时间：${newBlog.bgTime}</li>
                                <li class="view">${newBlog.bgPraise}人已阅读</li>
                            </ul>
                        </div>
                        <%--<div class="tags">
                            <a href="/" target="_blank">个人博客</a> &nbsp; <a href="/"
                                                                           target="_blank">小世界</a></div>--%>
                        <div class="news_about">
                            <strong>简介</strong>${newBlog.bgProfile}
                        </div>
                        <div class="news_con">
                            ${newBlog.bgContent}
                        </div>
                    </div>
                    <div class="news_pl">
                        <h2><i class="layui-icon layui-icon-reply-fill"></i>文章评论</h2>
                        <div id="plpost">
                            <form action="" class="layui-form" method="post">
                                <div class="layui-form-item">
                                    <input type="text" value="<shiro:principal/>" lay-verType="tips"
                                           lay-verify="chackUser" style="width: 0px;height: 0px;opacity: 0;">
                                    <input type="hidden" name="conId" id="conId" value="${newBlog.id}">
                                    <textarea name="comText" placeholder="有什么想说的"
                                              style="width: 100%;background-color: rgb(241,241,241);border: 0;border-radius: 5px;padding: 10px;resize: none;"
                                              rows="6"
                                              id="comText" lay-verType="tips"
                                              lay-verify="comText"></textarea>
                                    <button class="btn" lay-submit="" lay-filter="LAY-user-comments-submit">评 论</button>
                                </div>
                            </form>
                        </div>
                    </div>
                    <div class="fb" id="biuuu_comments_list">
                    </div>
                    <div id="demo0" style="text-align: center;"></div>
                </div>
            </main>
        </div>
        <div class="broadside layui-col-md3">
            <%@include file="broadside.jsp" %>
        </div>
    </div>
</div>
<%@include file="pageBottom.jsp" %>
<script>
    layui.use(['laypage', 'code', 'form', 'layer', 'jquery'], function () {
        var laypage = layui.laypage, layer = layui.layer, $ = layui.jquery, form = layui.form;
        layui.code({elem: 'pre', title: '代码', skin: 'notepad', encode: true, about: false});
        form.verify({
            chackUser: function (value) {
                if (value == "" || value == "") {
                    return "请先登录！";
                }
            },
            comText: function (value) {
                if (value == "" || value == null) {
                    return "留言不能为空！";
                }
            }
        });
        form.on('submit(LAY-user-comments-submit)', function (data) {
            //监听提交
            $.ajax({
                url: '${pageContext.request.contextPath}/user/insertCommentsByBlogId',
                async: false, //改为同步请求
                dateType: 'json',
                data: data.field,
                type: "post",
                success: function (result) {
                    if (result == "评论成功！") {
                        layer.msg(result, {
                            icon: 1,
                            time: 1000
                        }, function () {
                            location.reload();
                        });
                    } else {
                        layer.msg(result, {
                            icon: 5,
                            time: 1000
                        }, function () {
                            location.reload();
                        });
                    }
                }
            });
        });
        let data = eval(${comments});
        if (data.length > 10) {
            //调用分页
            laypage.render({
                elem: 'demo0',
                count: data.length,
                theme: '#03A9F4',
                layout: ['count', 'prev', 'page', 'next', 'limit', 'refresh', 'skip'],
                jump: function (obj) {
                    //模拟渲染
                    document.getElementById('biuuu_comments_list').innerHTML = function () {
                        let arr = [],
                            thisData = data.concat().splice(obj.curr * obj.limit - obj.limit, obj.limit);
                        layui.each(thisData, function (index, item) {
                            arr.push('<div class="comment"><div class="common-avatar J_User"><img src="${pageContext.request.contextPath}' + item.user.headPictrue + '" width="100%" height="100%" /> </div> <div class="comment-block"> <p class="comment-user"><span class="comment-username J_User"> ' + item.user.nickname + ' </span><span class="comment-time">' + item.comTime + '</span> </p> <div class="comment-content J_CommentContent">' + item.comText + ' </div> </div> </div>');
                        });
                        return arr.join('');
                    }();
                }
            });
        }else if (data.length>0){
            $(data).each(function (index, item) {
                $("#biuuu_comments_list").append('<div class="comment"><div class="common-avatar J_User"><img src="${pageContext.request.contextPath}'+ item.user.headPictrue + '" width="100%" height="100%" /> </div> <div class="comment-block"> <p class="comment-user"><span class="comment-username J_User"> ' + item.user.nickname + ' </span><span class="comment-time">' + item.comTime + '</span> </p> <div class="comment-content J_CommentContent">' + item.comText + ' </div> </div> </div>');
            });
        }else if (data.length==0){
            $("#biuuu_comments_list").append('<h3 style="text-align: center;">该文章暂时还没有人评论哦！</h3>');
        }
    });
</script>
</body>
</html>

