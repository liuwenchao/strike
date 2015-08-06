$(function () {
    var p = null,
        swipeElem = $("#imgSwipe"),
        imgElems = swipeElem.children().eq(0).find("img"),
        liElems = swipeElem.children().eq(1).find("li"),
        maxIdx = imgElems.length - 2,
        curIdx = 1;
    new Swipe(document.getElementById("imgSwipe"), {
        startSlide: 0,
        auto: 4000,
        speed: 300,
        callback: function (idx, u) {

            liElems.removeClass("active").eq(idx).addClass("active");
            if (curIdx <= maxIdx) {
                if (idx >= 1 && idx <= maxIdx) {
                    var imgElem = imgElems.eq(idx + 1);
                    if (imgElem.length > 0) {
                        src = imgElem.attr("data-src");
                        imgElem.attr("src", src)
                    }
                }
                curIdx++;
            }
        }
    });
});
