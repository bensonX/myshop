/**
 * 提示
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
    $('[data-tag="lose"]').bind('click', this.closeClick);

    // 是否弹出过期窗口
    this.setInter = setInterval(function () {

      $.ajax({
        url: self.options.urlRefreshPost,
        type: "GET",
        data: self.options.data,
        dataType: "json",
        cache: false,
        success: function(data) {

          if (data.result.type == "SUCCESS") {
            self.getSuccess();
            clearInterval(self.setInter);
          }

         }
      });
    }, 5000);
  };
  
  // 关闭窗口
  WechatPrompt.fn.closeClick = function () {
	  window.close();
	  $('[data-tag="wechatRefresh"]').hide();
	  $('[data-tag="shieldingLayer"]').hide();
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
