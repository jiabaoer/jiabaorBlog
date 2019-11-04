<%--
  Created by IntelliJ IDEA.
  User: jiabaoer
  Date: 2019/9/8
  Time: 11:33
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport"
          content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=0">
    <title>黄文贵个人博客-我的相册</title>
    <meta name="keywords" content="黄文贵个人相册,个人相册,个人博客,个人网站,个人主页,IT博客,技术博客">
    <meta name="description" content="此个人博客是致力于IT技术的学习交流型个人技术博客网站，包括网站开发、服务器运维、WEB设计等领域，创建该个人博客也是为了方便与志同道合的朋友一起学习交流，分享经验，感谢大家的支持。">
    <link rel="icon" type="image/x-icon, image/vnd.microsoft.icon" href="${pageContext.request.contextPath}/img/icon.ico">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/layui/css/layui.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/main.css">
    <script src="${pageContext.request.contextPath}/js/jquery-2.1.0.min.js" type="text/javascript" charset="utf-8"></script>
    <script src="${pageContext.request.contextPath}/js/scrollReveal.js" type="text/javascript" charset="utf-8"></script>
    <script src="${pageContext.request.contextPath}/layui/layui.js" type="text/javascript" charset="utf-8"></script>
    <script src="${pageContext.request.contextPath}/js/comm.js" type="text/javascript" charset="utf-8"></script>
    <script type="text/javascript">
        if (!(/msie [6|7|8|9]/i.test(navigator.userAgent))) {
            $(function () {
                window.scrollReveal = new scrollReveal({
                    reset: true
                });
            });
        }
    </script>
</head>
<body>
<%@include file="pageHead.jsp" %>
<div class="layui-container" style="height: 100%">
    <div class="layui-row">
        <div class="layui-col-md12">
            <div class="album-content w1000" id="layer-photos-demo" class="layer-photos-demo">
                <article>
                    <div class="picbox">
                        <c:forEach items="${albumList}" var="album">
                            <ul>
                                <li data-scroll-reveal="enter bottom over 1s"><a
                                        href="${pageContext.request.contextPath}/showAlbumAllPictureById/${album.id}"><i><img
                                        src="${pageContext.request.contextPath}${album.amCoverFile}"></i>
                                    <div class="picinfo">
                                        <h3>${album.amTitle}</h3>
                                        <span>${album.amProfile}</span>
                                    </div>
                                </a></li>
                            </ul>
                        </c:forEach>
                    </div>
                </article>
            </div>
        </div>
    </div>
</div>
<%@include file="pageBottom.jsp" %>
</body>
</html>

