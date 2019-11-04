<%--
  Created by IntelliJ IDEA.
  User: lenovo
  Date: 2019/10/15
  Time: 14:06
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta name="viewport"
          content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=0">
    <meta name="viewport" content="width=440,user-scalable=no">
    <title>黄文贵个人博客-听听音乐</title>
    <meta name="keywords" content="音乐,听听音乐,黄文贵个人博客,个人博客,个人网站,个人主页,IT博客,技术博客">
    <meta name="description" content="此个人博客是致力于IT技术的学习交流型个人技术博客网站，包括网站开发、服务器运维、WEB设计等领域，创建该个人博客也是为了方便与志同道合的朋友一起学习交流，分享经验，感谢大家的支持。">
    <link rel="icon" type="image/x-icon, image/vnd.microsoft.icon"
          href="${pageContext.request.contextPath}/img/icon.ico">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/layui/css/layui.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/main.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/font/iconfont.css">
    <script src="${pageContext.request.contextPath}/js/jquery-2.1.0.min.js" type="text/javascript" charset="utf-8"></script>
    <script src="${pageContext.request.contextPath}/js/comm.js" type="text/javascript" charset="utf-8"></script>
    <script src="${pageContext.request.contextPath}/js/music.js" type="text/javascript" charset="utf-8"></script>
    <script src="${pageContext.request.contextPath}/layui/layui.js" type="text/javascript" charset="utf-8"></script>
</head>
<body>
<%@include file="pageHead.jsp" %>
<div class="layui-container" style="margin-bottom: 20px;">
    <div class="layui-row">
        <div id="skPlayer"></div>
    </div>
</div>
<%@include file="pageBottom.jsp" %>
<script>
    var player = new skPlayer({
        autoplay: false,
        //可选项,自动播放,默认为false,true/false
        listshow: true,
        //可选项,列表显示,默认为true,true/false
        mode: 'listloop',
        //可选项,循环模式,默认为'listloop'
        //'listloop',列表循环
        //'singleloop',单曲循环
        music: {
            //必需项,音乐配置
            type: 'cloud',
            //必需项,网易云方式指定填'cloud'
            source: 3778678
            //必需项,网易云音乐歌单id
            //登录网易云网页版,在网页地址中拿到
            // ... playlist?id=317921676
        }
    });
</script>
</body>
</html>
