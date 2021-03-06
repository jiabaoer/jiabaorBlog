<%--
  Created by IntelliJ IDEA.
  User: lenovo
  Date: 2019/9/11
  Time: 13:45
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>博客文章修改</title>
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
                layui.$(".layui-nav-tree li").eq(0).addClass("layui-nav-itemed");
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
                                    <div class="layui-form-item">
                                        <input type="hidden" name="id" value="${blog.id}">
                                        <label class="layui-form-label">博客标题</label>
                                        <div class="layui-input-inline">
                                            <input type="text" name="bgTitle" value="${blog.bgTitle}" required
                                                   lay-verify="required"
                                                   placeholder="请输入标题" autocomplete="off"
                                                   class="layui-input">
                                        </div>
                                        <label class="layui-form-label">所属类别</label>
                                        <div class="layui-input-inline">
                                            <select name="typeId">
                                                <c:forEach items="${blogtypeList}" var="btl">
                                                    <c:if test="${btl.btId==blog.typeId}">
                                                        <option value="${btl.btId}"
                                                                selected="selected">${btl.btName}</option>
                                                    </c:if>
                                                    <c:if test="${btl.btId!=blog.typeId}">
                                                        <option value="${btl.btId}">${btl.btName}</option>
                                                    </c:if>
                                                </c:forEach>
                                            </select>
                                        </div>
                                    </div>
                                    <div class="layui-form-item">
                                        <label class="layui-form-label">封面图</label>
                                        <div class="layui-input-inline">
                                            <button type="button" class="layui-btn" id="test1">上传图片</button>
                                            <div class="layui-upload-list">
                                                <input type="hidden" id="bgCoverFile" name="bgCoverFile" value="${blog.bgCoverFile}">
                                                <img class="layui-upload-img"
                                                     src="${pageContext.request.contextPath}${blog.bgCoverFile}"
                                                     id="demo1" style="width: 100px;">
                                                <p id="demoText"></p>
                                            </div>
                                        </div>
                                        <label class="layui-form-label">博客简介</label>
                                        <div class="layui-input-inline">
                                            <textarea name="bgProfile" class="layui-textarea" id="" cols="5"
                                                      rows="2">${blog.bgProfile}</textarea>
                                        </div>
                                    </div>
                                    <div class="layui-form-item layui-form-text">
                                        <label class="layui-form-label">博客内容</label>
                                        <div class="layui-input-block">
                                            <textarea id="bgContent" name="bgContent"
                                                      class="layui-textarea fly-editor">${blog.bgContent}</textarea>
                                        </div>
                                    </div>
                                    <div class="layui-form-item">
                                        <div class="layui-input-block">
                                            <button class="layui-btn" lay-submit lay-filter="formDemo">修改博客</button>
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
<script type="text/javascript">
    //富文本编辑器
    layui.use(['layedit', 'form', 'upload', 'jquery'], function () {
        var layedit = layui.layedit, $ = layui.jquery, upload = layui.upload;
        var uploadInst = upload.render({
            elem: '#test1'
            , url: '${pageContext.request.contextPath}/admin/uploadBlogCover'
            , done: function (res) {
                $("#bgCoverFile").val(res.data.src);
                $('#demo1').attr('src', ${pageContext.request.contextPath}res.data.src);
            }
        });
        layedit.set({
            uploadImage: {
                url: '/admin/uploadFile',//接口url
                type: 'post'//默认post
            }, tool: ['code', 'strong', 'italic', 'underline', 'del', 'addhr', '|', 'fontFomatt', 'colorpicker', 'face'
                , '|', 'left', 'center', 'right', '|', 'link', 'unlink', 'image_alt'
                , '|', 'table'
            ]
            , height: '500'
        });
        var index = layedit.build("bgContent");
        layedit.sync(index);
        //表单提交
        var form = layui.form;
        //监听提交
        form.on('submit(formDemo)', function (data) {
            data.field.bgContent = layedit.getContent(index);
            layui.$.ajax({
                //请求路径
                url: "/admin/updateBlog",
                //请求类型
                type: "POST",
                data: data.field,
                dataType: "JSON",
                //请求成功的会调函数
                success: function (result) {
                    layer.msg(result.info, {time: 500}, function () {
                        location.href = "/admin/selectBlogList?pageSize=0&pageNumber=0";
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
    })
    ;
</script>
</body>
</html>