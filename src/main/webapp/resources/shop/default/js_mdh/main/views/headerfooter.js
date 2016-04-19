;jQuery(document).ready(function(){
		// 用户信息
		var $headerName = $("#headerName");
		var $topName = $("#topName");

		var $goodsSearchForm = $("#goodsSearchForm");
		var $keyword = $("#goodsSearchForm input");
		var defaultKeyword = $keyword.attr('data-search');

		if ($.getUserName()) {
			$headerName.text($.getUserName());
			$topName.text($.getUserName());
			$("#login_in").show();
			$("#login_out").remove();
			$("#noLogin").remove();
			$("#isLogin").show();
		} else {
			$("#login_in").remove();
			$("#login_out").show();
			$("#isLogin").remove();
			$("#noLogin").show();
		}

		// 搜索
		$keyword.focus(function() {
			if ($.trim($keyword.val()) == defaultKeyword) {
				$keyword.val("");
			}
		});	
		$keyword.blur(function() {
			if ($.trim($keyword.val()) == "") {
				$keyword.val(defaultKeyword);
			}
		});
		$goodsSearchForm.submit(function() {
			if ($.trim($keyword.val()) == "" || $keyword.val() == defaultKeyword) {
				return false;
			}
		});

		Side({});
});

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

      this.oldShoppingId = 0;
      this.clearClick = 0;
    },

    documentEvent: function () {
      //鼠标移动到登录按钮
      $('[data-side="li"]').bind({
        mouseenter: function (event) {
        	var $fd = $(this).find('[data-side="showHide"]');
        	$fd.animate({right: 46});
      		$fd.css("visibility","visible");
        },

        mouseleave: function () {
        	var $fd = $(this).find('[data-side="showHide"]');
        	$fd.animate({right: 0});
      		$fd.css("visibility","hidden");
      	}
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