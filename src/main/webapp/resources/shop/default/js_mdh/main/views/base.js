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

/**
 * 右侧栏点击功能
 * @param  {[type]} $      [description]
 * @param  {[type]} window [description]
 * @return {[type]}        [description]
 */
;(function ($, window) {

  function Klass (options) {
    if (!(this instanceof Klass)) return new Klass(options);
    this.init.apply(this, arguments);
  };

  Klass.fn = Klass.prototype = {
    init: function (options) {
      this.options = options;
      this.views();
      this.documentEvent();
    },

    views: function () {

      // 侧边栏
      this.windowSize();
      // 侧边栏随窗口改变而改变
      $(window).bind('resize', this.windowSize);

      //登录
      //this.isLogin();
      //
      this.oldShoppingId = 0;
      this.clearClick = 0;
    },

    documentEvent: function () {
      //鼠标移动到登录按钮
      $('[data-side="login"]').bind({
        mouseenter: $.proxy(function () {
          if ($.checkLogin())
            this.mouseenterEvent($('[data-side="isLogin"]'), 46);
          else
            this.mouseenterEvent($('[data-side="noLogin"]'), 46);
        }, this),

        mouseleave: $.proxy(function () {
          if ($.checkLogin())
            this.mouseleaveEvent($('[data-side="isLogin"]'), -46);
          else
            this.mouseleaveEvent($('[data-side="noLogin"]'), -46);
        }, this)
      });

      //鼠标移动到登录按钮
      $('[data-side="mobile"]').bind({
        mouseenter: $.proxy(function () {
          this.mouseenterEvent($('[data-side="isMobile"]'), 46);
        }, this),

        mouseleave: $.proxy(function () {
            this.mouseleaveEvent($('[data-side="isMobile"]'), -46);
        }, this)
      });
      //鼠标移动到登录按钮
      $('[data-side="weixin"]').bind({
        mouseenter: $.proxy(function () {
          this.mouseenterEvent($('[data-side="isWeixin"]'), 46);
        }, this),

        mouseleave: $.proxy(function () {
            this.mouseleaveEvent($('[data-side="isWeixin"]'), -46);
        }, this)
      });

      //鼠标移动到登录按钮
      $('[data-side="cart"]').bind({
        click: $.proxy(function (e) {
          e.stopPropagation();
          clearTimeout(this.setTimeoutOver);
          this.setTimeoutOver = setTimeout(function () {
            
              var $isShow = $('[data-side="cart"]');
              var $isCart = $('[data-side="isCart"]');
              var $noCart = $('[data-side="noCart"]');
              var $main = $('[data-side="main"]');
              if ($isShow.attr('data-isshow') == 1) {
                if ($.checkLogin()) {
                  $isCart.css("visibility","visible");
                  $noCart.css("visibility","hidden");
                }
                else {
                  $noCart.css("visibility","visible");
                  $isCart.css("visibility","hidden");
                }

                $main.animate({right: 200});
                $isShow.attr('data-isshow', 0);
              }
              else { 
                $main.animate({right: 0});
                $isShow.attr('data-isshow', 1);
              }
          }, 50);  
        }, this)
      });

        // 点击选中所有还是不选中所有
        //$('[data-tag="selectAll"]').bind('click', $.proxy(this.selectAllClick, this));
        // 点击选中还是不选中
       // $('[data-tag="select"]').bind('click', $.proxy(this.selectClick, this));
        // 减事件
        $('[data-tag="minus"]').bind('click', $.proxy(this.minusClick, this));
        // 加事件
        $('[data-tag="plus"]').bind('click', $.proxy(this.plusClick, this));

        // 删除产品
        $('[data-tag="del"]').bind('click', $.proxy(this.delClick, this));

        $(window).bind('click', function () {
          $('[data-side="main"]').animate({right: 0});
          $('[data-side="cart"]').attr('data-isshow', 1);
        });
    },

    isLogin: function () {

    },
    // 移上去效果
    mouseenterEvent: function ($this, number) {
      $this.animate({right: number});
      $this.css("visibility","visible");
    },
    // 移出去效果 
    mouseleaveEvent: function ($this, number) {
      $this.animate({right: number,queue:true});
      $this.css("visibility","hidden");
    },

    // 点击上去的效果
    clickEvent: function ($this, number) {

      var _this = this;
      setTimeout(function () {
        $(_this).children(".tooltip").animate({right: 0,queue:true});
        $(_this).children(".tooltip").css("visibility","visible");
      }, 100);

      $(this).children(".tooltip").css("visibility","hidden");
      $(this).children(".tooltip").animate({right: -307,queue:true});
    },

    windowSize: function ($this) {
      var $main = $('[data-side="main"]');
      var $isShow = $('[data-side="isShow"]');
      var $isCart = $('[data-side="isCart"]');
      var $noCart = $('[data-side="noCart"]');
      var isShowHeight = $isShow.outerHeight();
      var windowHeight = $(window).outerHeight();
      $main.css({
        top: (windowHeight-isShowHeight)/2
      });
      var scrollTop = $(window).scrollTop();
      var offset = $main.offset();
      var offsetTop = offset.top;
      var top = offsetTop - scrollTop;
      $isCart.css({
        top: -top-92,
        height: windowHeight
      });
      $noCart.css({
        top: -top-92,
        height: windowHeight
      });

    },

    //  // 点击选中所有还是不选中所有
    // selectAllClick: function (e) {
    //   var checked = $(e.target).is(':checked');
    //   if (checked) {
    //     $('[data-data="form"]').find('[data-tag="select"]').attr({checked: 'true'});
    //   }
    //   else {
    //     $('[data-data="form"]').find('[data-tag="select"]:checked').removeAttr('checked');
    //   }
    //   this.totalPrice();
    // },
    // //点击选中还是不选中
    // selectClick: function (e) {
    //   this.totalPrice();
    // },

    // 减事件
    minusClick: function (e) {
      var $number = $(e.target).siblings('[data-tag="count"]');
      var shoopingId = $(e.target).parents('tr').attr('data-list');
      var num = parseInt($number.html());
      if (num >= 2 ) {
        $number.html(--num);
        this.minusPlusPost(num, shoopingId);
        this.totalPrice();
      }
    },
    // 加事件
    plusClick: function (e) {
      var $number = $(e.target).siblings('[data-tag="count"]');
      var shoopingId = $(e.target).parents('tr').attr('data-list');
      var num = parseInt($number.html());
      if (num > 0 ) {
        $number.html(++num);
        this.minusPlusPost(num, shoopingId);
        this.totalPrice();
      }
    },
    // 删除产品
    delClick:  function (e) {
      var target = $(e.target).parents('tr');
      var shoppingId = target.attr('data-list');
      var checked = target.find('[data-tag="select"]').is(':checked');
      var self = this;
      var data = {};

      $.extend(data, {id: shoppingId}, self.options.deleteData);

      if (this.clearClick == shoppingId)
        return false;
      this.clearClick = shoppingId;
      $.ajax({
        url: self.options.urlDeletePost,
        type: "POST",
        data: data,
        dataType: "json",
        cache: false,
        success: function(data) {
          if (data.message.type == "success") {
            target.remove();
            self.clearClick = 0;
            if (checked) self.totalPrice();  // 重新计算总价
            var list = $('[data-tag="select"]').length || 0;
            if (!list) {
              location.reload();
            }
          }
        }
      });
    },
    // 提交表单
    submitClick: function (e) {
      var $form = $('[data-data="form"]')
      var len = $form.find('[data-tag="select"]:checked').length;
      if (this.options.disabled == 1) {
        $form.find('[data-tag="select"]:checked').removeAttr('disabled');
      }

      if (len)
        $form.submit();
      else
        layer('请选择产品');
    },

    // 结算总价
    totalPrice: function () {
      var times = 100;
      var $totalPrice = $('[data-tag="totalPrice"]');
      var count = 0;
      $('[data-tag="select"]:checked').each(function (num, context) {
        var price = $(context)
          .parents('tr')
          .find('[data-tag="priceAll"]')
          .html();
        var singlePrice = parseFloat(price.substr(1));
        var timesPrice = singlePrice*times;
        count += timesPrice;
      });
      $totalPrice.html((count/times).toFixed(2));

    },

    // 加减接口
    minusPlusPost: function (num, shoppingId) {
      var self = this;
      var data = {};
      var shoppingId = shoppingId;
      var num = num;
      // 判断是同个产品
      if (!this.oldShoppingId && shoppingId == this.oldShoppingId) {
        clearTimeout(this.clickTime);
      }

      this.oldShoppingId = shoppingId;
      this.clickTime = setTimeout(function (){
        $.extend(data, {quantity: num, id: shoppingId}, self.options.minusPlusData);

        $.ajax({
          url: self.options.urlMinusPlusPost,
          type: "POST",
          data: data,
          dataType: "json",
          cache: false,
          success: function(data) {
            if (data.isLowStock) {
              layer('库存不足')
            }
            if (data.message.type == "success") {
              $('[data-list="'+shoppingId+'"]')
                .find('[data-tag="priceAll"]')
                .html('￥'+data.effectivePrice);
              self.totalPrice();
            }
          }
        });
      }, 1000);
    }



  }


  window.Side = Klass
})(jQuery, window);

