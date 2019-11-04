<%--
  Created by IntelliJ IDEA.
  User: jiabaoer
  Date: 2019/9/8
  Time: 11:34
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=0">
    <title>黄文贵个人博客-关于我</title>
    <meta name="keywords" content="黄文贵个人博客,关于黄文贵个人博客,个人博客,个人网站,个人主页,IT博客,技术博客">
    <meta name="description"
          content="此个人博客是致力于IT技术的学习交流型个人技术博客网站，包括网站开发、服务器运维、WEB设计等领域，创建该个人博客也是为了方便与志同道合的朋友一起学习交流，分享经验，感谢大家的支持。">
    <link rel="icon" type="image/x-icon, image/vnd.microsoft.icon"
          href="${pageContext.request.contextPath}/img/icon.ico">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/layui/css/layui.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/main.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/about.css">
    <script src="${pageContext.request.contextPath}/js/jquery-2.1.0.min.js" type="text/javascript"
            charset="utf-8"></script>
    <script src="${pageContext.request.contextPath}/layui/layui.js" type="text/javascript" charset="utf-8"></script>
    <script src="${pageContext.request.contextPath}/js/comm.js" type="text/javascript" charset="utf-8"></script>
</head>
<body>
<%@include file="pageHead.jsp" %>
<div class="layui-container">
    <div class="layui-row">
        <div class="layui-col-md12">
            <div class="card">
                <div class="card-content">
                    <div class="row">
                        <div class="profile center-align">
                            <div class="avatar">
                                <img src="${pageContext.request.contextPath}${user.headPictrue}" alt="${user.nickname}"
                                     class="circle avatar-img">
                            </div>
                            <div class="author">
                                <div class="post-statis">
                                    <div class="statis">
                                        <span class="count"><a
                                                href="${pageContext.request.contextPath}/blogs"
                                                target="_blank">${blogCount}</a></span>
                                        <span class="name">文章</span>
                                    </div>
                                    <div class="statis">
                                        <span class="count"><a href="#">${blogTypeCount}</a></span>
                                        <span class="name">分类</span>
                                    </div>
                                    <div class="statis">
                                        <span class="count"><a
                                                href="${pageContext.request.contextPath}/album">${albumCount}</a></span>
                                        <span class="name">相册</span>
                                    </div>
                                </div>
                                <div class="title">${user.nickname}</div>
                                <div class="title"><i class="layui-icon layui-icon-about" style="font-size: 28px;"></i>简介</div>
                                <div class="center-align">${user.profile}
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="center-align" style="margin-top: 100px;">
                            <h2><i class="layui-icon layui-icon-link"></i>友情链接</h2>
                            <div class="info-title">
                                <c:forEach items="${friends}" var="fd">
                                    <i class="layui-icon layui-icon-friends" style="margin: 10px;color: #42b983;"><a
                                            href="${fd.friendUrl}" target="_blank"
                                            style="color: #42b983;">${fd.friendName}</a></i>
                                </c:forEach>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<%@include file="pageBottom.jsp" %>
</body>
</html>

