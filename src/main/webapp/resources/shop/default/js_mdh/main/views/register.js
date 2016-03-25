/**
 * 注册验证和提交表单
 * version 0.0.1
 */

;$(function () {

  var $registerForm = $("#registerForm");
  var $username = $("#username");
  var $password = $("#password");
  var $code = $("#code");
  var $agreement = $("#agreement");
  var $submit = $("button:submit");
  var $codeButton = $('#codeButton');


  // 表单验证
  $registerForm.validate({
    rules: {
      username: {
        required: true,
        pattern: /1[3|4|5|7|8|9]\d{9}/,
        minlength: 11,
        remote: {
          url: "/jshop/register/check_username.jhtml",
          cache: false
        }
      },
      password: {
        required: true,
        minlength: 6
      },
      rePassword: {
        required: true,
        equalTo: "#password"
      }
    },
    messages: {
      username: {
        pattern: "只允许输入正确的手机号",
        remote: "手机已被注册"
      }
    },
    submitHandler: function(form) {
      $.ajax({
        url: "/jshop/common/public_key.jhtml",
        type: "GET",
        dataType: "json",
        cache: false,
        beforeSend: function() {
          $submit.prop("disabled", true);
        },
        success: function(data) {
          var rsaKey = new RSAKey();
          rsaKey.setPublic(b64tohex(data.modulus), b64tohex(data.exponent));
          var enPassword = hex2b64(rsaKey.encrypt($password.val()));
          $.ajax({
            url: $registerForm.attr("action"),
            type: "POST",
            data: {
              username: $username.val(),
              enPassword: enPassword,
              email: $email.val(),
              code: $code.val()
            },
            dataType: "json",
            cache: false,
            success: function(message) {
              $.message(message);
              if (message.type == "success") {
                setTimeout(function() {
                  $submit.prop("disabled", false);
                  location.href = "/jshop/";
                }, 3000);
              } else {
                $submit.prop("disabled", false);
                  $captcha.val("");
                  $captchaImage.attr("src", "/jshop/common/captcha.jhtml?captchaId=17aef028-8785-40c9-b7af-b71259578e5b&timestamp=" + new Date().getTime());
              }
            }
          });
        }
      });
    }
  });


});