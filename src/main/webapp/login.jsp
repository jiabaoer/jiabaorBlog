<%--
  Created by IntelliJ IDEA.
  User: lenovo
  Date: 2019/10/3
  Time: 11:22
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="utf-8">
    <title>黄文贵个人博客-登录</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport"
          content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=0">
    <link rel="icon" type="image/x-icon, image/vnd.microsoft.icon"
          href="${pageContext.request.contextPath}/img/icon.ico">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/layui/css/layui.css" media="all">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/log&rg.css" media="all">
    <script src="${pageContext.request.contextPath}/js/jquery-2.1.0.min.js" type="text/javascript" charset="utf-8"></script>
    <script src="${pageContext.request.contextPath}/layui/layui.js" type="text/javascript" charset="utf-8"></script>
</head>
<body style="background-image: url('${pageContext.request.contextPath}/img/头像.jpg');">
<div class="layadmin-user-login-main" id="login">
    <div class="layadmin-user-login-box layadmin-user-login-header">
        <h3>登录</h3>
        <p>jiabaoer博客</p>
    </div>
    <div class="layadmin-user-login-box layadmin-user-login-body">
        <form action="" class="layui-form" id="loginForm">
            <div class="layui-form-item">
                <label class="layadmin-user-login-icon layui-icon layui-icon-username"
                       for="LAY-user-login-email"></label>
                <input type="text" name="email" id="LAY-user-login-email" lay-verType="tips" lay-verify="checkEmail"
                       placeholder="QQ邮箱" class="layui-input">
            </div>
            <div class="layui-form-item">
                <label class="layadmin-user-login-icon layui-icon layui-icon-password"
                       for="LAY-user-login-password"></label>
                <input type="password" name="password" id="LAY-user-login-password" lay-verType="tips"
                       lay-verify="password"
                       placeholder="密码" class="layui-input">
            </div>
            <div class="layui-form-item">
                <div class="layui-row">
                    <div class="layui-col-xs7">
                        <label class="layadmin-user-login-icon layui-icon layui-icon-vercode"
                               for="LAY-user-login-vercode"></label>
                        <input type="text" name="vercode" id="LAY-user-login-vercode" lay-verType="tips"
                               lay-verify="vercode"
                               placeholder="验证码" class="layui-input">
                    </div>
                    <div class="layui-col-xs5">
                        <div style="margin-left: 10px;">
                            <img src="${pageContext.request.contextPath}/getCode" class="layadmin-user-login-codeimg"
                                 id="LAY-user-get-vercode">
                        </div>
                    </div>
                </div>
            </div>
            <div class="layui-form-item" style="margin-bottom: 20px;">
                <%--<input type="checkbox" class="layui-form-checkbox" name="remember" title="记住密码">
                <div class="layui-unselect layui-form-checkbox" lay-skin="primary">
                    <span>记住密码</span><i class="layui-icon layui-icon-ok"></i></div>--%>
                <a href="${pageContext.request.contextPath}/updPwd" class="layadmin-user-jump-change layadmin-link"
                   style="margin-top: 7px;">忘记密码？</a>
            </div>
            <div class="layui-form-item">
                <button class="layui-btn layui-btn-fluid" lay-submit="" style="background-color: #03A9F4;"
                        lay-filter="LAY-user-login-submit">登 录
                </button>
            </div>
            <div class="layui-trans layui-form-item layadmin-user-login-other">
                <%--<label>第三方账号登录</label>--%>
                <%--<a href="/qqLogin"><i class="layui-icon layui-icon-login-qq"></i></a>--%>
                <%--<a href="javascript:;"><i class="layui-icon layui-icon-login-wechat"></i></a>--%>
                <a href="${pageContext.request.contextPath}/register"
                   class="layadmin-user-jump-change layadmin-link">注册帐号</a>
            </div>
        </form>
    </div>
</div>
<script>
    layui.use(['form', 'layer', 'jquery'], function () {
        var layer = layui.layer, $ = layui.jquery, form = layui.form;
        //表单验证
        form.verify({
            checkEmail: function (value) {
                if (value == null || value == "") {
                    return "请输入邮箱！";
                } else if (!new RegExp("^[1-9]\\d{4,12}@qq\\.com$").test(value)) {
                    return "邮箱格式不正确！";
                } else {
                    var bl = false;
                    $.ajax({
                        url: '${pageContext.request.contextPath}/checkEmail?email=' + value,
                        async: false, //改为同步请求
                        type: "post",
                        success: function (result) {
                            bl = result;
                        }
                    });
                    if (!bl) {
                        return "该邮箱未注册！";
                    }
                }
            },
            password: function (value) {
                if (value == null || value == "") {
                    return "密码不能为空！";
                } else if (/^[\f\n\r\t\v]$/.test(value)) {
                    return '密码不能有空格！';
                } else if (!/^(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{6,20}$/.test(value)) {
                    return '密码至少包含 数字和英文，长度6-20！';
                }
            },
            vercode: function (value) {
                if (value == null || value == "") {
                    return "请输入验证码！";
                }
            }
        });
        //监听提交
        form.on('submit(LAY-user-login-submit)', function (data) {
            $.ajax({
                url: '${pageContext.request.contextPath}/userLogin',
                async: false, //改为同步请求
                dateType: 'json',
                data: data.field,
                type: "post",
                success: function (result) {
                    if (result == "登录成功") {
                        layer.msg(result, {
                            icon: 1,
                            time: 1000
                        }, function () {
                            //返回上一层并刷新
                            window.location.href = document.referrer;
                        });
                    } else {
                        layer.msg(result, {
                            icon: 5,
                            time: 1000
                        }, function () {
                            var timestamp = (new Date()).valueOf();
                            $(".layadmin-user-login-codeimg").attr("src", "${pageContext.request.contextPath}/getCode?timestamp=" + timestamp);
                        });
                    }
                }
            });
            return false;
        });
        $(".layadmin-user-login-codeimg").on("click", function () {
            var timestamp = (new Date()).valueOf();
            $(this).attr("src", "${pageContext.request.contextPath}/getCode?timestamp=" + timestamp);
        });
    });
</script>
</body>
</html>
