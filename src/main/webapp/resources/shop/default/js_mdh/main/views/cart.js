;(function ($, window) {

	  // 购物车
	  function SideCart (options) {
	    if (!(this instanceof SideCart)) return new SideCart(options);
	    this.init.apply(this, arguments);
	  };

	  SideCart.fn = SideCart.prototype;
	  // 初始化
	  SideCart.fn.init = function (options) {
	    this.options = options;
	    this.$el = $(this.options.el);
	    console.log(this.$el);
	    this.documentClick();
	    this.oldShoppingId = 0;
	    this.clearClick = 0;
	    
	    if (this.options.disabled == 1)
	      this.views();
	  };

	  SideCart.fn.views = function () {
		 this.$el.find('[data-data="form"]')
	      .find('input[type="checkbox"]')
	      .attr({
	        checked: 'checked',
	        disabled: 'disabled'
	      });
	    this.totalPrice();
	  };

	  //绑定事件
	  SideCart.fn.documentClick = function () {
	    // 点击选中所有还是不选中所有
		  this.$el.find('[data-tag="selectAll"]').bind('click', $.proxy(this.selectAllClick, this));
	    // 点击选中还是不选中
		  this.$el.delegate('[data-tag="select"]','click', $.proxy(this.selectClick, this));
	    // 减事件
		  this.$el.delegate('[data-tag="minus"]','click', $.proxy(this.minusClick, this));
	    // 加事件
		  this.$el.delegate('[data-tag="plus"]','click', $.proxy(this.plusClick, this));

	    // 删除产品
		  this.$el.delegate('[data-tag="del"]','click', $.proxy(this.delClick, this));

	    // 提交表单
		  this.$el.find('[data-tag="submit"]').bind('click', $.proxy(this.submitClick, this));
	  };

	  // 点击选中所有还是不选中所有
	  SideCart.fn.selectAllClick = function (e) {
	    var checked = $(e.target).is(':checked');
	    if (checked) {
	    	this.$el.find('[data-data="form"]').find('[data-tag="select"]').attr({checked: 'true'});
	    }
	    else {
	    	this.$el.find('[data-data="form"]').find('[data-tag="select"]:checked').removeAttr('checked');
	    }
	    this.totalPrice();
	  };
	  //点击选中还是不选中
	  SideCart.fn.selectClick = function (e) {
	    this.totalPrice();
	  };

	  // 减事件
	  SideCart.fn.minusClick = function (e) {
	    var $number = $(e.target).parents('tr').find('[data-tag="count"]');
	    var shoopingId = $(e.target).parents('tr').attr('data-list');
	    var num = parseInt(Number($number.html()));
	    if (num >= 2 ) {
	      $number.html(--num);
	      this.minusPlusPost(num, shoopingId);
	      this.totalPrice();
	    }
	  };
	  // 加事件
	  SideCart.fn.plusClick = function (e) {
		 
	    var $number = $(e.target).parents('tr').find('[data-tag="count"]');
	    var shoopingId = $(e.target).parents('tr').attr('data-list');
	    var num = parseInt(Number($number.html()));
	    console.log($(e.target));
	    if (num > 0 ) {
	      $number.html(++num);
	      this.minusPlusPost(num, shoopingId);
	      this.totalPrice();
	    }
	  };
	  // 删除产品
	  SideCart.fn.delClick = function (e) {
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
	          var list = self.$el.find('[data-tag="select"]').length || 0;
	          if (!list) {
	            location.reload();
	          }
	        }
	      }
	    });
	  };
	  // 提交表单
	  SideCart.fn.submitClick = function (e) {
	    var $form = this.$el.find('[data-data="form"]')
	    var len = $form.find('[data-tag="select"]:checked').length;
	    if (this.options.disabled == 1) {
	      $form.find('[data-tag="select"]:checked').removeAttr('disabled');
	    }

	    if (len)
	      $form.submit();
	    else
	      layer('请选择产品');
	  };

	  // 结算总价
	  SideCart.fn.totalPrice = function () {
	    var times = 100;
	    var $totalPrice = this.$el.find('[data-tag="totalPrice"]');
	    var count = 0;
	    this.$el.find('[data-tag="select"]:checked').each(function (num, context) {
	      var price = $(context)
	        .parents('tr')
	        .find('[data-tag="priceAll"]')
	        .html();
	      var singlePrice = parseFloat(price.substr(1));
	      var timesPrice = singlePrice*times;
	      count += timesPrice;
	    });
	    $totalPrice.html('￥'+(count/times).toFixed(2));

	  };

	  // 加减接口
	  SideCart.fn.minusPlusPost = function (num, shoppingId) {
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
	        	console.log(data);
	          if (data.isLowStock) {
	            layer('库存不足')
	          }
	          if (data.message.type == "success") {
	        	 self.$el.find('[data-list="'+shoppingId+'"]')
	              .find('[data-tag="priceAll"]')
	              .html('￥'+data.effectivePrice);
	            self.totalPrice();
	          }
	        }
	      });
	    }, 1000);
	  };

	  window.SideCart = SideCart;

})(jQuery, window);