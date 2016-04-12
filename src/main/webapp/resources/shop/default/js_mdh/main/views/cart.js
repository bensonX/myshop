/**
 * 购物车页面js
 */
;(function ($, window) {

  // 购物车
  function ShoppingCart (options) {
    if (!(this instanceof ShoppingCart)) return new ShoppingCart(options);
    this.init.apply(this, arguments);
  };

  ShoppingCart.fn = ShoppingCart.prototype;
  // 初始化
  ShoppingCart.fn.init = function (options) {
    this.options = options;
    this.documentClick();
    this.oldShoppingId = 0;
    this.clearClick = 0;

    if (this.options.disabled == 1)
      this.views();
  };

  ShoppingCart.fn.views = function () {
    $('[data-data="form"]')
      .find('input[type="checkbox"]')
      .attr({
        checked: 'checked',
        disabled: 'disabled'
      });
  };

  //绑定事件
  ShoppingCart.fn.documentClick = function () {
    // 点击选中所有还是不选中所有
    $('[data-tag="selectAll"]').bind('click', $.proxy(this.selectAllClick, this));
    // 点击选中还是不选中
    $('[data-tag="select"]').bind('click', $.proxy(this.selectClick, this));
    // 减事件
    $('[data-tag="minus"]').bind('click', $.proxy(this.minusClick, this));
    // 加事件
    $('[data-tag="plus"]').bind('click', $.proxy(this.plusClick, this));

    // 删除产品
    $('[data-tag="del"]').bind('click', $.proxy(this.delClick, this));

    // 提交表单
    $('[data-tag="submit"]').bind('click', $.proxy(this.submitClick, this));
  };

  // 点击选中所有还是不选中所有
  ShoppingCart.fn.selectAllClick = function (e) {
    var checked = $(e.target).is(':checked');
    if (checked) {
      $('[data-data="form"]').find('[data-tag="select"]').attr({checked: 'true'});
    }
    else {
      $('[data-data="form"]').find('[data-tag="select"]:checked').removeAttr('checked');
    }
    this.totalPrice();
  };
  //点击选中还是不选中
  ShoppingCart.fn.selectClick = function (e) {
    this.totalPrice();
  };

  // 减事件
  ShoppingCart.fn.minusClick = function (e) {
    var $number = $(e.target).siblings('[data-tag="count"]');
    var shoopingId = $(e.target).parents('tr').attr('data-list');
    var num = parseInt($number.html());
    if (num >= 2 ) {
      $number.html(--num);
      this.minusPlusPost(num, shoopingId);
      this.totalPrice();
    }
  };
  // 加事件
  ShoppingCart.fn.plusClick = function (e) {
    var $number = $(e.target).siblings('[data-tag="count"]');
    var shoopingId = $(e.target).parents('tr').attr('data-list');
    var num = parseInt($number.html());
    if (num > 0 ) {
      $number.html(++num);
      this.minusPlusPost(num, shoopingId);
      this.totalPrice();
    }
  };
  // 删除产品
  ShoppingCart.fn.delClick = function (e) {
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
      success: function(message) {
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
  };
  // 提交表单
  ShoppingCart.fn.submitClick = function (e) {
    var $form = $('[data-data="form"]')
    var len = $form.find('[data-tag="select"]:checked').length;
    if (len)
      $form.submit();
    else
      layer('请选择产品');
  };

  // 结算总价
  ShoppingCart.fn.totalPrice = function () {
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

  };

  // 加减接口
  ShoppingCart.fn.minusPlusPost = function (num, shoppingId) {
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
  };

  window.ShoppingCart = ShoppingCart;

})(jQuery, window);