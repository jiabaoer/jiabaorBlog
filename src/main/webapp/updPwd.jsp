<%--
  Created by IntelliJ IDEA.
  User: lenovo
  Date: 2019/10/3
  Time: 11:33
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="utf-8">
    <title>黄文贵博客-修改密码</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport"
          content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=0">
    <link rel="icon" type="image/x-icon, image/vnd.microsoft.icon"
          href="${pageContext.request.contextPath}/img/icon.ico">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/layui/css/layui.css" media="all">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/log&rg.css" media="all">
    <script src="${pageContext.request.contextPath}/layui/layui.js" type="text/javascript" charset="utf-8"></script>
    <script src="${pageContext.request.contextPath}/js/jquery-2.1.0.min.js" type="text/javascript" charset="utf-8"></script>
</head>
<body style="background-image: url('${pageContext.request.contextPath}/img/头像.jpg');">
<div class="layadmin-user-login-main" id="findPassword">
    <div class="layadmin-user-login-box layadmin-user-login-header">
        <h3>修改密码</h3>
    </div>
    <div class="layadmin-user-login-box layadmin-user-login-body layui-form">
        <form class="layui-form" id="findForm">
            <div class="layui-form-item">
                <label class="layadmin-user-login-icon layui-icon layui-icon-username"
                       for="LAY-user-findPassword-vercode"></label>
                <input type="text" name="email" id="LAY-user-findPassword-vercode" lay-verType="tips" lay-verify="findPasswordEmail"
                       placeholder="QQ邮箱"
                       class="layui-input getEmail">
            </div>
            <div class="layui-form-item">
                <label class="layadmin-user-login-icon layui-icon layui-icon-password"
                       for="LAY-user-login-password"></label>
                <input type="password" name="password" id="LAY-user-login-password" lay-verType="tips" lay-verify="password"
                       placeholder="新密码" class="layui-input">
            </div>
            <div class="layui-form-item">
                <div class="layui-row">
                    <div class="layui-col-xs7">
                        <label class="layadmin-user-login-icon layui-icon layui-icon-vercode"
                               for="LAY-user-login-vercode"></label>
                        <input type="text" name="vercode" id="LAY-user-login-vercode" lay-verType="tips" lay-verify="vercode"
                               placeholder="邮箱验证码" class="layui-input">
                    </div>
                    <div class="layui-col-xs5">
                        <div style="margin-left: 10px;">
                            <input id="btnSendCode"
                                   style="width: 110px;height: 39px;text-align: center;background-color: white;border: 1px solid #E2E2E2;"
                                   name="btnSendCode" type="button" value="获取验证码" onclick="sendMessage();"/>
                        </div>
                    </div>
                </div>
            </div>
            <div class="layui-form-item">
                <button class="layui-btn layui-btn-fluid" style="background-color: #03A9F4;" lay-submit="" lay-filter="LAY-user-findPassword-submit">修 改
                </button>
            </div>
            <div class="layui-trans layui-form-item layadmin-user-login-other">
                <a href="${pageContext.request.contextPath}/login"
                   class="layadmin-user-jump-change layadmin-link">登录</a>
            </div>
        </form>
    </div>
</div>
<script>


    layui.use(['form', 'layer', 'jquery'], function () {
        var layer = layui.layer, $ = layui.jquery, login, register, form = layui.form;
        //表单验证
        form.verify({
            findPasswordEmail: function (value) {
                if (value == "" || value == null) {
                    return "请输入邮箱";
                }
                if (!new RegExp("^[1-9]\\d{4,12}@qq\\.com$").test(value)) {
                    return '邮箱格式不正确';
                }
            },
            password: function (value) {
                if (value == null || value == "") {
                    return "新密码不能为空";
                } else if (/^[\f\n\r\t\v]$/.test(value)) {
                    return '新密码不能有空格';
                } else if (!/^(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{6,20}$/.test(value)) {
                    return '新密码至少包含 数字和英文，长度6-20';
                }
            },
            vercode: function (value) {
                if (value == null || value == "") {
                    return "请输入验证码";
                }
            }

        });
        //监听提交
        form.on('submit(LAY-user-findPassword-submit)', function (data) {
            $.ajax({
                url: '${pageContext.request.contextPath}/updPassword',
                async: false, //改为同步请求
                dateType: 'json',
                data: data.field,
                type: "post",
                success: function (result) {
                    if (result == "修改成功") {
                        layer.msg(result, {
                            icon: 1,
                            time: 1000
                        }, function () {
                            location.href = 'login.jsp';
                        });
                    } else {
                        layer.msg(result, {
                            icon: 5,
                            time: 1000
                        });
                    }
                }
            });
            return false;
        });
        var InterValObj; //timer变量，控制时间
        var count = 60; //间隔函数，1秒执行
        var curCount;//当前剩余秒数
        //发送短信验证码
        window.sendMessage = function () {
            var email = $(".getEmail").val();
            var password = $("#LAY-user-login-password").val();
            if (email == "" || email == null) {
                layer.msg("请输入邮箱", {
                    icon: 5,
                    time: 1000
                });
            } else if (!(/^[1-9]\d{4,12}@qq\.com$/.test(email))) {
                layer.msg("邮箱格式不正确", {
                    icon: 5,
                    time: 1000
                });
            } else if (password == null || password == "") {
                layer.msg("新密码不能为空", {
                    icon: 5,
                    time: 1000
                });
            } else if (/^[\f\n\r\t\v]$/.test(password)) {
                layer.msg("新密码不能有空格", {
                    icon: 5,
                    time: 1000
                });
            } else if (!/^(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{6,20}$/.test(password)) {
                layer.msg("新密码至少包含 数字和英文，长度6-20", {
                    icon: 5,
                    time: 1000
                });
            } else {
                $.ajax({
                    url: '${pageContext.request.contextPath}/updPasswordCode',
                    dateType: 'json',
                    data: {"email": email},
                    type: "post",
                    success: function (result) {
                        if (result == "验证码已发送你的QQ邮箱！") {
                            layer.msg(result, {
                                icon: 1,
                                time: 1000
                            }, function () {
                                curCount = count;
                                // 设置button效果，开始计时
                                document.getElementById("btnSendCode").setAttribute("disabled", "true");//设置按钮为禁用状态
                                document.getElementById("btnSendCode").value = curCount + "秒后重获";//更改按钮文字
                                InterValObj = window.setInterval(SetRemainTime, 1000); // 启动计时器timer处理函数，1秒执行一次
                            });
                        } else {
                            layer.msg(result, {
                                icon: 5,
                                time: 1000
                            });
                        }
                    }
                });
            }

        }

        //timer处理函数
        function SetRemainTime() {
            if (curCount == 0) {//超时重新获取验证码
                window.clearInterval(InterValObj);// 停止计时器
                document.getElementById("btnSendCode").removeAttribute("disabled");//移除禁用状态改为可用
                document.getElementById("btnSendCode").value = "重获验证码";
            } else {
                curCount--;
                document.getElementById("btnSendCode").value = curCount + "秒后重获";
            }
        }
    });
</script>
</body>
</html>
