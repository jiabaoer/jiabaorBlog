<%--
  Created by IntelliJ IDEA.
  User: jiabaoer
  Date: 2019/9/8
  Time: 21:34
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<script type="text/javascript">
    layui.config({
        base: '${pageContext.request.contextPath}/js/'
    }).use(['element', 'laypage', 'jquery', 'menu'], function () {
        var element = layui.element, laypage = layui.laypage, $ = layui.$, menu = layui.menu;
        laypage.render({
            elem: 'demo',
            count: 70 //数据总数，从服务端得到
        });
        menu.init();
    });
</script>
<style>
    .layui-nav .layui-nav-item a {
        color: #333;
    }

    .header .welcome-text a:hover {
        color: #03A9F4;
    }
</style>
<div class="header" id="header">
    <div class="menu-btn">
        <div class="menu"></div>
    </div>
    <h1 class="logo">
        <img src="${pageContext.request.contextPath}/img/logo.png">
    </h1>
    <div class="nav">
        <ul>
            <li></i><a href="${pageContext.request.contextPath}/">首页</a></li>
            <li><a href="${pageContext.request.contextPath}/blogs">文章</a></li>
            <li><a href="${pageContext.request.contextPath}/album">相册</a></li>
            <li><a href="${pageContext.request.contextPath}/music">音乐</a></li>
            <li><a href="${pageContext.request.contextPath}/leave">留言</a></li>
            <li><a href="${pageContext.request.contextPath}/about">关于我</a></li>
        </ul>
    </div>
    <ul class="layui-nav header-down-nav">
        <li class="layui-nav-item"><a href="${pageContext.request.contextPath}/">首页</a></li>
        <li class="layui-nav-item"><a href="${pageContext.request.contextPath}/blogs">文章</a></li>
        <li class="layui-nav-item"><a href="${pageContext.request.contextPath}/album">相册</a></li>
        <li class="layui-nav-item"><a href="${pageContext.request.contextPath}/music">音乐</a></li>
        <li class="layui-nav-item"><a href="${pageContext.request.contextPath}/leave">留言</a></li>
        <li class="layui-nav-item"><a href="${pageContext.request.contextPath}/about">关于我</a></li>
        <shiro:guest>
            <li class="layui-nav-item">
                <a href="${pageContext.request.contextPath}/login">登录</a>
            </li>
            <li class="layui-nav-item">
                <a href="${pageContext.request.contextPath}/register">注册</a>
            </li>
        </shiro:guest>
        <shiro:user>
            <li class="layui-nav-item" style="line-height: 110px;">
                <a href="javascript:;"><img src="<shiro:principal
                        type="com.jiabaoer.pojo.User" property="headPictrue"/>" class="layui-nav-img">欢迎<span style="font-size: 18px;color: #F44336;"><shiro:principal
                        type="com.jiabaoer.pojo.User" property="nickname"/></span>登录</a>
                <dl class="layui-nav-child" style="top: 110px;">
                    <shiro:hasRole name="user">
                        <dd><a href="${pageContext.request.contextPath}/user/selUserInfo" target="_blank"><i class="layui-icon layui-icon-set"></i>&nbsp;个人信息</a></dd>
                    </shiro:hasRole>
                    <shiro:hasRole name="admin">
                        </dd><dd><a href="${pageContext.request.contextPath}/user/selUserInfo" target="_blank"><i class="layui-icon layui-icon-set"></i>&nbsp;个人信息</a></dd>
                        </dd>
                        <dd lay-unselect="">
                            <a href="${pageContext.request.contextPath}/admin/main" target="_blank"><i class="layui-icon layui-icon-console"></i>&nbsp;后台管理</a>
                        </dd>
                    </shiro:hasRole>
                    <dd><a href="/logout"><i class="layui-icon layui-icon-close"></i>&nbsp;注销</a></dd>
                </dl>
            </li>
        </shiro:user>
    </ul>
    <ul class="layui-nav welcome-text" style="background-color:transparent;">
        <shiro:guest>
            <li class="layui-nav-item" style="line-height: 110px;">
                <a href="${pageContext.request.contextPath}/login">登录</a>
            </li>
            <li class="layui-nav-item" style="line-height: 120px;">
                <a href="${pageContext.request.contextPath}/register">注册</a>
            </li>
        </shiro:guest>
        <shiro:user>
            <li class="layui-nav-item" style="line-height: 110px;">
                <a href="javascript:;"><img src="<shiro:principal
                        type="com.jiabaoer.pojo.User" property="headPictrue"/>" class="layui-nav-img">欢迎<span style="font-size: 18px;color: #F44336;"><shiro:principal
                        type="com.jiabaoer.pojo.User" property="nickname"/></span>登录</a>
                <dl class="layui-nav-child" style="top: 110px;">
                    <shiro:hasRole name="user">
                        <dd><a href="${pageContext.request.contextPath}/user/selUserInfo" target="_blank"><i class="layui-icon layui-icon-set"></i>&nbsp;个人信息</a></dd>
                    </shiro:hasRole>
                    <shiro:hasRole name="admin">
                        </dd><dd><a href="${pageContext.request.contextPath}/user/selUserInfo" target="_blank"><i class="layui-icon layui-icon-set"></i>&nbsp;个人信息</a></dd>
                        </dd>
                        <dd lay-unselect="">
                            <a href="${pageContext.request.contextPath}/admin/main" target="_blank"><i class="layui-icon layui-icon-console"></i>&nbsp;后台管理</a>
                        </dd>
                    </shiro:hasRole>
                    <dd><a href="${pageContext.request.contextPath}/logout"><i class="layui-icon layui-icon-close"></i>&nbsp;注销</a></dd>
                </dl>
            </li>
        </shiro:user>
    </ul>
</div>
