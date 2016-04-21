// 所有header，footer的js动态

;$(function() {
  if ($('.nav').offset()) {
    var y = $('.nav').offset().top;

    $(window).scroll(function(event) {
        var top = $(window).scrollTop();
        if (top >= y) {
              $('.nav').addClass('current');
              $('.search').addClass('selected');
            } else {
              $('.nav').removeClass('current');
              $('.search').removeClass('selected');
              $('#header .search').css('margin-bottom', 0);
            }
        });
      }


  $('.nav>ul>li').hover(function() {
    $(this).find('.innav').slideDown(300);
  }, function() {
    $(this).find('.innav').slideUp(300);
  });

  $('.innav>ul>li').mouseover(function(event) {
    var n=$(this).index();
    $(this).addClass('current').siblings().removeClass('current');
    $('.innav>ol>li').eq(n).css('display', 'block').siblings().css('display', 'none');;
  });

 

  $('.news ul li:nth-child(4n)').css('margin-right', 0);
  $('.moods ul li:nth-child(4n)').css('margin-right', 0);

  // 人气商品开始
  $('.moods ul li').hover(function() {
    $(this).find('.top').stop().fadeIn(400);
  }, function() {
    $(this).find('.top').stop().fadeOut(400);
  });

  // 图片区域初始化
  $('.list-images li').eq(1).css('margin-right', '0');
  $('.list-images li').eq(4).css('margin-right', '0');

  // 侧边栏悬停效果
  $('.list-nav li').mouseover(function() {
    var num = $(this).index();
    $(this).find('.list-twoCategory').show();
    $(this).find('.list-twoCategory ul li').eq(num - 1).addClass('current').siblings().removeClass('current');
  }).mouseout(function() {
    $(this).find('.list-twoCategory').hide();
  });

 $('.list-innav li').mouseover(function() {
    var num=$(this).index();
    event.stopPropagation();
    $(this).addClass('current').siblings().removeClass('current');
    $('.list-twoCategory').eq(num).show().siblings().hide();
  });
  $('.list-twoCategory').mouseout(function(event) {
    $(this).hide();
  });

   // placehloder兼容处理
  if (!('placeholder' in document.createElement('input'))) {

    $('input[placeholder],textarea[placeholder]').each(function() {
      var that = $(this),
        text = that.attr('placeholder');
      if (that.val() === "") {
        that.val(text).addClass('placeholder');
      }
      that.focus(function() {
          if (that.val() === text) {
            that.val("").removeClass('placeholder');
          }
        })
        .blur(function() {
          if (that.val() === "") {
            that.val(text).addClass('placeholder');
          }
        })
        .closest('form').submit(function() {
          if (that.val() === text) {
            that.val('');
          }
        });
    });
  }

  // 底部效果
  $('#footer .copy p span a.last').hover(function() {
    $('#footer .copy .scan').css('display', 'block');
  }, function() {
    $('#footer .copy .scan').css('display', 'none');
  });



  // list初始化
  $('[data-items="list"]:nth-child(3n)').addClass('nth-child-three');


    // 注册页
    $('.form .password input').focus(function(event) {
      $('.form .register-fix').css('display', 'block');
    });

    // 详情页分享效果
    $('[data-share="btn"]').click(function(event) {
      $('[data-share="way"]').stop().animate({'margin-left': 20}, 500);
    });


});