<%--
  Created by IntelliJ IDEA.
  User: lenovo
  Date: 2019/9/25
  Time: 11:24
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<script>
    $(function () {
        $.ajax({
            url: '${pageContext.request.contextPath}/showBroadside',
            success: function (result) {
                //相册
                $.each(result.albumList, function (i, album) {
                    $(".wdxc ul").append($('<li></li>').append($('<a></a>').attr('href', ${pageContext.request.contextPath}/showAlbumAllPictureById/ + album.id).append('<img src="${pageContext.request.contextPath}' + album.amCoverFile + '"/>')));
                });
                //分类
                $.each(result.blogTypeList, function (i, bt) {
                    $(".fenlei ul").append('<li><a href="${pageContext.request.contextPath}/selelctByIdBlog/' + bt.btId + '">' + bt.btName + '</a></li>');
                });
                //站在推荐
                $.each(result.blogs, function (i, bg) {
                    $(".tuijian ul").append('<li><a href="${pageContext.request.contextPath}/selectBlogById/' + bg.id + '">' + bg.bgTitle + '</a></li>');
                });
                //友情链接
                $.each(result.friends, function (i, fd) {
                    $(".links ul").append('<a href="' + fd.friendUrl + '" target="_blank">' + fd.friendName + '</a>');
                });
            }
        });
    });
</script>
<aside class="l_box">
    <div class="about_me">
        <h3>关于我</h3>
        <ul>
            <i><img src="${pageContext.request.contextPath}${admin.headPictrue}"></i>
            <p><b><a href="${pageContext.request.contextPath}/about">${admin.nickname}</a> </b>，${admin.profile}</p>
        </ul>
    </div>
    <div class="wdxc">
        <h3>我的相册</h3>
        <ul>
        </ul>
    </div>
    <div class="search">
        <form action="" method="post" name="searchform" id="searchform">
            <input name="keyboard" id="keyboard" class="input_text" value="请输入关键字词"
                   style="color: rgb(153, 153, 153);"
                   onfocus="if(value=='请输入关键字词'){this.style.color='#000';value=''}"
                   onblur="if(value==''){this.style.color='#999';value='请输入关键字词'}"
                   type="text">
            <input name="Submit" class="input_submit" value="搜索" type="submit">
        </form>
    </div>
    <div class="fenlei">
        <h3>文章分类</h3>
        <ul>
        </ul>
    </div>
    <div class="tuijian">
        <h3>站长推荐</h3>
        <ul>
        </ul>
    </div>
    <div class="links">
        <h3>友情链接</h3>
        <ul>
        </ul>
    </div>
    <div class="guanzhu">
        <h3>关注我</h3>
        <ul>
            <img src="${pageContext.request.contextPath}/img/微信二维码.png">
        </ul>
    </div>
</aside>

