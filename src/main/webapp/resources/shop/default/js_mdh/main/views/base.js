// 所有header，footer的js动态

;$(function() {
      if ($('.nav').offset()) {
        var y = $('.nav').offset().top;

        $(window).scroll(function(event) {
            var top = $(window).scrollTop();
            if (top >= y) {
              $('.nav').addClass('current');
            } else {
              $('.nav').removeClass('current');
            }
        });
      }


      $('.nav ul li').hover(function() {
        $(this).find('.innav').stop().slideDown(300);
      }, function() {
        $(this).find('.innav').stop().slideUp(300);
      });
      // 返回顶部
      $('.fix .five').click(function(event) {
        $(this).parents('html,body').stop().animate({
          'scrollTop': '0'
        }, 300);
      });
      // 窗口固定区域开始
     $('.fix a.two').mouseover(function() {
      $('.fix div').stop().animate({'right': -396}, 300)
       $('.shopping-list').stop().animate({'right': 0}, 300);
       $('.shopping-list2').stop().animate({'right': 0}, 300);
     });

     $('.shopping-list').hover(function() {
       $('.shopping-list').stop().animate({'right': 0}, 300);
     }, function() {
       $(this).stop().animate({'right':-396},300);
     });

     $('.shopping-list2').hover(function() {
       $('.shopping-list2').stop().animate({'right': 0}, 300);
     }, function() {
       $(this).stop().animate({'right':-396},300);
     });
     
    $('.fix a.one').mouseover(function() {
      $('.fix div').stop().animate({'right': -396}, 300);
       $('.shopping-list2').stop().animate({'right': -396}, 300);
       $('.shopping-list').stop().animate({'right': -396}, 300);
      $('.fix .infix').stop().animate({'right':45},300);
      $('.fix .logged').stop().animate({'right':45},300);
    });

    $('.fix .infix').hover(function() {
       $(this).stop().animate({'right': 45}, 300);
     }, function() {
       $(this).stop().animate({'right':-120},300);
     });

    $('.fix .logged').hover(function() {
       $(this).stop().animate({'right': 45}, 300);
     }, function() {
       $(this).stop().animate({'right':-180},300);
     });

    $('.fix a.three').mouseover(function() {
       $('.shopping-list').stop().animate({'right': -396}, 300);
       $('.shopping-list2').stop().animate({'right': -396}, 300);
        $('.fix div').stop().animate({'right': -396}, 300)
       $('.fix .tell').stop().animate({'right': 45}, 300);
     });

    $('.fix .tell').hover(function() {
       $(this).stop().animate({'right': 45}, 300);
     }, function() {
       $(this).stop().animate({'right':-180},300);
     });

    $('.fix a.fore').mouseover(function() {
       $('.shopping-list').stop().animate({'right': -396}, 300);
       $('.shopping-list2').stop().animate({'right': -396}, 300);
      $('.fix div').stop().animate({'right': -396}, 300)
       $('.fix .images').stop().animate({'right': 45}, 300);
     });

    $('.fix .images').hover(function() {
       $(this).stop().animate({'right': 45}, 300);
     }, function() {
       $(this).stop().animate({'right':-396},300);
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
        var num = $(this).index();
        $(this).find('.list-twoCategory').hide();
      });

      // 购买导航开始
      // $('.goods-nav span').hover(function() {
      //   $(this).find('.goods-opt').stop().slideDown(300);
      // }, function() {
      //   $(this).find('.goods-opt').stop().slideUp(300);
      // });


      // $('.goods-opt a').click(function() {
      //   var text = $(this).html();
      //   $(this).parents('span').html(text);

      // });

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

      // list初始化
      $('[data-items="list"]:nth-child(3n)').addClass('nth-child-three');

  });

/**
 * cookie
 */
// 添加Cookie
function addCookie(name, value, options) {
  if (arguments.length > 1 && name != null) {
    if (options == null) {
      options = {};
    }
    if (value == null) {
      options.expires = -1;
    }
    if (typeof options.expires == "number") {
      var time = options.expires;
      var expires = options.expires = new Date();
      expires.setTime(expires.getTime() + time * 1000);
    }
    if (options.path == null) {
      options.path = "/";
    }
    if (options.domain == null) {
      options.domain = "";
    }
    document.cookie = encodeURIComponent(String(name)) + "=" + encodeURIComponent(String(value)) + (options.expires != null ? "; expires=" + options.expires.toUTCString() : "") + (options.path != "" ? "; path=" + options.path : "") + (options.domain != "" ? "; domain=" + options.domain : "") + (options.secure != null ? "; secure" : "");
  }
}

// 获取Cookie
function getCookie(name) {
  if (name != null) {
    var value = new RegExp("(?:^|; )" + encodeURIComponent(String(name)) + "=([^;]*)").exec(document.cookie);
    return value ? decodeURIComponent(value[1]) : null;
  }
}

// 移除Cookie
function removeCookie(name, options) {
  addCookie(name, null, options);
}

