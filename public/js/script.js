jQuery(function($) {
  $('.thanks').live('click', function() {
    $('#thanks').slideToggle("hidden");
    $('html, body').animate({ scrollTop: $('#scroll_target').offset().top });
    return false;
  });


  function pumpDown() {
    $('.signup-dude a').animate(
        {width: "-=3px", height: "-=3px", paddingLeft: '0px'},
        pumpUp
    )
  }

  function pumpUp() {
    $('.signup-dude a').animate(
        {width: "+=3px", height: "+=3px", paddingLeft: '2px'},
        pumpDown
    )
  }
  $('.signup-dude a, .registry_now').click(function() {
    $('.speaker-registration form').submit();
    return false;
  });
  pumpUp();

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


  var runcowbell;
  var cowbell = new Audio('/audio/cowbell.mp3')
  cowbell.loop = true;
  cowbell.preload = true;
  cowbell.moar = function() {
    cowbell.currentTime=0;
    cowbell.play();
  }
  window.moarCowbell = function() {
    $('#moarcowbell').show();
    cowbell.moar();
    runcowbell = setInterval(function() { cowbell.moar(); }, 6400);
    setTimeout(function() {
      $(document).unbind('click.moar').bind('click.moar', function(e) {
        var t = $(e.target);
        var isMoar = t.is('#moarcowbell') || (t.parents('#moarcowbell').length != 0);

        if (!isMoar) lessCowbell();
      })
    }, 1);
  }
  window.lessCowbell = function() {
    cowbell.pause();
    clearInterval(runcowbell);
    $('#moarcowbell').fadeOut();
  }

  if (window.location.hash.toString().match(/mmoar-cowbell/)) 
    setTimeout(function() { moarCowbell(); }, 2000);
});
