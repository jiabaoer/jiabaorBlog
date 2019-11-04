<%--
  Created by IntelliJ IDEA.
  User: jiabaoer
  Date: 2019/9/8
  Time: 11:36
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport"
          content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=0">
    <title>黄文贵个人博客-图片信息</title>
    <meta name="keywords" content="黄文贵个人相片,个人相片,个人博客,个人网站,个人主页,IT博客,技术博客">
    <meta name="description"
          content="此个人博客是致力于IT技术的学习交流型个人技术博客网站，包括网站开发、服务器运维、WEB设计等领域，创建该个人博客也是为了方便与志同道合的朋友一起学习交流，分享经验，感谢大家的支持。">
    <link rel="icon" type="image/x-icon, image/vnd.microsoft.icon"
          href="${pageContext.request.contextPath}/img/icon.ico">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/layui/css/layui.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/main.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/info.css"/>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/pictrue.css"/>
    <script src="${pageContext.request.contextPath}/js/jquery-2.1.0.min.js" type="text/javascript"
            charset="utf-8"></script>
    <script src="${pageContext.request.contextPath}/js/comm.js" type="text/javascript" charset="utf-8"></script>
    <script src="${pageContext.request.contextPath}/js/jquery.SuperSlide.2.1.1.js" type="text/javascript"
            charset="utf-8"></script>
    <script src="${pageContext.request.contextPath}/layui/layui.js" type="text/javascript" charset="utf-8"></script>
    <style>
        .layui-container .layui-row {
            margin-top: 10px;
        }
    </style>
</head>
<body>
<%@include file="pageHead.jsp" %>
<div class="layui-container" style="background-color: white;box-shadow: 0px 14px 80px rgba(34, 35, 58, 0.2);">
    <h2 style="
    margin: 10px 0;
    font-size: 22px;
    color: #222;font-weight: 900;"> ${album.amTitle} </h2>
    <span style="color: #ababab;">${album.amTime}</span>
    <div class="news_about">
        <strong>简介</strong>${album.amProfile}
    </div>
    <div id="play">
        <ul class="img_ul">
            <c:forEach items="${album.pictureList}" var="pt">
                <li style="display:block;"><a class="img_a"><img
                        src="${pageContext.request.contextPath}${pt.ptUrl}"></a></li>
            </c:forEach>
        </ul>
        <a href="javascript:void(0)" class="prev_a change_a" title="上一张"> <span></span></a>
        <a href="javascript:void(0)" class="next_a change_a" title="下一张"> <span
                style="display: none; "></span> </a>
    </div>
    <div class="img_hd">
        <ul class=" clearfix">

            <c:forEach items="${album.pictureList}" var="pt">
                <li><a class="img_a"><img src="${pageContext.request.contextPath}${pt.ptUrl}"
                                          onload="imgs_load(this)"></a></li>
            </c:forEach>

        </ul>
        <a class="bottom_a prev_a" style="opacity: 0.7; "></a>
        <a class="bottom_a next_a" style="opacity: 0.7; "></a>
    </div>
</div>
<%@include file="pageBottom.jsp" %>
<script>
    let i = 0; //图片标识
    let img_num = $(".img_ul").children("li").length; //图片个数
    $(".img_ul li").hide(); //初始化图片
    play();
    $(function () {
        $(".img_hd ul").css("width", ($(".img_hd ul li").outerWidth(true)) * img_num); //设置ul的长度

        $(".bottom_a").css("opacity", 0.7); //初始化底部a透明度
        //$("#play").css("height",$("#play .img_ul").height());
        if (!window.XMLHttpRequest) { //对ie6设置a的位置
            $(".change_a").css("height", $(".change_a").parent().height());
        }
        $(".change_a").focus(function () {
            this.blur();
        });
        $(".bottom_a").hover(function () { //底部a经过事件
            $(this).css("opacity", 1);
        }, function () {
            $(this).css("opacity", 0.7);
        });
        $(".change_a").hover(function () { //箭头显示事件
            $(this).children("span").show();
        }, function () {
            $(this).children("span").hide();
        });
        $(".img_hd ul li").click(function () {
            i = $(this).index();
            play();
        });
        $(".prev_a").click(function () {
            //i+=img_num;
            i--;
            //i=i%img_num;
            i = (i < 0 ? 0 : i);
            play();
        });
        $(".next_a").click(function () {
            i++;
            //i=i%img_num;
            i = (i > (img_num - 1) ? (img_num - 1) : i);
            play();
        });
    });

    function play() { //动画移动
        var img = new Image(); //图片预加载
        img.onload = function () {
            img_load(img, $(".img_ul").children("li").eq(i).find("img"))
        };
        img.src = $(".img_ul").children("li").eq(i).find("img").attr("src");
        //$(".img_ul").children("li").eq(i).find("img").(img_load($(".img_ul").children("li").eq(i).find("img")));

        $(".img_hd ul").children("li").eq(i).addClass("on").siblings().removeClass("on");
        if (img_num > 7) { //大于7个的时候进行移动
            if (i < img_num - 3) { //前3个
                $(".img_hd ul").animate({
                    "marginLeft": (-($(".img_hd ul li").outerWidth() + 4) * (i - 3 < 0 ? 0 : (i - 3)))
                });
            } else if (i >= img_num - 3) { //后3个
                $(".img_hd ul").animate({
                    "marginLeft": (-($(".img_hd ul li").outerWidth() + 4) * (img_num - 7))
                });
            }
        }
        if (!window.XMLHttpRequest) { //对ie6设置a的位置
            $(".change_a").css("height", $(".change_a").parent().height());
        }
    }

    function img_load(img_id, now_imgid) { //大图片加载设置 （img_id 新建的img,now_imgid当前图片）

        if (img_id.width / img_id.height > 1) {
            if (img_id.width >= $("#play").width()) $(now_imgid).width($("#play").width());
        } else {
            if (img_id.height >= 500) $(now_imgid).height(500);
        }
        $(".img_ul").children("li").eq(i).show().siblings("li").hide(); //大小确定后进行显示
    }

    function imgs_load(img_id) { //小图片加载设置
        if (img_id.width >= $(".img_hd ul li").width()) {
            img_id.width = 80
        }
        if (img_id.height >= $(".img_hd ul li").height()) {
            img_id.height = $(".img_hd ul li").height();
        }
    }
</script>
</body>
</html>
