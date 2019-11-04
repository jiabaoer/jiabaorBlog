<%--
  Created by IntelliJ IDEA.
  User: jiabaoer
  Date: 2019/9/8
  Time: 11:58
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <meta charset="utf-8">
    <title>博客类别信息管理</title>
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
                layui.$(".layui-nav-tree li").eq(1).addClass("layui-nav-itemed");
            });
        });
    </script>
    <style>
        .site-demo {
            margin-bottom: 10px;
        }

        .layui-form-item .layui-input-inline {
            display: block;
            float: none;
            left: -3px;
            width: auto;
            margin: 0;
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
                                        <th colspan="3">
                                            <button data-method="offset" data-type="auto" id="layerDemo"
                                                    class="layui-btn layui-btn-default" style="margin-left: 10px;">添加
                                            </button>

                                        </th>
                                    </tr>
                                    <tr>
                                        <th>ID</th>
                                        <th>博客类型名称</th>
                                        <th>操作</th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    <c:forEach items="${pageInfo.list}" var="bt">
                                        <tr>
                                            <td>${bt.btId}</td>
                                            <td>${bt.btName}</td>
                                            <td>
                                                <button class="layui-btn layui-btn-info" id="blogType_update_btn"
                                                        value="${bt.btId}"
                                                        style="margin-left: 10px;">修改
                                                </button>
                                                <button class="layui-btn layui-btn-danger" value="${bt.btId}"
                                                        id="blogType_delete_btn" style="margin-left: 10px;">删除
                                                </button>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                    <tr align="center">
                                        <td colspan="2">
                                            <a href="/admin/showAllBlogType?blog=blogType&pageNumber=${pageInfo.pageNumber-1 }&pageSize=${pageInfo.pageSize}"
                                               <c:if test="${pageInfo.pageNumber<=1 }">onclick="javascript:return false;" </c:if>>上一页</a>
                                        </td>
                                        <td>
                                            <a href="/admin/showAllBlogType?blog=blogType&pageNumber=${pageInfo.pageNumber+1 }&pageSize=${pageInfo.pageSize}"
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

</script>
<script>
    //添加博客类别
    layui.use(['layer', 'jquery'], function () {
        var $ = layui.jquery,
            layer = layui.layer;
        //触发事件
        var active = {
            offset: function (othis) {
                var type = othis.data('type');
                layer.open({
                    type: 1,
                    offset: type,
                    id: 'layerDemo' + type //防止重复弹出
                    ,
                    title: '添加类别',
                    content: '<label class="layui-form-label">分类名:</label><div class="layui-input-inline"><input type="text" id="btName" name="btName" required lay-verify="required" placeholder="请输入分类名" autocomplete="off" class="layui-input"></div>',
                    btn: '添加',
                    btnAlign: 'c' //按钮居中
                    , area: ['300px', '150px'],
                    shade: 0 //不显示遮罩
                    ,
                    yes: function () {
                        $.ajax({
                            url: '${pageContext.request.contextPath}/admin/addBlogType/' + $("#btName").val(),
                            type: 'POST',
                            success: function (result) {
                                layer.msg(result, {time: 500}, function () {
                                    location.reload();
                                });
                            }
                        });
                    }
                });
            }
        };
        $('#layerDemo').on('click', function () {
            var othis = $(this),
                method = othis.data('method');
            active[method] ? active[method].call(this, othis) : '';
        });
        //根据id单个删除
        $(document).on("click", "#blogType_delete_btn", function () {
            //弹出是否确认删除对话框
            var blogTypeName = $(this).parents("tr").find("td:eq(1)").text();
            var blogTypeId = $(this).val();
            layer.confirm("确认删除【" + blogTypeName + "】吗？", function () {
                //发送ajax请求删除
                $.ajax({
                    url: "${pageContext.request.contextPath}/admin/delBlogTypeById/" + blogTypeId,
                    type: "POST",
                    success: function (result) {
                        layer.msg(result, {time: 500}, function () {
                            location.reload();
                        });
                    }
                });
            });
        });
        //根据id修改类别
        $(document).on("click", "#blogType_update_btn", function () {
            //弹出是否确认删除对话框
            var blogTypeName = $(this).parents("tr").find("td:eq(1)").text();
            var blogTypeId = $(this).val();
            layui.use("layer", function () {
                layer.prompt({title: '请修改分类名称', value: blogTypeName}, function (value) {
                    ;                    //发送ajax请求删除
                    $.ajax({
                        url: "${pageContext.request.contextPath}/admin/updateBlogTypeById",
                        data: {
                            btId: blogTypeId, btName: value
                        },
                        type: "POST",
                        success: function (result) {
                            layer.msg(result, {time: 500}, function () {
                                location.reload();
                            });
                        }
                    });
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
    });
</script>
</body>
</html>

