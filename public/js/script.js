jQuery(function($) {
  $('.thanks').live('click', function() {
    $('#thanks').slideToggle("hidden");
    $('html, body').animate({ scrollTop: $('#scroll_target').offset().top });
    return false;
  });

  var $container = $('#desconf-2010 ul');

  window.rotation = setInterval(function() {
    var $videos = $container.find('li'),
        first  = $videos.eq(0),
        second = $videos.eq(1),
        third  = $videos.eq(2);
    
    first.appendTo($container);
    second.appendTo($container);
    third.appendTo($container);
  }, 8000);
});
