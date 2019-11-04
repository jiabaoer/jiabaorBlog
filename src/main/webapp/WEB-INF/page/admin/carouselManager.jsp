<%--
  Created by IntelliJ IDEA.
  User: jiabaoer
  Date: 2019/9/8
  Time: 12:01
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <meta charset="utf-8">
    <title>轮播图管理</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="format-detection" content="telephone=no">
    <link rel="icon" type="image/x-icon, image/vnd.microsoft.icon"
          href="${pageContext.request.contextPath}/img/icon.ico">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/layui/css/layui.css"/>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/admin.css"/>
    <script src="${pageContext.request.contextPath}/layui/layui.js" type="text/javascript" charset="utf-8"></script>
    <script>
        layui.use('jquery', function () {
            layui.$(function () {
                layui.$(".layui-nav-tree li").eq(5).addClass("layui-nav-itemed");
            });
        });
    </script>
    <style>
        .site-demo {
            margin-bottom: 10px;
        }

        .layui-layer-page {
            width: 300px;
        }
    </style>
</head>
<body>
<div class="layui-layout layui-layout-admin">
    <div class="layui-header header header-demo" autumn>
        <%@include file="navbar.jsp" %>
        <!-- 主体内容 -->
        <div class="layui-tab layui-tab-brief" lay-filter="demoTitle">
            <div class="layui-body layui-tab-content site-demo site-demo-body">
                <div class="layui-tab-item layui-show">
                    <div class="layui-main">
                        <div id="LAY_preview">
                            <div class="layui-container">
                                <table class="layui-table">
                                    <thead>
                                    <tr>
                                        <th>ID</th>
                                        <th>轮播图</th>
                                        <th>操作</th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    <c:forEach items="${pageInfo.list}" var="carousel">
                                        <tr>
                                            <td>${carousel.id}</td>
                                            <td><img src="${pageContext.request.contextPath}${carousel.carouselUrl}"
                                                     style="width: 50px;height: 40px"></td>
                                            <td>
                                                <button class="layui-btn layui-btn-danger" value="${carousel.id}"
                                                        id="carousel_delete_btn" style="margin-left: 10px;">删除
                                                </button>

                                            </td>
                                        </tr>
                                    </c:forEach>
                                    <tr align="center">
                                        <td>
                                            <a href="/admin/carousel?blog=blogType&pageNumber=${pageInfo.pageNumber-1 }&pageSize=${pageInfo.pageSize}"
                                               <c:if test="${pageInfo.pageNumber<=1 }">onclick="javascript:return false;" </c:if>>上一页</a>
                                        </td>
                                        <td colspan="2">
                                            <a href="/admin/carousel?blog=blogType&pageNumber=${pageInfo.pageNumber+1 }&pageSize=${pageInfo.pageSize}"
                                               <c:if test="${pageInfo.pageNumber>=pageInfo.total }">onclick="javascript:return false;" </c:if>>下一页</a>
                                        </td>
                                    </tr>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="site-tree-mobile">
            <i class="layui-icon">&#xe602;</i>
        </div>
        <div class="site-close-mobile" style="display: none;">
            <i class="layui-icon">&#xe603;</i>
        </div>
    </div>
</div>
<script>
    layui.use(['layer', 'upload', 'jquery'], function () {
        var $ = layui.jquery,
            layer = layui.layer, upload = layui.upload;
        //根据id单个删除相册
        $(document).on("click", "#carousel_delete_btn", function () {
            //弹出是否确认删除对话框
            var carouselId = $(this).val();
            layer.confirm("确认删除【" + carouselId + "】吗？", function () {
                //发送ajax请求删除
                $.ajax({
                    url: "${pageContext.request.contextPath}/admin/delCarouselById/" + carouselId,
                    type: "POST",
                    success: function (result) {
                        layer.msg(result, {time: 500}, function () {
                            location.reload();
                        });
                    }
                });
            });
        });
        //手机设备的简单适配
        var treeMobile = $('.site-tree-mobile'),
            shadeMobile = $(".site-close-mobile");

        treeMobile.on('click', function () {
            treeMobile.css("display", "none");
            $('body').addClass('site-mobile');
            shadeMobile.css("display", "block");
        });

        shadeMobile.on('click', function () {
            shadeMobile.css("display", "none");
            $('body').removeClass('site-mobile');
            treeMobile.css("display", "block");
        });
    })
    ;
</script>
</body>
</html>
