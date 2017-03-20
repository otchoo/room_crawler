$(document).on("turbolinks:load", function () {
  $(".list-photos").magnificPopup({
    delegate: "a",
    type: "image",
    closeOnContentClick: false,
    closeBtnInside: false,
    image: {
      verticalFit: true,
      titleSrc: function(item) {
        return item.el.attr("title");
      }
    },
    gallery: {
      enabled: true
    },
    zoom: {
      enabled: true,
      duration: 300,
      opener: function(element) {
        return element.find("img");
      }
    }
  });
});
