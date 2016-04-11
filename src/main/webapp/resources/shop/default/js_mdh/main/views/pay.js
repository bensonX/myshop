/**
 * 微信过期提示
 */
;(function ($, window) {

  // 构造函数
  function WechatPrompt (options) {
    if (!(this instanceof WechatPrompt)) return new WechatPrompt(options);
    this.init.apply(this, arguments);
  };

  WechatPrompt.fn = WechatPrompt.prototype;

  // 初始化
  WechatPrompt.fn.init = function (options) {
    this.options = options;
    this.documentEvent();
  };

  // 事件
  WechatPrompt.fn.documentEvent = function () {
    var self = this;
    // 刷新页面
    $('[data-tag="refreshClick"]').bind('click', this.refreshClick);

    // 是否弹出过期窗口
    this.setInter = setInterval(function () {

      $.ajax({
        url: self.options.urlRefreshPost,
        type: "POST",
        data: self.options.data,
        dataType: "json",
        cache: false,
        success: function(message) {

          if (message.type == "success") {
            self.getSuccess();
            clearInterval(self.setInter);
          }

         }
      });
    }, 5000);
  };

  // 刷新事件
  WechatPrompt.fn.refreshClick = function () {
    location.reload();
  };

  // 成功返回弹出窗口
  WechatPrompt.fn.getSuccess = function () {

    // 弹出窗口随窗口改变
    this.windowSize();
    // 弹出窗口随窗口改变而改变
    $(window).resize(this.windowSize);
  };

  // 弹出窗口的位置
  WechatPrompt.fn.windowSize = function () {
    var $wechatRefresh = $('[data-tag="wechatRefresh"]');
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



  window.WechatPrompt = WechatPrompt;

})(jQuery, window);

/**
 * 微信支付成功失败提示
 */
;(function ($, window) {

  // 构造函数
  function PaySuccess (options) {
    if (!(this instanceof PaySuccess)) return new PaySuccess(options);
    this.init.apply(this, arguments);
  };

  PaySuccess.fn = PaySuccess.prototype;

  // 初始化
  PaySuccess.fn.init = function (options) {
    this.options = options;
    this.documentEvent();
  };

  // 事件
  PaySuccess.fn.documentEvent = function () {
    var self = this;
    // 刷新页面
    //$('[data-tag="jumpClick"]').bind('click', this.jumpClick);
    // 关闭弹出窗口
    $('[data-tag="popupClose"]').bind('click', this.closeClick);

    // 是否弹出过期窗口
    this.setInter = setInterval(function () {

      $.ajax({
        url: self.options.urlPaySuccessPost,
        type: "POST",
        data: self.options.data,
        dataType: "json",
        cache: false,
        success: function(message) {

          if (message.type == "success") {
            self.getSuccess();
            clearInterval(self.setInter);
          }

         }
      });
    }, 5000);
  };

  // 刷新事件
  PaySuccess.fn.jumpClick = function () {
    location.href = this.options.urlMyOrder;
  };

  // 关闭窗口
  PaySuccess.fn.closeClick = function () {
    $('[data-tag="popupLayer"]').hide();
    $('[data-tag="shieldingLayer"]').hide();
  };

  // 成功返回弹出窗口
  PaySuccess.fn.getSuccess = function () {

    // 弹出窗口随窗口改变
    this.windowSize();
    // 弹出窗口随窗口改变而改变
    $(window).resize(this.windowSize);
  };

  // 弹出窗口的位置
  PaySuccess.fn.windowSize = function () {
    var $popupLayer = $('[data-tag="popupLayer"]');
    var width = $popupLayer.outerWidth();
    var height = $popupLayer.outerHeight();

    var windowWdith = $(window).width();
    var windowHeight = $(window).height();
    $popupLayer.css({
      top: (windowHeight-height)/2,
      left: (windowWdith-width)/2,
      display: 'block'
    });

    $('[data-tag="shieldingLayer"]').css({
      width: windowWdith,
      height: windowHeight
    }).show();
  },



  window.PaySuccess = PaySuccess;

})(jQuery, window);