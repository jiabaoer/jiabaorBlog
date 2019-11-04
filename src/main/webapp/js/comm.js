$(document).ready(function () {
    let new_scroll_position = 0;
    let last_scroll_position;
    let header = document.getElementById("header");

    window.addEventListener('scroll', function (e) {
        last_scroll_position = window.scrollY;

        // Scrolling down
        if (new_scroll_position < last_scroll_position && last_scroll_position > 80) {
            // header.removeClass('slideDown').addClass('slideUp');
            header.classList.remove("slideDown");
            header.classList.add("slideUp");

            // Scrolling up
        } else if (new_scroll_position > last_scroll_position) {
            // header.removeClass('slideUp').addClass('slideDown');
            header.classList.remove("slideUp");
            header.classList.add("slideDown");
        }

        new_scroll_position = last_scroll_position;
    });
    //回到顶部
    let offset = 300,
        offset_opacity = 1200,
        scroll_top_duration = 700,
        $back_to_top = $('.cd-top');

    $(window).scroll(function () {
        ($(this).scrollTop() > offset) ? $back_to_top.addClass('cd-is-visible') : $back_to_top.removeClass(
            'cd-is-visible cd-fade-out');
        if ($(this).scrollTop() > offset_opacity) {
            $back_to_top.addClass('cd-fade-out');
        }
    });
    $back_to_top.on('click', function (event) {
        event.preventDefault();
        $('body,html').animate({
            scrollTop: 0,
        }, scroll_top_duration);
    });
});
