<%--
  Created by IntelliJ IDEA.
  User: jiabaoer
  Date: 2019/9/8
  Time: 12:00
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <meta charset="utf-8">
    <title>评论管理</title>
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
                layui.$(".layui-nav-tree li").eq(2).addClass("layui-nav-itemed");
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
    <div class="layui-header header header-demo">
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
                                        <th colspan="6">
                                            <button class="layui-btn layui-btn-danger" id="comments_delete_all_btn"
                                                    style="margin-left: 10px;">删除
                                            </button>
                                        </th>
                                    </tr>
                                    <tr>
                                        <th>
                                            <input type="checkbox" id="checkAll" name="like[dai]" title="全选">
                                        </th>
                                        <th>ID</th>
                                        <th>博客标题</th>
                                        <th colspan="2">评论内容</th>
                                        <th>评论日期</th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    <c:forEach items="${pageInfo.list}" var="cmt">
                                        <tr>
                                            <td>
                                                <input type="checkbox" value="${cmt.comId}" class="layui-form-checkbox"
                                                       name="like[dai]"
                                                       title="选中">
                                            </td>
                                            <td>${cmt.comId}</td>
                                            <td>${cmt.blog.bgTitle}</td>
                                            <td colspan="2">${cmt.comText}</td>
                                            <td>${cmt.comTime}</td>
                                        </tr>
                                    </c:forEach>
                                    <tr align="center">
                                        <td colspan="3">
                                            <a href="/admin/selectAllComments?pageNumber=${pageInfo.pageNumber-1 }&pageSize=${pageInfo.pageSize}"
                                               <c:if test="${pageInfo.pageNumber<=1 }">onclick="javascript:return false;" </c:if>>上一页</a>
                                        </td>
                                        <td colspan="3">
                                            <a href="/admin/selectAllComments?pageNumber=${pageInfo.pageNumber+1 }&pageSize=${pageInfo.pageSize}"
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
    layui.use(['jquery', 'layer'], function () {
        var $ = layui.jquery, layer = layui.layer;
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
        $("#comments_delete_all_btn").click(function () {
            var delPicture_ids = "";
            $.each($(".layui-form-checkbox:checked"), function () {
                //组装员工id字符串
                delPicture_ids += $(this).parents("tr").find("td:eq(1)").text() + "-"
            });
            //去除delPicture_ids多余的-
            delPicture_ids = delPicture_ids.substring(0, delPicture_ids.length - 1);
            layer.confirm("确认删除【" + delPicture_ids + "】吗？", function () {
                //发送ajax请求删除
                $.ajax({
                    url: "/admin/delComments_ids/" + delPicture_ids,
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
    });
</script>
</body>
</html>
