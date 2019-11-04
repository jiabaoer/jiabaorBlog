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
    <title>相片分类管理</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="format-detection" content="telephone=no">
    <link rel="icon" type="image/x-icon, image/vnd.microsoft.icon" href="${pageContext.request.contextPath}/img/icon.ico">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/layui/css/layui.css"/>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/admin.css"/>
    <script src="${pageContext.request.contextPath}/layui/layui.js" type="text/javascript" charset="utf-8"></script>
    <script>
        layui.use('jquery', function () {
            layui.$(function () {
                layui.$(".layui-nav-tree li").eq(4).addClass("layui-nav-itemed");
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
                                        <th colspan="5">
                                            <button data-method="offset" data-type="auto" id="layerDemo"
                                                    class="layui-btn layui-btn-default" style="margin-left: 10px;">添加
                                            </button>
                                        </th>
                                    </tr>
                                    <tr>
                                        <th>ID</th>
                                        <th>相册名称</th>
                                        <th>相册简介</th>
                                        <th>相册日期</th>
                                        <th>操作</th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    <c:forEach items="${pageInfo.list}" var="album">
                                        <tr>
                                            <td>${album.id}</td>
                                            <td>${album.amTitle}</td>
                                            <td>${album.amProfile}</td>
                                            <td>${album.amTime}</td>
                                            <td>
                                                <input type="hidden" amCoverFile="${album.amCoverFile}">
                                                <button class="layui-btn layui-btn-info" data-type="auto"
                                                        style="margin-left: 10px;">修改
                                                </button>
                                                <button class="layui-btn layui-btn-danger" value="${album.id}"
                                                        id="album_delete_btn" style="margin-left: 10px;">删除
                                                </button>

                                            </td>
                                        </tr>
                                    </c:forEach>
                                    <tr align="center">
                                        <td colspan="3">
                                            <a href="/admin/showAllAlbum?blog=blogType&pageNumber=${pageInfo.pageNumber-1 }&pageSize=${pageInfo.pageSize}"
                                               <c:if test="${pageInfo.pageNumber<=1 }">onclick="javascript:return false;" </c:if>>上一页</a>
                                        </td>
                                        <td colspan="2">
                                            <a href="/admin/showAllAlbum?blog=blogType&pageNumber=${pageInfo.pageNumber+1 }&pageSize=${pageInfo.pageSize}"
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
<div class="layui-form" id="addAlbum" style="display: none;">
    <div class="layui-form-item">
        <label class="layui-form-label" style="width: 100px;">输入相册标题</label>
        <div class="layui-input-block">
            <input type="text" name="addAmTitle" required lay-varify="required"
                   placeholder="请输入相册标题" autocomplete="on" class="layui-input" id="addAmTitle"
                   style="width: 150px;">
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">文章封面图</label>
        <button type="button" class="layui-btn" id="test1">上传图片</button>
        <div class="layui-upload-list">
            <input type="hidden" id="addAmCoverFile" name="addAmCoverFile" value="">
            <img class="layui-upload-img" id="demo1" style="width: 50px;margin-left: 120px;">
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label" style="width: 100px;">输入相册简介</label>
        <div class="layui-input-block">
            <input type="text" name="addAmProfile" required lay-varify="required" placeholder="请输入相册简介"
                   autocomplete="on" class="layui-input" id="addAmProfile" style="width: 150px;">
        </div>
    </div>
</div>
<div class="layui-form" id="updateAlbum" style="display: none;">
    <div class="layui-form-item">
        <label class="layui-form-label" style="width: 50px;">输入相册标题</label>
        <div class="layui-input-block">
            <input type="text" name="updAmTitle" required lay-varify="required"
                   placeholder="请输入相册标题" autocomplete="on" class="layui-input" id="updAmTitle"
                   style="width: 150px;">
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">文章封面图</label>
        <button type="button" class="layui-btn" id="test2">上传图片</button>
        <div class="layui-upload-list">
            <input type="hidden" id="updAmCoverFile" name="updAmCoverFile" value="">
            <img class="layui-upload-img" id="demo2" style="width: 100px;margin-left: 120px;">
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label" style="width: 100px;">输入相册简介</label>
        <div class="layui-input-block">
            <input type="text" name="updAmProfile" required lay-varify="required" placeholder="请输入相册简介"
                   autocomplete="on" class="layui-input" id="updAmProfile" style="width: 150px;">
        </div>
    </div>
</div>
<script>
    layui.use(['layer', 'upload', 'jquery'], function () {
        var $ = layui.jquery,
            layer = layui.layer, upload = layui.upload;
        upload.render({
            elem: '#test1'
            , url: '${pageContext.request.contextPath}/admin/uploadAlbumPicture'
            , done: function (res) {
                $("#addAmCoverFile").val(res.data.src);
                $('#demo1').attr('src', res.data.src);
            }
        });
        upload.render({
            elem: '#test2'
            , url: '${pageContext.request.contextPath}/admin/uploadAlbumPicture'
            , done: function (res) {
                $("#updAmCoverFile").val(res.data.src);
                $('#demo2').attr('src', res.data.src);
            }
        });
        //触发事件
        $("#layerDemo").click(function () {
            layer.open({
                type: 1,
                title: "添加相册",
                id: $(this).data("type"),
                content: $("#addAlbum"),
                btn: ['添加', '取消'],
                shade: 0, //不显示遮罩
                yes: function () {
                    $.ajax({
                        url: "${pageContext.request.contextPath}/admin/addAlbum",
                        data: {
                            amTitle: $("#addAmTitle").val(),
                            amProfile: $("#addAmProfile").val(),
                            amCoverFile: $("#addAmCoverFile").val()
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
        //根据id修改相册
        $(".layui-btn-info").click(function () {
            $("#updAmCoverFile").val($(this).parents("tr").find("td:eq(4)").find("input[type='hidden']").attr("amCoverFile"));
            $("#demo2").attr("src", $(this).parents("tr").find("td:eq(4)").find("input[type='hidden']").attr("amCoverFile"));
            var id = $(this).parents("tr").find("td:eq(0)").text();
            $("#updAmTitle").val($(this).parents("tr").find("td:eq(1)").text());
            $("#updAmProfile").val($(this).parents("tr").find("td:eq(2)").text());
            layer.open({
                type: 1,
                title: "修改相册",
                id: $(this).data("type"),
                content: $("#updateAlbum"),
                btn: ['修改', '取消'],
                shade: 0, //不显示遮罩
                yes: function () {
                    $.ajax({
                        url: "${pageContext.request.contextPath}/admin/updateAlbumById",
                        data: {
                            id: id,
                            amTitle: $("#updAmTitle").val(),
                            amProfile: $("#updAmProfile").val(),
                            amCoverFile: $("#updAmCoverFile").val()
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
        //根据id单个删除相册
        $(document).on("click", "#album_delete_btn", function () {
            //弹出是否确认删除对话框
            var albumName = $(this).parents("tr").find("td:eq(1)").text();
            var albumId = $(this).val();
            layer.confirm("确认删除【" + albumName + "】吗？", function () {
                //发送ajax请求删除
                $.ajax({
                    url: "${pageContext.request.contextPath}/admin/delAlbumById/" + albumId,
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
