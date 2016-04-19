// 页面特效
$(function () {

  var $jqzoom = $('#jqzoom');
  // 放大镜
  $jqzoom.jqueryzoom({xzoom:250,yzoom:250});

  // 切换图片
  $('[data-tag="small"] li').bind('mouseover', function (event) {
    if ($(this).attr('class') != 'tb-selected' ) {
      $(this).addClass('tb-selected').siblings().removeClass('tb-selected');
      var imgsrc = $(this).find('img').attr('largeimg');
      var jqimgsrc = $(this).find('img').attr('jqimg');
      $jqzoom.find('img').attr({src: imgsrc, jqimg: jqimgsrc});
    }
  });

});

// 表单数据验证和事件
;(function ($, window) {
  // 定义构造函数
  function ShoppingForm (options) {
    if (!(this instanceof ShoppingForm)) return new ShoppingForm(options);
    this.init.apply(this, arguments);
  };

  ShoppingForm.fn = ShoppingForm.prototype;

  // 初始化
  ShoppingForm.fn.init = function (options) {
    this.options = options;
    this.views();           // 初始化视图
    this.documentClick();   // 表单事件
  };
  // 初始化视图
  ShoppingForm.fn.views = function () {
	  
	  
  };

  // 初始化事件
  ShoppingForm.fn.documentClick = function () {
    //  减产品数量
    $('[data-tag="minus"]').bind('click', this.minusProductClick);
    // 加产品数量
    $('[data-tag="plus"]').bind('click', this.plusProductClick);
    // 数量框输入
    $('[data-tag="number"]').bind('change keyup', this.numberProductClick);

  };

  // 提起表单数据
  ShoppingForm.fn.data = function () {
    return {
      arrayData: this.arrayData(),
      number: $('[data-tag="number"]').val()
    };
  };

  // 数组获取数据
  ShoppingForm.fn.arrayData = function () {
    var data = [];
    $('[data-tag="formList"] ul').each(function (e) {
      var property = $(this).attr('data-property');
      var ariaLabel;
      if (property) {
        ariaLabel = $(this).find('[aria-label]').attr('aria-label');
        data.push(property+':'+ariaLabel);
      }
    });
    return data;
  };

  // 减产品数量
  ShoppingForm.fn.minusProductClick = function () {
    var $number = $('[data-tag="number"]');
    var num = parseInt($number.val());
    if (num >= 2 ) $number.val(--num);
  };

  // 加产品数量
  ShoppingForm.fn.plusProductClick = function () {
    var $number = $('[data-tag="number"]');
    var num = parseInt($number.val());
    if (num > 0 ) $number.val(++num);
    
  };

  // 数量框输入
  ShoppingForm.fn.numberProductClick = function () {
    var num = $(this).val();
    var param = /^[1-9]{1}[0-9]*$/;

    if (!param.test(num)) {
      if (parseInt(num) < 1)
        $(this).val(1);
      else
        $(this).val(parseInt(num) || '1');
    }
  };



  window.ShoppingForm = ShoppingForm;

})(jQuery, window);


/**
 * 购物车事件和验证
 */
;(function ($, window) {
  // 定义构造函数
  function ShoppingCart (options) {
    if (!(this instanceof ShoppingCart)) return new ShoppingCart(options);
    this.init.apply(this, arguments);
  };

  ShoppingCart.fn = ShoppingCart.prototype;
  // 初始化
  ShoppingCart.fn.init = function (options) {
    this.options = options;
    this.views();
    this.documentClick();
  };
  // 隐藏一个图片做抛物线效果
  ShoppingCart.fn.views = function () {
    $('[data-tag="button"]')
      .prepend(
        $('[data-tag="small"] li:first img')
          .clone()
          .css({
            width: '0px',
            height: '0px'
          })
      );
  };

  // 事件
  ShoppingCart.fn.documentClick = function () {
    // 点击购物车
    var self = this;

    $('[data-tag="addCart"]').bind('click', $.proxy(this.clickCart, this));
  };

  // 购物车事件
  ShoppingCart.fn.clickCart = function (event) {
    var self = this;
    // 判断用户是否登录,不存在跳到用户登录页面
    if (!$.checkLogin()){    	
    	location.href = self.options.urlLogin;
    }
    $.ajax({
      url: self.options.urlCartPost,
      type: "POST",
      data: self.options.data(),
      dataType: "json",
      cache: false,
      success: function(message) {

        if (message.type == "success") {
          self.getSuccess(message);
        }
        else {
          layer(message.content);
        }
       }
    });
    return false;
  };
  // 购物车事件返回成功的数据处理
  ShoppingCart.fn.getSuccess = function (message) {
    var $headerCart = $('#headerCart');
    var $image = $('[data-tag="addCart"]').siblings('img');
    var cartOffset = $headerCart.offset();
    var imageOffset = $image.offset();
    $image.clone().css({
      width: 120,
      height: 120,
      position: "absolute",
      "z-index": 20,
      top: imageOffset.top,
      left: imageOffset.left,
      opacity: 0.8,
      border: "1px solid #dddddd",
      "background-color": "#eeeeee",
      "display": "inline-block"
    }).appendTo("body").animate({
      width: 30,
      height: 30,
      top: cartOffset.top,
      left: cartOffset.left,
      opacity: 0.2
     }, 800, function() {
      $(this).remove();
     });
     // 右边固定栏购物车显示
     $headerCart.find('span').html(message.content);
  };

  // 购物车事件返回错误的数据处理
  ShoppingCart.fn.getError = function (message, $this) {
    if (message.content == 1) {
      location.href = this.options.urlLogin;
    }
    else {
      console.log(message.content);
    }
  };

  window.ShoppingCart = ShoppingCart;
})(jQuery, window);

/**
 * 立即购买事件和验证
 */
;(function ($, window) {
  // 定义构造函数
  function BuyImmediately (options) {
    if (!(this instanceof BuyImmediately)) return new BuyImmediately(options);
    this.init.apply(this, arguments);
  };

  BuyImmediately.fn = BuyImmediately.prototype;
  // 初始化
  BuyImmediately.fn.init = function (options) {
    this.options = options;
    this.documentClick();
  };


  // 事件
  BuyImmediately.fn.documentClick = function () {
    // 点击立即购买
    var self = this;

    $('[data-tag="buyImmediately"]').bind('click', $.proxy(this.clickBuyImmediately, this));
  };

  // 立即购买事件
  BuyImmediately.fn.clickBuyImmediately = function (event) {
    var self = this;
    var data = self.options.data();
    // 判断用户是否登录,不存在跳到用户登录页面
    if (!$.checkLogin())
    {
    	location.href = self.options.urlLogin;    	
    }
    
    $('#productId').val(data.productId);
    $('#quantity').val(data.quantity);
    
    
    $(event.target).parents('form').submit();
  };

  // 立即购买事件返回错误的数据处理
  BuyImmediately.fn.getError = function (message, $this) {
    if (message.content == 1) {
      location.href = this.options.urlLogin;
    }
    else {
      layer(message.content);
    }
  };

  window.BuyImmediately = BuyImmediately;
})(jQuery, window);