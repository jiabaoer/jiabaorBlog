layui.define(['jquery', 'element', 'laytpl', 'carousel', 'laypage'], function (exports) {
    let $ = layui.$, laytpl = layui.laytpl, element = layui.element, laypage = layui.laypage, carousel = layui.carousel;
    let _mm = {
        request: function (param) {
            let _this = this;
            $.ajax({
                type: param.method || 'get',
                url: param.url || '',
                dataType: param.type || 'json',
                data: param.data || '',
                success: function (res) {
                    // 请求成功
                    if (0 === res.status) {
                        typeof param.success === 'function' && param.success(res, res.msg);
                    }
                    // 请求数据错误
                    else if (1 === res.status) {
                        typeof param.error === 'function' && param.error(res.msg);
                    }
                },
                error: function (err) {
                    typeof param.error === 'function' && param.error(err.statusText);
                }
            });
        },
        renderHtml: function (htmlTemplate, data) {
            let template = laytpl(htmlTemplate),
                result = template.render(data);
            return result;
        }
    }
    exports('mm', _mm)
});