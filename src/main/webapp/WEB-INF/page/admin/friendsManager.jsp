<%--
  Created by IntelliJ IDEA.
  User: lenovo
  Date: 2019/10/27
  Time: 15:08
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<html>
<head>
    <meta charset="utf-8">
    <title>友情链接管理</title>
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
                layui.$(".layui-nav-tree li").eq(7).addClass("layui-nav-itemed");
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
                                        <th colspan="4">
                                            <button data-method="offset" data-type="auto" id="layerDemo"
                                                    class="layui-btn layui-btn-default" style="margin-left: 10px;">添加
                                            </button>
                                        </th>
                                    </tr>
                                    <tr>
                                        <th>ID</th>
                                        <th>友链地址</th>
                                        <th>友链名称</th>
                                        <th>操作</th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    <c:forEach items="${friends}" var="fd">
                                        <tr style="font-size: 5px">
                                            <td>${fd.id}</td>
                                            <td>${fd.friendUrl}</td>
                                            <td>${fd.friendName}</td>
                                            <td>
                                                <button class="layui-btn layui-btn-info" data-method="offset"
                                                        data-type="auto" id="friend_update_btn"
                                                        value="${fd.id}"
                                                        style="margin-left: 10px;">修改
                                                </button>
                                                <button class="layui-btn layui-btn-danger" value="${fd.id}"
                                                        id="friend_delete_btn" style="margin-left: 10px;">删除
                                                </button>
                                            </td>
                                        </tr>
                                    </c:forEach>
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
<div class="layui-form" id="updateFriend" style="display: none;width: 300px;">
    <div class="layui-form-item">
        <label class="layui-form-label">输入友链网址</label>
        <div class="layui-input-block">
            <input type="text" name="friendUrl" required lay-varify="required"
                   placeholder="请输入友链网址" autocomplete="on" class="layui-input" id="friendUrl"
                   style="width: 150px;">
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">输入友链名称</label>
        <div class="layui-input-block">
            <input type="text" name="friendName" required lay-varify="required" placeholder="请输入友链名称"
                   autocomplete="on" class="layui-input" id="friendName" style="width: 150px;">
        </div>
    </div>
</div>
<script>
    //添加博客类别
    layui.use(['layer', 'jquery'], function () {
        var $ = layui.jquery,
            layer = layui.layer;
        //触发事件
        $("#layerDemo").click(function () {
            layer.open({
                type: 1,
                title: "修改友链",
                id: $(this).data("type"),
                content: $("#updateFriend"),
                btn: ['添加', '取消'],
                shade: 0, //不显示遮罩
                yes: function () {
                    $.ajax({
                        url: "${pageContext.request.contextPath}/admin/addFriend",
                        data: {
                            friendUrl: $("#friendUrl").val(),
                            friendName: $("#friendName").val(),
                        },
                        type: "POST",
                        success: function (result) {
                            layer.msg(result, {time: 500}, function () {
                                location.reload();
                            });
                        }
                    });
                }
            });
        });
        $('#layerDemo').on('click', function () {
            var othis = $(this),
                method = othis.data('method');
            active[method] ? active[method].call(this, othis) : '';
        });
        //根据id单个删除
        $(document).on("click", "#friend_delete_btn", function () {
            //弹出是否确认删除对话框
            var friendName = $(this).parents("tr").find("td:eq(1)").text();
            var friendId = $(this).val();
            layer.confirm("确认删除【" + friendName + "】吗？", function () {
                //发送ajax请求删除
                $.ajax({
                    url: "${pageContext.request.contextPath}/admin/delFriendById/" + friendId,
                    type: "POST",
                    success: function (result) {
                        layer.msg(result, {time: 500}, function () {
                            location.reload();
                        });
                    }
                });
            });
        });
        //根据id修改友链
        $(".layui-btn-info").click(function () {
            var id = $(this).parents("tr").find("td:eq(0)").text();
            $("#friendUrl").val($(this).parents("tr").find("td:eq(1)").text());
            $("#friendName").val($(this).parents("tr").find("td:eq(2)").text());
            layer.open({
                type: 1,
                title: "修改友链",
                id: $(this).data("type"),
                content: $("#updateFriend"),
                btn: ['修改', '取消'],
                shade: 0, //不显示遮罩
                yes: function () {
                    $.ajax({
                        url: "${pageContext.request.contextPath}/admin/updFriendById",
                        data: {
                            id: id,
                            friendUrl: $("#friendUrl").val(),
                            friendName: $("#friendName").val(),
                        },
                        type: "POST",
                        success: function (result) {
                            layer.msg(result, {time: 500}, function () {
                                location.reload();
                            });
                        }
                    });
                }
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
