/**
 * 输入手机号码页面的效果
 */

;(function ($, window) {
  // 构造函数
  function FindPassword (options) {
    if (!(this instanceof FindPassword)) return new FindPassword(options);
    this.init.apply(this, arguments);
  };

  FindPassword.fn = FindPassword.prototype;

  // 初始化
  FindPassword.fn.init = function (options) {
    this.options = options;
    this.documentClick();
  };

  // 事件
  FindPassword.fn.documentClick = function () {
    // 绑定更换图片验证事件
    $('[data-tag="codeImgClick"]').bind('click', $.proxy(this.codeImgClick, this));

    // 验证手机号是否存在
    $('[data-tag="mobile"]').bind('blur', $.proxy(this.mobileClick, this));

    // 提交数据到后台
    $('[data-tag="submit"]').bind('click', $.proxy(this.submitClick, this));
  };

  // 验证手机号码是否存在
  FindPassword.fn.mobileClick = function () {
    var $prompt = $('[data-tag="prompt"]');
    var self = this;
    var data = {};
    // 判断一下
    $prompt.attr({'data-is': 'false'});
    if (!this.mobile()) return false;

    $.extend(data, {mobile: this.mobile()}, self.options.data);

    console.log("urlMobilePost: ");
    console.log(data);

    $.ajax({
      url: self.options.urlMobilePost,
      type: "POST",
      data: data,
      dataType: "json",
      cache: false,
      success: function(message) {

        console.log("message: ");
        console.log(message);

        if (message.type != "success") {
          self.promptShow(true, message.content);
          $prompt.attr({'data-is': 'true'});
        }
        else {
          $prompt.attr({'data-is': 'false'});
          self.promptShow(false);
        }

       }
    });
  };

  // 更换图片验证事件
  FindPassword.fn.codeImgClick = function () {
    var time = this.options.codeImgSrc+(new Date()).getTime();
    console.log("codeImgSrc: "+ time);
    $('[data-tag="codeImg"]').attr('src', time);
  };

  // 提交数据到后台
  FindPassword.fn.submitClick = function () {
    var $form = $('[data-tag="form"]');

    if (!this.mobile() || !this.code() || !$('[data-tag="prompt"]').hasClass('hidden')) return false;

    $form.submit();

  };

  // 手机号码验证
  FindPassword.fn.mobile = function () {
    var $mobile = $('[data-tag="mobile"]');
    var mobile = $.trim($mobile.val());
    var param = /^1[3|4|5|7|8|9]{1}\d{9}$/g;
    if (!param.test(mobile)) {
      this.promptShow(true, '请输入正确的手机号');
      return false;
    }
    this.promptShow(false);
    return mobile;
  };

  // 验证码验证  
  FindPassword.fn.code = function () {
    var $code = $('[data-tag="code"]');
    var code = $.trim($code.val());
    var paramCode = /^[0-9a-zA-Z]{4}$/;

    if (!paramCode.test(code)) {
      this.promptShow(true, '请输入正确的验证码');
      return false;
    }
    this.promptShow(false);
    return code;
  };

  // 错误提示
  FindPassword.fn.promptShow = function (hiddenVisable, context) {
    var $prompt = $('[data-tag="prompt"]');
    if ($prompt.attr('data-is') == 'true') return false;
    if (!hiddenVisable) {
      $prompt.addClass('hidden');
    }
    else {
      $prompt
        .removeClass('hidden')
        .find('span')
        .html(context);
    }
  }

  window.FindPassword = FindPassword;

})(jQuery, window);


/**
 * 手机号码获取验证码
 */

;(function ($, window) {
  // 构造函数
  function Authentication (options) {
    if (!(this instanceof Authentication)) return new Authentication(options);
    this.init.apply(this, arguments);
  };

  Authentication.fn = Authentication.prototype;

  // 初始化
  Authentication.fn.init = function (options) {
    this.options = options;
    this.documentClick();

    // 打开页面的时候直接发送获取验证码
    this.mobileCodeClick();
  };

  // 事件
  Authentication.fn.documentClick = function () {
    // 绑定更换图片验证事件
    $('[data-tag="mobileCodeClick"]').bind('click', $.proxy(this.mobileCodeClick, this));

    // 提交数据到后台
    $('[data-tag="submit"]').bind('click', $.proxy(this.submitClick, this));
  };

  // 验证手机号码是否存在
  Authentication.fn.mobileCodeClick = function () {
    var $prompt = $('[data-tag="prompt"]');
    var self = this;
    var data = {};

    $.extend(data, self.options.data);

    console.log("urlMobileCodePost: ");
    console.log(data);
    // 倒计时
    self.countdown();

    $.ajax({
      url: self.options.urlMobileCodePost,
      type: "POST",
      data: data,
      dataType: "json",
      cache: false,
      success: function(message) {

        console.log("message: ");
        console.log(message);

        if (message.type != "success") {
          self.promptShow(true, message.content);
          $prompt.attr({'data-is': 'true'});
          clearInterval(self.setInter);
          self.mobileCodeButtonStyle('获取验证码');
        }
        else {
          $prompt.attr({'data-is': 'false'});
          self.promptShow(false);
        }

       }
    });
  };

  // 提交数据到后台
  Authentication.fn.submitClick = function () {
    var $form = $('[data-tag="form"]');

    if (!this.code() || !$('[data-tag="prompt"]').hasClass('hidden')) return false;

    $form.submit();

  };

  // 验证码验证  
  Authentication.fn.code = function () {
    var $code = $('[data-tag="code"]');
    var code = $.trim($code.val());
    var paramCode = /^[0-9a-zA-Z]{4}$/;

    if (!paramCode.test(code)) {
      this.promptShow(true, '请输入正确的验证码');
      return false;
    }
    this.promptShow(false);
    return code;
  };

  // 错误提示
  Authentication.fn.promptShow = function (hiddenVisable, context) {
    var $prompt = $('[data-tag="prompt"]');
    if ($prompt.attr('data-is') == 'true') return false;
    if (!hiddenVisable) {
      $prompt.addClass('hidden');
    }
    else {
      $prompt
        .removeClass('hidden')
        .find('span')
        .html(context);
    }
  };

  // 倒计时
  // 获取手机验证码按钮倒计时
  Authentication.fn.countdown = function () {
      var time = 30;
      var self = this;
      this.mobileCodeButtonStyle(time);
      this.setInter = setInterval(function () {
          --time;
          if (time >= 0) {
              $('[data-tag="mobileCodeClick"]').html(time+'秒');
          }
          else {
             clearInterval(self.setInter);
             self.mobileCodeButtonStyle('获取验证码');
          }
      }, 1000);
  };
  // 获取手机验证码按钮禁止点击
  Authentication.fn.mobileCodeButtonStyle = function (options) {
      if (typeof options == 'number')
          $('[data-tag="mobileCodeClick"]')
              .html(options+'秒')
              .attr('disabled', 'disabled')
              .addClass('clickBackground');
      else 
          $('[data-tag="mobileCodeClick"]')
              .html(options)
              .removeAttr('disabled')
              .removeClass('clickBackground');
  }

  window.Authentication = Authentication;

})(jQuery, window);



/**
 * 重置密码验证和提交
 */

;(function ($, window) {
  // 构造函数
  function resetPassword (options) {
    if (!(this instanceof resetPassword)) return new resetPassword(options);
    this.init.apply(this, arguments);
  };

  resetPassword.fn = resetPassword.prototype;

  // 初始化
  resetPassword.fn.init = function (options) {
    this.options = options;
    this.documentClick();
  };

  // 事件
  resetPassword.fn.documentClick = function () {
    // 提交数据到后台
    $('[data-tag="submit"]').bind('click', $.proxy(this.submitClick, this));
  };

  // ajax提交密码
  resetPassword.fn.submitClick = function () {
    var $prompt = $('[data-tag="prompt"]');
    var self = this;
    var data = {};

    if (!this.password() || !$('[data-tag="prompt"]').hasClass('hidden')) return false;

    $.extend(data, {password: this.password()}, self.options.data);

    console.log("urlResetPost: ");
    console.log(data);

    $.ajax({
      url: self.options.urlResetPost,
      type: "POST",
      data: data,
      dataType: "json",
      cache: false,
      success: function(message) {

        console.log("message: ");
        console.log(message);

        if (message.type != "success") {
          self.promptShow(true, message.content);
          $prompt.attr({'data-is': 'true'});
        }
        else {
          // 弹出窗口随窗口改变
          self.windowSize();
          // 弹出窗口随窗口改变而改变
          $(window).resize(self.windowSize);
        }

       }
    });
  };

  // 密码验证
  resetPassword.fn.password = function () {
    var $password = $('[data-tag="password"]');
    var $againPassword = $('[data-tag="againPassword"]');

    var password = $.trim($password.val());
    var againPassword = $.trim($againPassword.val());

    var param = /.{6,}/;

    if (!param.test(password)) {
      this.promptShow(true, '请重置六位数以上的密码');
      return false;
    }
    if (password !== againPassword) {
      this.promptShow(true, '密码和确认密码不一致');
      return false;
    }

    this.promptShow(false);
    return password;
  };

  // 错误提示
  resetPassword.fn.promptShow = function (hiddenVisable, context) {
    var $prompt = $('[data-tag="prompt"]');
    if ($prompt.attr('data-is') == 'true') return false;
    if (!hiddenVisable) {
      $prompt.addClass('hidden');
    }
    else {
      $prompt
        .removeClass('hidden')
        .find('span')
        .html(context);
    }
  };

  // 弹出窗口的位置
  resetPassword.fn.windowSize = function () {
    var $wechatRefresh = $('[data-tag="popup"]');
    var width = $wechatRefresh.outerWidth();
    var height = $wechatRefresh.outerHeight();

    var windowWdith = $(window).width();
    var windowHeight = $(window).height();
    $wechatRefresh.css({
      top: (windowHeight-height)/2,
      left: (windowWdith-width)/2,
      display: 'block'
    });

    $('[data-tag="shieldingLayer"]').css({
      width: windowWdith,
      height: windowHeight
    }).show();
  };

  window.resetPassword = resetPassword;

})(jQuery, window);