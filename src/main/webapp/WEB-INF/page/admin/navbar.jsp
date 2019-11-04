<%--
  Created by IntelliJ IDEA.
  User: jiabaoer
  Date: 2019/9/9
  Time: 8:49
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<div class="layui-header layui-bg-cyan">
    <img class="logo" src="${pageContext.request.contextPath}/img/logo.png">
    <!-- 头部区域 -->
    <ul class="layui-nav layui-layout-left">
        <li class="layui-nav-item" lay-unselect>
            <a href="${pageContext.request.contextPath}/" target="_blank" title="前台">
                <i class="layui-icon layui-icon-website">前台</i>
            </a>
        </li>
    </ul>
    <ul class="layui-nav layui-layout-right" lay-filter="layadmin-layout-right">
        <li class="layui-nav-item">
            <shiro:user>
                欢迎<shiro:principal type="com.jiabaoer.pojo.User" property="nickname"/><shiro:hasRole
                    name="admin">--->管理员</shiro:hasRole>
            </shiro:user>
        </li>
    </ul>

</div>

<!-- 侧边菜单 -->
<div class="layui-side" style="background-color: #2F4056!important;">
    <div class="layui-side-scroll">
        <ul class="layui-nav layui-nav-tree layui-nav-side" lay-filter="test">
            <!-- 侧边导航:-->
            <li class="layui-nav-item">
                <a href="javascript:;">博客管理</a>
                <dl class="layui-nav-child">
                    <dd><a href="${pageContext.request.contextPath}/admin/showAllBlogType/bg">写博客</a></dd>
                    <dd><a href="${pageContext.request.contextPath}/admin/selectBlogList">博客信息管理</a></dd>
                </dl>
            </li>
            <li class="layui-nav-item">
                <a href="javascript:;">博客类别管理</a>
                <dl class="layui-nav-child">
                    <dd>
                        <a href="${pageContext.request.contextPath}/admin/showAllBlogType/blogType?pageSize=0&pageNumber=0">博客类别信息管理</a>
                    </dd>
                </dl>
            </li>
            <li class="layui-nav-item">
                <a href="javascript:;">评论管理</a>
                <dl class="layui-nav-child">
                    <dd><a href="${pageContext.request.contextPath}/admin/selectAllComments">评论信息管理</a></dd>
                </dl>
            </li>
            <li class="layui-nav-item">
                <a href="javascript:;">图片管理</a>
                <dl class="layui-nav-child">
                    <dd><a href="${pageContext.request.contextPath}/admin/picture">上传图片</a></dd>
                    <dd><a href="${pageContext.request.contextPath}/admin/selectAllPicture?pageNumber=0&pageSize=0">图片信息管理</a>
                    </dd>
                </dl>
            </li>
            <li class="layui-nav-item">
                <a href="javascript:;">相册管理</a>
                <dl class="layui-nav-child">
                    <dd>
                        <a href="${pageContext.request.contextPath}/admin/showAllAlbum?pageNumber=0&pageSize=0">相册信息管理</a>
                    </dd>
                </dl>
            </li>
            <li class="layui-nav-item">
                <a href="javascript:;">轮播图管理</a>
                <dl class="layui-nav-child">
                    <dd><a href="${pageContext.request.contextPath}/admin/carouselUpd">轮播图上传</a></dd>
                    <dd><a href="${pageContext.request.contextPath}/admin/carousel?pageNumber=0&pageSize=0">轮播信息管理</a>
                    </dd>
                </dl>
            </li>
            <li class="layui-nav-item">
                <a href="javascript:;">留言管理</a>
                <dl class="layui-nav-child">
                    <dd><a href="${pageContext.request.contextPath}/admin/leaveManager">留言信息管理</a></dd>
                </dl>
            </li>
            <li class="layui-nav-item">
                <a href="javascript:;">友链管理</a>
                <dl class="layui-nav-child">
                    <dd><a href="${pageContext.request.contextPath}/admin/friends">友链信息管理</a></dd>
                </dl>
            </li>
            <li class="layui-nav-item">
                <a href="javascript:;">用户管理</a>
                <dl class="layui-nav-child">
                    <dd><a href="${pageContext.request.contextPath}/admin/userManager">用户信息管理</a></dd>
                </dl>
            </li>
        </ul>
    </div>
</div>
<script>
    //注意：导航 依赖 element 模块，否则无法进行功能性操作
    layui.use('element', function () {
        var element = layui.element;
    });
</script>