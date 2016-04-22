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
      this.getData = false;
      this.getCartData();
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
      var _this = this;
      //鼠标移动到登录按钮
      $('[data-side="li"]').bind({
        mouseenter: function (event) {
        	var $fd = $(this).find('[data-side="showHide"]');
        	$fd.animate({right: 56});
      		$fd.css("visibility","visible");
          if ($(this).attr('data-sideGet')) {
            _this.getCartData();
          }
        },

        mouseleave: function () {
        	var $fd = $(this).find('[data-side="showHide"]');
        	$fd.animate({right: 100});
      		$fd.css("visibility","hidden");
      	}
      });
      

      // 底部效果
      $('#footer .copy p span a.last').hover(function() {
        $('#footer .copy .scan').css('display', 'block');
      }, function() {
        $('#footer .copy .scan').css('display', 'none');
      });

        // 底部鼠标移上出现二维码
      $('#footer .copy p span a.last').hover(function() {
        $('#footer .copy .scan').css('display', 'block');
      }, function() {
       $('#footer .copy .scan').css('display', 'none');
      });
      
      // 显示加减删除按钮
      $('[data-footer="cart"]').delegate('.details', 'mouseenter', function (e) {
    	  $(this).addClass('selected');
      });
      $('[data-footer="cart"]').delegate('.details', 'mouseleave', function (e) {
    	  $(this).removeClass('selected');
      })

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

    /**
     * 是否加载购物车数据
     */
    getCartData: function () {
      var _this = this;
      //如果已经加载过一次数据就不再加载购物车数据了
      if (this.getData) return;
      this.getData = true;
      $.ajax({
        url: shopxx.base+'/cart/getCartData.jhtml',
    //	url: _this.options.urlGetCart,
        data: {},
        type: 'GET',
        dataType: 'json',
        success: function (data) {
        	_this.processCart(data);
        }
      })
    },
    
    
    
    processCart: function (data) {
    	var length = data.cart.length || 0;
    	var hl= '';
    	var count = 0;
    	if (!length) return;
    	
    	for (var i = 0; i < length; i++) {
    		hl += this.template(data.cart[i]);
    		count += Number(data.cart[i]["cartItem.price"]);
    	}
    	
    	$('[data-cart="tbody"]').html(hl);
    	$('[data-footer="cart"]').find('[data-tag="totalNumber"]').html(length);
    	$('[data-footer="cart"]').find('[data-tag="totalPrice"]').html(count);
    },
    
    template: function (data) {
    	var specifications = '';
    	if (data['product.specifications'])
    		specifications = data['product.specifications'][1];
    	
    	return '<tr class="details" data-list="'+data["cartItem.id"]+'">'
	        +'<td class="first">'
	        +'<input class="a" checked disabled = "true" type="checkbox" data-tag="select" name="cartItemIds" value="'+data["cartItem.id"]+'" >'
	      +'</td>'
	      +'<td class = "img">'
	        +'<a href = "'+data["product.url"]+'" target="_blank">'
	          +'<img src="'+data["product.thumbnail"]+'"></td>'
	        +'</a>'
	      +'<td class="text">'
	        +'<a href = "'+data["product.url"]+'" class = "href" target="_blank">'
	          +'<h6>'+data["product.goods.name"]+'</h6>'
	        +'</a>'
	        +'<div class = "clearfix box">'
	          +'<strong class = "fl">'+specifications+'</strong>'
	          +'<div class = "fl num">'
	            +'<a href = "javascript:;" class = "minus fl" data-tag="minus"><i></i></a>'
	            +'<span data-tag="count" class = "fl">'+data.quantity+'</span>'
	            +'<a href = "javascript:;" class = "plus fl" data-tag="plus"><i></i></a>'
	          +'</div>'
	          +'<div class = "money fr">'
	            +'<span data-tag="priceAll">￥'+data["cartItem.price"]+'</span>'
	          +'</div>'
	        +'</div>'
	      +'</td>'
	      +'<td class="last">'
	        +'<a herf = "javascript:;" data-tag="del"></a>'
	      +'</td>'
	    +'</tr>';
    }
  }


  window.Side = Klass;
})(jQuery, window);
