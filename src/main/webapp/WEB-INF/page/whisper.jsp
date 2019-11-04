<%--
  Created by IntelliJ IDEA.
  User: jiabaoer
  Date: 2019/9/8
  Time: 11:37
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=0">
    <title>黄文贵个人博客-我的文章</title>
    <meta name="keywords" content="黄文贵个人博客,个人博客,个人网站,个人主页,IT博客,技术博客">
    <meta name="description"
          content="此个人博客是致力于IT技术的学习交流型个人技术博客网站，包括网站开发、服务器运维、WEB设计等领域，创建该个人博客也是为了方便与志同道合的朋友一起学习交流，分享经验，感谢大家的支持。">
    <script src="${pageContext.request.contextPath}/js/jquery-2.1.0.min.js" type="text/javascript"
            charset="utf-8"></script>
    <script src="${pageContext.request.contextPath}/js/comm.js" type="text/javascript" charset="utf-8"></script>
    <link rel="icon" type="image/x-icon, image/vnd.microsoft.icon"
          href="${pageContext.request.contextPath}/img/icon.ico">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/layui/css/layui.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/main.css">
    <script src="${pageContext.request.contextPath}/js/jquery-2.1.0.min.js" type="text/javascript"
            charset="utf-8"></script>
    <script src="${pageContext.request.contextPath}/layui/layui.js" type="text/javascript" charset="utf-8"></script>
    <style type="text/css">
        .layui-container .layui-row {
            margin-top: 10px;
        }
    </style>
</head>
<body>
<%@include file="pageHead.jsp" %>
<div class="layui-container">
    <div class="layui-row">
        <div class="layui-col-md9">
            <div id="J_ShortBlog">
            </div>
            <div id="demo0" style="text-align: center;"></div>
        </div>
        <div class="broadside layui-col-md3">
            <%@include file="broadside.jsp" %>
        </div>
    </div>
</div>
<%@include file="pageBottom.jsp" %>

<script>
    layui.use('laypage', function () {
        var laypage = layui.laypage;
        var data = eval(${blogs});
        if (data.length > 10) {
            //调用分页
            laypage.render({
                elem: 'demo0',
                count: data.length,
                theme: '#1E9FFF',
                layout: ['count', 'prev', 'page', 'next', 'limit', 'refresh', 'skip'],
                jump: function (obj) {
                    //模拟渲染
                    document.getElementById('J_ShortBlog').innerHTML = function () {
                        var arr = [],
                            thisData = data.concat().splice(obj.curr * obj.limit - obj.limit, obj.limit);
                        layui.each(thisData, function (index, item) {
                            arr.push('<div class="blog-slider">\n' +
                                '                        <div class="blog-slider__item">\n' +
                                '                            <div class="blog-slider__img">\n' +
                                '                                <img src="${pageContext.request.contextPath}' + item.bgCoverFile + '" alt="">\n' +
                                '                            </div>\n' +
                                '                            <div class="blog-slider__content">\n' +
                                '                                <div class="blog-slider__title"><a\n' +
                                '                                        href="${pageContext.request.contextPath}/selectBlogById/' + item.id + '">' + item.bgTitle + '</a>\n' +
                                '                                </div>\n' +
                                '                                <span class="blog-slider__code"><i class="layui-icon layui-icon-list"><a\n' +
                                '                                             href="${pageContext.request.contextPath}/selelctByIdBlog/' + item.blogType.btId + '">' + item.blogType.btName + '</a></i><i class="layui-icon layui-icon-user"><a href="${pageContext.request.contextPath}/about">' + item.user.nickname + '</a></i><i class="layui-icon layui-icon-date">' + item.bgTime + '</i><i class="layui-icon layui-icon-circle-dot">' + item.bgPraise + '</i></span>\n' +
                                '                                <div class="blog-slider__text">' + item.bgProfile + '</div>\n' +
                                '                                <a href="${pageContext.request.contextPath}/selectBlogById/' + item.id + '"\n' +
                                '                                   class="blog-slider__button">详情</a>\n' +
                                '                            </div>\n' +
                                '                        </div>\n' +
                                '                    </div>');
                        });
                        return arr.join('');

                    }();
                }
            });
        } else if (data.length > 0) {
            $(data).each(function (index, item) {
                $("#J_ShortBlog").append('<div class="blog-slider">\n' +
                    '                        <div class="blog-slider__item">\n' +
                    '                            <div class="blog-slider__img">\n' +
                    '                                <img src="${pageContext.request.contextPath}' + item.bgCoverFile + '" alt="">\n' +
                    '                            </div>\n' +
                    '                            <div class="blog-slider__content">\n' +
                    '                                <div class="blog-slider__title"><a\n' +
                    '                                        href="${pageContext.request.contextPath}/selectBlogById/' + item.id + '">' + item.bgTitle + '</a>\n' +
                    '                                </div>\n' +
                    '                                <span class="blog-slider__code"><i class="layui-icon layui-icon-list"><a\n' +
                    '                                             href="${pageContext.request.contextPath}/selelctByIdBlog/' + item.blogType.btId + '">' + item.blogType.btName + '</a></i><i class="layui-icon layui-icon-user"><a href="${pageContext.request.contextPath}/about">' + item.user.nickname + '</a></i><i class="layui-icon layui-icon-date">' + item.bgTime + '</i><i class="layui-icon layui-icon-circle-dot">' + item.bgPraise + '</i></span>\n' +
                    '                                <div class="blog-slider__text">' + item.bgProfile + '</div>\n' +
                    '                                <a href="${pageContext.request.contextPath}/selectBlogById/' + item.id + '"\n' +
                    '                                   class="blog-slider__button">详情</a>\n' +
                    '                            </div>\n' +
                    '                        </div>\n' +
                    '                    </div>')
            });
        } else if (data.length == 0) {
            $("#J_ShortBlog").append("<h3 style='text-align: center;'>该分类暂时没有文章！</h3>");
        }
    });
</script>
</body>
</html>
