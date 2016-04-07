/**
* 邮箱验证
*/
;(function ($, window) {

 // 构造函数
 function EmailVerification (options) {
   if (!(this instanceof EmailVerification)) return new EmailVerification(options);
   this.init.apply(this, arguments);
 };

 EmailVerification.fn = EmailVerification.prototype;

 // 初始化
 EmailVerification.fn.init = function (options) {
   this.options = options;
   this.documentEvent();
 };

 // 事件
 EmailVerification.fn.documentEvent = function () {
   // 点开页面
   $('[data-tag="emailClick"]').bind('click', $.proxy(this.emailClick, this));

   // 关闭弹出窗口
   $('[data-tag="close"]').bind('click', this.closeClick);

   // 提交邮箱
   $('[data-tag="emailSubmit"]').bind('click', $.proxy(this.emailSubmit, this));
   // 输入框focus
   $('[data-tag="emailInput"]').bind('focus', $.proxy(this.emailInput, this));

 };

 // 刷新事件
 EmailVerification.fn.emailClick = function () {
   $('[data-tag="email"]').show()
   $('[data-tag="shieldingLayer"]').show();
   // 弹出窗口随窗口改变
   this.windowSize();
   // 弹出窗口随窗口改变而改变
   $(window).resize(this.windowSize);
 };

 // 关闭窗口
 EmailVerification.fn.closeClick = function () {
   $('[data-tag="email"]').hide();
   $('[data-tag="shieldingLayer"]').hide();
   $(window).unbind('resize');
 };

 // 邮箱提交事件
EmailVerification.fn.emailSubmit = function () {
   var self = this;
   var data = {};
   var $emailInput = $('[data-tag="emailInput"]');
   var $prompt = $('[data-tag="prompt"]');
   var pattern = /^[a-z\d]+(\.[a-z\d]+)*@([\da-z](-[\da-z])?)+(\.{1,2}[a-z]+)+$/;
   var email = $.trim($emailInput.val());
   if (!pattern.test(email)) {
      $prompt.html('邮箱的格式不正确');
      return false;
   }

   $.extend(data, {email: email}, self.options.data);
   console.log("urlEmailVerificationPost: ");
   console.log(data);
   $.ajax({
     url: self.options.urlEmailVerificationPost,
     type: "POST",
     data: data,
     dataType: "json",
     cache: false,
     success: function(message) {

       console.log("message: ");
       console.log(message);

       if (message.type == "success") {
         location.reload();
       }
       else {
          $prompt.html(message.content);
       }

      }
   });
 };

// 弹出窗口的位置
EmailVerification.fn.windowSize = function () {
   var $wechatRefresh = $('[data-tag="email"]');
   var width = $wechatRefresh.outerWidth();
   var height = $wechatRefresh.outerHeight();

   var windowWdith = $(window).width();
   var windowHeight = $(window).height();
   $wechatRefresh.css({
     top: (windowHeight-height)/2,
     left: (windowWdith-width)/2
   });

   $('[data-tag="shieldingLayer"]').css({
     width: windowWdith,
     height: windowHeight
   });
 },

 // 获取邮箱focus
 EmailVerification.fn.emailInput = function (event) {
   $('[data-tag="prompt"]').html('');
 }

 window.EmailVerification = EmailVerification;

})(jQuery, window);