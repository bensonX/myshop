/**
 * 获取地址
 */

;
(function($, window) {

  function Klass(options) {
    if (!(this instanceof Klass)) return new Klass(options);
  };

  Klass.prototype = {
    constructor: Klass,

    initData: [{
      "name": "北京市",
      "value": 1
    }, {
      "name": "天津市",
      "value": 18
    }, {
      "name": "河北省",
      "value": 35
    }, {
      "name": "山西省",
      "value": 219
    }, {
      "name": "内蒙古自治区",
      "value": 350
    }, {
      "name": "辽宁省",
      "value": 465
    }, {
      "name": "吉林省",
      "value": 580
    }, {
      "name": "黑龙江省",
      "value": 650
    }, {
      "name": "上海市",
      "value": 792
    }, {
      "name": "江苏省",
      "value": 810
    }, {
      "name": "浙江省",
      "value": 924
    }, {
      "name": "安徽省",
      "value": 1026
    }, {
      "name": "福建省",
      "value": 1148
    }, {
      "name": "江西省",
      "value": 1243
    }, {
      "name": "山东省",
      "value": 1355
    }, {
      "name": "河南省",
      "value": 1511
    }, {
      "name": "湖北省",
      "value": 1688
    }, {
      "name": "湖南省",
      "value": 1805
    }, {
      "name": "广东省",
      "value": 1942
    }, {
      "name": "广西壮族自治区",
      "value": 2085
    }, {
      "name": "海南省",
      "value": 2210
    }, {
      "name": "重庆市",
      "value": 2237
    }, {
      "name": "四川省",
      "value": 2276
    }, {
      "name": "贵州省",
      "value": 2481
    }, {
      "name": "云南省",
      "value": 2579
    }, {
      "name": "西藏自治区",
      "value": 2725
    }, {
      "name": "陕西省",
      "value": 2807
    }, {
      "name": "甘肃省",
      "value": 2925
    }, {
      "name": "青海省",
      "value": 3026
    }, {
      "name": "宁夏回族自治区",
      "value": 3078
    }, {
      "name": "新疆维吾尔自治区",
      "value": 3106
    }, {
      "name": "台湾省",
      "value": 3220
    }, {
      "name": "香港特别行政区",
      "value": 3221
    }, {
      "name": "澳门特别行政区",
      "value": 3222
    }],

    init: function(options) {
      if (!options) return false;
      this.processing(options);

      this.views();
      this.documentEvent();
    },
    // 出来接口数据
    processing: function(options) {
      if (typeof options != 'object') return false;
      for (var k in options) this[k] = options[k];
    },
    // 初始化视图
    views: function() {
      var data = this.initData;
      this.template(this.province, data);
    },
    // 初始化事件
    documentEvent: function() {

      $('body').delegate(this.province, 'change', $.proxy(this.provinceEvent, this));
      $('body').delegate(this.city, 'change', $.proxy(this.cityEvent, this));
      $('body').delegate(this.town, 'change', $.proxy(this.townEvent, this));
    },

    provinceEvent: function(e) {
      var e = e;
      $(this.city).find('option:nth-child(n+2)').remove();
      $(this.town).find('option:nth-child(n+2)').remove();
      var selected = null;

      if (typeof e == 'number') {
        selected = e;
        $(this.province).find('[value="' + e + '"]').attr('selected', true);
      } else {
        selected = $(this.province).find('option:selected').val();
        $(this.province).attr('province', selected);
      }

      var num = selected || null;
      var _this = this;

      if (!num) {
        return false;
      }

      this.ajaxGet(num, function(data) {
        //return false;
        _this.template(_this.city, data);
        $(_this.city).removeAttr('disabled');
        if (typeof e == 'number') {
          $(_this.city).find('[value="' + $(_this.city).attr("city") + '"]').attr('selected', true);
        }
      });
    },

    cityEvent: function(e) {

      var e = e;

      $(this.town).find('option:nth-child(n+2)').remove();

      var selected = null;

      if (typeof e == 'number') {
        selected = $(this.city).attr('city');
      } else {
        selected = $(this.city).find('option:selected').val();
        $(this.city).attr('city', selected);
      }
      var num = selected || null;
      var _this = this;

      if (!num) {
        return false;
      }
      this.ajaxGet(num, function(data) {
        _this.template(_this.town, data);
        $(_this.town).removeAttr('disabled');
        if (typeof e == 'number') {
          $(_this.town).find('[value="' + $(_this.town).attr("town") + '"]').attr('selected', true);
        }
      });
    },

    townEvent: function(e) {
      var e = e;
      var selected = null

      selected = $(this.town).find('option:selected').val();
      $(this.town).attr('town', selected);
    },

    ajaxGet: function(num, callback) {
      var num = num || null;
      var callback = callback;
      $.ajax({
        url: this.urlPost,
        type: 'GET',
        data: {
          parentId: num
        },
        dataType: 'json',
        cache: false,
        success: function(data) {
          callback(data);
        }
      })
    },

    template: function(obj, data) {
      for (var i = 0, len = data.length; i < len; i++) {
        $(obj).append('<option value="' + data[i].value + '">' + data[i].name + '</option>');
      }
    }
  };

  Klass.provinceEvent = Klass.prototype.provinceEvent;
  Klass.cityEvent = Klass.prototype.cityEvent;
  Klass.townEvent = Klass.prototype.townEvent;

  window.selectCity = new Klass;

})(jQuery, window);


/**
 * 地址验证和一些与地址有关的效果
 * addressValidation
 */

;
(function($, window) {

  // 购物车
  function Klass(options) {
    if (!(this instanceof Klass)) return new Klass(options);
    this.init.apply(this, arguments);
  };

  Klass.fn = Klass.prototype;
  // 初始化
  Klass.fn.init = function(options) {
    this.options = options;
    this.views();
    this.documentClick();

    // 防止快速多次提交数据默认值
    this.isAddPost = false;
    this.isChangePerform = false;
  };

  // 初始化视图

  Klass.fn.views = function () {
  	// document
  	this.$userName = $('[data-tag="userName"]');
  	this.$province = $('[data-tag="province"]');
  	this.$city = $('[data-tag="city"]');
  	this.$address = $('[data-tag="address"]');
  	this.$idCard = $('[data-tag="idCard"]');
  	this.$mobile = $('[data-tag="mobile"]');
  	this.$town = $('[data-tag="town"]');
  	this.$addressSubmit = $('[data-tag="addressSubmit"]');
  	this.addAddress = $('[data-tag="addAddress"]');
  	this.popupClose = $('[data-tag="popupClose"]');
  	this.$isDefault = $('[data-tag="isDefault"]');

  	this.isShowAddress();

  };

  //绑定事件
  Klass.fn.documentClick = function() {
    // 显示添加地址栏
    this.addAddress.bind('click', $.proxy(this.addAddressClick, this));

    // 关闭弹出框
    this.popupClose.bind('click', $.proxy(this.closeClick, this));

    //  绑定验证用户名失去焦点事件
    this.$userName.bind('blur', $.proxy(this.checkUserName, this));
    // 选择省份
    this.$province.bind('click', $.proxy(this.checkProvince, this));

    // 绑定验证地址事件
    this.$address.bind('blur', $.proxy(this.checkAddress, this));

    // 绑定身份证验证事件
    this.$idCard.bind('blur', $.proxy(this.checkIdCard, this));

    // 绑定手机号验证事件
    this.$mobile.bind('blur', $.proxy(this.checkMobile, this));

    // 地址提交事件
    this.$addressSubmit.bind('click', $.proxy(this.addressSubmitClick, this));

    // 设置默认地址
    $('[data-tag="butAddress"]').delegate('[data-address="default"]', 'click', $.proxy(this.defaultClick, this));

    // 删除地址
    $('[data-tag="butAddress"]').delegate('[data-address="delete"]', 'click', $.proxy(this.deleteClick, this));

    // 编辑地址
    $('[data-tag="butAddress"]').delegate('[data-address="edit"]', 'click', $.proxy(this.editClick, this));

    // 左右滚动
    $('[data-tag="scrollLeft"]').bind('click', $.proxy(this.scrollLeftClick, this));
    $('[data-tag="scrollRight"]').bind('click', $.proxy(this.scrollRightClick, this));

    // 提交表单绑定事件
    $('[data-tag="formSubmit"]').bind('click', $.proxy(this.formSubmit, this));
  };

  // 是否显示地址输入框
  Klass.fn.isShowAddress = function() {
    // 显示收货地址还是显示输入地址
    var $addressForm = $('[data-tag="addressForm"]'),
      $butAddress = $('[data-tag="butAddress"]');
    // 如果不存在地址显示
    var isShow = $('[data-address="items"] li').length || 0;
    if (isShow < 1) {
      $addressForm.removeClass('dn layer');
      $butAddress.addClass('dn');
    } else {
      $butAddress.removeClass('dn');
      $addressForm.addClass('dn');
      this.itemsWidth();
    }
  };

  // 修改items的框
  Klass.fn.itemsWidth = function () {
  	var $items = $('[data-address="items"]');
  	var liLen = $items.find('li').length;
  	var liWdith = $items.find('li').outerWidth();
  	$items.css({
  		width: (liWdith+10)*liLen
  	})
  };

  // 用户姓名验证
  Klass.fn.checkUserName = function() {
    this.prompt('username', false);
    var patternUser = /^[\s\S]{2,60}$/;
    var user = $.trim(this.$userName.val()) || '';
    if (!user || !patternUser.test(user)) {
      this.prompt('username', true, '请输入正确的用户名(2-20字符)');
      return false;
    }
    return true;
  };

  // 省验证
  Klass.fn.checkProvince = function() {
    this.prompt('province', false);
    var province = $.trim(this.$province.find(':selected').html());
    if (!province || province == "所在省份") {
      this.prompt('province', true, '请选择省份');
      return false;
    }
    return true;
  };

  // 详细地址验证
  Klass.fn.checkAddress = function() {
    this.prompt('address', false);
    var patternAddress = /^[\s\S]{5,60}$/;
    var address = $.trim(this.$address.val()) || '';
    if (!address || !patternAddress.test(address)) {
      this.prompt('address', true, '请输入正确的地址，5-60个字');
      return false;
    }
    return true;
  };
  // 手机号验证
  Klass.fn.checkMobile = function() {
    this.prompt('mobile', false);
    var patternMobile = /^1[3|4|5|7|8|9]{1}\d{9}$/;
    var mobile = $.trim(this.$mobile.val()) || '';
    if (!mobile || !patternMobile.test(mobile)) {
      this.prompt('mobile', true, '请输入正确的手机号');
      return false;
    }
    return true;
  };
  // 身份证验证
  Klass.fn.checkIdCard = function() {
    this.prompt('idcard', false);
    var idCard = $.trim(this.$idCard.val()) || '';

    if (!idCard) {
      this.prompt('idcard', true, '请输入正确的身份证号码');
      return false;
    }
    //15位和18位身份证号码的正则表达式
    var regIdCard = /^(^[1-9]\d{7}((0\d)|(1[0-2]))(([0|1|2]\d)|3[0-1])\d{3}$)|(^[1-9]\d{5}[1-9]\d{3}((0\d)|(1[0-2]))(([0|1|2]\d)|3[0-1])((\d{4})|\d{3}[Xx])$)$/;

    //如果通过该验证，说明身份证格式正确，但准确性还需计算
    if (regIdCard.test(idCard)) {
      if (idCard.length == 18) {
        var idCardWi = new Array(7, 9, 10, 5, 8, 4, 2, 1, 6, 3, 7, 9, 10, 5, 8, 4, 2); //将前17位加权因子保存在数组里
        var idCardY = new Array(1, 0, 10, 9, 8, 7, 6, 5, 4, 3, 2); //这是除以11后，可能产生的11位余数、验证码，也保存成数组
        var idCardWiSum = 0; //用来保存前17位各自乖以加权因子后的总和
        for (var i = 0; i < 17; i++) {
          idCardWiSum += idCard.substring(i, i + 1) * idCardWi[i];
        }

        var idCardMod = idCardWiSum % 11; //计算出校验码所在数组的位置
        var idCardLast = idCard.substring(17); //得到最后一位身份证号码

        //如果等于2，则说明校验码是10，身份证号码最后一位应该是X
        if (idCardMod == 2) {
          if (idCardLast == "X" || idCardLast == "x") {
            return true;
          } else {
            this.prompt('idcard', true, '请输入正确的身份证号码');
            return false;
          }
        } else {
          //用计算出的验证码与最后一位身份证号码匹配，如果一致，说明通过，否则是无效的身份证号码
          if (idCardLast == idCardY[idCardMod]) {
            return true;
          } else {
            this.prompt('idcard', true, '请输入正确的身份证号码');
            return false;
          }
        }
      }
    } else {
      this.prompt('idcard', true, '请输入正确的身份证号码');
      return false;
    }
  };

  // 添加地址

  Klass.fn.addAddressClick = function () {
	if ($('[data-address="items"] li').length >= 4) {
  		layer('不能超过四个地址，请修改或删除再添加地址');
  		return false;
  	}
  	// 弹出窗口随窗口改变
    this.windowSize();
    // 弹出窗口随窗口改变而改变
    $(window).bind('resize', this.windowSize);

    $('[data-tag="title"]').html('新增地址');
  };

  // 弹出窗口的位置
  Klass.fn.windowSize = function() {
      var $addressForm = $('[data-tag="addressForm"]');
      var width = $addressForm.outerWidth();
      var height = $addressForm.outerHeight();

      var windowWdith = $(window).width();
      var windowHeight = $(window).height();
      $addressForm.css({
        top: (windowHeight - height) / 2,
        left: (windowWdith - width) / 2,
      }).addClass('layer').removeClass('dn');

      $('[data-tag="shieldingLayer"]').css({
        width: windowWdith,
        height: windowHeight
      }).show();
    },

    // 关闭窗口
    Klass.fn.closeClick = function() {
      var $addAddressForm = $('[data-tag="addressForm"]');
      $addAddressForm.find('input, textarea').val('');
      this.$province.removeAttr('province').find('option:selected').removeAttr('selected');
      this.$city.removeAttr('city').find('option:nth-child(n+2)').remove();
      this.$town.removeAttr('town').find('option:nth-child(n+2)').remove();
      $addAddressForm.addClass('dn');
      $('[data-tag="shieldingLayer"]').hide();
      $(window).unbind('resize', this.windowSize);
      this.itemsWidth();
    };

  /**
   * 提示错误
   * @param  {[type]} type    [属于那个doc， mobile，address]
   * @param  {[type]} status  [隐藏，还是显示]
   * @param  {[type]} context [需要显示的错误]
   * 
   */
  Klass.fn.prompt = function(type, status, context) {
    var $error = $('[data-tag="error"]');
    var isHidden = $error.hasClass('hidden');
    var isType = $error.attr('data-type');
    if ((!status && type == isType) || type == "all") {
      $error
        .addClass('hidden')
        .removeAttr('data-type')
        .find('span')
        .html('');
    }

    if (status && (!isType || type == isType)) {
      $error
        .removeClass('hidden')
        .attr('data-type', type)
        .find('span')
        .html(context);
    }
  };

  // 新增，添加地址提交
  Klass.fn.addressSubmitClick = function () {
  	var self = this;
  	var url = this.options.urlAddAddress;
  	var postData = this.options.addAddressData();
  	var id = $('[data-tag="addressForm"]').attr('data-id');
  	// 验证输入是否正确
  	if (!this.checkUserName() || !this.checkProvince() 
  		|| !this.checkAddress() || !this.checkIdCard() 
  		|| !this.checkMobile()) return false;

  	if (self.isAddPost) return false;

  	if ($.trim(id)) {
  		url = this.options.urlEditAddress;
  		postData = this.options.editAddressData();
  	}
  	self.isAddPost = true;
 
  	$.ajax({
  		url: url,
  		type: "POST",
  		data: postData,
  		dataType: "json",
  		cache: false,
  		success: function (data) {
  			console.log(data);
  			self.isAddPost = false;
  			if (data.message.type == 'success') {
  				self.getAddAddressSuccess(data, id);
  				self.isShowAddress();
  			}
  			else {
  				self.prompt('all', true, 'message.content');
  			}
  		}
  	})
  };

  // 数据返回后成功处理,添加
  Klass.fn.getAddAddressSuccess = function (context, id) {
	
    var isSelected = context.isDefault ? 'selected' : "";
  	var hl = '<li class="fl '+isSelected+'" data-id = "'+context.id+'">'
						+'<p class="information">'+(context.consignee || '')
							+'<span class="fr">'+(context.phone || '')+'</span>'
						+'</P>'
            +'<strong>'+(context.cardId || '')+'</strong>'
						+'<em>'+(context.areaName || '')+'<br />'+(context.address || '')+'</em>'
						+'<p class="about">'
							+'<a href="javascript:;" class = "default" data-address="default">默认地址</a>'
							+'<a class="editor" href="javascript:;" data-address="edit">编辑</a>'
							+'<a href="javascript:;" data-address="delete">删除</a>'
						+'</p>'
					+'</li>';
		if (isSelected && id) {
			$('[data-tag="butAddress"]').find('[data-id="'+id+'"]').remove();
			$('[data-tag="addressForm"]').removeAttr('data-id');
		}
		if (isSelected) {
			$('[data-address="items"]').find('li').removeClass('selected');
			$('[data-address="items"]').prepend(hl);
			$('[data-address="items"]').css({
				left: 0
			});
		} else {
			$('[data-address="items"]').append(hl);
		}
		
		// 关闭弹出框
		this.closeClick();
  };

  // 设置默认的地址
  Klass.fn.defaultClick = function (e) {
  	var self = this;
  	var $target = $(e.target).parents('[data-id]');
  	var isChange = $target.hasClass('selected');
  	if (isChange) return false;
  	if (self.isChangePerform) return false;
  	var posData = {
  		id: $target.attr('data-id')
  	}
  	self.isChangePerform = true;

  	$.ajax({
  		url: this.options.urlDefaultAddressPost,
  		type: "POST",
  		data: posData,
  		dataType: "json",
  		cache: false,
  		success: function(data){
  			console.log(data);
  			self.isChangePerform = false;
  			if (data.message.type == 'success') {
  				$target
  					.addClass('selected')
  					.siblings('li')
  					.removeClass('selected');
  				$('[data-address="items"]').prepend($target.clone());
  				$target.remove();
  				$('[data-address="items"]').css({
  					left: 0
  				})
  			}
  			else {
  				layer('设置默认的地址失败');
  			}
  		}
  	});

  };

  // 删除地址
  Klass.fn.deleteClick = function (e) {
  	var self = this;
  	var $target = $(e.target).parents('[data-id]');
  	if (self.isDeletePerform) return false;

  	var data = {
  		id: $target.attr('data-id')
  	}
  	self.isDeletePerform = true;
  	$.ajax({
  		url: this.options.urlDeleteAddressPost,
  		type: "POST",
  		data: data,
  		dataType: "json",
  		cache: false,
  		success: function (data) {
  			self.isDeletePerform = false;
  			if (data.type == 'success') {
  				$target.remove();
  				self.isShowAddress();
  			}
  			else {
  				layer('删除地址失败');
  			}
  		}
  	})
  };

  // 编辑
  Klass.fn.editClick = function (e) {
  	var self = this;
  	var $target = $(e.target).parents('[data-id]');
  	var id = $target.attr('data-id');
  	$.ajax({
  		url: this.options.urlEditPost,
  		type: "POST",
  		data: {id: id},
  		dataType: "json",
  		cache: false,
  		success: function (data) {
  			if (data.message.type == 'success') {
  				self.editViews(data);
  	  			// 弹出窗口随窗口改变
  			    self.windowSize();
  			    // 弹出窗口随窗口改变而改变
  			    $(window).resize(self.windowSize);
  			    $('[data-tag="title"]').html('编辑地址');
  			}
  			else {
  				layer('获取编辑地址失败');
  			}
  		}
  	});
  };

  Klass.fn.editViews = function (data) {
	 console.log(data);
	var area = JSON.parse(data.area);
	var province = area.pop();
	var city = area.pop();
	var town = area.pop();
  	$('[data-tag="addressForm"]').attr('data-id', data.id);
  	this.$userName.val(data.consignee);
 
  	this.$province.attr('province', Number(province.areaId));
  	selectCity.provinceEvent(Number(province.areaId));
  	if (city) {
  		this.$city.attr('city', Number(city.areaId));
  		selectCity.cityEvent(Number(city.areaId));
  	}
  	if (town) {
  		this.$town.attr('town', Number(town.areaId));
  	}
  	this.$address.val(data.address);
  	this.$idCard.val(data.cardId);
  	this.$mobile.val(data.phone);
  	if (data.isDefault)
  		this.$isDefault.attr('checked', 'checked');
  };
  // 地址栏左滑动
  Klass.fn.scrollLeftClick = function () {
  	
  	var $items = $('[data-address="items"]');
  	var $scroll = $('[data-tag="scroll-address"]');
  	var width = $items.width();
  	var positionWidth = $items.position();
  	var scrollWidth = $scroll.width();
  	var liWidth = $items.find('li').outerWidth()+10;
  	if (width <= scrollWidth) return false;
  	if (positionWidth.left >= 0) return false;
  	$items.css({
  		'left': positionWidth.left+liWidth
  	});
  };
  // 地址栏右滑动
  Klass.fn.scrollRightClick = function () {
	  console.log('0000');
	  var $items = $('[data-address="items"]');
  	var $scroll = $('[data-tag="scroll-address"]');
  	var width = $items.width();
  	var positionWidth = $items.position();
  	var scrollWidth = $scroll.width();
  	var liWidth = $items.find('li').outerWidth()+10;
  	if (width <= scrollWidth) return false;
  	if (-positionWidth.left+scrollWidth >= width) return false;
  	$items.css({
  		'left': positionWidth.left-liWidth
  	});
  	
  };

  // 提交表单
  Klass.fn.formSubmit = function (e) {
  	var self = this;
  	var addressId = $('[data-address="items"] li.selected').attr("data-id");
  	var note = $('[data-tag="note"]').val();
  	if (!addressId) {
  		layer('请填写/设置默认地址');
  		return false;
  	}
  	else
  		$('[data-tag="inputAddressId"]').val(addressId);

  	if (note)
  		$('[data-tag="inputNote"]').val(note);

  	//var dataPost = $(e.target).parents('form').serialize();
    $(e.target).parents('form').attr('action', self.options.urlSubmitPost);
    $(e.target).parents('form').submit();
  	// $.ajax({
  	// 	url: self.options.urlSubmitPost,
  	// 	type: "POST",
  	// 	data: dataPost,
  	// 	dataType: "json",
  	// 	cache: false,
  	// 	beforeSend: function() {
			// 	$(e.target).prop("disabled", true);
			// },
  	// 	success: function (data) {

  	// 		self.isDeletePerform = false;
  	// 		if (data.message.type == 'success') {
  	// 			location.href = self.options.urlPayment+"?sn=" + data.sn;
  	// 		}
  	// 		else {
  	// 			layer(data.message.content);
  	// 			setTimeout(function() {
			// 			location.reload(true);
			// 		}, 3000);
  	// 		}
  	// 	},
			// complete: function() {
			// 	$(e.target).prop("disabled", false);
			// }
  	// })

  };

  window.addressValidation = Klass;

})(jQuery, window);