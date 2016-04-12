// 所有header，footer的js动态

;$(function() {
  if ($('.nav').offset()) {
    var y = $('.nav').offset().top;

    $(window).scroll(function(event) {
        var top = $(window).scrollTop();
        if (top >= y) {
              $('.nav').addClass('current');
              $('.search form').addClass('current');
              $('#header .search').css('margin-bottom', 50);
            } else {
              $('.nav').removeClass('current');
              $('.search form').removeClass('current');
              $('#header .search').css('margin-bottom', 0);
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

  $(".quick_links_panel li").mouseenter(function(){
    $(this).children(".mp_tooltip").animate({right :46});
    $(this).children(".mp_tooltip").css("visibility","visible");

  });
  $(".quick_links_panel li").mouseleave(function(){
    $(this).children(".mp_tooltip").css("visibility","hidden");
    $(this).children(".mp_tooltip").animate({right: -46,queue:true});
  });
 
    $(".quick_links_panel li[data-cart='shoppingcart']").mouseenter(function(){
      var _this = this;
      setTimeout(function () {
        $(_this).children(".tooltip").animate({right: 0,queue:true});
        $(_this).children(".tooltip").css("visibility","visible");
      }, 100);
    });

   $(".quick_links_panel li[data-cart='shoppingcart']").mouseleave(function(){
      $(this).children(".tooltip").css("visibility","hidden");
      $(this).children(".tooltip").animate({right: -307,queue:true});
   });

   $(".quick_links_panel li").mouseenter(function(){
     $(this).children(".wx_tooltip").animate({right: 46,queue:true});
     $(this).children(".wx_tooltip").css("visibility","visible");

   });

   $(".quick_links_panel li").mouseleave(function(){
     $(this).children(".wx_tooltip").css("visibility","hidden");
     $(this).children(".wx_tooltip").animate({right: 80,queue:true});
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
  // 购买导航开始
  // .list-twoCategory ul li
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


    // 注册页
    $('.form .password input').focus(function(event) {
      $('.form .register-fix').css('display', 'block');
    });
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

/**
 * 弹出接口api
 */

;(function (window, $) {

  function Layer (options) {
    if (!(this instanceof Layer)) return new Layer(options);
    this.init.apply(this, arguments);
  };

  Layer.prototype = {
    constructor: Layer,

    init: function (options) {
      this.options = options;

      this.views();
      this.documentEvent();
    },

    views: function () {
      if (!this.options) return false;
      this.template(this.options);
      // 弹出窗口随窗口改变
      this.windowSize();
      // 弹出窗口随窗口改变而改变
      $(window).resize(this.windowSize);

    },

    documentEvent: function () {

      // 关闭事件
      $('body').delegate('[data-popup="closeEvent"]', 'click', this.closeEvent);
    },

    template: function (context) {
      var hl = '<div class = "common-popup" data-popup="popup" >'
        +'<div class = "title clearfix" >'
          +'<h4>买德好</h4>'
          +'<strong data-popup="closeEvent">x</strong>'
        +'</div>'
        +'<div class = "context" >'
          +'<p>'+context+'</p>'
        +'</div>'
      +'</div>'
      +'<div class = "common-shielding" data-popup="shieldingLayer"></div>';

      $('body').append(hl);
    },

    closeEvent: function () {
      $('[data-popup="popup"]').remove();
      $('[data-popup="shieldingLayer"]').remove();
    },

    // 弹出窗口的位置
    windowSize: function () {
      var $wechatRefresh = $('[data-popup="popup"]');
      var width = $wechatRefresh.outerWidth();
      var height = $wechatRefresh.outerHeight();

      var windowWdith = $(window).width();
      var windowHeight = $(window).height();
      $wechatRefresh.css({
        top: (windowHeight-height)/2,
        left: (windowWdith-width)/2
      }).show();

      $('[data-popup="shieldingLayer"]').css({
        width: windowWdith,
        height: windowHeight
      }).show();
    }


  };

  window.layer = Layer;
})(window, jQuery);


/**
 * 基本功能
 */
;(function ($, window) {

  function Klass (options) {
    if (!(this instanceof Klass)) return new Klass(options);
  };

  Klass.fn = Klass.prototype = {
    constructor: constructor,

    init: function (options) {
      this.options = options;
    },
    // 收藏
    enshrine: function (options) {
      var options = options;
      $('body').delegate('[data-goods="enshrine"]', 'click', function(event) {
        event.stopPropagation();
        var id = $(event.target).attr('goods');
        console.log(event);
        $.ajax({
          url: options,
          type: "POST",
          data: {goodsId: id},
          dataType: "json",
          cache: false,
          success: function(message) {
            //$.message(message);
            layer(message);
          }
        });
        return false;
      });
    }
  };

  window.init = new Klass;
 
})(jQuery, window);

