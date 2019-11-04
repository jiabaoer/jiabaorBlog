layui.define(['mm', 'jquery'], function (exports) {
    let $ = layui.$,
        mm = layui.mm;
    let menu = {
        init: function () {
            $('.menu').on('click', function () {
                if ($(this).hasClass('on')) {
                    $(this).removeClass('on')
                    $('.header-down-nav').removeClass('layui-show');
                } else {
                    $(this).addClass('on')
                    $('.header-down-nav').addClass('layui-show');
                }
            })
            window.onresize = function () {
                let curwidth = document.documentElement.clientWidth;
                if (curwidth > 760) {
                    $('.header-down-nav').removeClass('layui-show');
                    $('.menu').removeClass('on');
                }
            };
            let count = $('.list-cont .cont').length;
            $('.volume span').text(count);
            let off;
            $('.op-list .like').on('click', function () {
                let oSpan = $(this).children('span');
                let num = parseInt($(oSpan).text())
                off = $(this).attr('off')
                if (off) {
                    $(this).removeClass('active');
                    off = true;
                    $(oSpan).text(num - 1)
                    $(this).attr('off', '')
                } else {
                    $(this).addClass('active');
                    off = false;
                    $(oSpan).text(num + 1)
                    $(this).attr('off', 'true')
                }
            })
        },
        off: function () {
            $('.off').on('click', function () {
                let off = $(this).attr('off');
                let chi = $(this).children('i');
                let text = $(this).children('span');
                let cont = $(this).parents('.item').siblings('.review-version');
                if (off) {
                    $(text).text('展开');
                    $(chi).attr('class', 'layui-icon layui-icon-down');
                    $(this).attr('off', '');
                    $(cont).addClass('layui-hide');
                } else {
                    $(text).text('收起');
                    $(chi).attr('class', 'layui-icon layui-icon-up')
                    $(this).attr('off', 'true')
                    $(cont).removeClass('layui-hide')
                }
            })
        },
        submit: function () {
            $('.definite').on('click', function (e) {
                let event = e || event;
                event.preventDefault();
                let $listcont = $(this).parents('.form').siblings('.list-cont').length ? $(this).parents('.form').siblings(
                    '.list-cont') : $(this).parents('.form-box').siblings('.list-cont');
                console.log($listcont)
                let img = $(this).parents('form').siblings('img').attr('src');
                let textarea = $(this).parents('.layui-form-item').siblings('.layui-form-text').children('.layui-input-block')
                    .children('textarea');
                let name = $(textarea).val();
                let html = laytplCont.innerHTML;
                let data = {
                    avatar: img,
                    name: '吴亦凡',
                    cont: name,
                }
                let cunt, cunts;
                if (name) {
                    let cont = mm.renderHtml(html, data);
                    $listcont.prepend(cont);
                    cunt = $(this).parents('.form-box').siblings('.volume').children('span');
                    cunts = $(this).parents('.form-box').siblings('.list-cont').children('.cont').length;
                    textarea.val('')
                } else {
                    layer.msg('请输入内容')
                }
                cunt.text(cunts);
            })
        }
    }
    exports('menu', menu)
});
