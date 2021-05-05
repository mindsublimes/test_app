$(document).ready(function() {
  $('.change-language').on("click", function(){
    locale = $(this).val()
    debugger
    $.ajax({
      url: "/news_letters/change_language",
      type: "POST",
      dataType: "json",
      data: {locale : locale}
    });
  })
})
