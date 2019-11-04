<%--
  Created by IntelliJ IDEA.
  User: lenovo
  Date: 2019/10/7
  Time: 16:41
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=0">
    <title>黄文贵个人博客-个人信息</title>
    <link rel="icon" type="image/x-icon, image/vnd.microsoft.icon"
          href="${pageContext.request.contextPath}/img/icon.ico">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/main.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/layui/css/layui.css">
    <script src="${pageContext.request.contextPath}/js/jquery-2.1.0.min.js" type="text/javascript" charset="utf-8"></script>
    <script src="${pageContext.request.contextPath}/js/comm.js" type="text/javascript" charset="utf-8"></script>
    <script src="${pageContext.request.contextPath}/layui/layui.js" type="text/javascript" charset="utf-8"></script>
</head>
<body>
<%@include file="pageHead.jsp" %>
<div class="layui-container" style="height: 550px">
    <div class="layui-tab" lay-filter="test">
        <ul class="layui-tab-title" style="text-align: center;">
            <li class="layui-this" lay-id="11">个人信息</li>
            <li lay-id="22">修改密码</li>
        </ul>
        <div class="layui-tab-content" style="height: 450px;">
            <div class="layui-tab-item layui-show">
                <div class="layui-card">
                    <div class="layui-card-body">
                        <form action="" method="post" class="layui-form" style="align-content: center;">
                            <div class="layui-form-item">
                                <label class="layui-form-label">QQ邮箱</label>
                                <div class="layui-input-inline">
                                    <input type="text" name="email" value="${user.email}" readonly=""
                                           class="layui-input">
                                </div>
                                <div class="layui-form-mid layui-word-aux">不可修改</div>
                            </div>
                            <div class="layui-form-item">
                                <label class="layui-form-label">昵称</label>
                                <div class="layui-input-inline">
                                    <input type="text" name="nickname" value="${user.nickname}" lay-verify="nickname"
                                           autocomplete="off"
                                           placeholder="请输入昵称" class="layui-input">
                                </div>
                            </div>
                            <div class="layui-form-item">
                                <label class="layui-form-label">头像</label>
                                <button type="button" class="layui-btn" id="test1">上传图片</button>
                                <div class="layui-upload-list">
                                    <input type="hidden" id="headPictrue" name="headPictrue"
                                           value="${user.headPictrue}">
                                    <img src="${pageContext.request.contextPath}${user.headPictrue}"
                                         class="layui-upload-img" id="demo1" style="width: 50px;margin-left: 120px;">
                                </div>
                            </div>
                            <div class="layui-form-item">
                                <div class="layui-input-block">
                                    <button class="layui-btn" lay-submit="" lay-filter="LAY-user-updInfo-submit">确认修改
                                    </button>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
            <div class="layui-tab-item">
                <div class="layui-card">
                    <div class="layui-card-body">
                        <form action="" method="post" class="layui-form">
                            <div class="layui-form-item">
                                <label class="layui-form-label">原密码</label>
                                <div class="layui-input-inline">
                                    <input type="password" name="oldPassword" class="layui-input"
                                           lay-verify="oldPassword">
                                </div>
                            </div>
                            <div class="layui-form-item">
                                <label class="layui-form-label">新密码</label>
                                <div class="layui-input-inline">
                                    <input type="password" name="newPassword" class="layui-input"
                                           lay-verify="newPassword">
                                </div>
                            </div>
                            <div class="layui-form-item">
                                <div class="layui-input-block">
                                    <button class="layui-btn" lay-submit="" lay-filter="LAY-user-updPwd-submit">确认修改
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
<%@include file="pageBottom.jsp" %>
<script>
    layui.use(['element', 'layer', 'upload', 'form', 'jquery'], function () {
        var $ = layui.jquery, layer = layui.layer, upload = layui.upload, form = layui.form, element = layui.element;
        var layid = location.hash.replace(/^#test=/, '');
        element.tabChange('test', layid);
        element.on('tab(test)', function (elem) {
            location.hash = 'test=' + $(this).attr('lay-id');
        });
        upload.render({
            elem: '#test1'
            , url: '${pageContext.request.contextPath}/user/updHeadPictrue'
            , done: function (res) {
                $("#headPictrue").val(res.data.src);
                $('#demo1').attr('src', res.data.src);
            }
        });
        form.verify({
            oldPassword: function (value) {

                if (value == null || value == "") {
                    return "密码不能为空";
                } else if (/^[\f\n\r\t\v]$/.test(value)) {
                    return '密码不能有空格';
                } else if (!/^(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{6,20}$/.test(value)) {
                    return '密码至少包含 数字和英文，长度6-20';
                } else {
                    var bl = false;
                    $.ajax({
                        url: '${pageContext.request.contextPath}/user/checkPassword/' + value,
                        async: false, //改为同步请求
                        type: "post",
                        success: function (result) {
                            bl = result;
                        }
                    });
                    if (bl) {
                        return "密码输入错误!";
                    }
                }
            },
            newPassword: function (value) {
                if (value == null || value == "") {
                    return "密码不能为空";
                } else if (/^[\f\n\r\t\v]$/.test(value)) {
                    return '密码不能有空格';
                } else if (!/^(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{6,20}$/.test(value)) {
                    return '密码至少包含 数字和英文，长度6-20';
                }
            },
            nickname: [/^[\headPictrue-\u9FA5]{2,6}$/, '昵称必须是中文且2-6个字符']
        });
        //监听提交
        form.on('submit(LAY-user-updInfo-submit)', function (data) {
            $.ajax({
                url: '${pageContext.request.contextPath}/user/updUserInfo',
                async: false, //改为同步请求
                data: data.field,
                type: "post",
                success: function (result) {
                    layer.msg(result, {time: 500}, function () {
                        location.reload();
                    });
                }
            });
            return false;
        });
        //修改密码
        form.on('submit(LAY-user-updPwd-submit)', function (data) {
            $.ajax({
                url: '${pageContext.request.contextPath}/user/updPwd',
                async: false, //改为同步请求
                data: data.field,
                type: "post",
                success: function (result) {
                    layer.msg(result, {time: 500}, function () {
                        location.reload();
                    });
                }
            });
            return false;
        });
    });
</script>
</body>
</html>
