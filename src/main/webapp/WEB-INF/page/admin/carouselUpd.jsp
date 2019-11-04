<%--
  Created by IntelliJ IDEA.
  User: jiabaoer
  Date: 2019/9/8
  Time: 12:01
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <meta charset="utf-8">
    <title>轮播上传图片</title>
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
                                <form class="layui-form" action="">
                                    <div class="layui-form-item layui-form-text">
                                        <label class="layui-form-label">相册内容</label>
                                        <div class="layui-upload-drag" id="test10">
                                            <input type="hidden" id="ptUrl" value="" name="carouselUrl">
                                            <i class="layui-icon"></i>
                                            <p>点击上传，或将文件拖拽到此处</p>
                                        </div>
                                    </div>
                                    <div class="layui-form-item">
                                        <div class="layui-input-block">
                                            <button class="layui-btn" lay-submit lay-filter="formDemo">上传
                                            </button>
                                        </div>
                                    </div>
                                </form>
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
    //Demo
    layui.use(['form', 'layer', 'jquery', 'upload'], function () {
        var form = layui.form, $ = layui.jquery, upload = layui.upload;
        var str = "";
        //拖拽上传
        upload.render({
            elem: '#test10'
            , url: '/admin/carouselUpload'
            , done: function (res) {
                console.log(res)
                str += res.data.src + "-";
                //上传完毕
                $('#test10').append('<img src="' + res.data.src + '" alt="' + res.data.title + '" style="width: 50px;height: 80px" class="layui-upload-img">');
                $("#ptUrl").val(str.substring(0, str.length - 1));
            }
        });
        //监听提交
        form.on('submit(formDemo)', function (data) {
            $.ajax({
                url: "/admin/addCaousel",
                data: data.field,
                type: "POST",
                success: function (result) {
                    layer.msg(result, {time: 500}, function () {
                        location.reload();
                    });
                }
            });
            return false;
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