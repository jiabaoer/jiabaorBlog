<%--
  Created by IntelliJ IDEA.
  User: jiabaoer
  Date: 2019/9/8
  Time: 11:58
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<html>
<head>
    <meta charset="utf-8">
    <title>博客信息管理</title>
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
                        <div class="layui-container">
                            <table class="layui-table">
                                <thead>
                                <tr>
                                    <th colspan="10">
                                        <button class="layui-btn layui-btn-danger" id="blog_delete_all_btn"
                                                style="margin-left: 10px;">
                                            删除
                                        </button>
                                    </th>
                                </tr>
                                <tr>
                                    <th>
                                        <input type="checkbox" name="like[dai]" id="checkAll" title="全选">
                                    </th>
                                    <th>ID</th>
                                    <th>博客分类</th>
                                    <th>博客标题</th>
                                    <th>博客日期</th>
                                    <th>博客浏览数</th>
                                    <th>操作</th>
                                </tr>
                                </thead>
                                </thead>
                                <tbody>
                                <c:forEach items="${pageInfo.list}" var="blog">
                                    <tr>
                                        <td>
                                            <input type="checkbox" value="${blog.id}" class="layui-form-checkbox"
                                                   name="like[dai]"
                                                   title="选中">
                                        </td>
                                        <td>${blog.id}</td>
                                        <td>${blog.blogType.btName}</td>
                                        <td>${blog.bgTitle}</td>
                                        <td>${blog.bgTime}</td>
                                        <td>${blog.bgPraise}</td>
                                        </td>
                                        <td>
                                            <a href="selectByIdBlogAndTypeShow/${blog.id}"
                                               style="background-color: #009688;color: #fff;text-align: center;font-size: 14px;border: none; border-radius: 2px;cursor: pointer;"
                                            >修改
                                            </a>
                                            &nbsp;
                                            <a del-id="${blog.id}"
                                               id="blog_delete_btn"
                                               style="background-color: red;color: #fff;text-align: center;font-size: 14px;border: none; border-radius: 2px;cursor: pointer;">
                                                删除
                                            </a>
                                        </td>
                                    </tr>
                                </c:forEach>
                                <tr align="center">
                                    <td colspan="4">
                                        <a href="/admin/selectBlogList?pageNumber=${pageInfo.pageNumber-1 }&pageSize=${pageInfo.pageSize}"
                                           <c:if test="${pageInfo.pageNumber<=1 }">onclick="javascript:return false;" </c:if>>上一页</a>
                                    </td>
                                    <td colspan="4">
                                        <a href="/admin/selectBlogList?pageNumber=${pageInfo.pageNumber+1 }&pageSize=${pageInfo.pageSize}"
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
        <div class="site-tree-mobile">
            <i class="layui-icon">&#xe602;</i>
        </div>
        <div class="site-close-mobile" style="display: none;">
            <i class="layui-icon">&#xe603;</i>
        </div>
    </div>
</div>
<script>
    layui.use(["layer", 'jquery'], function () {
        var $ = layui.jquery;
        //完成全选。全不选功能
        $("#checkAll").click(function () {
            //attr获取checked是undefind
            //我们这些dom原生的属性；attr获取自定义属性的值
            //prop修改和读取dom原生的值
            $(".layui-form-checkbox").prop("checked", $(this).prop("checked"));
        });
        $(document).on("click", ".layui-form-checkbox", function () {
            //判断当前选择中的元素是否是5个
            var flag = $(".check_item:checked").length == $(".check_item:checked").length;
            $("#checkAll").prop("checked", flag);
        });
        //点击全部删除，就批量删除
        $("#blog_delete_all_btn").click(function () {
            var blogNames = "";
            var delBlog_ids = "";
            $.each($(".layui-form-checkbox:checked"), function () {
                blogNames += $(this).parents("tr").find("td:eq(3)").text() + ",";
                //组装员工id字符串
                delBlog_ids += $(this).parents("tr").find("td:eq(1)").text() + "-"
            });
            //去除empNames多余的，
            blogNames = blogNames.substring(0, blogNames.length - 1);
            //去除del_idstr多余的-
            delBlog_ids = delBlog_ids.substring(0, delBlog_ids.length - 1);
            layui.layer.confirm("确认删除【" + blogNames + "】吗？", function () {
                //发送ajax请求删除
                $.ajax({
                    url: "/admin/delBlog_ids/" + delBlog_ids,
                    type: "POST",
                    success: function (result) {
                        layer.msg(result, {time: 500}, function () {
                            location.reload();
                        });
                    }
                });
            });
        });

        //根据id单个删除
        $(document).on("click", "#blog_delete_btn", function () {
            //弹出是否确认删除对话框
            var blogName = $(this).parents("tr").find("td:eq(3)").text();
            var blogId = $(this).attr("del-id");
            layui.use("layer", function () {
                layui.layer.confirm("确认删除【" + blogName + "】吗？", function () {
                    //发送ajax请求删除
                    $.ajax({
                        url: "/admin/delBlog_ids/" + blogId,
                        type: "DELETE",
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
