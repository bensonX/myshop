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
      this.minusPlusPost(num, 'minus', shoopingId);
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
      this.minusPlusPost(num, 'plus', shoopingId);
      this.totalPrice();
    }
  };
  // 删除产品
  ShoppingCart.fn.delClick = function (e) {
    var target = $(e.target).parents('tr');
    var shoopingId = target.attr('data-list');
    var checked = target.find('[data-tag="select"]').is(':checked');
    var self = this;
    var data = {};

    $.extend(data, {shoopingId: shoopingId}, self.options.deleteData);

    console.log("urlDeletePost: ");
    console.log(data);

    $.ajax({
      url: self.options.urlDeletePost,
      type: "POST",
      data: data,
      dataType: "json",
      cache: false,
      success: function(message) {

        console.log("message: ");
        console.log(message);

        if (message.type == "success") {
          target.remove();
          if (checked) self.totalPrice();  // 重新计算总价
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
      alert('请选择产品提交');
  };

  // 结算总价
  ShoppingCart.fn.totalPrice = function () {
    var times = 100;
    var $totalPrice = $('[data-tag="totalPrice"]');
    var count = 0;
    var price = parseFloat($totalPrice.html());
    var intPrice = parseInt(price*times);
    $('[data-tag="select"]:checked').each(function (num, context) {
      var price = $(context)
        .parents('tr')
        .find('[data-tag="priceAll"]')
        .html();
      var timesPrice = price*times;
      count += timesPrice;
    });
    $totalPrice.html((count/times).toFixed(2));

  };

  // 加减接口
  ShoppingCart.fn.minusPlusPost = function (num, type, shoopingId) {
    var self = this;
    var data = {};
    var shoopingId = shoopingId;

    $.extend(data, {num: num, type: type, shoopingId: shoopingId}, self.options.minusPlusData);

    console.log("urlMinusPlusPost: ");
    console.log(data);

    $.ajax({
      url: self.options.urlMinusPlusPost,
      type: "POST",
      data: data,
      dataType: "json",
      cache: false,
      success: function(message) {

        console.log("message: ");
        console.log(message);

        if (message.type == "success") {
          $('[data-list="'+shoopingId+'"]')
            .find('[data-tag="priceAll"]')
            .html(message.data.priceAll);
          self.totalPrice();
        }
      }
    });
  };

  // 删除接口
  ShoppingCart.fn.deletePost = function () {

  };

  window.ShoppingCart = ShoppingCart;

})(jQuery, window);