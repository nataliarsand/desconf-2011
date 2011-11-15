jQuery(function($) {
  $('.thanks').live('click', function() {
    $('#thanks').slideToggle("hidden");
    $('html, body').animate({ scrollTop: $('#scroll_target').offset().top });
    return false;
  });

  var $container = $('#desconf-2010 ul');

  function startRotation() {
    window.rotation = setInterval(function() {
      var $videos = $container.find('li'),
          first  = $videos.eq(0),
          second = $videos.eq(1),
          third  = $videos.eq(2);

      first.appendTo($container);
      second.appendTo($container);
      third.appendTo($container);
    }, 8000);
  }

  startRotation();

  $('.moar-desconf-2010').click(function(e) {
    var $this = $(this);
    e.preventDefault();

    if ($this.is('.expanded')) {
      startRotation();
      $('#desconf-2010 ul').animate({'height': '220px'}, 1500);
      $this.removeClass('expanded');
      $this.find('.text').text('ver mais');
      $this.find('.arrow-down').removeClass('up');
    } else {
      clearInterval(window.rotation);
      $('#desconf-2010 ul').animate({'height': '3110px'}, 1500);
      $this.addClass('expanded');
      $this.find('.text').text('voltar');
      $this.find('.arrow-down').addClass('up');
    }
  });
});
