<%--
  Created by IntelliJ IDEA.
  User: jiabaoer
  Date: 2019/9/8
  Time: 11:13
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=0">
    <title>Jiabaoer-黄文贵个人博客</title>
    <meta name="keywords" content="HTML,CSS,js,spring,springMvc,mybatis,jsp,servlet,黄文贵个人博客,个人博客,个人网站,个人主页,IT博客,技术博客">
    <meta name="description"
          content="此个人博客是致力于IT技术的学习交流型个人技术博客网站，包括网站开发、服  务器运维、WEB设计等领域，创建该个人博客也是为了方便与志同道合的朋友一起学习交流，分享经验，感谢大家的支持。">
    <link rel="icon" type="image/x-icon, image/vnd.microsoft.icon"
          href="${pageContext.request.contextPath}/img/icon.ico">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/layui/css/layui.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/main.css">
    <script src="${pageContext.request.contextPath}/js/jquery-2.1.0.min.js" type="text/javascript"
            charset="utf-8"></script>
    <script src="${pageContext.request.contextPath}/js/comm.js" type="text/javascript" charset="utf-8"></script>
    <script src="${pageContext.request.contextPath}/layui/layui.js" type="text/javascript" charset="utf-8"></script>
</head>
<style>
    .layui-carousel > [carousel-item] {
        border-radius: 10px;
    }
</style>
<body>
<%@include file="pageHead.jsp" %>
<div class="layui-container">
    <div class="layui-row">
        <div class="layui-col-md9">
            <div class="layui-carousel" id="test1">
                <div carousel-item>
                    <c:forEach items="${carouselList}" var="cl">
                        <div><img src="${pageContext.request.contextPath}${cl.carouselUrl}" height="100%" width="100%">
                        </div>
                    </c:forEach>
                </div>
            </div>
            <div id="">
                <c:forEach items="${blogs}" var="bg">
                    <div class="blog-slider">
                        <div class="blog-slider__item">
                            <div class="blog-slider__img">
                                <img src="${pageContext.request.contextPath}${bg.bgCoverFile}" alt="">
                            </div>
                            <div class="blog-slider__content">
                                <div class="blog-slider__title"><a
                                        href="${pageContext.request.contextPath}/selectBlogById/${bg.id}">${bg.bgTitle}</a>
                                </div>
                                <span class="blog-slider__code">
                                     <i class="layui-icon layui-icon-list"><a
                                             href="${pageContext.request.contextPath}/selelctByIdBlog/${bg.blogType.btId}">${bg.blogType.btName}</a></i>
                                    <i class="layui-icon layui-icon-user"><a
                                            href="${pageContext.request.contextPath}/about">${bg.user.nickname}</a></i><i
                                        class="layui-icon layui-icon-date">${bg.bgTime}</i><i
                                        class="layui-icon layui-icon-circle-dot">${bg.bgPraise}</i></span></i></span>
                                <div class="blog-slider__text">${bg.bgProfile}</div>
                                <a href="${pageContext.request.contextPath}/selectBlogById/${bg.id}"
                                   class="blog-slider__button">详情</a>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </div>
        <div class="broadside layui-col-md3">
            <%@include file="broadside.jsp" %>
        </div>
    </div>
</div>
<%@include file="pageBottom.jsp" %>
<script type="text/javascript">
    layui.use('carousel', function () {
        //建造实例
        layui.carousel.render({
            elem: '#test1',
            width: '97%',//设置容器宽度
            arrow: 'hover', //始终显示箭头
            height: '300',
            interval: '5000',
            anim: 'fade'
        });
    });
</script>
</body>
</html>
